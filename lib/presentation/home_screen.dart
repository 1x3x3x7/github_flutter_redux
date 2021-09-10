import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:github_flutter_redux/common/app_routes.dart';
import 'package:github_flutter_redux/data/api_response.dart';
import 'package:github_flutter_redux/domain/search_repositories_response.dart';
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
          )),
    );
  }
}

class SearchWidget extends StatelessWidget {
  final Function onSubmitText;
  const SearchWidget({Key? key, required this.onSubmitText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white,
      decoration: const InputDecoration.collapsed(hintText: 'Search'),
      autofocus: true,
      onSubmitted: (text) => onSubmitText(text),
    );
  }
}

class SearchResultWidget extends StatelessWidget {
  final ApiResponse<SearchRepositoriesResponse> response;
  final Function openRepo;
  const SearchResultWidget(
      {Key? key, required this.response, required this.openRepo})
      : super(key: key);

  @override
  Widget build(BuildContext context) => buildWidget(response, openRepo);

  buildWidget(
      ApiResponse<SearchRepositoriesResponse> response, Function openRepo) {
    switch (response.status) {
      case Status.LOADING:
        return const Center(child: CircularProgressIndicator());
      case Status.ERROR:
        return Center(child: Text(response.message));
      case Status.COMPLETED:
        return Center(
            child: ListView.builder(
                itemCount: response.data?.items.length ?? 0,
                itemBuilder: (context, index) {
                  final item = response.data!.items[index];
                  return InkWell(
                    onTap: () => openRepo({item.owner!.login, item.name}),
                    child: Card(
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item.name),
                              Text('☆ ${item.stargazersCount}')
                            ],
                          ),
                        )),
                  );
                }));
      default:
        throw ArgumentError('No argument ${response.status}');
    }
  }
}

class SearchViewModel {
  final Function onSumbitText;
  final Function openRepo;
  final ApiResponse<SearchRepositoriesResponse> response;
  SearchViewModel(this.onSumbitText, this.openRepo, this.response);

  static fromStore(Store<AppState> store) {
    return SearchViewModel(
        (query) => store.dispatch(SearchResultLoadAction(query)),
        (data) => store.dispatch(
            NavigateToAction.push(AppRoutes.repo_srceen, arguments: data)),
        store.state.searchState.response);
  }
}
