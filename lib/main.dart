import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_flutter_redux/data/app_client.dart';
import 'package:github_flutter_redux/data/search_repository.dart';
import 'package:github_flutter_redux/presentation/home_screen.dart';
import 'package:github_flutter_redux/redux/app_reducer.dart';
import 'package:github_flutter_redux/redux/app_state.dart';
import 'package:github_flutter_redux/redux/search_middleware.dart';
import 'package:redux/redux.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

final theme = ThemeData(
  primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

class MyApp extends StatelessWidget {
  final appClient = AppClient();
  late final searchRepository = SearchRepository(appClient);
  late final store = Store<AppState>(
    appReducer,
    middleware: [SearchMiddleware(searchRepository)],
    initialState: AppState.initial(),
  );

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Github',
        theme: theme,
        home: HomeScreen(),
      ),
    );
  }
}
