import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:atrak/gen/assets.gen.dart';
import 'package:atrak/view/component_screen/Solid_color.dart';
import 'package:atrak/view/component_screen/size_screen.dart';
import 'package:atrak/view/component_screen/solidColor.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';

class AppStyle {
  AppStyle._();//instance private to value static
 static var box = GetStorage();
  static TextStyle mainTextStyle = TextStyle(
    fontFamily: "YekanBakhMid",
    fontSize: AppSize.multiminSizeText,
    fontWeight: FontWeight.normal,
    color: SolidColor.dr_appColorWhite,
    textBaseline: TextBaseline.alphabetic
  );
  static TextStyle mainTextStyleLogo = TextStyle(
      fontFamily: "YekanBakhMid",
      fontSize: AppSize.minSizeText2,
      // fontWeight: FontWeight.normal,
      color: SolidColorMain.simia_whiteAndBlack,
      textBaseline: TextBaseline.alphabetic
  );
  static TextStyle mainTextStyleTitle = TextStyle(
      fontFamily: "YekanBakh",
      fontSize: AppSize.maxSizeText,
      fontWeight: FontWeight.normal,
      color: SolidColor.dr_appColorWhite,
      textBaseline: TextBaseline.alphabetic
  );
  static TextStyle mainTextStyleDel = TextStyle(
      fontFamily: "Insanibc2",
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color:Colors.white,
      decoration: TextDecoration.lineThrough
  );
  static TextStyle mainTextStyleWhite = TextStyle(
      fontFamily: "Insanibc",
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color:Colors.white
  );
  static TextStyle mainTextStyleInvite = TextStyle(
    fontFamily: "Insanibc2",
    fontSize: 15,
    // fontWeight: FontWeight.w400,
      color:Colors.black.withOpacity(.5)
  );
  static TextStyle mainTextStyleInviteIntro = TextStyle(
      fontFamily: "Insanibc2",
      fontSize: 10,
      // fontWeight: FontWeight.w400,
      color:Colors.black.withOpacity(.5)
  );
  //TODO font body

  static TextStyle mainTextStyleContent = TextStyle(
    fontFamily: "Insanibc",
    fontSize: AppSize.midSizeText,
    fontWeight: FontWeight.w700,
    height: 2.1,
    color:Colors.white.withOpacity(0.9),
    decorationStyle: TextDecorationStyle.dotted
  );
  //TODO font title
  static TextStyle mainTextStyleContentTitle = TextStyle(
      fontFamily: "Insanibc",
      fontSize: AppSize.maxSizeText,
      fontWeight: FontWeight.w700,
      color:Colors.white.withOpacity(0.9),
      decorationStyle: TextDecorationStyle.dotted
  );
  static TextStyle mainTextStyleContentEng = TextStyle(
      fontFamily: "Insanibc2",
      fontSize: 9.0,
      fontWeight: FontWeight.w700,
      color:Colors.white.withOpacity(0.9),
      decorationStyle: TextDecorationStyle.dotted
  );



  static BoxDecoration mainDecorationStyle = BoxDecoration(
  color: Color.fromARGB(255, 227, 244, 254),borderRadius: BorderRadius.all(Radius.circular(5))
  );  
  static BoxDecoration slideDecorationStyle = BoxDecoration(
  color: Colors.white.withOpacity(.5),borderRadius: BorderRadius.all(Radius.circular(5))
  );



}