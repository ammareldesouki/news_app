import 'package:flutter/material.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/network/api_request.dart';
import 'package:news_app/features/home/presentation/widgets/article_card.dart';

class ArticleList extends StatefulWidget {
  final String sourceid;

  const ArticleList({super.key, required this.sourceid});

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  final ScrollController _scrollController = ScrollController();
  final List<ArticleDetailesModel> _articles = [];
  int _currentPage = 1;
  final int _pageSize = 20;
  bool _isLoading = false;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _loadArticles(reset: true);
    _scrollController.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(covariant ArticleList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sourceid != widget.sourceid) {
      _loadArticles(reset: true);
    }
  }

  void _onScroll() {
    if (!_scrollController.hasClients || _isLoadingMore || !_hasMore) return;

    final threshold = 200; // pixels from bottom
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= threshold) {
      _loadArticles();
    }
  }

  Future<void> _loadArticles({bool reset = false}) async {
    if (_isLoading || _isLoadingMore) return;

    if (reset) {
      setState(() {
        _articles.clear();
        _currentPage = 1;
        _hasMore = true;
        _isLoading = true;
      });
    } else {
      setState(() {
        _isLoadingMore = true;
      });
    }

    try {
      final List<ArticleDetailesModel> newArticles =
          await ApiRequests.getArticles(
            widget.sourceid,
            page: _currentPage,
            pageSize: _pageSize,
          );

      setState(() {
        if (newArticles.isEmpty) {
          _hasMore = false;
        } else {
          _articles.addAll(newArticles);
          _currentPage++;
        }
        _isLoading = false;
        _isLoadingMore = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isLoadingMore = false;
      });
      print('Error loading articles: $e');
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_articles.isEmpty && _isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_articles.isEmpty) {
      return const Center(child: Text('No articles available'));
    }

    return Column(
      children: [
        ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) =>
              ArticleCard(articleDetailesModel: _articles[index]),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: _articles.length,
        ),
        if (_isLoadingMore)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: CircularProgressIndicator(),
          ),
        if (!_hasMore && _articles.isNotEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'No more articles to load',
              style: TextStyle(color: Colors.grey),
            ),
          ),
      ],
    );
  }
}
