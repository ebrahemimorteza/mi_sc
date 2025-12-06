import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:atrak/gen/assets.gen.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/Solid_color.dart';
import 'package:atrak/view/component_screen/selectOption_screen.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
import 'package:atrak/view/component_screen/style.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CardScreen{
  var box = GetStorage();
  Widget cardButton(size,context,vertical,horzintal,color,colorBorder,radius,icon,title,titleColor,isIcon){
    return SizedBox(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: vertical,horizontal: horzintal),
        decoration: BoxDecoration(
          border: Border.all(
            color: colorBorder,
            width: 0.5,
          ),
          color:color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            isIcon ? Padding(
              padding: const EdgeInsets.all(1.0),
              child: Image(image:icon,width:15,height:15,),):Text(''),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(title,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14.0,color: titleColor),)),
            ),
          ],
        ),
      ),
    );
  }
  Widget cardAdd(size){
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 120,
        height: 52.0,
        margin: EdgeInsets.all(1.0),
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          // border: Border.all(
          //   color: SolidColor.dr_appBlack1 ,
          //   width: 0.5,
          // ),
          color:SolidColorMain.simia_PaleBlue,
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Image(image:Assets.icons.plus.provider()),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(MyStrings.nashr_plus,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget cardModal(size,ImageProvider image,title){
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Container(
        width: 140,
        height: 45.0,
        margin: EdgeInsets.all(5.0),
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          // border: Border.all(
          //   color: SolidColor.dr_appBlack1 ,
          //   width: 0.5,
          // ),
          color:SolidColorMain.simia_PaleBlue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Image(image:image),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 12.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
              ),
            ),
            // Expanded(
            //   flex: 1,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Text(''),),
            // ),
          ],
        ),
      ),
    );
  }
  Widget cardSelectPic(size,Function(int) selectPic){
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: [
          Container(
            width: size.width/1.35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(MyStrings.nashr_tb_picKhesaratKala,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 12,color: SolidColorMain.simia_BackwhiteAndBlack),),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Center(child: ),
              Container(
                width: size.width/1.35,
                height: 53,
                decoration: BoxDecoration(
                  color:SolidColorMain.simia_cancleAndPlus,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color:Colors.grey,
                    width: 1.5,
                  ),
                ),
                child: Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(onTap:(){},child: Image(image: Assets.icons.changepic.provider())),
                  ),
                  Text(MyStrings.nashr_tb_startPicKhesaratKala,style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_subTitle),),
                ],),
              )
            ]
            ,),

        ],
      ),
    );
  }
  Widget cardSelectOption(size,context,title,icon){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image(image:icon,width: 45,height: 45,fit: BoxFit.contain,),
        Text(title,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14,color: SolidColorMain.simia_BackwhiteAndBlack),),
      ],
    );
  }
  Widget cardSelectOptionWithOption(size,context,title,subtitle,icon,subIcon,Function(int) select){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image(image:icon,width: 45,height: 45,fit: BoxFit.contain,),
        Expanded(flex:3,child: Text(title,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14,color: SolidColorMain.simia_BackwhiteAndBlack),)),
        Expanded(
          flex: 2,
          child: ZoomTapAnimation(
              onTap: (){
                select(1);
                },
              child:Container(
                width: 80,
                height: 34,
                decoration: BoxDecoration(
                  color:SolidColorMain.simia_PaleBlue,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color:SolidColorMain.simia_Blue,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(onTap:(){},child: Image(image:subIcon)),
                    Text(subtitle,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14,color:SolidColorMain.simia_Blue,),),
                  ],),)
          ),
        )
      ],
    );
  }

}