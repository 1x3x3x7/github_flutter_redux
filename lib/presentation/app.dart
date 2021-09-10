import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:github_flutter_redux/common/app_routes.dart';
import 'package:github_flutter_redux/data/app_client.dart';
import 'package:github_flutter_redux/data/repo_repository.dart';
import 'package:github_flutter_redux/data/search_repository.dart';
import 'package:github_flutter_redux/common/extensions.dart';
import 'package:github_flutter_redux/presentation/home_screen.dart';
import 'package:github_flutter_redux/presentation/repo_screen.dart';
import 'package:github_flutter_redux/redux/app/app_reducer.dart';
import 'package:github_flutter_redux/redux/app/app_state.dart';
import 'package:github_flutter_redux/redux/repo/repo_middleware.dart';
import 'package:github_flutter_redux/redux/search/search_middleware.dart';
import 'package:redux/redux.dart';

class App extends StatelessWidget {
  final theme = ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  final appClient = AppClient();
  late final searchRepository = SearchRepository(appClient);
  late final repoRepository = RepoRepository(appClient);
  late final store = Store<AppState>(
    appReducer,
    middleware: [
      SearchMiddleware(searchRepository),
      RepoMiddleware(repoRepository),
      const NavigationMiddleware<AppState>()
    ],
    initialState: AppState.initial(),
  );

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Github',
        theme: theme,
        navigatorKey: NavigatorHolder.navigatorKey,
        onGenerateRoute: _getRoute,
      ),
    );
  }

  Route _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home_screen:
        return const HomeScreen().buildRoute(settings);
      case AppRoutes.repo_srceen:
        return RepoScreen(
                owner: (settings.arguments as Set<String>).first,
                repo: (settings.arguments as Set<String>).last)
            .buildRoute(settings);
      default:
        throw ArgumentError('No agrument ${settings.name}');
    }
  }
}
