import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_flutter_redux/data/api_response.dart';
import 'package:github_flutter_redux/redux/search_state.dart';

@immutable
class AppState {
  final SearchState searchState;
  const AppState({required this.searchState});

  factory AppState.initial() {
    return AppState(
        searchState: SearchState(response: ApiResponse.completed(null)));
  }
  AppState copyWith(SearchState? searchState) {
    return AppState(searchState: searchState ?? this.searchState);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          searchState == other.searchState;

  @override
  String toString() => const JsonEncoder.withIndent(' ').convert(this);

  @override
  int get hashCode => searchState.hashCode;
}
