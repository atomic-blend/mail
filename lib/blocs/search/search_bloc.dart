import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/models/mail/mail.dart';
import 'package:mail/services/search_service.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends HydratedBloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<Search>(_onSearch);
  }

  @override
  SearchState? fromJson(Map<String, dynamic> json) {
    return SearchInitial();
  }

  @override
  Map<String, dynamic>? toJson(SearchState state) {
    return null;
  }

  void _onSearch(Search event, Emitter<SearchState> emit) {
    emit(SearchLoading());
    try {
      final results = SearchService.search([
        ...event.mailBloc.state.mails ?? [],
      ], event.query);
      emit(SearchLoaded(results));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
