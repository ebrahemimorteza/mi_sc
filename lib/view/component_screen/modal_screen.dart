import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:atrak/gen/assets.gen.dart';
import 'package:atrak/view/car_screen/tableCar_screen.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/Solid_color.dart';
import 'package:atrak/view/component_screen/solidColor.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
import 'package:atrak/view/component_screen/style.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class JModal{
  var box = GetStorage();
  Future<Object?> modalTopSheet(context,size,changeScreen)async{
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.topCenter,
          child: SafeArea(
            child: Material(
              color:box.read(today)==night ? SolidColor.dr_appBlack2  : Colors.transparent,
              child: Container(
                width: size.width,
                height: size.height*0.55,
                margin: EdgeInsets.all(1.0),
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color:box.read(today)==night ? SolidColor.dr_appBlack2 : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(MyStrings.nashr_logo,style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_BackwhiteAndBlack),),
                          ZoomTapAnimation(onTap:(){Navigator.of(context).pop();},child: Image(image: box.read(today)==night ?  Assets.icons.whiteClose.provider() : Assets.icons.close.provider()))
                        ]
                        ,),
                    ),
                    SizedBox(height: 5,),
                    // ZoomTapAnimation(onTap:(){
                    //   showDialog(
                    //     context: context,
                    //     barrierDismissible: false,
                    //     builder: (BuildContext context) => TakhlyehScreen(changeScreen:changeScreen ,),
                    //     // builder: (BuildContext context) =>ChatPage(globalContext: context),
                    //   );
                    // },child: boxCol(size,context,box.read(today)==night ?  Assets.icons.blackTakhlieh.provider() : Assets.icons.whiteTakhlieh.provider(),MyStrings.nashr_exit,false)),
                    // SizedBox(height: 5,),
                    // ZoomTapAnimation(onTap:(){
                    //   showDialog(
                    //     context: context,
                    //     barrierDismissible: false,
                    //     builder: (BuildContext context) => BargiriScreen(changeScreen:changeScreen ,),
                    //     // builder: (BuildContext context) =>ChatPage(globalContext: context),
                    //   );
                    // },child: boxCol(size,context,box.read(today)==night ?  Assets.icons.blackBargiri.provider() : Assets.icons.whiteBargiri.provider(),MyStrings.nashr_bar,false)),
                    SizedBox(height: 5,),
                    // ZoomTapAnimation(onTap:(){
                    //   showDialog(
                    //     context: context,
                    //     barrierDismissible: false,
                    //     builder: (BuildContext context) => GetBar(changeScreen:changeScreen ,),
                    //     // builder: (BuildContext context) =>ChatPage(globalContext: context),
                    //   );
                    // },child: boxCol(size,context,box.read(today)==night ?  Assets.icons.blackbar.provider() : Assets.icons.whitebar.provider(),MyStrings.nashr_tb_title,false)),
                    SizedBox(height: 5,),
                    // ZoomTapAnimation(onTap:(){
                    //   showDialog(
                    //     context: context,
                    //     barrierDismissible: false,
                    //     builder: (BuildContext context) => GetCar(changeScreen:changeScreen ,),
                    //     // builder: (BuildContext context) =>ChatPage(globalContext: context),
                    //   );
                    // },child: boxCol(size,context,box.read(today)==night ?  Assets.icons.blackWantCar.provider() : Assets.icons.whiteWantCar.provider(),MyStrings.nashr_getCar_request,false)),
                    SizedBox(height: 5,),
                    // ZoomTapAnimation(onTap:(){
                    //   showDialog(
                    //     context: context,
                    //     barrierDismissible: false,
                    //     builder: (BuildContext context) => TableanbarScreen(changeScreen:changeScreen ,),
                    //     // builder: (BuildContext context) =>ChatPage(globalContext: context),
                    //   );
                    // },child: boxCol(size,context,box.read(today)==night ?  Assets.icons.blackAnbar.provider() : Assets.icons.whiteAnbar.provider(),MyStrings.nashr_seeOpacity,false)),
                    SizedBox(height: 5,),
                    Divider(
                      color: SolidColorMain.simia_cancleAndPlus,     // رنگ خط
                      thickness: 1,           // ضخامت خط
                      indent: 16,             // فاصله از چپ
                      endIndent: 16,          // فاصله از راست
                    ),
                    SizedBox(height: 5,),
                    ZoomTapAnimation(onTap:(){
                      changeScreen(3);
                    },child: boxCol(size,context,box.read(today)==night ?  Assets.icons.nighUser.provider() : Assets.icons.profile.provider(),MyStrings.nashr_profile,false)),
                    SizedBox(height: 5,),
                    // ZoomTapAnimation(onTap:(){
                    //   showDialog(
                    //     context: context,
                    //     barrierDismissible: false,
                    //     builder: (BuildContext context) => BargiriScreen(changeScreen:changeScreen ,),
                    //     // builder: (BuildContext context) =>ChatPage(globalContext: context),
                    //   );
                    // },child: boxCol(size,context,Assets.icons.turnOff.provider() ,MyStrings.nashr_close,true)),

                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, -1), // از بالا
            end: Offset(0, 0),
          ).animate(anim1),
          child: child,
        );
      },
    );
  }
Widget boxCol(size,context,ImageProvider icon , String title ,isPost){
    return Container(
      width: size.width/1.10,height: 44,

      decoration: BoxDecoration(color:isPost ? SolidColorMain.simia_PaleRed:  SolidColorMain.simia_whiteAndBlack,borderRadius: BorderRadius.all(Radius.circular(10.0),),
        border: Border.all(
          color:SolidColorMain.simia_cancleAndPlus,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(image: icon),
            SizedBox(width: 2,),
            Text(title,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),

          ],),
      ),
    );
}

}