part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class SelectedCategory extends HomeState {}

final class SetCurrentTapIndex extends HomeState {}

final class LoodingLoadSources extends HomeState {}

final class SuccsedLoadSources extends HomeState {}

final class ErorrLoadSources extends HomeState {}

final class LoodingLoadArticle extends HomeState {}

final class SuccsedLoadArticle extends HomeState {}

final class ErorrLoadArticle extends HomeState {}

final class SelectedArticle extends HomeState {}

final class ClickSearch extends HomeState {}

final class onClickUrl extends HomeState {}
