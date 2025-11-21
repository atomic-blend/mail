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

/// MailComposerHelper: responsible for opening composer UI appropriately
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
          ),
        ),
      );
    }
  }
}

/// The main composer widget
class MailComposer extends ResponsiveStatefulWidget {
  final send_mail.SendMail? mail;
  final Mail? inReplyTo;
  final Function(String)? onSubjectChanged;
  final bool? windowMode;
  final Color? backgroundColor;

  const MailComposer({
    super.key,
    this.mail,
    this.inReplyTo,
    this.onSubjectChanged,
    this.windowMode = false,
    this.backgroundColor,
  });

  @override
  ResponsiveState<MailComposer> createState() => MailComposerState();
}

class MailComposerState extends ResponsiveState<MailComposer> {
  // Editor & controllers
  late FleatherController editorController;
  final TextEditingController subjectController = TextEditingController();

  // Fields state
  List<String> to = [];
  String? from;
  List<String> userEmails = [];
  String? toError;
  List<String> toEmailsErrors = [];

  @override
  void initState() {
    super.initState();
    _initializeFromDraftOrReply();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Ensure we have the current user's account email as default 'from' option
    final authState = context.read<AuthBloc>().state;
    final userEmail = authState.user?.email;
    if (userEmail != null) {
      userEmails = [userEmail];
      from ??= userEmail;
    }
  }

  void _initializeFromDraftOrReply() {
    // Default empty editor
    FleatherController defaultEditor() =>
        FleatherController(document: ParchmentDocument());

    // If a draft send_mail is supplied, try to populate fields
    if (widget.mail?.mail != null) {
      final draft = widget.mail!.mail!;
      subjectController.text = draft.getHeader("Subject") ?? "";

      final toHeader = draft.getHeader("To");
      if (toHeader is List) {
        to = List<String>.from(toHeader);
      } else if (toHeader is String && toHeader.isNotEmpty) {
        to = [toHeader];
      } else {
        to = [];
      }

      from = draft.getHeader("From");

      try {
        final textContent = draft.textContent ?? "";
        if (textContent.isNotEmpty) {
          editorController =
              FleatherController(document: parchmentHtml.decode(textContent));
        } else {
          editorController = defaultEditor();
        }
      } catch (e) {
        editorController = defaultEditor();
      }
      return;
    }

    // If replying to an email, pre-fill subject and to
    if (widget.inReplyTo != null) {
      final original = widget.inReplyTo!;
      final origSubject = original.getHeader("Subject") ?? "";
      if (origSubject.toLowerCase().startsWith("re:")) {
        subjectController.text = origSubject;
      } else {
        subjectController.text = "Re: $origSubject";
      }

      final originalFrom = original.getHeader("From");
      if (originalFrom != null) {
        // check if originalFrom is just an email or a Name <email> format
        final emailRegex = RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        );
        if (emailRegex.hasMatch(originalFrom)) {
        to = [originalFrom];
        } else {
          // Try to extract email from Name <email> format
          final emailExtractRegex = RegExp(r'<([^>]+)>');
          final match = emailExtractRegex.firstMatch(originalFrom);
          if (match != null && match.groupCount >= 1) {
            to = [match.group(1)!];
          }
        }
      }
    }

