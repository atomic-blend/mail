import 'package:ab_shared/blocs/auth/auth.bloc.dart';
import 'package:ab_shared/components/app/window_layout/window_layout_controller.dart';
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
import 'package:mail/pages/mails/composer/window_mail_composer.dart';
import 'package:mail/utils/get_it.dart';
import 'package:parchment/codecs.dart';

class MailComposerHelper {
  static void openMailComposer(
    BuildContext context, {
    send_mail.SendMail? mail,
    Mail? inReplyTo,
    Function(String)? onSubjectChanged,
    bool? windowMode = false,
    Color? backgroundColor,
  }) {
    if (isDesktop(context)) {
      getIt<WindowLayoutController>().addWindow(
        WindowMailComposer(
          initiallyCollapsed: false,
          draft: mail,
          inReplyTo: inReplyTo,
        ),
      );
    } else {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => SizedBox(
              height: getSize(context).height * 0.88,
              child: MailComposer(
                mail: mail,
                inReplyTo: inReplyTo,
                onSubjectChanged: onSubjectChanged,
                backgroundColor: backgroundColor,
              )));
    }
  }
}

class MailComposer extends ResponsiveStatefulWidget {
  final send_mail.SendMail? mail;
  final Mail? inReplyTo;
  final Function(String)? onSubjectChanged;
  final bool? windowMode;
  final Color? backgroundColor;
  const MailComposer(
      {super.key,
      this.mail,
      this.inReplyTo,
      this.onSubjectChanged,
      this.windowMode = false,
      this.backgroundColor});

  @override
  ResponsiveState<MailComposer> createState() => MailComposerState();
}

class MailComposerState extends ResponsiveState<MailComposer> {
  FleatherController? editorState;
  TextEditingController subjectController = TextEditingController();
  TextEditingController toController = TextEditingController();

  String? subject;
  String? from;
  List<String>? userEmails = [];
  List<String>? to = [];
  String? toError;
  List<String>? toEmailsErrors = [];

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

      from = widget.mail!.mail!.getHeader("From");

      // Initialize from field with current user's email if not already set
      if (from == null) {
        final authState = context.read<AuthBloc>().state;
        if (authState.user != null) {
          from = authState.user!.email!;
          userEmails = [from!];
        }
      }

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

