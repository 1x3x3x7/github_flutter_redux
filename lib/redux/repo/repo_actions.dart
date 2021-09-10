import 'package:github_flutter_redux/data/api_response.dart';
import 'package:github_flutter_redux/domain/repo_response.dart';

class RepoLoadAction {
  final String owner;
  final String repo;

  RepoLoadAction(this.owner, this.repo);
}

class RepoLoadedAction {
  final ApiResponse<RepoResponse> data;

  RepoLoadedAction(this.data);
}
