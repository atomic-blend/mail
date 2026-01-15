import 'package:ab_shared/blocs/auth/auth.bloc.dart';
import 'package:ab_shared/components/buttons/primary_button_square.dart';
import 'package:ab_shared/components/forms/app_text_form_field.dart';
import 'package:ab_shared/components/widgets/elevated_container.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/i18n/strings.g.dart';

/// Modal that prompts the user to provide an email from an authorized domain
/// and optionally set a backup email.
class EmailDomainValidationModal extends StatefulWidget {
  final String currentEmail;
  final List<String> authorizedDomains;

  const EmailDomainValidationModal({
    super.key,
    required this.currentEmail,
    required this.authorizedDomains,
  });

  @override
  State<EmailDomainValidationModal> createState() =>
      _EmailDomainValidationModalState();
}

class _EmailDomainValidationModalState
    extends State<EmailDomainValidationModal> {
  final TextEditingController emailUsernameController = TextEditingController();
  final TextEditingController backupEmailController = TextEditingController();
  String? selectedDomain;
  String? newEmailError;
  String? backupEmailError;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Pre-populate backup email with current email
    backupEmailController.text = widget.currentEmail;
    // Set default domain to first in list if available
    if (widget.authorizedDomains.isNotEmpty) {
      selectedDomain = widget.authorizedDomains.first;
    }
  }

  @override
  void dispose() {
    emailUsernameController.dispose();
    backupEmailController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    return emailRegex.hasMatch(email);
  }

  bool _isValidUsername(String username) {
    if (username.isEmpty) return false;
    final usernameRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+$",
    );
    return usernameRegex.hasMatch(username);
  }

  void _validateAndSubmit() {
    setState(() {
      newEmailError = null;
      backupEmailError = null;
    });

    final username = emailUsernameController.text.trim();
    final backupEmail = backupEmailController.text.trim();

    // Validate username
    if (username.isEmpty) {
      setState(() {
        newEmailError =
            context.t.email_domain_validation.errors['empty_email']!;
      });
      return;
    }

    if (!_isValidUsername(username)) {
      setState(() {
        newEmailError =
            context.t.email_domain_validation.errors['invalid_email_format']!;
      });
      return;
    }

    if (selectedDomain == null) {
      setState(() {
        newEmailError = 'Please select a domain';
      });
      return;
    }

    // Construct the full email
    final newEmail = '$username@$selectedDomain';

    // Validate backup email if provided
    if (backupEmail.isNotEmpty && !_isValidEmail(backupEmail)) {
      setState(() {
        backupEmailError =
            context.t.email_domain_validation.errors['invalid_email_format']!;
      });
      return;
    }

    // Submit to backend via auth bloc
    setState(() => isLoading = true);

    var user = context.read<AuthBloc>().state.user;
    if (user == null) {
      return;
    }

    user.email = newEmail;
    user.backupEmail = backupEmail.isNotEmpty ? backupEmail : null;

    context.read<AuthBloc>().add(
          UpdateUserProfile(
            user,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.toString().contains('UserUpdateProfileSuccess')) {
          setState(() => isLoading = false);
          if (mounted) Navigator.of(context).pop();
        } else if (state.toString().contains('Error')) {
          setState(() {
            isLoading = false;
            newEmailError =
                context.t.email_domain_validation.errors['update_failed']!;
          });
        }
      },
      child: Dialog(
        child: ElevatedContainer(
          width: isDesktop(context) ? 500 : double.infinity,
          padding: EdgeInsets.all($constants.insets.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                context.t.email_domain_validation.title,
                style: getTextTheme(context).displaySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: $constants.insets.sm),

              // Description
              Text(
                context.t.email_domain_validation.description(
                  domains: widget.authorizedDomains.join(', '),
                ),
                style: getTextTheme(context).bodyMedium,
              ),
              SizedBox(height: $constants.insets.md),

              // Current email display
              Text(
                context.t.email_domain_validation.current_email,
                style: getTextTheme(context).bodySmall!.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: $constants.insets.xxs),
              Text(
                widget.currentEmail,
                style: getTextTheme(context).bodyMedium,
              ),
              SizedBox(height: $constants.insets.md),

              // New email field with username + domain dropdown
              Text(
                context.t.email_domain_validation.new_email_label,
                style: getTextTheme(context).bodySmall!.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: $constants.insets.xxs),
              if (isDesktop(context))
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: AppTextFormField(
                        controller: emailUsernameController,
                        hintText: 'username',
                        backgroundColor: getTheme(context).surface,
                      ),
                    ),
                    SizedBox(width: $constants.insets.xs),
                    Text(
                      '@',
                      style: getTextTheme(context).bodyLarge,
                    ),
                    SizedBox(width: $constants.insets.xs),
                    Expanded(
                      flex: 2,
                      child: CustomPopup(
                        barrierColor: Colors.transparent,
                        content: SizedBox(
                          width: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Please select a domain",
                                style: getTextTheme(context)
                                    .headlineSmall!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: $constants.insets.sm),
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ...widget.authorizedDomains.map(
                                      (e) => Padding(
                                        padding: EdgeInsets.only(
                                          bottom: $constants.insets.sm,
                                        ),
                                        child: GestureDetector(
                                          onTap: isLoading
                                              ? null
                                              : () {
                                                  setState(() {
                                                    selectedDomain = e;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: getTheme(context)
                                                  .surfaceContainer,
                                              borderRadius: BorderRadius.circular(
                                                $constants.corners.sm,
                                              ),
                                            ),
                                            width: double.infinity,
                                            height: 45,
                                            child: Center(child: Text(e)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: $constants.insets.sm,
                            vertical: $constants.insets.xs,
                          ),
                          decoration: BoxDecoration(
                            color: getTheme(context).surface,
                            borderRadius:
                                BorderRadius.circular($constants.corners.sm),
                            border: Border.all(
                              color: Colors.grey.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedDomain ?? 'Select',
                                style: getTextTheme(context).bodyMedium,
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    // First line: Username field
                    AppTextFormField(
                      controller: emailUsernameController,
                      hintText: 'username',
                      backgroundColor: getTheme(context).surface,
                    ),
                    SizedBox(height: $constants.insets.xs),
                    // Second line: @ + domain popup
                    Row(
                      children: [
                        Text(
                          '@',
                          style: getTextTheme(context).bodyLarge,
                        ),
                        SizedBox(width: $constants.insets.xs),
                        Expanded(
                          child: CustomPopup(
                            barrierColor: Colors.transparent,
                            content: SizedBox(
                              width: 250,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Please select a domain",
                                    style: getTextTheme(context)
                                        .headlineSmall!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: $constants.insets.sm),
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ...widget.authorizedDomains.map(
                                          (e) => Padding(
                                            padding: EdgeInsets.only(
                                              bottom: $constants.insets.sm,
                                            ),
                                            child: GestureDetector(
                                              onTap: isLoading
                                                  ? null
                                                  : () {
                                                      setState(() {
                                                        selectedDomain = e;
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: getTheme(context)
                                                      .surfaceContainer,
                                                  borderRadius: BorderRadius.circular(
                                                    $constants.corners.sm,
                                                  ),
                                                ),
                                                width: double.infinity,
                                                height: 45,
                                                child: Center(child: Text(e)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: $constants.insets.sm,
                                vertical: $constants.insets.xs,
                              ),
                              decoration: BoxDecoration(
                                color: getTheme(context).surface,
                                borderRadius:
                                    BorderRadius.circular($constants.corners.sm),
                                border: Border.all(
                                  color: Colors.grey.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedDomain ?? 'Select',
                                    style: getTextTheme(context).bodyMedium,
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              if (newEmailError != null) ...[
                SizedBox(height: $constants.insets.xxs),
                Text(
                  newEmailError!,
                  style: getTextTheme(context).bodySmall!.copyWith(
                        color: getTheme(context).error,
                      ),
                ),
              ],
              SizedBox(height: $constants.insets.md),

              // Backup email field
              Text(
                context.t.email_domain_validation.backup_email_label,
                style: getTextTheme(context).bodySmall!.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: $constants.insets.xxs),
              AppTextFormField(
                controller: backupEmailController,
                hintText: context.t.email_domain_validation.backup_email_hint,
                backgroundColor: getTheme(context).surface,
              ),
              if (backupEmailError != null) ...[
                SizedBox(height: $constants.insets.xxs),
                Text(
                  backupEmailError!,
                  style: getTextTheme(context).bodySmall!.copyWith(
                        color: getTheme(context).error,
                      ),
                ),
              ],
              SizedBox(height: $constants.insets.md),

              // Info text
              Container(
                padding: EdgeInsets.all($constants.insets.sm),
                decoration: BoxDecoration(
                  color:
                      getTheme(context).primaryContainer.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular($constants.corners.sm),
                ),
                child: Text(
                  context.t.email_domain_validation.info,
                  style: getTextTheme(context).bodySmall,
                ),
              ),
              SizedBox(height: $constants.insets.md),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: PrimaryButtonSquare(
                  onPressed: isLoading ? null : _validateAndSubmit,
                  text: isLoading
                      ? context.t.email_domain_validation.submitting
                      : context.t.email_domain_validation.submit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
