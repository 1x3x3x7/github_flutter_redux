import 'package:github_flutter_redux/data/api_response.dart';
import 'package:github_flutter_redux/domain/repo_response.dart';

class RepoState {
  final ApiResponse<RepoResponse> response;
  final String owner;
  final String repo;

  RepoState({required this.response, this.owner = '', this.repo = ''});

  copyWith({ApiResponse<RepoResponse>? response, String? owner, String? repo}) {
    return RepoState(
        response: response ?? this.response,
        owner: owner ?? this.owner,
        repo: repo ?? this.repo);
  }
}
