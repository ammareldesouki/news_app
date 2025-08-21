import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/constants/colors.dart';
import 'package:news_app/core/constants/image_strings.dart';
import 'package:news_app/core/services/app_setting_provider.dart';
import 'package:provider/provider.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key, required this.onClikedHomme});

  final Function onClikedHomme;
  
  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {


    List<String>_Language = ["English", "عربي",];
    List <String>_Theme = ["Light", "Dark"];
    final appSetting = Provider.of<AppSettingProvider>(context);
    return Container(
        width: MediaQuery.sizeOf(context).width*0.7,


  color: Colors.black,

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Container(

              height: MediaQuery.sizeOf(context).height*0.3,
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child:Center(child: Text('News App',style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),)),
            ),
            GestureDetector(
              onTap: (){
                widget.onClikedHomme();
              },
              child: Row(
                spacing: 5,
                children: [
                Icon(Icons.home,color: Colors.white,),
                  Text("Go To Home",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),)
              ],),
            ),
            Divider(height: 1,color: Colors.white,),



    SizedBox(height: 16),
    Row(
      spacing: 5,
      children: [
        ImageIcon(AssetImage(TImages.themeIcon),size: 24,color: Colors.white,),

        Text("Theme", style: Theme
            .of(context)
            .textTheme
            .titleMedium!.copyWith(color: Colors.white)),
      ],
    ),
    CustomDropdown<String>(
    hintText: 'Theme',

    decoration: CustomDropdownDecoration(
    closedFillColor: Colors.black ,
    closedBorder: Border.all(color: Colors.white),
    expandedBorder: Border.all(color: TColors.white),
    expandedFillColor: Colors.black ,
    listItemStyle: Theme
        .of(context)
        .textTheme
        .titleMedium!
        .copyWith(color: Colors.white),
    closedSuffixIcon: Icon(
    Icons.arrow_drop_down, size: 30, color: Colors.white,),
    headerStyle: Theme
        .of(context)
        .textTheme
        .titleMedium!
        .copyWith(color: Colors.white),
    ),
    items: _Theme,


    onChanged: (value) {
       if (value=="Light")
         appSetting.setThemeMode(ThemeMode.light);
       else

         appSetting.setThemeMode(ThemeMode.dark);


    },
    ),
    Row(
      spacing: 5,
      children: [
        ImageIcon(AssetImage(TImages.globelIcon),size: 24,color: Colors.white,),
        Text(
          "Language",
          style: Theme
              .of(context)
              .textTheme
              .titleMedium!.copyWith(color: Colors.white),
        ),
      ],
    )
  ,
    CustomDropdown<String>(

    hintText: 'Select Languge',

    items: _Language,
    decoration: CustomDropdownDecoration(
    closedFillColor:  Colors.black ,
    closedBorder: Border.all(color: Colors.white),
    expandedBorder: Border.all(color: Colors.white),
    expandedFillColor:Colors.black ,
    listItemStyle: Theme
        .of(context)
        .textTheme
        .titleMedium!
        .copyWith(color: Colors.white),
    closedSuffixIcon: Icon(
    Icons.arrow_drop_down, size: 30, color: Colors.white,),
    headerStyle: Theme
        .of(context)
        .textTheme
        .titleMedium!
        .copyWith(color: Colors.white),
    ),

    onChanged: (value) {


    },
    ),

    ],



        ),

      );

  }
}
