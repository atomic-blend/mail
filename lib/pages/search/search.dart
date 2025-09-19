import 'package:ab_shared/components/forms/search_bar.dart';
import 'package:ab_shared/components/widgets/elevated_container.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/blocs/search/search_bloc.dart';
import 'package:mail/components/cards/mail_card.dart';
import 'package:mail/models/mail/mail.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
        builder: (context, searchState) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: $constants.insets.xs),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: $constants.insets.xs),
              child: ElevatedContainer(
                child: ABSearchBar(
                  controller: searchController,
                  onChanged: (query) {
                    _onSearch(context, query);
                  },
                ),
              ),
            ),
            if (searchState is SearchLoaded) ...[
              ...searchState.results.map((result) {
                if (result is Mail) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: $constants.insets.xs),
                    child: MailCard(mail: result),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ],
        ),
      );
    });
  }

  void _onSearch(BuildContext context, String query) {
    context.read<SearchBloc>().add(
          Search(
            query,
            context.read<MailBloc>(),
          ),
        );
  }
}
