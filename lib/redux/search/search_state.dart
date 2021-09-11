import 'package:github_flutter_redux/data/api_response.dart';
import 'package:github_flutter_redux/domain/search_repositories_response.dart';

class SearchState {
  final ApiResponse<SearchRepositoriesResponse> response;
  final String query;

  SearchState({required this.response, this.query = ''});

  copyWith({ApiResponse<SearchRepositoriesResponse>? response, String? query}) {
    return SearchState(
        response: response ?? this.response, query: query ?? this.query);
  }
}
