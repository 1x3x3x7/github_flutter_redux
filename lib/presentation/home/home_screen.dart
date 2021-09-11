import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:github_flutter_redux/common/app_routes.dart';
import 'package:github_flutter_redux/data/api_response.dart';
import 'package:github_flutter_redux/domain/search_repositories_response.dart';
import 'package:github_flutter_redux/presentation/home/search_result_widget.dart';
import 'package:github_flutter_redux/presentation/home/search_widget.dart';
import 'package:github_flutter_redux/redux/app/app_state.dart';
import 'package:github_flutter_redux/redux/search/search_actions.dart';
import 'package:redux/redux.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SearchViewModel>(
      converter: (store) => SearchViewModel.fromStore(store),
      builder: (context, vm) => Scaffold(
          appBar: AppBar(title: SearchWidget(onSubmitText: vm.onSumbitText)),
          body: SearchResultWidget(
            response: vm.response,
            openRepo: vm.openRepo,
            onRetry: () => vm.onSumbitText(vm.query),
          )),
    );
  }
}

class SearchViewModel {
  final Function onSumbitText;
  final Function openRepo;
  final ApiResponse<SearchRepositoriesResponse> response;
  final String query;

  SearchViewModel(this.onSumbitText, this.openRepo, this.response, this.query);

  static fromStore(Store<AppState> store) {
    return SearchViewModel(
        (query) => store.dispatch(SearchResultLoadAction(query)),
        (data) => store.dispatch(
            NavigateToAction.push(AppRoutes.repo_srceen, arguments: data)),
        store.state.searchState.response,
        store.state.searchState.query);
  }
}
