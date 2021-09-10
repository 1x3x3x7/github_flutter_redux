import 'package:github_flutter_redux/redux/app/app_state.dart';
import 'package:github_flutter_redux/redux/repo/repo_reducer.dart';
import 'package:github_flutter_redux/redux/search/search_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
      searchState: searchReducer(state.searchState, action),
      repoState: repoReducer(state.repoState, action));
}
