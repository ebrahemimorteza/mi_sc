import 'dart:convert';

import 'package:atrak/repository/jjTools.dart';
import 'package:atrak/view/home_screen/background_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:atrak/gen/assets.gen.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/Solid_color.dart';
import 'package:atrak/view/component_screen/button_screen.dart';
import 'package:atrak/view/component_screen/card_screen.dart';
import 'package:atrak/view/component_screen/selectOption_screen.dart';
import 'package:atrak/view/component_screen/size_screen.dart';
import 'package:atrak/view/component_screen/solidColor.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
import 'package:atrak/view/component_screen/style.dart';
// import 'package:atrak/view/getBar_screen/AddGeter_screen.dart';
// import 'package:atrak/view/getBar_screen/AddLocation_screen.dart';
// import 'package:atrak/view/getBar_screen/AddSender_screen.dart';
// import 'package:atrak/view/home_screen/background_screen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../component_screen/textFiled_screen.dart';
import '../component_screen/title_screen.dart';

class StepProgressPage extends StatefulWidget {
  StepProgressPage({super.key,required this.userId,required this.formId,required this.answerSetId});
  String ? userId;
  String ? formId;
  String ? answerSetId;
  @override
  _StepProgressPageState createState() => _StepProgressPageState();
}

class _StepProgressPageState extends State<StepProgressPage> {
  int _currentStep = 0;
  var box = GetStorage();
   final salaray_list=[];
  List<int> selectedIndices = [];
  final List<String> options = [MyStrings.nashr_boxkala,MyStrings.nashr_needboxkala,MyStrings.nashr_jarsaghilkala,MyStrings.nashr_abhkordegikala,MyStrings.nashr_shekastedegikala,];
  String? selectedGender; // 'male' یا 'female'
  final Map<String, TextEditingController> loginController = {
    'username': TextEditingController(),
    'password': TextEditingController(),
  };
  void _saveSelectedIndices() {
    box.write('selectedTimes', selectedIndices);
  }

  void _loadSelectedIndices() {
    selectedIndices = List<int>.from(box.read('selectedTimes') ?? []);
  }
  @override
  void initState(){
    super.initState();
    getSalaray();
  }

