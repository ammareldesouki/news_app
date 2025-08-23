import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
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

  List<SourcesDtailesModel> get sources => _sources;

  List<ArticleDetailesModel> get articles => _articles;

  ArticleDetailesModel? get selectedArticle => _selectedArticle;

  CategoryModel? get selectedCategory => _selectedCategory;
  bool _clickSearch = false;

  bool get clickSerch => _clickSearch;

  int get currentTapIndex => _selectedTabIndex;

  bool get isLoading => _isLoading;

  static HomeCubit get(context) => BlocProvider.of(context);

  void onClickSearch() {
    _clickSearch = !_clickSearch;
    emit(ClickSearch());
  }

  void onClickCategoryCard({CategoryModel? category}) {
    _selectedCategory = category;

    emit(SelectedCategory());
  }

  Future<void> setCurrentTapIndex(int index) async {
    _selectedTabIndex = index;
    await getArticles(_sources[index].id);
    emit(SetCurrentTapIndex());
  }

  Future<void> getArticles(String sourceId) async {
    emit(LoodingLoadArticle());
    try {
      _articles = await ApiRequests.getArticles(sourceId);
      emit(SuccsedLoadArticle());
    } catch (e) {
      print('Error loading articles: $e');
      emit(ErorrLoadArticle());
    }
  }

  Future<void> loadSources(String categoryId) async {
    _isLoading = true;
    emit(LoodingLoadSources());

    try {
      _sources = await ApiRequests.getSources(categoryId);
      emit(SuccsedLoadSources());
      _isLoading = false;
    } catch (e) {
      print('Error loading sources: $e');
      emit(ErorrLoadSources());
    }
  }

  void onClickArticleCard({ArticleDetailesModel? article}) {
    _selectedArticle = article;

    emit(SelectedArticle());
  }

  Future<void> onClickShowArticle(String articleUrl) async {
    final Uri uri = Uri.parse(articleUrl);
    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      emit(onClickUrl());
    }
  }
}
