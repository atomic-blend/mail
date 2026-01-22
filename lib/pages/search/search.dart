import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/blocs/search/search_bloc.dart';
import 'package:mail/components/cards/mail_card.dart';
import 'package:mail/models/mail/mail.dart';
import 'package:mail/pages/mails/mail_details.dart';

part 'search.g.dart';

@TypedGoRoute<SearchRoute>(path: '/search', name: "search")
class SearchRoute extends GoRouteData with _$SearchRoute {
  final String? q;

  SearchRoute({this.q});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SearchScreen(
      query: q,
    );
  }
}

class SearchScreen extends StatefulWidget {
  final String? query;

  const SearchScreen({super.key, this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  dynamic previewed;

  @override
  void initState() {
    super.initState();
    _searchMails(context.read<MailBloc>().state.mails ?? [], widget.query);
  }

  @override
  void didUpdateWidget(covariant SearchScreen oldWidget) {
    if (oldWidget.query != widget.query) {
      _searchMails(context.read<MailBloc>().state.mails ?? [], widget.query);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _searchMails(List<Mail> mails, String? query) {
    context.read<SearchBloc>().add(
          Search(
            query ?? "",
            context.read<MailBloc>(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
        builder: (context, searchState) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: $constants.insets.xs),
        child: Row(
          children: [
            SizedBox(
              width: isDesktop(context)
                  ? getSize(context).width > $constants.screenSize.md
                      ? 350
                      : getSize(context).width * 0.66
                  : getSize(context).width * 0.95,
              child: Column(
                children: [
                  if (searchState is SearchLoaded) ...[
                    ...searchState.results.map((result) {
                      if (result is Mail) {
                        return Padding(
                          padding:
                              EdgeInsets.only(bottom: $constants.insets.xs),
                          child: MailCard(
                            mail: result,
                            onTap: (dynamic mail) {
                              if (isDesktop(context)) {
                                setState(() {
                                  previewed = mail;
                                });
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MailDetailScreen(
                                          mail,
                                          onCancel: () {
                                            Navigator.of(context).pop();
                                          },
                                        )));
                              }
                            },
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                  ],
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
                  child: _buildSearchPreview(),
                ),
              ),
            ]
          ],
        ),
      );
    });
  }

  Widget _buildSearchPreview() {
    if (previewed is Mail) {
      return MailDetailScreen(
        previewed as Mail,
        mode: MailScreenMode.integrated,
        onCancel: () {
          if (isDesktop(context)) {
            setState(() {
              previewed = null;
            });
          } else {
            Navigator.of(context).pop();
          }
        },
      );
    }
    return const SizedBox.shrink();
  }
}
