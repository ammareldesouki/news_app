import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/cubit/home_cubit.dart';
import 'package:news_app/features/home/presentation/view/widgets/article_list.dart';
import 'package:provider/provider.dart';

class CategorydDtailsScreen extends StatefulWidget {
  final String categoryId;

  const CategorydDtailsScreen({super.key, required this.categoryId});

  @override
  State<CategorydDtailsScreen> createState() => _CategorydDtailsScreenState();
}

class _CategorydDtailsScreenState extends State<CategorydDtailsScreen> {
  @override
  void initState() {
    // Load sources for the category
    var provider = HomeCubit.get(context);
    provider.loadSources(widget.categoryId);
    Future.wait([
      provider.loadSources(widget.categoryId),
    ]).then((value) {
      provider.getArticles(
        Provider
            .of<HomeCubit>(context, listen: false)
            .sources[0].id,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(

      builder: (context, provider) {
        var provider = HomeCubit.get(context);
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.sources.isEmpty) {
          return const Center(child: Text('No sources available'));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              DefaultTabController(
                initialIndex: provider.currentTapIndex,
                length: provider.sources.length,
                child: TabBar(
                  tabAlignment: TabAlignment.start,
                  indicatorColor: Colors.black,
                  isScrollable: true,
                  onTap: (index) {
                    provider.setCurrentTapIndex(index);
                  },
                  tabs: provider.sources.map((data) {
                    return Text(
                      data.name,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium,
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10,),
              ArticleList(
                  sourceid: provider.sources[provider.currentTapIndex].id),
            ],
          ),
        );
      },
    );
  }
}