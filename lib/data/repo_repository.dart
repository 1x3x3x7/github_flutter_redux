import 'package:github_flutter_redux/data/app_client.dart';
import 'package:github_flutter_redux/domain/repo_response.dart';

class RepoRepository {
  final AppClient appClient;
  RepoRepository(this.appClient);

  Future<RepoResponse> getRepo(String owner, String repo) async =>
      RepoResponse.fromJson(await appClient.get('repos/$owner/$repo'));
}
