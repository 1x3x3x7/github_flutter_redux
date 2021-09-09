import 'package:github_flutter_redux/redux/app_state.dart';
import 'package:github_flutter_redux/redux/search_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(searchState: searchReducer(state.searchState, action));
}
