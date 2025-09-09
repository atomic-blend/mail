import 'package:ab_shared/components/responsive_stateful_widget.dart';
import 'package:ab_shared/components/widgets/elevated_container.dart';
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
  Widget buildDesktop(BuildContext context) {
    return const Placeholder();
  }

  @override
  Widget buildMobile(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedContainer(
              padding: EdgeInsets.only(top: getSize(context).height * 0.055),
            height: getSize(context).height * 0.2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(onPressed: () {
                  //TODO: close the composer if empty
                  //TODO: ask the user if they want to save the draft when the body content is not filled but there is a subject / from / to
                  //TODO: save the draft if there's a mail content automatically
                  Navigator.pop(context);
                }, icon: Icon(CupertinoIcons.chevron_back),), 
              ],),
            )
          ],
        ),
      ),
    );
  }
}