import 'package:github_flutter_redux/data/api_response.dart';
import 'package:github_flutter_redux/domain/search_repositories_response.dart';

class SearchState {
  final ApiResponse<SearchRepositoriesResponse> response;

  SearchState({required this.response});

  copyWith({ApiResponse<SearchRepositoriesResponse>? response}) {
    return SearchState(response: response ?? this.response);
  }
}
