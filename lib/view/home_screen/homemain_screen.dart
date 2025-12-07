import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:atrak/gen/assets.gen.dart';
import 'package:atrak/repository/jjTools.dart';
import 'package:atrak/repository/repository_screen.dart';
import 'package:atrak/view/car_screen/tableCar_screen.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/Solid_color.dart';
import 'package:atrak/view/component_screen/line_screen.dart';
import 'package:atrak/view/component_screen/solidColor.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
import 'package:atrak/view/component_screen/style.dart';
import 'package:atrak/view/home_screen/header_screen.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../car_screen/car_screen.dart';

class HomemainScreen extends StatelessWidget {
  HomemainScreen({super.key,required this.changeScreen,required this.back});
  final Function(int) changeScreen;
  final Function(int) back;
  var box = GetStorage();
  // final now = DateTime.now(); // تاریخ امروز میلادی
  @override
  Widget build(BuildContext context) {
  final jalali = Jalali.fromDateTime(DateTime.now()); // تبدیل به شمسی
  final date ="${jalali.year}/${jalali.month}/${jalali.day}";
    // now = DateTime.now(); // تاریخ امروز میلادی
    // jalali = Jalali.fromDateTime(now); // تبدیل به شمسی
    var size = MediaQuery.sizeOf(context);
    double sizeScreenMain = box.read(sizeScreen);
    return Center(
      child: Container(
        width: size.width/1.10,
        child: Column(
          children: [
            circle(size),
            SizedBox(height: 5,),
            title(size,date),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                ZoomTapAnimation(child: InkWell(onTap: (){
                  showDialog(
                    context: context, // دقت کن که این context باید زیر BlocProvider باشه
                    builder: (BuildContext dialogContext) {
                      return MultiRepositoryProvider(
                        providers: [
                          RepositoryProvider<Repository>(
                            create: (context) => Repository(),
                          ),
                        ],  // همون بلوکی که توی صفحه اصلی داری
                        child: CarScreen(animateCart: changeScreen),
                      );
                    },
                  );
                },child: content(size,size.width/2.30,MyStrings.nashr_car,false))),
                SizedBox(width: 10,),
                ZoomTapAnimation(child: InkWell(onTap: (){
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('به زودی')));
                  // showDialog(
                  //   context: context, // دقت کن که این context باید زیر BlocProvider باشه
                  //   builder: (BuildContext dialogContext) {
                  //     return MultiRepositoryProvider(
                  //         providers: [
                  //           RepositoryProvider<Repository>(
                  //             create: (context) => Repository(),
                  //           ),
                  //         ],  // همون بلوکی که توی صفحه اصلی داری
                  //       child: BarScreen(animateCart: changeScreen),
                  //     );
                  //   },
                  // );
                },child: content(size,size.width/2.30,MyStrings.nashr_getBar,false))),


              ],),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ZoomTapAnimation(onTap:(){
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('به زودی')));
                  // showDialog(
                  //   context: context,
                  //   barrierDismissible: false,
                  //   builder: (BuildContext context) => TableanbarScreen(changeScreen:changeScreen ,),
                  //   // builder: (BuildContext context) =>ChatPage(globalContext: context),
                  // );
                },
                    child: content(size,size.width/1.10,MyStrings.nashr_seeOpacity,true)),
              ],),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ZoomTapAnimation(onTap:(){
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('به زودی')));
                  // showDialog(
                  //   context: context,
                  //   barrierDismissible: false,
                  //   builder: (BuildContext context) => BargiriScreen(changeScreen:changeScreen ,),
                  //    // builder: (BuildContext context) =>ChatPage(globalContext: context),
                  // );
                },child: content(size,size.width/2.30,MyStrings.nashr_bar,false)),
                SizedBox(width: 10,),
                ZoomTapAnimation(onTap:(){
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('به زودی')));
                  // showDialog(
                  //   context: context,
                  //   barrierDismissible: false,
                  //   builder: (BuildContext context) => TakhlyehScreen(changeScreen:changeScreen ,),
                  //   // builder: (BuildContext context) =>ChatPage(globalContext: context),
                  // );
                },child: content(size,size.width/2.30,MyStrings.nashr_exit,false)),

              ],),

        ],),
      ),
    );
  }
  Widget circle(Size size){
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Container(
          width: size.width/1.10,
          height: 56,
          decoration: BoxDecoration(borderRadius : BorderRadius.all(Radius.circular(40.0)) ,shape: BoxShape.rectangle,color:SolidColorMain.simia_whiteAndBlack,border: Border.all(color: SolidColorMain.simia_whiteAndBlack,width: 1),),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(box.read(name)==null ? MyStrings.nashr_name : "${box.read(name)}",style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(borderRadius : BorderRadius.all(Radius.circular(40.0)) ,shape: BoxShape.rectangle,color:SolidColorMain.simia_BackwhiteAndBlack,border: Border.all(color: SolidColorMain.simia_cancleAndPlus,width: 1),),
                child: box.read(name)==null ? Image(image: Assets.icons.pic.provider()) : ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Image.network('${JJ.serverUpload}${box.read(photo)}',
                    // width: 100,
                    // height: 100,
                    cacheHeight: 261,
                    cacheWidth: 261,),
                ),
                ),
              )
              // Image(image: icon),
            ],
          ),
        ),
      ),
    );
  }
  Widget title(Size size,final date){
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Container(
          width: size.width/1.10,
          height: 37.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(MyStrings.nashr_menu,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 18.0,color: SolidColorMain.simia_Title),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${date}",style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_subTitle),),
              ),
              // Image(image: icon),
            ],
          ),
        ),
      ),
    );
  }
  Widget content(Size size,width,text,isPost){
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Container(
          width: width,
          height: size.height*0.15,
          decoration: BoxDecoration(
            borderRadius : BorderRadius.all(Radius.circular(10.0)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF4350A2), // آبی تیره
                Color(0xFF61A1F5), // آبی روشن
              ],
            ),
          ),
          child:isPost ? Row(mainAxisAlignment:MainAxisAlignment.center,children: [
            // Image(image: image),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(child: Text(text,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appColorWhite,fontSize: 13.0),)),
            )
          ],) : Column(children: [
            // Image(image: image),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(child: Text(text,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appColorWhite,fontSize: 13.0),)),
            )
          ],),
        )
      ),
    );
  }
}