    if (widget.inReplyTo != null) {
      final originalMail = widget.inReplyTo!;
      final originalSubject = originalMail.getHeader("Subject") ?? "";
      if (originalSubject.toLowerCase().startsWith("re:")) {
        subjectController.text = originalSubject;
      } else {
        subjectController.text = "Re: $originalSubject";
      }

      final originalFrom = originalMail.getHeader("From");
      if (originalFrom != null) {
        to = [originalFrom];
      }
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize from field with current user's email if not already set
    final authState = context.read<AuthBloc>().state;
    final userAccountEmail = authState.user!.email!;
    userEmails = [userAccountEmail];
    from ??= userAccountEmail;
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
          disableShadow: widget.windowMode == true,
          color: widget.backgroundColor ?? getTheme(context).surface,
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
                  if (widget.windowMode == false)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            draftAndPop(context);
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
                              _sendMail(context);
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
                  _buildFieldWithLabel(
                    context.t.mail_composer.to,
                    ComposerToField(
                      emails: to,
                      erroredEmails: toEmailsErrors,
                      backgroundColor:
                          widget.backgroundColor ?? getTheme(context).surface,
                      onSelected: (value) {
                        setState(() {
                          to?.add(value);
                        });
                      },
                      onRemoved: (value) {
                        setState(() {
                          to?.remove(value);
                        });
                      },
                    ),
                    errorText: toError,
                  ),
                  // _buildPaddedDivider(),
                  _buildFieldWithLabel(
                    context.t.mail_composer.from,
                    ComposerFromField(
                      emails: userEmails!,
                      initialValue: from,
                      backgroundColor:
                          widget.backgroundColor ?? getTheme(context).surface,
                      onSelected: (value) {
                        setState(() {
                          from = value;
                        });
                      },
                    ),
                  ),
                  // _buildPaddedDivider(),
                  _buildFieldWithLabel(
                      context.t.mail_composer.subject,
                      AppTextFormField(
                        textStyle: getTextTheme(context)
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                        controller: subjectController,
                        value: subject,
                        backgroundColor:
                            widget.backgroundColor ?? getTheme(context).surface,
                        onChange: () => {
                          if (widget.onSubjectChanged != null)
                            {widget.onSubjectChanged!(subjectController.text)}
                        },
                      )),
                  // _buildPaddedDivider(),
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
                    ? widget.windowMode != true
                        ? $constants.insets.lg
                        : 0
                    : MediaQuery.of(context).viewInsets.bottom +
                        $constants.insets.xs,
                left: 0,
                right: 0,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: $constants.insets.md),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ABEditorToolbar(
                        editorState: editorState!,
                        backgroundColor:
                            widget.backgroundColor ?? getTheme(context).surface,
                      ),
                      if (widget.windowMode == true) ...[
                        SizedBox(width: $constants.insets.sm),
                        PrimaryButtonSquare(
                          height: 45,
                          onPressed: () {
                            _sendMail(context);
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
                        )
                      ]
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
    });
  }

  Widget _buildFieldWithLabel(String label, Widget field, {String? errorText}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: $constants.insets.sm),
          child: Row(
            children: [
              Text(
                "$label:",
                style: getTextTheme(context)
                    .bodyMedium!
                    .copyWith(color: Colors.grey),
              ),
              SizedBox(width: $constants.insets.xxs),
              Expanded(child: field),
            ],
          ),
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: $constants.insets.sm, vertical: 2),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                errorText,
                style: getTextTheme(context)
                    .bodySmall!
                    .copyWith(color: getTheme(context).error),
              ),
            ),
          ),
      ],
    );
  }

  Future<Mail?> _generateMailEntity({
    bool? isDraft = false,
  }) async {
    final htmlContent = parchmentHtml.encode(editorState!.document);
    final mdContent = parchmentMarkdown.encode(editorState!.document);
    final plainTextContent = _markdownToPlainText(mdContent);

    if (isDraft != true) {
      final emptyFields = [];

      if (to == null || to!.isEmpty) {
        setState(() {
          toError = context.t.mail_composer.errors["no_recipient"]!;
        });
        return null;
      }

      if (subjectController.text.isEmpty) {
        emptyFields.add("subject");
      }

      if (htmlContent.isEmpty) {
        emptyFields.add("body");
      }

      // ask in a dialog if the user still wants to send the email if there are empty fields
      final proceed = await _confirmEmptyMailDialog(context, emptyFields);
      if (!proceed) {
        return null;
      }

      // loop through to list and validate email addresses, collect invalid ones
      List<String> toEmailsErrors = [];
      for (var email in to!) {
        final emailRegex = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
        if (!emailRegex.hasMatch(email)) {
          toEmailsErrors.add(email);
        }
      }
      if (toEmailsErrors.isNotEmpty) {
        setState(() {
          this.toEmailsErrors = toEmailsErrors;
          toError = context.t.mail_composer.errors["invalid_recipient"]!;
        });
        return null;
      } else {
        setState(() {
          this.toEmailsErrors = [];
        });
      }
    }

    final mail = Mail();
    mail.headers = {
      "To": to,
      "From": from,
      "Subject": subjectController.text,
    };

    mail.textContent = plainTextContent;
    mail.htmlContent = htmlContent;
    mail.createdAt = DateTime.now();

    return mail;
  }

  Future<bool> _confirmEmptyMailDialog(
    BuildContext context,
    List<dynamic> emptyFields,
  ) async {
    if (emptyFields.isNotEmpty) {
      // For now, we just proceed without blocking
      return await showDialog(
        context: context,
        builder: (context) => ABModal(
          width: 400,
          title: context.t.mail_composer.incomplete_email_modal.title,
          description:
              "${context.t.mail_composer.incomplete_email_modal.description}\n\n${emptyFields.map((field) => '- ${context.t.mail_composer.fields[field]}').join('\n')}\n\n${context.t.mail_composer.incomplete_email_modal.want_to_go_back}",
          confirmText:
              context.t.mail_composer.incomplete_email_modal.confirm_text,
          cancelText:
              context.t.mail_composer.incomplete_email_modal.cancel_text,
          onConfirm: () {
            Navigator.pop(context, true);
          },
          onCancel: () {
            Navigator.pop(context, false);
          },
        ),
      );
    }
    return true;
  }

  void _sendMail(BuildContext context) async {
    final mail = await _generateMailEntity();

    if (mail == null) {
      return;
    }

    if (!context.mounted) return;
    context.read<MailBloc>().add(SendMail(mail));
  }

  String _markdownToPlainText(String mdContent) {
    // Regular expression to match Markdown symbols including '#'
    RegExp regex = RegExp(r'[*_~`#]');
    // Replace Markdown symbols with an empty string
    return mdContent.replaceAll(regex, '');
  }

  void draftAndPop(
    BuildContext context, {
    bool pop = true,
  }) async {
    if (editorState!.document.length <= 1 &&
        subjectController.text.isEmpty &&
        toController.text.isEmpty) {
      if (pop) Navigator.pop(context);
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
                width: 400,
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
      final mail = await _generateMailEntity(
        isDraft: true,
      );
      if (mail == null) {
        return;
      }
      if (widget.mail != null) {
        // update the draft
        if (!context.mounted) return;
        context.read<MailBloc>().add(UpdateDraft(mail, widget.mail!.id!));
      } else {
        if (!context.mounted) return;
        context.read<MailBloc>().add(SaveDraft(mail));
      }
    }
    if (pop) {
      if (!context.mounted) return;
      Navigator.pop(context);
    }
    return;
  }
}
