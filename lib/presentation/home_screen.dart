import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_flutter_redux/data/api_response.dart';
import 'package:github_flutter_redux/data/search_repositories_response.dart';
import 'package:github_flutter_redux/redux/app_state.dart';
import 'package:github_flutter_redux/redux/search_actions.dart';
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
          body: SearchResultWidget(response: vm.response)),
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
  const SearchResultWidget({Key? key, required this.response})
      : super(key: key);

  @override
  Widget build(BuildContext context) => buildWidget(response);

  buildWidget(ApiResponse<SearchRepositoriesResponse> response) {
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
                  return Card(
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(response.data?.items[index].name ?? ''),
                      ));
                }));
      default:
        throw ArgumentError('No argument ${response.status}');
    }
  }
}

class SearchViewModel {
  final Function onSumbitText;
  final ApiResponse<SearchRepositoriesResponse> response;
  SearchViewModel(this.onSumbitText, this.response);

  static fromStore(Store<AppState> store) {
    return SearchViewModel(
        (query) => store.dispatch(SearchResultLoadAction(query)),
        store.state.searchState.response);
  }
}
