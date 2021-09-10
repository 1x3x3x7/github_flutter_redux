import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_flutter_redux/data/api_response.dart';
import 'package:github_flutter_redux/redux/repo/repo_state.dart';
import 'package:github_flutter_redux/redux/search/search_state.dart';

@immutable
class AppState {
  final SearchState searchState;
  final RepoState repoState;
  const AppState({required this.searchState, required this.repoState});

  factory AppState.initial() {
    return AppState(
        searchState: SearchState(response: ApiResponse.completed(null)),
        repoState: RepoState(response: ApiResponse.completed(null)));
  }
  AppState copyWith(SearchState? searchState, RepoState? repoState) {
    return AppState(
        searchState: searchState ?? this.searchState,
        repoState: repoState ?? this.repoState);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          searchState == other.searchState &&
          repoState == other.repoState;

  @override
  String toString() => const JsonEncoder.withIndent(' ').convert(this);

  @override
  int get hashCode => searchState.hashCode ^ repoState.hashCode;
}
