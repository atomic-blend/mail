import 'package:ab_shared/blocs/auth/auth.bloc.dart';
import 'package:ab_shared/components/forms/app_text_form_field.dart';
import 'package:ab_shared/components/responsive_stateful_widget.dart';
import 'package:ab_shared/components/widgets/elevated_container.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/models/mail/mail.dart';

class MailComposer extends ResponsiveStatefulWidget {
  const MailComposer({super.key});

  @override
  ResponsiveState<MailComposer> createState() => _MailComposerState();
}

class _MailComposerState extends ResponsiveState<MailComposer> {
  EditorState editorState = EditorState.blank(withInitialText: true);
  TextEditingController subjectController = TextEditingController();
  TextEditingController toController = TextEditingController();

  String? subject;
  String? from;
  List<String> availableFrom = [];
  List<String>? to = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return const Placeholder();
  }

  @override
  Widget buildMobile(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        availableFrom ??= [];
        if (authState.user != null && !availableFrom.contains(authState.user!.email!)) {
          availableFrom.add(authState.user!.email!);
          from = availableFrom.first;
        }
        return MobileToolbarV2(
          editorState: editorState,
          toolbarItems: [
         textDecorationMobileToolbarItemV2,
          buildTextAndBackgroundColorMobileToolbarItem(),
          blocksMobileToolbarItem,
          linkMobileToolbarItem,
          dividerMobileToolbarItem, 
        
          ],
          child: ElevatedContainer(
              padding: EdgeInsets.only(top: $constants.insets.xs,),
              width: double.infinity,
              child: Column(
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
                  // TODO: Add email fields (To, Subject, etc.) here
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: $constants.insets.sm),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("New Mail", style: getTextTheme(context).displaySmall!.copyWith(fontWeight: FontWeight.bold),),
                        IconButton(onPressed: (){
                          _sendMail();
                        }, icon: Icon(CupertinoIcons.arrow_up_circle_fill, size: 30,color: getTheme(context).primary,),), 
                      ],
                    ),
                  ),
                  SizedBox(height: $constants.insets.xs),
                  _buildPaddedDivider(),
                  SizedBox(height: $constants.insets.xs),
                  _buildEmailFields("To", toController),
                  SizedBox(height: $constants.insets.xs),
                  _buildPaddedDivider(),
                  _buildEmailFields("From", null, enabled: false, value: from, onTap: () {
                    print("show from selector");
                    // _showFromSelector();
                  },),
                  _buildPaddedDivider(),
                  _buildEmailFields("Subject", subjectController),
                  //TODO: Add email fields (To, Subject, etc.) here
                  //TODO: Add email content editor here
                  _buildPaddedDivider(),
                  SizedBox(height: $constants.insets.xs),
                  SizedBox(
                    width: double.infinity,
                    height: getSize(context).height * 0.42,
                    child: AppFlowyEditor(
                      editorStyle: EditorStyle.mobile(
                      ), 
                          editorState: editorState,
                        ),
                  ),
          
                ],
              ),
            ),
        );
      }
    ) ;
  }

  Widget _buildPaddedDivider() {
   return  Padding(
                padding: EdgeInsets.symmetric(horizontal: $constants.insets.sm),
                child: Divider(),
              );
  }

  Widget _buildEmailFields(String label, TextEditingController? controller, {String? value, bool? enabled = true, VoidCallback? onTap,}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: $constants.insets.sm),
      child: 
      GestureDetector(
        onTap: () {
          if (onTap != null && enabled == false) {
            onTap();
          }
        },
        child: AppTextFormField(
          labelText: label,
          controller: controller,
          value: value,
          backgroundColor: getTheme(context).surface,
          ),
      ),
    );
  }

  void _sendMail() {
    final htmlContent = documentToHTML(editorState.document);
    final mdContent = documentToMarkdown(editorState.document);
    final plainTextContent = _plainTextFromMarkdown(mdContent);
    print("HTML Content: $htmlContent");
    print("Markdown Content: $mdContent");
    print("Plain Text Content: $plainTextContent");

  //TODO: add attachements and create a raw mail entity like it's done in the backend
    final mail = Mail();
    mail.headers = [
      {"Key": "To", "Value": [toController.text]},
      {"Key": "From", "Value": from},
      {"Key": "Subject", "Value": subjectController.text},
    ];
    mail.textContent = plainTextContent;
    mail.htmlContent = htmlContent;
    mail.createdAt = DateTime.now();
    print("Mail: ${mail.toRawMail()}");

    //context.read<MailBloc>().add(SendMail(mail));
  }
  
  String _plainTextFromMarkdown(String mdContent) {
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
    if (editorState.document.isEmpty && (subjectController.text.isNotEmpty || toController.text.isNotEmpty || from != null)) {
      //TODO: show modal
      saveDraft = true;
    }

    if (!editorState.document.isEmpty) {
      //TODO: save the draft
      saveDraft = true;
    }

    if (saveDraft) {
      //TODO: save the draft
      Navigator.pop(context);
      return;
    }
  } 
}

