import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:atrak/gen/assets.gen.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/Solid_color.dart';
import 'package:atrak/view/component_screen/solidColor.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
import 'package:atrak/view/component_screen/style.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
// import 'package:atrak/view/getBar_screen/modalBar_screen.dart' as _shModal;


class TableScreen{
  var box =GetStorage();
  Widget tableHeader(size,context,idBijeck,sender,reciver,anbar,dicription,param5,param6,param7){
    return Container(
      width: size.width/1.10,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
        Text(idBijeck,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
        Text(sender,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
        Text(reciver,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
        Text(anbar,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
        dicription=="" ? Text('') : Text(dicription,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
        param5=="" ? Text('') : Text(param5,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
        param6=="" ? Text('') : Text(param6,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
      ],),
    );
  }
  Widget tableBody(size,context,param,param1,param2,param3,param4,param5,param6,param7 ,Function(int) select){
    return Container(
      // width: size.width,
      // height: size.height*0.618,
      // decoration: BoxDecoration(
      //   color:SolidColorMain.simia_whiteAndBlack,
      //   borderRadius: BorderRadius.circular(5.0),
      // ),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: size.width/1.05,
              height: 40,
              decoration: BoxDecoration(
                color:SolidColorMain.simia_cancleAndPlus,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                  Text(param,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
                  Text(param1,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
                  Text(param2,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
                  Text(param3,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
                  ZoomTapAnimation(onTap:(){
                    select(1);
                  },child: Image(image: box.read(today)==day ? Assets.icons.eyeWhiteTable.provider(): Assets.icons.eyeBlackTable.provider())),
                  param5=="" ? Text('') : Text(param4,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
                ],),
              ),
            ),
          ),]
      ),
    );
  }
  Widget tableBodymin(size,context,param,param1,param2,param3,param4,param5,param6,param7 ,Function(int) select){
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: size.width/1.40,
            height: size.height*.05,
            decoration: BoxDecoration(
              color:SolidColorMain.simia_cancleAndPlus,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                Text(param,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
                Text(param1,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
                Text(param2,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
                Text(param3,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
                Text(param4,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
                ZoomTapAnimation(onTap:(){select(1);},child: Image(image: box.read(today)==day ? Assets.icons.eyeWhiteTable.provider(): Assets.icons.eyeBlackTable.provider()))

              ],),
            ),
          ),
        ),]
    );
  }
}
