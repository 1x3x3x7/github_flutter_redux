import 'package:github_flutter_redux/data/api_response.dart';
import 'package:github_flutter_redux/data/repo_repository.dart';
import 'package:github_flutter_redux/redux/repo/repo_actions.dart';
import 'package:github_flutter_redux/redux/repo/repo_state.dart';
import 'package:redux/redux.dart';

class RepoMiddleware implements MiddlewareClass<RepoState> {
  final RepoRepository repoRepository;

  RepoMiddleware(this.repoRepository);

  @override
  call(Store store, action, NextDispatcher next) async {
    if (action is RepoLoadAction) {
      store.dispatch(RepoLoadedAction(ApiResponse.loading('loading')));
      try {
        final data = await repoRepository.getRepo(action.owner, action.repo);
        store.dispatch(RepoLoadedAction(ApiResponse.completed(data)));
      } catch (e) {
        store.dispatch(RepoLoadedAction(ApiResponse.error(e.toString())));
      }
    }

    next(action);
  }
}
