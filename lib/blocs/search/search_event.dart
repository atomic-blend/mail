part of 'search_bloc.dart';

sealed class SearchEvent {
  const SearchEvent();
}

final class Search extends SearchEvent {
  const Search(this.query, this.mailBloc);
  final String query;
  final MailBloc mailBloc;
}

final class SearchLogout extends SearchEvent {
  const SearchLogout();
}