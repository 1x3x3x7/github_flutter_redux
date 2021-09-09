import 'package:github_flutter_redux/data/api_response.dart';
import 'package:github_flutter_redux/data/search_repositories_response.dart';

class SearchResultLoadAction {
  final String query;

  SearchResultLoadAction(this.query);
}

class SearchResultLoadedAction {
  final ApiResponse<SearchRepositoriesResponse> data;
  SearchResultLoadedAction(this.data);
}
