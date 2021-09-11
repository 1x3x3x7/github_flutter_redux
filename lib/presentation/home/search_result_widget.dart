import 'package:flutter/material.dart';
import 'package:github_flutter_redux/data/api_response.dart';
import 'package:github_flutter_redux/domain/search_repositories_response.dart';
import 'package:github_flutter_redux/presentation/common/app_error_widget.dart';
import 'package:github_flutter_redux/presentation/common/app_loading_widget.dart';

class SearchResultWidget extends StatelessWidget {
  final ApiResponse<SearchRepositoriesResponse> response;
  final Function openRepo;
  final VoidCallback onRetry;
  const SearchResultWidget(
      {Key? key,
      required this.response,
      required this.openRepo,
      required this.onRetry})
      : super(key: key);

  @override
  Widget build(BuildContext context) => buildWidget(response, openRepo);

  buildWidget(
      ApiResponse<SearchRepositoriesResponse> response, Function openRepo) {
    switch (response.status) {
      case Status.LOADING:
        return Center(
            child: AppLoadingWidget(loadingMessage: response.message));
      case Status.ERROR:
        return Center(
            child: AppErrorWidget(
                onRetryPressed: onRetry, errorMessage: response.message));
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
