import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:github_flutter_redux/data/api_response.dart';
import 'package:github_flutter_redux/domain/repo_response.dart';
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
            body: buildWidget(vm.response),
          );
        });
  }

  buildWidget(ApiResponse<RepoResponse> response) {
    switch (response.status) {
      case Status.LOADING:
        return const Center(child: CircularProgressIndicator());
      case Status.ERROR:
        return Center(child: Text(response.message));
      case Status.COMPLETED:
        return Center(child: Text(response.data?.description ?? ''));
      default:
        throw ArgumentError('No argument ${response.status}');
    }
  }
}

class RepoViewModel {
  ApiResponse<RepoResponse> response;
  RepoViewModel(
    this.response,
  );

  static fromStore(Store<AppState> store) {
    return RepoViewModel(store.state.repoState.response);
  }
}
