import 'package:github_flutter_redux/data/api_response.dart';
import 'package:github_flutter_redux/domain/repo_response.dart';

class RepoState {
  final ApiResponse<RepoResponse> response;

  RepoState({required this.response});

  copyWith({ApiResponse<RepoResponse>? response}) {
    return RepoState(response: response ?? this.response);
  }
}
