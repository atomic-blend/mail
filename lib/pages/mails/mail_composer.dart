import 'package:ab_shared/components/responsive_stateful_widget.dart';
import 'package:ab_shared/components/widgets/elevated_container.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MailComposer extends ResponsiveStatefulWidget {
  const MailComposer({super.key});

  @override
  ResponsiveState<MailComposer> createState() => _MailComposerState();
}

class _MailComposerState extends ResponsiveState<MailComposer> {

  @override
  void initState() {
    super.initState();
    _initializeEditor();
  }

  void _initializeEditor() {
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
                    IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.arrow_up_circle_fill, size: 30,color: getTheme(context).primary,),), 
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
            ],
          ),
        ),
      ) ;
  }
}