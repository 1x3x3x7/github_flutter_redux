import 'package:github_flutter_redux/redux/search_actions.dart';
import 'package:github_flutter_redux/redux/search_state.dart';
import 'package:redux/redux.dart';

final searchReducer = combineReducers<SearchState>([
  TypedReducer<SearchState, SearchResultLoadAction>(_onLoad),
  TypedReducer<SearchState, SearchResultLoadedAction>(_onLoaded),
]);

SearchState _onLoad(SearchState state, SearchResultLoadAction action) =>
    state.copyWith();

SearchState _onLoaded(SearchState state, SearchResultLoadedAction action) =>
    state.copyWith(response: action.data);
