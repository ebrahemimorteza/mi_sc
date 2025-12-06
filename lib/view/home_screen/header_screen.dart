import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:atrak/gen/assets.gen.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/Solid_color.dart';
import 'package:atrak/view/component_screen/size_screen.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
import 'package:atrak/view/component_screen/style.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:atrak/view/component_screen/modal_screen.dart' as _shModal;

import '../component_screen/solidColor.dart';

class HeaderScreen extends StatelessWidget {
   HeaderScreen({super.key, required this.changeScreen});
   final Function(int) changeScreen;


  var box = GetStorage();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height / AppSize.heightheader,
      child: Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 0),
              child: ZoomTapAnimation(
                  child: TextButton(
                      onPressed : (){
                        changeScreen(2);
                      },
                      child: circle(size,box.read(today)==night ? Assets.icons.zee.provider() : Assets.icons.zeeblack.provider() ,Colors.white,))),
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 0),
            //   child: ZoomTapAnimation(
            //       child: TextButton(
            //           onPressed : (){
            //             _shModal.JModal().modalTopSheet(context,size,changeScreen);
            //           },
            //           child:  circle(size,box.read(today)==night ? Assets.icons.menu.provider() : Assets.icons.menuBlack.provider() ,Colors.white,))),
            // ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Image(image: Assets.images.logo.provider(),width: size.width*0.2,),
                  ),
                  Text(MyStrings.nashr_logo,style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_BackwhiteAndBlack),)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 0),
              child: ZoomTapAnimation(
                  child: TextButton(
                      onPressed : (){
                        print("object");
                        changeScreen(1);
                      },
                      child:  circle(size,box.read(today)==night ? Assets.icons.sun.provider() : Assets.icons.moonBlack.provider() ,Colors.white,))),
            ),

          ],
        ),
      ),
    );
  }
  Widget circle(size,ImageProvider icon, Color color){
    return Container(
      width: size.width*0.1,
      // height: 41,
      decoration: BoxDecoration(shape: BoxShape.circle,color:box.read(today)==night ? SolidColor.dr_appBlack : CupertinoColors.white,border: Border.all(color: box.read(today)==night ? SolidColor.dr_appBlack: SolidColor.dr_appBlack1,width: 1)),
      child: Image(image: icon),
    );
  }
}
