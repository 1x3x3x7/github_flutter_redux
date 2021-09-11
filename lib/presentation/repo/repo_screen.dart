import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:github_flutter_redux/data/api_response.dart';
import 'package:github_flutter_redux/domain/repo_response.dart';
import 'package:github_flutter_redux/presentation/common/app_error_widget.dart';
import 'package:github_flutter_redux/presentation/common/app_loading_widget.dart';
import 'package:github_flutter_redux/redux/app/app_state.dart';
import 'package:github_flutter_redux/redux/repo/repo_actions.dart';
import 'package:redux/redux.dart';

class RepoScreen extends StatefulWidget {
  final String owner;
  final String repo;
  const RepoScreen({Key? key, required this.owner, required this.repo})
      : super(key: key);

  @override
  _RepoScreenState createState() => _RepoScreenState();
}

class _RepoScreenState extends State<RepoScreen> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RepoViewModel>(
        converter: (store) => RepoViewModel.fromStore(store),
        onInit: (store) =>
            store.dispatch(RepoLoadAction(widget.owner, widget.repo)),
        builder: (context, vm) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.repo),
            ),
            body: buildWidget(vm.response, () => vm.onRetry(vm.owner, vm.repo)),
          );
        });
  }

  buildWidget(ApiResponse<RepoResponse> response, VoidCallback onRetry) {
    switch (response.status) {
      case Status.LOADING:
        return Center(
            child: AppLoadingWidget(loadingMessage: response.message));
      case Status.ERROR:
        return Center(
            child: AppErrorWidget(
          errorMessage: response.message,
          onRetryPressed: onRetry,
        ));
      case Status.COMPLETED:
        return Center(child: Text(response.data?.description ?? ''));
      default:
        throw ArgumentError('No argument ${response.status}');
    }
  }
}

class RepoViewModel {
  ApiResponse<RepoResponse> response;
  String owner;
  String repo;
  Function onRetry;
  RepoViewModel(this.owner, this.repo, this.response, this.onRetry);

  static fromStore(Store<AppState> store) {
    return RepoViewModel(
        store.state.repoState.owner,
        store.state.repoState.repo,
        store.state.repoState.response,
        (owner, repo) => store.dispatch(RepoLoadAction(owner, repo)));
  }
}
