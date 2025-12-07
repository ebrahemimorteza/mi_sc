import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:atrak/gen/assets.gen.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/Solid_color.dart';
import 'package:atrak/view/component_screen/button_screen.dart';
import 'package:atrak/view/component_screen/selectOption_screen.dart';
import 'package:atrak/view/component_screen/size_screen.dart';
import 'package:atrak/view/component_screen/solidColor.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
import 'package:atrak/view/component_screen/style.dart';
import 'package:atrak/view/component_screen/textFiled_screen.dart';
import 'package:atrak/view/component_screen/title_screen.dart';
import 'package:atrak/view/home_screen/background_screen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class FormcarScreen extends StatefulWidget {
  const FormcarScreen({super.key});

  @override
  State<FormcarScreen> createState() => _AddgeterScreenState();
}

class _AddgeterScreenState extends State<FormcarScreen> {
  var box = GetStorage();
  List<int> selectedIndices = [];
  final Map<String, TextEditingController> loginController = {
    'username': TextEditingController(),
    'password': TextEditingController(),
  };
  bool paramWoman = false;
  bool _obscureText = true;
  bool paramMen = true;
  bool _isShow=false;
  void _toggle(){
    setState(() {
      _isShow=!_isShow;
    });
  }
  final List<String> options = [MyStrings.nashr_sen_type1,MyStrings.nashr_sen_type2];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
            children: [
              Background(),
              SingleChildScrollView(
                // physics: SingleChildScrollView(),
                child: Column(
                  children: [
                    SizedBox(height: 5,),
                    TitleScreen().title(size, context, MyStrings.nashr_getCar_title,false,(val){Navigator.of(context).pop();}),
                    SizedBox(height: 5,),

                    // Column(
                    //   children: [
                    //     SizedBox(
                    //       height: 45,
                    //       width:size.width/1.10,
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           InkWell(onTap:(){},child: Image(image:box.read(today)==night ? Assets.icons.whiteLocation.provider():Assets.icons.blackLocation.provider())),
                    //           Expanded(flex: 2,child: Text(MyStrings.nashr_getCar_maghsad,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14,color: box.read(today)==day ? SolidColor.dr_appBlack: SolidColor.dr_appColorWhite),)),
                    //
                    //         ],
                    //       ),
                    //     ),
                    //     SelectoptionScreen(hintText: '',icon:box.read(today)==night ? Assets.icons.nightWhiteUser : Assets.icons.profile,controler: loginController['user_mobile'] ?? "",lableText: MyStrings.nashr_place,),
                    //   ],
                    // ),
                    // Column(
                    //   children: [
                    //     SizedBox(
                    //       height: 45,
                    //       width:size.width/1.10,
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           InkWell(onTap:(){},child: Image(image:box.read(today)==night ? Assets.icons.whiteCar.provider():Assets.icons.blackCar.provider(),)),
                    //           Expanded(flex:2,child: Text(MyStrings.nashr_getCar_typeCar,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14,color: box.read(today)==day ? SolidColor.dr_appBlack: SolidColor.dr_appColorWhite),)),
                    //
                    //         ],
                    //       ),
                    //     ),
                    //     SelectoptionScreen(hintText: '',icon:box.read(today)==night ? Assets.icons.nightWhiteUser : Assets.icons.profile,controler: loginController['user_mobile'] ?? "",lableText: MyStrings.nashr_place,),
                    //   ],
                    // ),
                    SizedBox(height: 5,),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Column(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       children: [
                    //         Padding(
                    //           padding: const EdgeInsets.only(top: 13.0),
                    //           child: Container(
                    //             width: size.width/2.30,
                    //             height: 15,
                    //             child: Row(
                    //               mainAxisAlignment: MainAxisAlignment.start,
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               children: [
                    //                 Text(MyStrings.nashr_getCar_date,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14,color: box.read(today)==day ? SolidColor.dr_appBlack: SolidColor.dr_appColorWhite),),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //         CustomInputField(hintText: '',icon:box.read(today)==night ? Assets.icons.nightWhiteUser : Assets.icons.profile,controler: loginController['user_mobile'],lableText: MyStrings.nashr_price,width: AppSize.widthStandard,isIcon: true,isPost: true,)
                    //       ],
                    //     ),
                    //     SizedBox(width: 5,),
                    //     Column(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       children: [
                    //         Padding(
                    //           padding: const EdgeInsets.only(top: 13.0),
                    //           child: Container(
                    //             width: size.width/2.30,
                    //             height: 15,
                    //             child: Row(
                    //               mainAxisAlignment: MainAxisAlignment.start,
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               children: [
                    //                 Text(MyStrings.nashr_getCar_oclock,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14,color: box.read(today)==day ? SolidColor.dr_appBlack: SolidColor.dr_appColorWhite),),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //         CustomInputField(hintText: '',icon:box.read(today)==night ? Assets.icons.nightWhiteUser : Assets.icons.profile,controler: loginController['user_mobile'],lableText: MyStrings.nashr_price,width: AppSize.widthStandard,isIcon: true,isPost: true,)
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    Container(
                      width: size.width/1.05,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(child: CustomInputField(hintText: '',icon:box.read(today)==night ? Assets.icons.nightWhiteUser : Assets.icons.profile,controler: loginController['user_mobile'],lableText: MyStrings.nashr_getCar_mabda,width: AppSize.widthStandard,isIcon: true,isPost: true,)),]
                              ,),
                          ),
                          //Checkbox
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Column(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       children: [
                    //         Padding(
                    //           padding: const EdgeInsets.only(top: 13.0),
                    //           child: Container(
                    //             width: size.width/2.30,
                    //             height: 15,
                    //             child: Row(
                    //               mainAxisAlignment: MainAxisAlignment.start,
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               children: [
                    //                 Text(MyStrings.nashr_getCar_price,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14,color: box.read(today)==day ? SolidColor.dr_appBlack: SolidColor.dr_appColorWhite),),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //         CustomInputField(hintText: '',icon:box.read(today)==night ? Assets.icons.nightWhiteUser : Assets.icons.profile,controler: loginController['user_mobile'],lableText: MyStrings.nashr_price,width: AppSize.widthStandard,isIcon: true,isPost: true,)
                    //       ],
                    //     ),
                    //     SizedBox(width: 5,),
                    //     Column(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       children: [
                    //         Padding(
                    //           padding: const EdgeInsets.only(top: 13.0),
                    //           child: Container(
                    //             width: size.width/2.30,
                    //             height: 15,
                    //             child: Row(
                    //               mainAxisAlignment: MainAxisAlignment.start,
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               children: [
                    //                 Text(MyStrings.nashr_getCar_vazn,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14,color: box.read(today)==day ? SolidColor.dr_appBlack: SolidColor.dr_appColorWhite),),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //         CustomInputField(hintText: '',icon:box.read(today)==night ? Assets.icons.nightWhiteUser : Assets.icons.profile,controler: loginController['user_mobile'],lableText: MyStrings.nashr_price,width: AppSize.widthStandard,isIcon: true,isPost: true,)
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    Container(
                      width: size.width/1.05,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(child: CustomInputField(hintText: '',icon:box.read(today)==night ? Assets.icons.nightWhiteUser : Assets.icons.profile,controler: loginController['user_mobile'],lableText: MyStrings.nashr_tb_disKhesaratKala,width: AppSize.widthStandard,isIcon: true,isPost: true,)),]
                              ,),
                          ),
                          //Checkbox
                        ],
                      ),
                    ),
                    Container(
                      width: size.width/1.05,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(child: CustomInputField(hintText: '',icon:box.read(today)==night ? Assets.icons.nightWhiteUser : Assets.icons.profile,controler: loginController['user_mobile'],lableText: MyStrings.nashr_getCar_maghsad,width: AppSize.widthStandard,isIcon: true,isPost: true,)),]
                              ,),
                          ),
                          //Checkbox
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),

                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left:0,
                right:0,
                child: Container(
                  // width: size.width/1.50,
                  // height: 53,
                  decoration: BoxDecoration(
                    // color:box.read(today)==night ? SolidColor.dr_appBlack : SolidColor.dr_appColorWhite,
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(
                    //   color:Colors.grey,
                    //   width: 1.5,
                    // ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                          ZoomTapAnimation(onTap:(){},child: ButtonScreen(title: MyStrings.nashr_insertActiveCarAnbarkala,color: SolidColorMain.simia_Blue,colorBorder: SolidColorMain.simia_Blue,colorText: SolidColorMain.simia_white,icon: "",height: 40,width: size.width/2.00,isPost: false,)),
                          ZoomTapAnimation(onTap:(){Navigator.of(context).pop();},child: ButtonScreen(title: MyStrings.nashr_cancle,color: SolidColorMain.simia_cancleAndPlus,colorBorder: SolidColorMain.simia_cancleAndPlus,colorText: SolidColorMain.simia_BackwhiteAndBlack,icon: "",height: 40,width: size.width/3.30,isPost: false,)),
                        ])
                      ],
                    ),
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
  Widget card(size,title){
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        width: 145,
        height: 45.0,
        margin: EdgeInsets.all(1.0),
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          // border: Border.all(
          //   color: SolidColor.dr_appBlack1 ,
          //   width: 0.5,
          // ),
          color:box.read(today)==night ? SolidColor.dr_appButton.withOpacity(0.2) : SolidColor.dr_appButton.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(image:Assets.icons.blackPlus.provider()),),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text(title,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14.0,color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack2),)),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
