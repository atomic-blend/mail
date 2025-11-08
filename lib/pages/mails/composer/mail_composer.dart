import 'package:ab_shared/blocs/auth/auth.bloc.dart';
import 'package:ab_shared/components/buttons/primary_button_square.dart';
import 'package:ab_shared/components/editor/ab_editor.dart';
import 'package:ab_shared/components/editor/ab_editor_toolbar.dart';
import 'package:ab_shared/components/forms/app_text_form_field.dart';
import 'package:ab_shared/components/modals/ab_modal.dart';
import 'package:ab_shared/components/responsive_stateful_widget.dart';
import 'package:ab_shared/components/widgets/elevated_container.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:ab_shared/utils/toast_helper.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:mail/models/mail/mail.dart';
import 'package:mail/models/send_mail/send_mail.dart' as send_mail;
import 'package:mail/pages/mails/composer/composer_from_field.dart';
import 'package:mail/pages/mails/composer/composer_to_field.dart';
import 'package:parchment/codecs.dart';

class MailComposer extends ResponsiveStatefulWidget {
  final send_mail.SendMail? mail;
  const MailComposer({super.key, this.mail});

  @override
  ResponsiveState<MailComposer> createState() => _MailComposerState();
}

class _MailComposerState extends ResponsiveState<MailComposer> {
  FleatherController? editorState;
  TextEditingController subjectController = TextEditingController();
  TextEditingController toController = TextEditingController();

  String? subject;
  String? from;
  List<String>? userEmails = [];
  List<String>? to = [];

