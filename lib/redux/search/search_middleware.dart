import 'package:github_flutter_redux/data/api_response.dart';
import 'package:github_flutter_redux/data/search_repository.dart';
import 'package:github_flutter_redux/redux/search/search_actions.dart';
import 'package:github_flutter_redux/redux/search/search_state.dart';
import 'package:redux/redux.dart';

class SearchMiddleware implements MiddlewareClass<SearchState> {
  final SearchRepository searchRepository;

  SearchMiddleware(this.searchRepository);

  @override
  call(Store store, action, NextDispatcher next) async {
    if (action is SearchResultLoadAction) {
      store.dispatch(SearchResultLoadedAction(ApiResponse.loading('loading')));
      try {
        final data = await searchRepository
            .searchRepositories(action.query.replaceAll(' ', '+'));
        store.dispatch(SearchResultLoadedAction(ApiResponse.completed(data)));
      } catch (e) {
        store.dispatch(
            SearchResultLoadedAction(ApiResponse.error(e.toString())));
      }
    }

    next(action);
  }
}
