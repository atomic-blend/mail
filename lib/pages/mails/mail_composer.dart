import 'dart:convert';

import 'package:ab_shared/blocs/auth/auth.bloc.dart';
import 'package:ab_shared/components/forms/app_text_form_field.dart';
import 'package:ab_shared/components/modals/ab_modal.dart';
import 'package:ab_shared/components/responsive_stateful_widget.dart';
import 'package:ab_shared/components/widgets/elevated_container.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/models/mail/mail.dart';
import 'package:mail/models/send_mail/send_mail.dart' as send_mail;
import 'package:parchment/codecs.dart';

class MailComposer extends ResponsiveStatefulWidget {
  final send_mail.SendMail? mail;
  const MailComposer({super.key, this.mail});

  @override
  ResponsiveState<MailComposer> createState() => _MailComposerState();
}

class _MailComposerState extends ResponsiveState<MailComposer> {
  dynamic editorState;
  TextEditingController subjectController = TextEditingController();
  TextEditingController toController = TextEditingController();

  String? subject;
  String? from;
  List<String> availableFrom = [];
  List<String>? to = [];

  @override
  void initState() {
    if (widget.mail?.mail != null) {
      subjectController.text = widget.mail!.mail!.getHeader("Subject") ?? "";
      to = List<String>.from(widget.mail!.mail!.getHeader("To") ?? []);
      from = widget.mail!.mail!.getHeader("From") ?? "";
      editorState = FleatherController(
          document: parchmentHtml.decode(widget.mail!.mail!.textContent ?? ""));
    } else {
      editorState = FleatherController(document: ParchmentDocument());
    }
    super.initState();
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return const Placeholder();
  }

  @override
  Widget buildMobile(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
      if (authState.user != null &&
          !availableFrom.contains(authState.user!.email!)) {
        availableFrom.add(authState.user!.email!);
        from = availableFrom.first;
      }

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
                IconButton(
                  onPressed: () {
                    _draftAndPop(context);
                  },
                  icon: Icon(CupertinoIcons.chevron_back),
                ),
                SizedBox(height: $constants.insets.xs),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: $constants.insets.sm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "New Mail",
                        style: getTextTheme(context)
                            .displaySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          _sendMail();
                        },
                        icon: Icon(
                          CupertinoIcons.arrow_up_circle_fill,
                          size: 30,
                          color: getTheme(context).primary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: $constants.insets.xs),
                _buildPaddedDivider(),
                _buildToField(toController, to),
                _buildPaddedDivider(),
                _buildEmailFields(
                  "From",
                  null,
                  enabled: false,
                  value: from,
                  onTap: () {
                    // _showFromSelector();
                  },
                ),
                _buildPaddedDivider(),
                _buildEmailFields("Subject", subjectController),
                _buildPaddedDivider(),
                SizedBox(height: $constants.insets.xs),
                SizedBox(
                  width: double.infinity,
                  height: getSize(context).height * 0.55,
                  child: _getEditor(),
                ),
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
                padding: EdgeInsets.symmetric(horizontal: $constants.insets.md),
                child: ElevatedContainer(
                    height: 50,
                    child: FleatherToolbar(children: [
                      ToggleStyleButton(
                        attribute: ParchmentAttribute.bold,
                        icon: CupertinoIcons.bold,
                        controller: editorState,
                        childBuilder:
                            (context, attribute, icon, isToggled, onPressed) =>
                                GestureDetector(
                          onTap: () {
                            if (onPressed != null) {
                              onPressed();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular($constants.corners.md),
                              color: isToggled
                                  ? getTheme(context).surface
                                  : getTheme(context).surfaceContainer,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(icon),
                            ),
                          ),
                        ),
                      ),
                    ])),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _getEditor() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $constants.insets.sm),
      child: FleatherEditor(controller: editorState),
    );
  }

  Widget _buildPaddedDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $constants.insets.sm),
      child: Divider(),
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
      child: Column(
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
              labelText: "To:",
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
    final htmlContent = parchmentHtml.encode(editorState.document);
    final mdContent = parchmentMarkdown.encode(editorState.document);
    final plainTextContent = _markdownToPlainText(mdContent);

    //TODO: add attachements and create a raw mail entity like it's done in the backend
    final mail = Mail();
    mail.headers = [
      {
        "Key": "To",
        "Value": [toController.text]
      },
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

    Navigator.pop(context);
  }

  String _markdownToPlainText(String mdContent) {
    // Regular expression to match Markdown symbols including '#'
    RegExp regex = RegExp(r'[*_~`#]');
    // Replace Markdown symbols with an empty string
    return mdContent.replaceAll(regex, '');
  }

  void _draftAndPop(BuildContext context) {
    if (editorState.document.isEmpty) {
      Navigator.pop(context);
      return;
    }
    // ask the user if they want to save the draft when the body content is not filled but there is a subject / from / to
    bool saveDraft = false;
    if (editorState.document.isEmpty &&
        (subjectController.text.isNotEmpty ||
            toController.text.isNotEmpty ||
            from != null)) {
      showDialog(
          context: context,
          builder: (context) => ABModal(
                title: "Save Draft",
                description: "Do you want to save the draft?",
                onConfirm: () {
                  saveDraft = true;
                  Navigator.pop(context);
                },
              ));
      return;
    }

    if (!editorState.document.isEmpty) {
      saveDraft = true;
    }

    if (saveDraft) {
      // save the draft
      final mail = _generateMailEntity();
      if (widget.mail != null) {
        // update the draft
        context.read<MailBloc>().add(UpdateDraft(mail, widget.mail!.id!));
      } else {
        context.read<MailBloc>().add(SaveDraft(mail));
      }
      Navigator.pop(context);
      return;
    }
  }
}