  @override
  void initState() {
    if (widget.mail?.mail != null) {
      subjectController.text = widget.mail!.mail!.getHeader("Subject") ?? "";

      // Safely handle To field - it might be a string or list
      final toHeader = widget.mail!.mail!.getHeader("To");
      if (toHeader is List) {
        to = List<String>.from(toHeader);
      } else if (toHeader is String && toHeader.isNotEmpty) {
        to = [toHeader];
      } else {
        to = [];
      }

      from = widget.mail!.mail!.getHeader("From") ?? "";

      // Safely decode HTML content to prevent stack overflow
      try {
        final textContent = widget.mail!.mail!.textContent ?? "";
        if (textContent.isNotEmpty) {
          editorState =
              FleatherController(document: parchmentHtml.decode(textContent));
        } else {
          editorState = FleatherController(document: ParchmentDocument());
        }
      } catch (e) {
        // If decoding fails, create empty document
        editorState = FleatherController(document: ParchmentDocument());
      }
    } else {
      editorState = FleatherController(document: ParchmentDocument());
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize from field with current user's email if not already set
    if (from == null) {
      final authState = context.read<AuthBloc>().state;
      if (authState.user != null) {
        from = authState.user!.email!;
        userEmails = [from!];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MailBloc, MailState>(
        listener: (context, mailState) {
          if (mailState is MailSendSuccess) {
            Navigator.pop(context);
          } else if (mailState is MailSendError) {
            ToastHelper.showError(
                context: context,
                title: context.t.mail_composer.errors["error_sending_email"]!);
          }
        },
        child: super.build(context));
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return buildMobile(context);
  }

  @override
  Widget buildMobile(BuildContext context) {
    return BlocBuilder<MailBloc, MailState>(builder: (context, mailState) {
      return BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
        return ElevatedContainer(
          padding: EdgeInsets.only(
            top: $constants.insets.xs,
          ),
          width: double.infinity,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          _draftAndPop(context);
                        },
                        icon: Icon(CupertinoIcons.chevron_back),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: $constants.insets.sm,
                        ),
                        child: PrimaryButtonSquare(
                          height: 35,
                          onPressed: () {
                            _sendMail();
                          },
                          leading: mailState is MailSending
                              ? CircularProgressIndicator.adaptive(
                                  strokeWidth: 2,
                                )
                              : null,
                          text: context.t.mail_composer.send,
                          textStyle:
                              getTextTheme(context).headlineSmall!.copyWith(
                                    color: $constants.palette.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: $constants.insets.xs),
                  _buildFieldWithLabel(
                    context.t.mail_composer.to,
                    ComposerToField(
                      emails: to,
                    ),
                  ),
                  // _buildToField(toController, to),
                  _buildPaddedDivider(),
                  _buildFieldWithLabel(
                    context.t.mail_composer.from,
                    ComposerFromField(
                      emails: userEmails!,
                      initialValue: from,
                      onSelected: (value) {
                        setState(() {
                          from = value;
                        });
                      },
                    ),
                  ),
                  _buildPaddedDivider(),
                  _buildEmailFields(
                      context.t.mail_composer.subject, subjectController),
                  _buildPaddedDivider(),
                  SizedBox(height: $constants.insets.xs),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: ABEditor(editorState: editorState!),
                    ),
                  ),
                  SizedBox(
                      height: isDesktop(context)
                          ? 85
                          : MediaQuery.of(context).viewInsets.bottom == 0
                              ? 85
                              : 60 + MediaQuery.of(context).viewInsets.bottom),
                ],
              ),
              Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom == 0
                    ? $constants.insets.lg
                    : MediaQuery.of(context).viewInsets.bottom +
                        $constants.insets.xs,
                left: 0,
                right: 0,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: $constants.insets.md),
                  child: ABEditorToolbar(editorState: editorState!),
                ),
              ),
            ],
          ),
        );
      });
    });
  }

  Widget _buildPaddedDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $constants.insets.sm),
      child: Divider(),
    );
  }

  Widget _buildFieldWithLabel(String label, Widget field) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $constants.insets.sm),
      child: Row(
        children: [
          Text(
            "$label:",
            style:
                getTextTheme(context).bodyMedium!.copyWith(color: Colors.grey),
          ),
          SizedBox(width: $constants.insets.xs),
          Expanded(child: field),
        ],
      ),
    );
  }

  Widget _buildEmailFields(
    String label,
    TextEditingController? controller, {
    String? value,
    bool? enabled = true,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $constants.insets.sm),
      child: GestureDetector(
        onTap: () {
          if (onTap != null && enabled == false) {
            onTap();
          }
        },
        child: AppTextFormField(
          height: 25,
          labelText: "$label:",
          rowLayout: true,
          labelStyle:
              getTextTheme(context).bodyMedium!.copyWith(color: Colors.grey),
          controller: controller,
          value: value,
          backgroundColor: null,
        ),
      ),
    );
  }

  Widget _buildToField(
    TextEditingController? controller,
    List<String>? to, {
    String? value,
    bool? enabled = true,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $constants.insets.sm),
      child: Wrap(
        children: [
          if (to != null && to.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: $constants.insets.xl),
              child: Wrap(
                children: [
                  ...to.map((to) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: $constants.insets.xs,
                            vertical: $constants.insets.xxs),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: $constants.insets.sm),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius:
                                BorderRadius.circular($constants.insets.sm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(to),
                              SizedBox(width: $constants.insets.xs),
                              GestureDetector(
                                child: Icon(
                                  CupertinoIcons.xmark_circle_fill,
                                  size: 15,
                                ),
                                onTap: () {
                                  setState(() {
                                    this.to?.remove(to);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
          GestureDetector(
            onTap: () {
              if (onTap != null && enabled == false) {
                onTap();
              }
            },
            child: AppTextFormField(
              height: 25,
              labelText: "${context.t.mail_composer.to}:",
              rowLayout: true,
              labelStyle: getTextTheme(context)
                  .bodyMedium!
                  .copyWith(color: Colors.grey),
              controller: controller,
              value: value,
              backgroundColor: null,
              onChange: () {
                // detect spaces in the controller text and add them to the to list + clear the controller text
                final spaces = controller?.text.split(" ");
                if (spaces!.length > 1) {
                  setState(() {
                    to?.add(spaces.first);
                    controller?.clear();
                  });
                }
              },
              onSubmitted: () {
                // store the email to the list + clear the controller text when the user presses enter
                setState(() {
                  to?.add(controller?.text ?? "");
                  controller?.clear();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Mail _generateMailEntity() {
    final htmlContent = parchmentHtml.encode(editorState!.document);
    final mdContent = parchmentMarkdown.encode(editorState!.document);
    final plainTextContent = _markdownToPlainText(mdContent);

    //TODO: add attachements and create a raw mail entity like it's done in the backend
    final mail = Mail();
    mail.headers = [
      {"Key": "To", "Value": to},
      {"Key": "From", "Value": from},
      {"Key": "Subject", "Value": subjectController.text},
    ];
    mail.textContent = plainTextContent;
    mail.htmlContent = htmlContent;
    mail.createdAt = DateTime.now();

    return mail;
  }

  void _sendMail() {
    final mail = _generateMailEntity();

    context.read<MailBloc>().add(SendMail(mail));
  }

  String _markdownToPlainText(String mdContent) {
    // Regular expression to match Markdown symbols including '#'
    RegExp regex = RegExp(r'[*_~`#]');
    // Replace Markdown symbols with an empty string
    return mdContent.replaceAll(regex, '');
  }

  void _draftAndPop(BuildContext context) async {
    if (editorState!.document.length <= 1 &&
        subjectController.text.isEmpty &&
        toController.text.isEmpty) {
      Navigator.pop(context);
      return;
    }
    // ask the user if they want to save the draft when the body content is not filled but there is a subject / from / to
    bool saveDraft = false;
    if (editorState!.document.length <= 1 &&
        (subjectController.text.isNotEmpty ||
            toController.text.isNotEmpty ||
            from != null)) {
      final result = await showDialog(
          context: context,
          builder: (context) => ABModal(
                title: context.t.mail_composer.save_draft_modal.title,
                description:
                    context.t.mail_composer.save_draft_modal.description,
                confirmText:
                    context.t.mail_composer.save_draft_modal.confirm_text,
                cancelText:
                    context.t.mail_composer.save_draft_modal.cancel_text,
                onConfirm: () {
                  Navigator.pop(context, true);
                },
                onCancel: () {
                  Navigator.pop(context, false);
                },
              ));
      saveDraft = result;
    }

    if (editorState!.document.length > 1) {
      saveDraft = true;
    }

    if (saveDraft) {
      // save the draft
      final mail = _generateMailEntity();
      if (widget.mail != null) {
        // update the draft
        if (!context.mounted) return;
        context.read<MailBloc>().add(UpdateDraft(mail, widget.mail!.id!));
      } else {
        if (!context.mounted) return;
        context.read<MailBloc>().add(SaveDraft(mail));
      }
    }
    if (!context.mounted) return;
    Navigator.pop(context);
    return;
  }
}
