import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:atrak/gen/assets.gen.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/Solid_color.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
import 'package:atrak/view/component_screen/style.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../component_screen/solidColor.dart';

class NavigationButton extends StatefulWidget {
  NavigationButton({
    Key? Key,
    required this.changescreen,
    required this.selectedButtonHome,
    required this.selectedButtonCart,
    required this.selectedButtonBookMe,
    required this.selectedButtonProfile,

  }) : super(key: Key);
  int selectedButtonHome = 1;
  int selectedButtonProfile = 0;
  int selectedButtonCart = 0;
  int selectedButtonBookMe = 0;
  int selectedButtonSearch = 0;
  final Function(int) changescreen;
  final focusNode = FocusNode();
  var box = GetStorage();

  @override
  State<NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  var box = GetStorage();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      //ios
      // bottom: 40,
      child: Container(
        decoration: BoxDecoration(
          color:box.read(today)==night ? Color(0xFF31354A) : null,
          gradient:box.read(today)==night ? null : LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFBAD8FF).withOpacity(0.2),  // سفید
            Color(0xFFBAD8FF),  // آبی روشن
          ],
        )), // آبی روشن
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Stack(
              children: [
              Container(
                // height: 200,
                width: size.width/1.15,
                height: size.height / 12,
                decoration: BoxDecoration(
                  color:SolidColorMain.simia_whiteAndBlack,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  // gradient: LinearGradient(
                  //
                  //   // colors: GradientColors.bottomNavBackground,
                  //   // begin: Alignment.topCenter,
                  //   // end: Alignment.bottomCenter,
                  // ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ZoomTapAnimation(
                        child: IndexedStack(
                            index: widget.selectedButtonHome,
                            // key: key,
                            children: [
                              TextButton(
                                onPressed: () => {
                                  widget.changescreen(0),
                                },
                                child:icon(box.read(today)==day ? Assets.icons.home.provider() : Assets.icons.nightWhiteHome.provider(),MyStrings.nashr_home,box.read(today)==night ? SolidColor.dr_appBlack1 :SolidColor.dr_appBlack2,size,false),
                                // iconSize: 35,
                              ),
                              TextButton(
                                onPressed: () => {},
                                child:
                                icon(box.read(today)==day ? Assets.icons.homeBlue.provider() : Assets.icons.nightHome.provider(),MyStrings.nashr_home,box.read(today)==night ? SolidColor.dr_appBlue1  : SolidColor.dr_appButton,size,true)
                              )
                            ]),
                      ),

                      ZoomTapAnimation(
                        child: IndexedStack(
                            index: widget.selectedButtonCart,
                            // key: key,
                            children: [
                              TextButton(
                                onPressed: () => {
                                  widget.changescreen(1),
                                },
                                child:icon(box.read(today)==day ? Assets.icons.message.provider() : Assets.icons.nightWhiteMessage.provider(),MyStrings.nashr_cart,box.read(today)==night ? SolidColor.dr_appBlack1 : SolidColor.dr_appBlack2,size,false),
                                // iconSize: 35,
                              ),
                              TextButton(
                                  onPressed: () => {},
                                  child:
                                  icon(box.read(today)==day ? Assets.icons.messageBlue.provider() : Assets.icons.nightMessage.provider(),MyStrings.nashr_cart,box.read(today)==night ? SolidColor.dr_appBlue1 : SolidColor.dr_appButton,size,true),
                              )
                            ]),
                      ),
                      ZoomTapAnimation(
                        child: IndexedStack(
                            index: widget.selectedButtonBookMe,
                            // key: key,
                            children: [
                              TextButton(
                                onPressed: () => {
                                  widget.changescreen(2),
                                },
                                child:icon(box.read(today)==day ? Assets.icons.setting.provider() : Assets.icons.nightWhiteSetting.provider(),MyStrings.nashr_book,box.read(today)==night ? SolidColor.dr_appBlack1 : SolidColor.dr_appBlack2,size,false),
                                // iconSize: 35,
                              ),
                              TextButton(
                                  onPressed: () => {},
                                  child:
                                  icon(box.read(today)==day ? Assets.icons.settingBlue.provider() : Assets.icons.nightSetting.provider(),MyStrings.nashr_book,box.read(today)==night ? SolidColor.dr_appBlue1 : SolidColor.dr_appButton,size,true),
                              )
                            ]),
                      ),
                      // ZoomTapAnimation(
                      //   child: IndexedStack(
                      //       index: widget.selectedButtonSearch,
                      //       // key: key,
                      //       children: [
                      //         TextButton(
                      //           onPressed: () => {
                      //             widget.changescreen(3),
                      //           },
                      //           child:icon(Icons.search,MyStrings.nashr_search,SolidColor.dr_appBlack2,size),
                      //
                      //           // iconSize: 35,
                      //         ),
                      //         TextButton(
                      //             onPressed: () => {},
                      //             child:
                      //             icon(Icons.search,MyStrings.nashr_search,SolidColor.dr_appButton,size),
                      //         )
                      //       ]),
                      // ),
                      ZoomTapAnimation(
                        child: IndexedStack(
                            index: widget.selectedButtonProfile,
                            // key: key,
                            children: [
                              TextButton(
                                onPressed: () => {
                                  widget.changescreen(3),
                                },
                                child:icon(box.read(today)==day ? Assets.icons.profile.provider() : Assets.icons.nightWhiteUser.provider(),MyStrings.nashr_profile,box.read(today)==night ? SolidColor.dr_appBlack1 : SolidColor.dr_appBlack2,size,false),
                                // iconSize: 35,
                              ),
                              TextButton(
                                  onPressed: () => {},
                                  child:
                                  icon(box.read(today)==day ? Assets.icons.profileBlue.provider() : Assets.icons.nighUser.provider() ,MyStrings.nashr_profile,box.read(today)==night ? SolidColor.dr_appBlue1 : SolidColor.dr_appButton,size,true)
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],)
          ],
        ),
      ),
    );
  }
  Widget icon(ImageProvider icon, String text, Color color,size,isPost) {
    return SizedBox(
      width: size.width*0.135, // عرض ثابت برای اطمینان از وسط‌چین شدن
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Positioned(
          //   top: -21,
          //   left: 0,
          //   right: 0,
          //   child: Center(
          //     child: Container(
          //       width: 10,
          //       height: 5,
          //       // color: Colors.grey[300],
          //       child: Align(
          //         alignment: Alignment.topCenter,
          //         child: Container(
          //           width: 50,
          //           height: 25,
          //           decoration: BoxDecoration(
          //             color:box.read(today)==night ? isPost ?  SolidColor.dr_appBlue1 : SolidColor.dr_appBlack2 :isPost ?  SolidColor.dr_appButton : SolidColor.softTurquoise,
          //             borderRadius: BorderRadius.vertical(
          //               top: Radius.circular(50),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // ایکون در وسط
          Container(
            child: Positioned(
              top: 0,
              left: 0,
              right: 0,
              // bottom: isPost ? 2 : 0,
              child: Align(
                alignment: Alignment.center,
                child: Image(image: icon,),
              ),
            ),
          ),
          // متن در زیر ایکون و وسط‌چین
          Positioned(
            top: 30, // فاصله از ایکون
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                text,
                style: AppStyle.mainTextStyle.copyWith(color: color,fontSize: 12.0,fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
