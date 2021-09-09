import 'package:github_flutter_redux/data/app_client.dart';
import 'package:github_flutter_redux/data/search_repositories_response.dart';

class SearchRepository {
  final AppClient appClient;
  SearchRepository(this.appClient);

  Future<SearchRepositoriesResponse> searchRepositories(String query) async =>
      SearchRepositoriesResponse.fromJson(await appClient
          .get('search/repositories?q=$query+&sort=stars&order=desc'));
}
