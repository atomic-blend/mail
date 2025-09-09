import 'package:ab_shared/components/responsive_stateful_widget.dart';
import 'package:ab_shared/components/widgets/elevated_container.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MailComposer extends ResponsiveStatefulWidget {
  const MailComposer({super.key});

  @override
  ResponsiveState<MailComposer> createState() => _MailComposerState();
}

class _MailComposerState extends ResponsiveState<MailComposer> {
  EditorState editorState = EditorState.blank(withInitialText: true);

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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        print("didPop: $didPop");
        print("result: $result");
        //TODO: close the composer if empty
        //TODO: ask the user if they want to save the draft when the body content is not filled but there is a subject / from / to
        //TODO: save the draft if there's a mail content automatically
      },
      child: ElevatedContainer(
          padding: EdgeInsets.only(top: $constants.insets.xs,),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: $constants.insets.sm),
                child: Divider(),
              ),  
              SizedBox(height: $constants.insets.xs),
              //TODO: Add email fields (To, Subject, etc.) here
              //TODO: Add email content editor here
              _buildPaddedDivider(),
              SizedBox(
                width: double.infinity,
                height: 500,
                child: AppFlowyEditor(
                  editorStyle: EditorStyle.mobile(), 
                      editorState: editorState,
                    ),
              ),

            ],
          ),
        ),
      ) ;
  }

  Widget _buildPaddedDivider() {
   return  Padding(
                padding: EdgeInsets.symmetric(horizontal: $constants.insets.sm),
                child: Divider(),
              );
  }

  void _sendMail() {
    final htmlContent = documentToHTML(editorState.document);
    final mdContent = documentToMarkdown(editorState.document);
    final plainTextContent = _plainTextFromMarkdown(mdContent);
    print("HTML Content: $htmlContent");
    print("Markdown Content: $mdContent");
    print("Plain Text Content: $plainTextContent");
  }
  
  String _plainTextFromMarkdown(String mdContent) {
// Regular expression to match Markdown symbols including '#'
RegExp regex = RegExp(r'[*_~`#]');
// Replace Markdown symbols with an empty string
return mdContent.replaceAll(regex, '');
  } 
}