  bool paramWoman = false;
  bool _obscureText = true;
  bool paramMen = true;
  bool _obscureTextMen = true;
  bool _obscureTextWoman = true;
  void _toggle(String name) {
    setState(() {
      if (name == 'showPass') {
        _obscureText = !_obscureText;
      } else if (name == 'woman') {
        _obscureTextWoman = !_obscureTextWoman;
        _obscureTextMen = _obscureTextMen;
        paramMen = false;
        paramWoman = true;
      } else if (name == 'men') {
        _obscureTextWoman = _obscureTextWoman;
        _obscureTextMen = !_obscureTextMen;
        paramWoman = false;
        paramMen = true;
      }
    });
  }
  void _nextStep() {
    print(_currentStep);
    _currentStep==0 ? param= MyStrings.nashr_tb_infoKala : _currentStep==1 ? param=MyStrings.nashr_tb_infoAnbar : param=MyStrings.nashr_tb_infoMainKala;
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    }
  }
  void _prevStep() {
    print(_currentStep);
    _currentStep==0 ? param= MyStrings.nashr_tb_infoKala : _currentStep==1 ? param=MyStrings.nashr_tb_infoAnbar : param=MyStrings.nashr_tb_infoMainKala;
    if (_currentStep > 1) {
      setState(() {
        _currentStep--;
      });
    }
  }
  var param = MyStrings.nashr_tb_infoMainKala;
  Widget _buildStepIndicator(int step,String text,size) {

    bool isActive = step <= _currentStep;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: 20,
      width: size.width/1.20,
      decoration: BoxDecoration(
        color:isActive ? SolidColorMain.simia_Blue : SolidColorMain.simia_PaleBlue,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(child: Text(text,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 11.0,color: SolidColorMain.simia_whiteAndBlack),)),
    );
  }
  Widget level3(size){
    return Stack(
        children: [
          Container(
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color:box.read(today)==night ? SolidColor.dr_appBlack2 : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildStepIndicator(0,MyStrings.nashr_tb_infoMainKala,size),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val21,style: AppStyle.mainTextStyleLogo.copyWith(color:SolidColorMain.simia_lable),),
                      Text("0",style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_BackwhiteAndBlack),),                        ]
                    ,),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val22,style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_lable),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[37]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_BackwhiteAndBlack),),                        ]
                    ,),
                ),
                Divider(
                  color: SolidColorMain.simia_cancleAndPlus,     // رنگ خط
                  thickness: 1,           // ضخامت خط
                  indent: 16,             // فاصله از چپ
                  endIndent: 16,          // فاصله از راست
                ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(MyStrings.nashr_title_val23,style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_lable),),
                          Text("${salaray_list.isEmpty ? "" : salaray_list[33]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_BackwhiteAndBlack),),
                          // Text(MyStrings.nashr_tb_create,style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_BackwhiteAndBlack),),                        ]
                        ])
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val24,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[35]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),                        ]
                    ,),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val25,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[39]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),                        ]
                    ,),
                ),
                Divider(
                  color: SolidColorMain.simia_cancleAndPlus,     // رنگ خط
                  thickness: 1,           // ضخامت خط
                  indent: 16,             // فاصله از چپ
                  endIndent: 16,          // فاصله از راست
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val26,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[38]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),                        ]
                    ,),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val27,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[42]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),                        ]
                    ,),
                ),
                Divider(
                  color: SolidColorMain.simia_cancleAndPlus,     // رنگ خط
                  thickness: 1,           // ضخامت خط
                  indent: 16,             // فاصله از چپ
                  endIndent: 16,          // فاصله از راست
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val28,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[41]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),                        ]
                    ,),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val29,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[40]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),                        ]
                    ,),
                ),
                Divider(
                  color: SolidColorMain.simia_cancleAndPlus,     // رنگ خط
                  thickness: 1,           // ضخامت خط
                  indent: 16,             // فاصله از چپ
                  endIndent: 16,          // فاصله از راست
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val30,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[35]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),                        ]
                    ,),
                ),
              ],
            ),
          ),
          // Positioned(
          //   bottom: 0,
          //   right: 0,
          //   left: 0,
          //   child: Container(
          //     // width: size.width/1.50,
          //     // height: 53,
          //     decoration: BoxDecoration(
          //       color:box.read(today)==night ? SolidColor.dr_appBlack : SolidColor.dr_appColorWhite,
          //       borderRadius: BorderRadius.circular(10),
          //       // border: Border.all(
          //       //   color:Colors.grey,
          //       //   width: 1.5,
          //       // ),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
          //             // ZoomTapAnimation(onTap:_nextStep,child: ButtonScreen(title: MyStrings.nashr_levelUpdate,color: SolidColorMain.simia_Blue,colorBorder: SolidColorMain.simia_Blue,colorText: SolidColorMain.simia_white,icon: "",height: 40,width: size.width/2.00,isPost: false,)),
          //             ZoomTapAnimation(onTap:_prevStep,child: ButtonScreen(title: MyStrings.nashr_prev,color: SolidColorMain.simia_cancleAndPlus,colorBorder: SolidColorMain.simia_cancleAndPlus,colorText: SolidColorMain.simia_BackwhiteAndBlack,icon: "",height: 40,width: size.width/3.30,isPost: false,)),
          //           ],)
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ]
    );
  }
  Widget level2(size){
    return Stack(
        children: [
          Container(
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color:box.read(today)==night ? SolidColor.dr_appBlack2 : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildStepIndicator(0,MyStrings.nashr_tb_infoAnbar,size),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val11,style: AppStyle.mainTextStyleLogo.copyWith(color:SolidColorMain.simia_lable),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[26]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_BackwhiteAndBlack),),                        ]
                    ,),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val12,style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_lable),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[11]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_BackwhiteAndBlack),),                        ]
                    ,),
                ),
                Divider(
                  color: SolidColorMain.simia_cancleAndPlus,     // رنگ خط
                  thickness: 1,           // ضخامت خط
                  indent: 16,             // فاصله از چپ
                  endIndent: 16,          // فاصله از راست
                ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(MyStrings.nashr_title_val13,style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_lable),),
                          Text("${salaray_list.isEmpty ? "" : salaray_list[12]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_BackwhiteAndBlack),),
                        ])
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val14,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[19]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),                        ]
                    ,),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val15,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[21]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),                        ]
                    ,),
                ),
                Divider(
                  color: SolidColorMain.simia_cancleAndPlus,     // رنگ خط
                  thickness: 1,           // ضخامت خط
                  indent: 16,             // فاصله از چپ
                  endIndent: 16,          // فاصله از راست
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val16,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[18]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),                        ]
                    ,),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val17,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[13]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),                        ]
                    ,),
                ),
                Divider(
                  color: SolidColorMain.simia_cancleAndPlus,     // رنگ خط
                  thickness: 1,           // ضخامت خط
                  indent: 16,             // فاصله از چپ
                  endIndent: 16,          // فاصله از راست
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val18,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[25]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),                        ]
                    ,),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val19,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[31]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),                        ]
                    ,),
                ),
                Divider(
                  color: SolidColorMain.simia_cancleAndPlus,     // رنگ خط
                  thickness: 1,           // ضخامت خط
                  indent: 16,             // فاصله از چپ
                  endIndent: 16,          // فاصله از راست
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val20,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),
                      Text("0",style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),                        ]
                    ,),
                ),
              ],
            ),
          ),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     // width: size.width/1.50,
          //     // height: 53,
          //     decoration: BoxDecoration(
          //       color:box.read(today)==night ? SolidColor.dr_appBlack : SolidColor.dr_appColorWhite,
          //       borderRadius: BorderRadius.circular(10),
          //       // border: Border.all(
          //       //   color:Colors.grey,
          //       //   width: 1.5,
          //       // ),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           SizedBox(height: 10,),
          //           Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
          //             // ZoomTapAnimation(onTap:_nextStep,child: ButtonScreen(title: MyStrings.nashr_tb_infoAnbar,color: SolidColorMain.simia_Blue,colorBorder: SolidColorMain.simia_Blue,colorText: SolidColorMain.simia_white,icon: "",height: 40,width: size.width/2.00,isPost: false,)),
          //             ZoomTapAnimation(onTap:(){Navigator.of(context).pop();},child: ButtonScreen(title: MyStrings.nashr_tb_deletKhesaratKala,color: SolidColorMain.simia_cancleAndPlus,colorBorder: SolidColorMain.simia_cancleAndPlus,colorText: SolidColorMain.simia_BackwhiteAndBlack,icon: "",height: 40,width: size.width/3.30,isPost: false,)),
          //           ],)
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ]
    );
  }
  Widget level1(size){
    return Stack(
        children:[
          Container(
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color:box.read(today)==night ? SolidColor.dr_appBlack2 : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                    _buildStepIndicator(0,MyStrings.nashr_tb_infoKala,size),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val1,style: AppStyle.mainTextStyleLogo.copyWith(color:SolidColorMain.simia_lable),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[10]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_BackwhiteAndBlack),),                        ]
                    ,),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val2,style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_lable),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[9]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_BackwhiteAndBlack),),                        ]
                    ,),
                ),
                Divider(
                  color: SolidColorMain.simia_cancleAndPlus,     // رنگ خط
                  thickness: 1,           // ضخامت خط
                  indent: 16,             // فاصله از چپ
                  endIndent: 16,          // فاصله از راست
                ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(MyStrings.nashr_title_val3,style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_lable),),
                          Text("${salaray_list.isEmpty ? "" : salaray_list[7]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_BackwhiteAndBlack),),
                          // Text(MyStrings.nashr_tb_create,style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_BackwhiteAndBlack),),                        ]
                        ])
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val4,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[6]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),                        ]
                    ,),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val5,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[5]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),                        ]
                    ,),
                ),
                Divider(
                  color: SolidColorMain.simia_cancleAndPlus,     // رنگ خط
                  thickness: 1,           // ضخامت خط
                  indent: 16,             // فاصله از چپ
                  endIndent: 16,          // فاصله از راست
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val6,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[3]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),                        ]
                    ,),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val7,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[2]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),                        ]
                    ,),
                ),
                Divider(
                  color: SolidColorMain.simia_cancleAndPlus,     // رنگ خط
                  thickness: 1,           // ضخامت خط
                  indent: 16,             // فاصله از چپ
                  endIndent: 16,          // فاصله از راست
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val8,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),
                      Text("0",style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),                        ]
                    ,),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val9,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),
                      Text("${salaray_list.isEmpty ? "" : salaray_list[1]["formanswers_answer"] ?? ""}",style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),                        ]
                    ,),
                ),
                Divider(
                  color: SolidColorMain.simia_cancleAndPlus,     // رنگ خط
                  thickness: 1,           // ضخامت خط
                  indent: 16,             // فاصله از چپ
                  endIndent: 16,          // فاصله از راست
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.nashr_title_val10,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),
                      Text("0",style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),                        ]
                    ,),
                ),
              ],
            ),
          ),
          // Positioned(
          //     bottom: 20,
          //     left: 0,
          //     right: 0,
          //     child:Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
          //       // ZoomTapAnimation(onTap:_nextStep,child: ButtonScreen(title: MyStrings.nashr_tb_infoKala,color: SolidColorMain.simia_Blue,colorBorder: SolidColorMain.simia_Blue,colorText: SolidColorMain.simia_white,icon: "",height: 40,width: size.width/2.00,isPost: false,)),
          //       ZoomTapAnimation(onTap:(){Navigator.of(context).pop();},child: ButtonScreen(title: MyStrings.nashr_tb_deletKhesaratKala,color: SolidColorMain.simia_cancleAndPlus,colorBorder: SolidColorMain.simia_cancleAndPlus,colorText: SolidColorMain.simia_BackwhiteAndBlack,icon: "",height: 40,width: size.width/3.30,isPost: false,)),
          //     ],)
          // ),
        ]
    );
  }
  Widget _buildContent(size) {
    print("_currentStep ${_currentStep}");
    print(_currentStep);
    return _currentStep==0 ? level1(size) : _currentStep==1 ? level2(size) : level3(size);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
          children: [
            Background(),
            Positioned(
              top: 30,
              child: Stack(children: [
                TitleScreen().title(size,context,MyStrings.nashr_tb_addKala,false),
                // Positioned(top:18,right: 150,child: Center(child: Text(param,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 11.0,color: SolidColorMain.simia_subTitle),)))
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(top: 100,bottom: 50),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    // Container(
                    //   width: size.width/1.10,
                    //   child: Directionality(
                    //     textDirection: TextDirection.ltr,
                    //     child: Row(
                    //       children: [
                    //         _buildStepIndicator(0),
                    //         _buildStepIndicator(1),
                    //         _buildStepIndicator(2),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 5),
                    level1(size),
                    SizedBox(height: 5),
                    level2(size),
                    SizedBox(height: 5),
                    level3(size),
                    SizedBox(height: 50),
                    // Expanded(child: _buildContent(size)),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child:Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                  // ZoomTapAnimation(onTap:_nextStep,child: ButtonScreen(title: MyStrings.nashr_tb_infoKala,color: SolidColorMain.simia_Blue,colorBorder: SolidColorMain.simia_Blue,colorText: SolidColorMain.simia_white,icon: "",height: 40,width: size.width/2.00,isPost: false,)),
                  ZoomTapAnimation(onTap:(){Navigator.of(context).pop();},child: ButtonScreen(title: MyStrings.nashr_tb_deletKhesaratKala,color: SolidColorMain.simia_cancleAndPlus,colorBorder: SolidColorMain.simia_cancleAndPlus,colorText: SolidColorMain.simia_BackwhiteAndBlack,icon: "",height: 40,width: size.width/3.30,isPost: false,)),
                ],)
            ),
          ]
      ),
    );
  }
  Widget add(title,size,context,ImageProvider image){
    return Container(
      width: 100,
      height: 34,
      decoration: BoxDecoration(
        color:box.read(today)==night ? SolidColor.dr_appBlack : SolidColor.dr_appButton.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color:box.read(today)==night ? SolidColor.dr_appBlack : SolidColor.dr_appButton.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(onTap:(){},child: Image(image:image)),
          Text(title,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14,color:box.read(today)==night ? SolidColor.dr_appBlack : SolidColor.dr_appButton,),),
        ],),);
  }
  Future<List> getSalaray() async {
    var params = "do=SalarayAttrack.getSalarayForm&formAnswers_formId="+widget.formId!+"&id="+widget.answerSetId!+"&userId="+widget.userId!;
    if (salaray_list.isEmpty) {
      await JJ().jjAjax(params).then((result) async {
        print("ppppppp1");
        print(result);
        final json = jsonDecode(result);
        print(json[42]);
        print(json);
        if (json==400) {
          // JJ.jjToast(MyStrings.dr_warning);
        } else {
          // for (var element in json) {
            salaray_list.addAll(json);
            setState(() {

            });
            // print("-------+-");
            // print(salaray_list.length);
            // print("-------+-");
          // }
        }
      });
    }
    return salaray_list;
  }
}