import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:atrak/gen/assets.gen.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/Solid_color.dart';
import 'package:atrak/view/component_screen/button_screen.dart';
import 'package:atrak/view/component_screen/solidColor.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
import 'package:atrak/view/component_screen/style.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class TitleScreen{
  var box = GetStorage();
  Widget title(size,context,title,isPost){
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Container(
          width: size.width/1.10,
          height: 35.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(title,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 18.0,color: SolidColorMain.simia_Title),),
                ),
              ),
              isPost ? Text(''): Expanded(
                flex: 1,
                child: ZoomTapAnimation(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(MyStrings.nashr_back,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_Title),),
                  ),
                ),
              ),
              isPost ? Text(''): Expanded(
                flex: 1,
                child: ZoomTapAnimation(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(Icons.arrow_forward,color: SolidColorMain.simia_Title,)
                  ),
                ),
              ),
              // Image(image: icon),
            ],
          ),
        ),
      ),
    );
  }
  Widget titleIcon(size,context,title){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_BackwhiteAndBlack,fontSize: 13.0,fontWeight: FontWeight.w700),),
          ZoomTapAnimation(onTap:(){Navigator.of(context).pop();},child: Image(image:Assets.icons.zarb.provider()))
        ]
        ,),
    );
  }
  Widget close(size,context,title){
    return Row(mainAxisAlignment:MainAxisAlignment.end,children: [
      ZoomTapAnimation(onTap:(){Navigator.of(context).pop();} ,child: ButtonScreen(title: title,color: SolidColorMain.simia_PaleBlue,colorBorder: SolidColorMain.simia_PaleBlue,colorText: SolidColorMain.simia_BackwhiteAndBlack,icon: "",height: 28,width: 48,isPost: false,),),
    ],);
  }
  Widget insert(size,context,title){
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
      ButtonScreen(title: title,color: SolidColorMain.simia_Blue,colorBorder: SolidColorMain.simia_Blue,colorText: SolidColorMain.simia_white,icon: "",height: 40,width: size.width/2.20,isPost: false,),
      ButtonScreen(title: MyStrings.nashr_tb_deletKhesaratKala,color: SolidColorMain.simia_cancleAndPlus,colorBorder: SolidColorMain.simia_cancleAndPlus,colorText: SolidColorMain.simia_BackwhiteAndBlack,icon: "",height: 40,width: size.width/3.30,isPost: false,),
    ],);
  }
}