import 'package:ab_shared/components/ab_toast.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/components/toast_notifications/selected_mails.dart';
import 'package:mail/models/mail/mail.dart';
import 'package:mail/pages/appbars/mail_appbar.dart';
import 'package:mail/pages/mails/mail_details.dart';
import 'package:mail/pages/mails/mail_list.dart';
import 'package:mail/pages/mails/no_mail_selected.dart';
import 'package:mail/pages/mails/selected_list.dart';
import 'package:mail/utils/get_it.dart';

class FliteredMailView extends StatefulWidget {
  final String title;
  final Function(Mail)? filter;
  const FliteredMailView({super.key, required this.title, this.filter});

  @override
  State<FliteredMailView> createState() => _FliteredMailViewState();
}

class _FliteredMailViewState extends State<FliteredMailView> {
  final abToastController = getIt<ABToastController>();
  List<Mail> selectedMails = [];
  bool? isSelecting = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MailBloc, MailState>(builder: (context, mailState) {
      final filteredMails = mailState.mails
              ?.where((mail) => widget.filter?.call(mail) ?? true)
              .toList() ??
          [];
      if (!isDesktop(context) &&
          selectedMails.isNotEmpty &&
          isSelecting == true) {
        abToastController.replaceNotification(
          ABToastNotification(
            key: ValueKey("selected_mails"),
            content: SelectedMailsToastNotification(mails: selectedMails),
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SizedBox(
                    height: getSize(context).height * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular($constants.corners.lg),
                        topRight: Radius.circular($constants.corners.lg),
                      ),
                      child: SelectedListScreen(
                        mails: selectedMails,
                        windowed: true,
                        onClearSelection: () {
                          setState(() {
                            selectedMails.clear();
                          });
                        },
                      ),
                    )),
              );
            },
          ),
        );
      } else {
        abToastController.removeNotification(
          ValueKey("selected_mails"),
        );
      }
      return Row(
        children: [
          SizedBox(
            width: isDesktop(context)
                ? getSize(context).width > $constants.screenSize.md
                    ? 350
                    : getSize(context).width * 0.66
                : getSize(context).width,
            child: Column(
              children: [
                MailAppbar(title: widget.title),
                Expanded(
                  child: MailList(
                    mails: filteredMails,
                    onSelect: (mail) {
                      setState(() {
                        selectedMails.add(mail);
                      });
                    },
                    onDeselect: (mail) {
                      setState(() {
                        selectedMails.remove(mail);
                      });
                    },
                    selectedMails: selectedMails,
                    isSelecting: isSelecting,
                    setIsSelecting: (value) {
                      setState(() {
                        isSelecting = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          if (isDesktop(context) &&
              getSize(context).width > $constants.screenSize.md) ...[
            SizedBox(width: $constants.insets.xs),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  right: $constants.insets.xs,
                  bottom: $constants.insets.xs,
                ),
                child: filteredMails.isEmpty || selectedMails.isEmpty
                    ? NoMailSelectedScreen(
                        icon: CupertinoIcons.tray_arrow_down,
                        title: widget.title,
                        numberOfMails: filteredMails.length,
                      )
                    : selectedMails.length == 1 && isSelecting != true
                        ? MailDetailScreen(
                            selectedMails.first,
                            mode: MailScreenMode.integrated,
                            onCancel: () {
                              setState(() {
                                selectedMails.clear();
                              });
                            },
                          )
                        : SelectedListScreen(
                            mails: selectedMails,
                            onClearSelection: () {
                              setState(() {
                                selectedMails.clear();
                              });
                            },
                          ),
              ),
            ),
          ]
        ],
      );
    });
  }
}
