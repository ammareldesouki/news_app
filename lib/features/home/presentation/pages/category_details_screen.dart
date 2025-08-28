import 'package:flutter/material.dart';
import 'package:news_app/core/models/sources_data_model.dart';
import 'package:news_app/core/network/api_request.dart';
import 'package:news_app/features/home/presentation/widgets/article_list.dart';

class CategorydDtailsScreen extends StatefulWidget {

  final String categoryId;


  const CategorydDtailsScreen({super.key, required this.categoryId});

  @override
  State<CategorydDtailsScreen> createState() => _CategorydDtailsScreenState();
}

class _CategorydDtailsScreenState extends State<CategorydDtailsScreen> with TickerProviderStateMixin {
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

    final sources = await ApiRequests.getSources(widget.categoryId);
    
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
          ArticleList(sourceid: _selectedSourceId)
        ],
      ),
    );
    
  }
}
