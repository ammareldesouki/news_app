import 'package:flutter/material.dart';
import 'package:news_app/core/models/category_model.dart';
import 'package:news_app/features/home/presentation/pages/category_details_screen.dart';
import 'package:news_app/features/home/presentation/widgets/category_card.dart';
import 'package:news_app/features/home/presentation/widgets/side_bar.dart';

import '../../../../core/constants/image_strings.dart';
import '../../../../core/models/data.dart' show Data;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool index=false;
   CategoryModel? _Selectedcategory;

  onClickCategoryCard(CategoryModel category){
    _Selectedcategory=category;
    print(_Selectedcategory?.id);
    setState(() {

    });
  }
  onClickHome(){
    _Selectedcategory=null;
    setState(() {
      
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( _Selectedcategory?.name?? "Home",style: Theme.of(context).textTheme.titleMedium,),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:  16.0),
            child: ImageIcon(AssetImage(TImages.searchIcon),size: 35,),
          )
        ],

      ),
      drawer: SideBar(onClikedHomme: onClickHome,),
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child:  _Selectedcategory ==null ? Column(
          crossAxisAlignment:CrossAxisAlignment.start ,
            children: [
              Text("Good Morning \n Here is Some News For You",style: Theme.of(context).textTheme.titleMedium,),

              ListView.separated
                (
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){

                return CategoryCard(categoryModel:  Data.categories[index],index: index,
                onClickCatagorycard: onClickCategoryCard,
                );


              }, separatorBuilder: (context,index) =>SizedBox(height: 15,), itemCount: Data.categories.length),
            ],
          ):CategorydDtailsScreen(categoryName: _Selectedcategory?.id?? "")
        ),
      )

    );
  }
}
