part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class SelectedCategory extends HomeState {}

final class SetCurrentTapIndex extends HomeState {}

final class LoadingLoadSources extends HomeState {}

final class SuccessLoadSources extends HomeState {}

final class ErrorLoadSources extends HomeState {}

final class LoadingLoadArticle extends HomeState {}

final class SuccessLoadArticle extends HomeState {}

final class ErrorLoadArticle extends HomeState {}

final class SelectedArticle extends HomeState {}

final class ClickSearch extends HomeState {}

final class OnClickUrl extends HomeState {}

final class LoadingSearchArticles extends HomeState {}

final class SuccessSearchArticles extends HomeState {}

final class ErrorSearchArticles extends HomeState {}

final class SearchCleared extends HomeState {}