import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/models/category_model.dart';
import 'package:news_app/core/network/api_request.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/models/sources_data_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<SourcesDtailesModel> _sources = [];
  int _selectedTabIndex = 0;
  bool _isLoading = false;
  CategoryModel? _selectedCategory;
  ArticleDetailesModel? _selectedArticle;
  List<ArticleDetailesModel> _articles = [];
  List<ArticleDetailesModel> _searchResults = [];
  bool _isSearching = false;
  bool _isSearchLoading = false;
  final TextEditingController _searchController = TextEditingController();

  List<SourcesDtailesModel> get sources => _sources;
  List<ArticleDetailesModel> get articles => _articles;

  List<ArticleDetailesModel> get searchResults => _searchResults;
  ArticleDetailesModel? get selectedArticle => _selectedArticle;
  CategoryModel? get selectedCategory => _selectedCategory;

  bool get clickSerch => _isSearching;

  bool get isSearchLoading => _isSearchLoading;

  TextEditingController get searchController => _searchController;
  int get currentTapIndex => _selectedTabIndex;
  bool get isLoading => _isLoading;

  static HomeCubit get(context) => BlocProvider.of(context);

  void onClickSearch() {
    _isSearching = !_isSearching;
    if (!_isSearching) {
      _searchController.clear();
      _searchResults = [];
    }
    emit(ClickSearch());
  }

  void onClickCategoryCard({CategoryModel? category}) {
    _selectedCategory = category;
    _isSearching = false;
    _searchResults = [];
    _searchController.clear();
    emit(SelectedCategory());
  }

  Future<void> setCurrentTapIndex(int index) async {
    _selectedTabIndex = index;
    await getArticles(_sources[index].id);
    emit(SetCurrentTapIndex());
  }

  Future<void> getArticles(String sourceId) async {
    emit(LoadingLoadArticle());
    try {
      _articles = await ApiRequests.getArticles(sourceId);
      emit(SuccessLoadArticle());
    } catch (e) {
      print('Error loading articles: $e');
      emit(ErrorLoadArticle());
    }
  }

  Future<void> loadSources(String categoryId) async {
    _isLoading = true;
    emit(LoadingLoadSources());
    try {
      _sources = await ApiRequests.getSources(categoryId);
      emit(SuccessLoadSources());
      _isLoading = false;
    } catch (e) {
      print('Error loading sources: $e');
      emit(ErrorLoadSources());
    }
  }

  void onClickArticleCard({ArticleDetailesModel? article}) {
    _selectedArticle = article;
    emit(SelectedArticle());
  }

  Future<void> onClickShowArticle(String articleUrl) async {
    final Uri uri = Uri.parse(articleUrl);
    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      emit(OnClickUrl());
    }
  }

  Future<void> searchArticles(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      _isSearchLoading = false;
      emit(SearchCleared());
      return;
    }

    _isSearchLoading = true;
    emit(LoadingSearchArticles());
    try {
      _searchResults = await ApiRequests.searchArticles(query);
      _isSearchLoading = false;
      emit(SuccessSearchArticles());
    } catch (e) {
      print('Error searching articles: $e');
      _isSearchLoading = false;
      _searchResults = [];
      emit(ErrorSearchArticles());
    }
  }

  @override
  Future<void> close() {
    _searchController.dispose();
    return super.close();
  }
}