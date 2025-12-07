import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:atrak/gen/assets.gen.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/Solid_color.dart';
import 'package:atrak/view/component_screen/card_screen.dart';
import 'package:atrak/view/component_screen/line_screen.dart';
import 'package:atrak/view/component_screen/search_screen.dart';
import 'package:atrak/view/component_screen/solidColor.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
import 'package:atrak/view/component_screen/style.dart';
import 'package:atrak/view/component_screen/title_screen.dart';
// import 'package:atrak/view/getBar_screen/addBar_screen.dart';
import 'package:atrak/view/home_screen/background_screen.dart';
import 'package:atrak/view/home_screen/header_screen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
// import 'package:atrak/view/getBar_screen/modalBar_screen.dart' as _shModal;

import 'formCar_screen.dart';

class GetCar extends StatefulWidget {
  const GetCar({super.key,required this.changeScreen});
  final Function(int) changeScreen;

  @override
  State<GetCar> createState() => _GetBarState();
}

class _GetBarState extends State<GetCar> {
  var box = GetStorage();
  final Map<String, TextEditingController> loginController = {
    'search': TextEditingController(),
  };
  void changeScreenModal(val){
    print("fdhfhdghf");
    setState(() {
      box.write(today, "${box.read(today)==night ? day : night }");
    });
    widget.changeScreen;
  }
  bool _isShow = false;
  void _toggle(){
    setState(() {
      _isShow=!_isShow;
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double sizeScreenMain = box.read(sizeScreen);
    return SafeArea(
      child: Scaffold(
        body: Stack(
            children: [
              Background(),
              Container(
                // width: size.width/1.10,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      HeaderScreen(changeScreen: changeScreenModal,),
                      SearchScreen(hintText: MyStrings.nashr_search,icon:box.read(today)==night ? Assets.icons.blackSearch : Assets.icons.whiteSearch,controler: loginController['search'],lableText: '',isPost: false,isPost2: false,search: (val){},),
                      SizedBox(height: 5,),
                      TitleScreen().title(size, context, MyStrings.nashr_getCar_request,false,(val){}),
                      SizedBox(height: 5,),
                      mRefresh(size,context),
                      SizedBox(height: 5,),
                      mRefresh(size,context),
                    ],),
                ),
              ),
              Positioned(bottom:60,right:20,child: ZoomTapAnimation(child: InkWell(onTap:(){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FormcarScreen()));
              },child: CardScreen().cardAdd(size),)))
            ]
        ),
      ),
    );
  }
  Widget mRefresh(size,context){
    return Container(
      width: size.width/1.10,
      decoration: BoxDecoration(
        color:SolidColorMain.simia_whiteAndBlack,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color:SolidColorMain.simia_cancleAndPlus,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Container(
            // width: size.width/1.10,
            child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
              Text(MyStrings.nashr_getCar_id,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_Title),),
              Text(MyStrings.nashr_getCar_mabda,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_Title),),
              Text(MyStrings.nashr_getCar_maghsad,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_Title),),
              Text(MyStrings.nashr_getCar_typeCar,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_Title),),

            ],),
          ),
          SizedBox(height: 2,),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                Text("5",style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_subTitle),),
                Text("رضا عباسی",style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: box.read(today)==night ? SolidColor.dr_appColorWhite: SolidColor.dr_appBlack3),),
                Text("عباس",style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: box.read(today)==night ? SolidColor.dr_appColorWhite: SolidColor.dr_appBlack3),),
                Text("تهران",style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: box.read(today)==night ? SolidColor.dr_appColorWhite: SolidColor.dr_appBlack3),),

              ],),
            ),
          ),
          Divider(
            color: SolidColorMain.simia_cancleAndPlus,     // رنگ خط
            thickness: 1,           // ضخامت خط
            indent: 16,             // فاصله از چپ
            endIndent: 16,          // فاصله از راست
          ),
          _dataTitle(MyStrings.nashr_getCar_price,MyStrings.nashr_getCar_finalprice,SolidColorMain.simia_BackwhiteAndBlack),
          SizedBox(height: 2,),
          _dataTitle(MyStrings.nashr_getCar_price,MyStrings.nashr_getCar_finalprice,SolidColorMain.simia_subTitle),
          Divider(
            color: SolidColorMain.simia_cancleAndPlus,     // رنگ خط
            thickness: 1,           // ضخامت خط
            indent: 16,             // فاصله از چپ
            endIndent: 16,          // فاصله از راست
          ),
          _dataTitle(MyStrings.nashr_getCar_date,MyStrings.nashr_getCar_oclock,SolidColorMain.simia_Title),
          SizedBox(height: 2,),
          _dataTitle(MyStrings.nashr_getCar_date,MyStrings.nashr_getCar_oclock,SolidColorMain.simia_subTitle),
          Divider(
            color: SolidColorMain.simia_cancleAndPlus,     // رنگ خط
            thickness: 1,           // ضخامت خط
            indent: 16,             // فاصله از چپ
            endIndent: 16,          // فاصله از راست
          ),

          _isShow ? Column(children: [
            _dataTitle(MyStrings.nashr_getCar_getCar,MyStrings.nashr_getCar_getNumber,SolidColorMain.simia_Title),
            SizedBox(height: 2,),
            _dataTitle(MyStrings.nashr_getCar_getCar,MyStrings.nashr_getCar_getNumber,SolidColorMain.simia_subTitle),
            SizedBox(height: 2,),
            _dataTitle(MyStrings.nashr_getCar_driver,MyStrings.nashr_getCar_hour,SolidColorMain.simia_Title),
            SizedBox(height: 2,),
            _dataTitle(MyStrings.nashr_getCar_driver,MyStrings.nashr_getCar_hour,SolidColorMain.simia_subTitle),
            SizedBox(height: 2,),
            _dataTitle(MyStrings.nashr_getCar_vazn,MyStrings.nashr_getCar_maghsads,SolidColorMain.simia_Title),
            SizedBox(height: 2,),
            _dataTitle(MyStrings.nashr_getCar_vazn,MyStrings.nashr_getCar_maghsads,SolidColorMain.simia_subTitle),
            Divider(
              color: SolidColorMain.simia_cancleAndPlus,     // رنگ خط
              thickness: 1,           // ضخامت خط
              indent: 16,             // فاصله از چپ
              endIndent: 16,          // فاصله از راست
            ),
            SizedBox(height: 2,),
            _dataTitle(MyStrings.nashr_getCar_createdate,MyStrings.nashr_getCar_bydate,SolidColorMain.simia_Title),
            SizedBox(height: 2,),
            _dataTitle(MyStrings.nashr_getCar_createdate,MyStrings.nashr_getCar_bydate,SolidColorMain.simia_subTitle),
            SizedBox(height: 2,),
            _dataTitle(MyStrings.nashr_getCar_dis,MyStrings.nashr_getCar_bydate,SolidColorMain.simia_Title),
            SizedBox(height: 2,),
            _dataTitle(MyStrings.nashr_getCar_dis,MyStrings.nashr_getCar_bydate,SolidColorMain.simia_subTitle),
            SizedBox(height: 2,),
            _dataTitle(MyStrings.nashr_getCar_disMaghsad,MyStrings.nashr_getCar_disMaghsad,SolidColorMain.simia_Title),
            SizedBox(height: 2,),
            _dataTitle(MyStrings.nashr_getCar_disMaghsad,MyStrings.nashr_getCar_disMaghsad,SolidColorMain.simia_subTitle),
          ],):Text(''),
          Container(
            // width: size.width/1.10,
            child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
              Text(MyStrings.nashr_getCar_status,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: box.read(today)==night ? SolidColor.dr_appColorWhite: SolidColor.dr_appBlack),),
              CardScreen().cardButton(size, context, 2.0, 1.0, SolidColorMain.simia_PaleGreen, SolidColorMain.simia_green, 5.0, "", MyStrings.nashr_getCar_status1,SolidColorMain.simia_green , false),
            ],),
          ),
          SizedBox(height: 2,),
          Container(
            // width: size.width/1.10,
            child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
              ZoomTapAnimation(onTap:(){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FormcarScreen()));
              } ,child:CardScreen().cardButton(size, context, 2.0, 2.0, SolidColorMain.simia_PaleOrange, SolidColorMain.simia_orange, 5.0, Assets.icons.edit.provider(), MyStrings.nashr_getCar_edit,SolidColorMain.simia_orange , true)),
              Text('',style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack3),),
              Text('',style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack3),),
              ZoomTapAnimation(
                onTap: _toggle,
                child: Row(
                  children: [
                    Text(_isShow ? MyStrings.nashr_getCar_lowgher : MyStrings.nashr_getCar_etc,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack3),),
                    Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(_isShow ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down_rounded,color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack3,)
                    ),
                  ],
                ),
              ),


            ],),
          ),
        ],),
      ),
    );
  }
  Widget _dataTitle(title1,title2,color){
    return Container(
      // width: size.width/1.10,
      child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
        Text(title1,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: color),),
        Text(title2,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: color),),
      ],),
    );
  }
}
