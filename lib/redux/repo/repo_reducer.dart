import 'package:github_flutter_redux/redux/repo/repo_actions.dart';
import 'package:github_flutter_redux/redux/repo/repo_state.dart';
import 'package:redux/redux.dart';

final repoReducer = combineReducers<RepoState>([
  TypedReducer<RepoState, RepoLoadAction>(_onLoad),
  TypedReducer<RepoState, RepoLoadedAction>(_onLoaded),
]);

RepoState _onLoad(RepoState state, RepoLoadAction action) => state.copyWith();

RepoState _onLoaded(RepoState state, RepoLoadedAction action) =>
    state.copyWith(response: action.data);
