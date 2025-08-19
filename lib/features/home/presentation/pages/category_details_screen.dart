import 'package:flutter/material.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/models/sources_data_model.dart';
import 'package:news_app/core/network/api_request.dart';
import 'package:news_app/features/home/presentation/widgets/article_card.dart';

class CategorydDtailsScreen extends StatefulWidget {

  final String categoryName;



  const CategorydDtailsScreen({super.key, required this.categoryName});

  @override
  State<CategorydDtailsScreen> createState() => _CategorydDtailsScreenState();
}

class _CategorydDtailsScreenState extends State<CategorydDtailsScreen> with TickerProviderStateMixin {
  late List<ArticleDetailesModel> _articles = [];
  List<SourcesDtailesModel> _sources = [];
  TabController? _tabController;
  int _selectedTabIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSources();
  }

  Future<void> _loadSources() async {
    setState(() {
      _isLoading = true;
    });
    
    final sources = await ApiRequests.getSources(widget.categoryName);
    
    setState(() {
      _sources = sources;
      _isLoading = false;
    });
    
    // Initialize tab controller after sources are loaded
    if (_sources.isNotEmpty) {
      _tabController = TabController(
        length: _sources.length,
        vsync: this,
        initialIndex: _selectedTabIndex,
      );
      
      _tabController!.addListener(() {
        if (_tabController!.indexIsChanging) {
          setState(() {
            _selectedTabIndex = _tabController!.index;
          });
        }
      });
    }
  }

  String get _selectedSourceId {
    if (_sources.isNotEmpty && _selectedTabIndex < _sources.length) {
      return _sources[_selectedTabIndex].id;
    }
    return "abc-news"; // fallback
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_sources.isEmpty) {
      return const Center(child: Text('No sources available'));
    }

    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        spacing: 10,
        children: [
          TabBar(
            controller: _tabController,
            tabAlignment: TabAlignment.start,
            indicatorColor: Colors.black,
            isScrollable: true,
            onTap: (index) {
              setState(() {
                _selectedTabIndex = index;
              });
            },
            tabs: _sources.map((data) {
              return Text(
                data.name,
                style:Theme.of(context).textTheme.bodyMedium,
              );
            }).toList(),
          ),
          FutureBuilder<List<ArticleDetailesModel>>(
            future: ApiRequests.getArticles(_selectedSourceId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Error loading articles'));
              }

              List<ArticleDetailesModel> articles = snapshot.data ?? [];

              if (articles.isEmpty) {
                return const Center(child: Text('No articles available'));
              }

              return SingleChildScrollView(
                physics:  CarouselScrollPhysics(),
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) =>
                      ArticleCard(articleDetailesModel: articles[index]),
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemCount: articles.length,
                ),
              );
            },
          ),
        ],
      ),
    );
    
  }
}
