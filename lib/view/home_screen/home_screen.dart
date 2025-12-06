import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:atrak/gen/assets.gen.dart';
import 'package:atrak/view/message_screen/message_screen.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/style.dart';
import 'package:atrak/view/home_screen/header_screen.dart';
import 'package:atrak/view/home_screen/homemain_screen.dart';
import 'package:atrak/view/profile_screen/setting_screen.dart';
import 'package:atrak/view/profile_screen/profile_screen.dart';


class Homescreen extends StatelessWidget {
  Homescreen({Key? Key, required this.size, required this.changeScreen, required this.param}) : super(key: Key);
  final Function(int) changeScreen;
  final Size size;
  final int param;
  List<Widget> get pages => [
    HomemainScreen(changeScreen: changeScreen),
    MessageScreen(),
    SittingScreen(changeScreen: changeScreen),
    ProfileScreen(),
  ];
  // List<Widget> page = [HomemainScreen(changeScreen: changeScreen,),MessageScreen(),SittingScreen(),ProfileScreen()];
  List<String> title = [MyStrings.nashr_home,MyStrings.nashr_cart,MyStrings.nashr_book,MyStrings.nashr_search,MyStrings.nashr_profile];
  @override
  Widget build(BuildContext context) {
    print("sfjdfjdhjdhfjfd ${param}");
    // TODO: implement build
    var size = MediaQuery.sizeOf(context);
    return Stack(
      children: [SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderScreen(changeScreen: changeScreen,),
                    pages[param],
                    // LineScreen()
                  ]))),

      ],
    );
  }
}