    // Default values
    editorController = FleatherController(document: ParchmentDocument());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MailBloc, MailState>(
      listener: _onMailStateChanged,
      child: super.build(context),
    );
  }

  void _onMailStateChanged(BuildContext context, MailState state) {
    if (state is MailSendSuccess) {
      if (context.mounted) Navigator.pop(context);
    } else if (state is MailSendError) {
      ToastHelper.showError(
        context: context,
        title: context.t.mail_composer.errors["error_sending_email"]!,
      );
    }
  }

  @override
  Widget buildDesktop(BuildContext context) => buildMobile(context);

  @override
  Widget buildMobile(BuildContext context) {
    return BlocBuilder<MailBloc, MailState>(
      builder: (context, mailState) {
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            return ElevatedContainer(
              disableShadow: widget.windowMode == true,
              color: widget.backgroundColor ?? getTheme(context).surface,
              padding: EdgeInsets.only(top: $constants.insets.xs),
              width: double.infinity,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.windowMode == false)
                        _HeaderBar(
                          onBack: () => draftAndPop(context),
                          onSend: () => _sendMail(context),
                          isSending: mailState is MailSending,
                        ),
                      _FieldWithLabel(
                        label: context.t.mail_composer.to,
                        errorText: toError,
                        child: ComposerToField(
                          emails: to,
                          erroredEmails: toEmailsErrors,
                          backgroundColor: widget.backgroundColor ??
                              getTheme(context).surface,
                          onSelected: (value) => setState(() => to.add(value)),
                          onRemoved: (value) =>
                              setState(() => to.remove(value)),
                        ),
                      ),
                      _FieldWithLabel(
                        label: context.t.mail_composer.from,
                        child: ComposerFromField(
                          emails: userEmails,
                          initialValue: from,
                          backgroundColor: widget.backgroundColor ??
                              getTheme(context).surface,
                          onSelected: (value) => setState(() => from = value),
                        ),
                      ),
                      _FieldWithLabel(
                        label: context.t.mail_composer.subject,
                        child: AppTextFormField(
                          textStyle: getTextTheme(context)
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                          controller: subjectController,
                          backgroundColor: widget.backgroundColor ??
                              getTheme(context).surface,
                          onChange: () {
                            if (widget.onSubjectChanged != null) {
                              widget.onSubjectChanged!(subjectController.text);
                            }
                          },
                        ),
                      ),
                      SizedBox(height: $constants.insets.xs),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: ABEditor(editorState: editorController),
                        ),
                      ),
                      SizedBox(
                        height: isDesktop(context)
                            ? 85
                            : MediaQuery.of(context).viewInsets.bottom == 0
                                ? 85
                                : 60 + MediaQuery.of(context).viewInsets.bottom,
                      ),
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
                      padding: EdgeInsets.symmetric(
                          horizontal: $constants.insets.md),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ABEditorToolbar(
                            editorState: editorController,
                            backgroundColor: widget.backgroundColor ??
                                getTheme(context).surface,
                          ),
                          if (widget.windowMode == true) ...[
                            SizedBox(width: $constants.insets.sm),
                            PrimaryButtonSquare(
                              height: 45,
                              onPressed: () => _sendMail(context),
                              leading: mailState is MailSending
                                  ? CircularProgressIndicator.adaptive(
                                      strokeWidth: 2)
                                  : null,
                              text: context.t.mail_composer.send,
                              textStyle:
                                  getTextTheme(context).headlineSmall!.copyWith(
                                        color: $constants.palette.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// Validate fields and generate a Mail entity. Returns null if validation fails or user cancels.
  Future<Mail?> _generateMailEntity({bool isDraft = false}) async {
    final htmlContent = parchmentHtml.encode(editorController.document);
    final mdContent = parchmentMarkdown.encode(editorController.document);
    final plainTextContent = _markdownToPlainText(mdContent);

    // If not a draft, validate recipients, subject/body and confirm if incomplete
    if (!isDraft) {
      // Validate recipients presence
      if (to.isEmpty) {
        setState(() {
          toError = context.t.mail_composer.errors["no_recipient"]!;
        });
        return null;
      }

      // Check empty subject/body
      final emptyFields = <String>[];
      if (subjectController.text.trim().isEmpty) emptyFields.add("subject");
      if (htmlContent.trim().isEmpty) emptyFields.add("body");

      final proceed = await _confirmEmptyMailDialog(context, emptyFields);
      if (!proceed) return null;

      // Validate email addresses and collect invalid ones
      final invalid = <String>[];
      final emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      );
      for (final email in to) {
        if (!emailRegex.hasMatch(email)) invalid.add(email);
      }

      if (invalid.isNotEmpty) {
        setState(() {
          toEmailsErrors = invalid;
          toError = context.t.mail_composer.errors["invalid_recipient"]!;
        });
        return null;
      } else {
        setState(() {
          toEmailsErrors = [];
          toError = null;
        });
      }
    }

    final mail = Mail()
      ..headers = {
        "To": to,
        "From": from,
        "Subject": subjectController.text,
      }
      ..textContent = plainTextContent
      ..htmlContent = htmlContent
      ..createdAt = DateTime.now();

    return mail;
  }

  Future<bool> _confirmEmptyMailDialog(
      BuildContext context, List<String> emptyFields) async {
    if (emptyFields.isEmpty) return true;

    final description =
        "${context.t.mail_composer.incomplete_email_modal.description}\n\n${emptyFields.map((f) => '- ${context.t.mail_composer.fields[f]}').join('\n')}\n\n${context.t.mail_composer.incomplete_email_modal.want_to_go_back}";

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ABModal(
        width: 400,
        title: context.t.mail_composer.incomplete_email_modal.title,
        description: description,
        confirmText:
            context.t.mail_composer.incomplete_email_modal.confirm_text,
        cancelText: context.t.mail_composer.incomplete_email_modal.cancel_text,
        onConfirm: () => Navigator.pop(context, true),
        onCancel: () => Navigator.pop(context, false),
      ),
    );

    return result ?? false;
  }

  void _sendMail(BuildContext context) async {
    final mail = await _generateMailEntity();
    if (mail == null) return;
    if (!context.mounted) return;
    context.read<MailBloc>().add(SendMail(mail));
  }

  String _markdownToPlainText(String mdContent) {
    final regex = RegExp(r'[*_~`#]');
    return mdContent.replaceAll(regex, '');
  }

  /// Save draft and pop. Behavior:
  /// - If everything empty -> just pop
  /// - If some fields filled, ask to save draft
  Future<void> draftAndPop(BuildContext context, {bool pop = true}) async {
    final editorHasContent = editorController.document.length > 1;
    final hasAnyField = editorHasContent ||
        subjectController.text.isNotEmpty ||
        to.isNotEmpty ||
        from != null;

    if (!hasAnyField) {
      if (pop && context.mounted) Navigator.pop(context);
      return;
    }

    bool saveDraft = false;

    // Ask only if body empty but other fields present
    if (!editorHasContent &&
        (subjectController.text.isNotEmpty || to.isNotEmpty)) {
      final result = await showDialog<bool>(
        context: context,
        builder: (context) => ABModal(
          width: 400,
          title: context.t.mail_composer.save_draft_modal.title,
          description: context.t.mail_composer.save_draft_modal.description,
          confirmText: context.t.mail_composer.save_draft_modal.confirm_text,
          cancelText: context.t.mail_composer.save_draft_modal.cancel_text,
          onConfirm: () => Navigator.pop(context, true),
          onCancel: () => Navigator.pop(context, false),
        ),
      );
      saveDraft = result ?? false;
    }

    // If editor has content we always save draft
    if (editorHasContent) saveDraft = true;

    if (saveDraft) {
      final mail = await _generateMailEntity(isDraft: true);
      if (mail == null) return;
      if (!context.mounted) return;

      if (widget.mail != null) {
        context.read<MailBloc>().add(UpdateDraft(mail, widget.mail!.id!));
      } else {
        context.read<MailBloc>().add(SaveDraft(mail));
      }
    }

    if (pop && context.mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    subjectController.dispose();
    super.dispose();
  }
}

/// Small reusable header bar widget that contains back button and send button
class _HeaderBar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onSend;
  final bool isSending;

  const _HeaderBar({
    required this.onBack,
    required this.onSend,
    this.isSending = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onBack,
          icon: Icon(CupertinoIcons.chevron_back),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: $constants.insets.sm),
          child: PrimaryButtonSquare(
            height: 35,
            onPressed: onSend,
            leading: isSending
                ? CircularProgressIndicator.adaptive(strokeWidth: 2)
                : null,
            text: context.t.mail_composer.send,
            textStyle: getTextTheme(context).headlineSmall!.copyWith(
                  color: $constants.palette.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}

/// Reusable labeled field row used for To/From/Subject fields
class _FieldWithLabel extends StatelessWidget {
  final String label;
  final Widget child;
  final String? errorText;

  const _FieldWithLabel({
    required this.label,
    required this.child,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
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
              Expanded(child: child),
            ],
          ),
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: $constants.insets.sm,
              vertical: 2,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                errorText!,
                style: getTextTheme(context)
                    .bodySmall!
                    .copyWith(color: getTheme(context).error),
              ),
            ),
          ),
      ],
    );
  }
}
