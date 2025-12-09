import 'dart:convert';
import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:atrak/gen/assets.gen.dart';
import 'package:atrak/repository/jjTools.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/Solid_color.dart';
import 'package:atrak/view/component_screen/line_screen.dart';
import 'package:atrak/view/component_screen/size_screen.dart';
import 'package:atrak/view/component_screen/solidColor.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
import 'package:atrak/view/component_screen/style.dart';
import 'package:atrak/view/component_screen/title_screen.dart';
import 'package:atrak/view/home_screen/header_screen.dart';
import 'package:atrak/view/login_screen/login-screen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SittingScreen extends StatefulWidget {
  const SittingScreen({super.key,required this.changeScreen,required this.back});
  final Function(int) changeScreen;
  final Function(int) back;

  @override
  State<SittingScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<SittingScreen> {
  var box = GetStorage();
  int selectedIndex = 0;
  int selectedIndex2 = 0;

  final List<String> options = ['روشن', 'تاریک', 'خودکار'];
  final List<String> options2 = ['روشن', 'خاموش'];

  @override
  void initState() {
    super.initState();
    _loadSelectedIndex();
    _loadSelectedIndex2();
  }

  Future<void> _loadSelectedIndex() async {
    // final prefs = await SharedPreferences.getInstance();
    setState(() {
      // selectedIndex = prefs.getInt('selected_option') ?? 0;
    });
  }

  Future<void> _saveSelectedIndex(int index) async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setInt('selected_option', index);
  }
  Future<void> _loadSelectedIndex2() async {
    // final prefs = await SharedPreferences.getInstance();
    setState(() {
      // selectedIndex2 = prefs.getInt('selected_option') ?? 0;
    });
  }

  Future<void> _saveSelectedIndex2(int index) async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setInt('selected_option', index);
  }
  Future<void> _exit()async{
    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // dynamic deviceData;
    // //
    // // //** TODO for mobile
    // if (Platform.isAndroid) {
    //   AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    //   deviceData = androidInfo.model;
    // } else if (Platform.isIOS) {
    //   IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    //   deviceData = iosInfo.utsname.machine;
    // } else if (kIsWeb) {
    //   // اینجا باید یک مقدار مناسب برای دستگاه‌های وب تعریف کنید
    //   WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
    //   deviceData = webBrowserInfo.userAgent;
    // } else {
    //   deviceData = 'Unknown device';
    // }

    final Map<String, dynamic> jsonBody = {
      // "device": deviceData,
      "os": "",
      "app_version": MyStrings.nashr_version
    };
    final tok = box.read(token); // ← توکن رو اینجا بزار
    final result = await JJ().jjPostJson2(
      jsonBody,
      "logout",
    );
    print(result);
    if (result == 'error') {
      // نمایش خطا یا چیزی
      return;
    }

    try {
      final json = jsonDecode(result);
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      print(json['code']);
      if (json.isEmpty) {
        // await prefs.setString("user_token", "");
      } else {
        // می‌تونی بگی موفقیت‌آمیز بود
        box.remove(token);
        box.remove(name);
        box.remove(last_name);
        box.remove(photo);
        box.remove(email);
        box.remove(role_name);
        box.remove(phone);
        // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
      // اگه می‌خوای UI آپدیت شه
      setState(() {
        // مثلاً isLoggedOut = true
      });
    } catch (e) {
      print("❌ خطا در json parsing: $e");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: size.height,
      child: Padding(
        padding: EdgeInsets.only(top: 2),
        child: Stack(
          children: [
            Container(
            // decoration: BoxDecoration(
            //     color: CupertinoColors.white,
            //     borderRadius: BorderRadius.all(Radius.circular(30.0))
            // ),
            child: Column(children: [
              SizedBox(height: 5,),
              TitleScreen().title(size, context, MyStrings.nashr_book,false,(val){widget.back(1);}),
              SizedBox(height: 10,),
              ZoomTapAnimation(child: InkWell(onTap:(){},child: boxCol(size,context,box.read(today)==night ?  Assets.icons.whiteAnbar.provider() : Assets.icons.whiteAnbar.provider(),MyStrings.nashr_tem,false,1))),
              SizedBox(height: 10,),
              // ZoomTapAnimation(child: InkWell(onTap:(){},child: boxCol(size,context,box.read(today)==night ?  Assets.icons.nighUser.provider() : Assets.icons.profile.provider(),MyStrings.nashr_finger,false,2))),
              SizedBox(height: 10,),
              Divider(
                color: Colors.grey,     // رنگ خط
                thickness: 1,           // ضخامت خط
                indent: 16,             // فاصله از چپ
                endIndent: 16,          // فاصله از راست
              ),
              SizedBox(height: 10,),
              // ZoomTapAnimation(onTap:_exit,child: boxCol(size,context,Assets.icons.turnOff.provider() ,MyStrings.nashr_close,true,3)),
              SizedBox(height: 10,),
              InkWell(onTap:(){} ,child: Center(child: Text(MyStrings.nashr_infoSitting,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13,color: SolidColorMain.simia_subTitle),))),
            ],),
          ),
            Positioned(right: 0,left: 0,bottom:size.height*0.4,child: Column(children: [
              // Image(image: Assets.images.heart.provider()),
              InkWell(onTap:(){} ,child: Center(child: Text("ورژن ${MyStrings.nashr_version}",style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13,color: box.read(today)==night ? SolidColor.dr_appColorWhite: SolidColor.dr_appBlack3),))),
            ],)),

      ]
        ),
      ),
    );
  }
  Widget boxCol(size,context,ImageProvider icon , String title ,isPost,number){
    return Container(
      width: size.width/1.10,height: 51,

      decoration: BoxDecoration(color:isPost ? SolidColorMain.simia_PaleRed:  box.read(today)==night ? SolidColor.dr_appBlack : SolidColor.dr_appColorWhite,borderRadius: BorderRadius.all(Radius.circular(isPost ? 10.0 : 50.0),),
        border: Border.all(
          color:box.read(today)==night ? SolidColor.dr_appBlack : SolidColor.dr_appBlack1,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            number==3 ? Image(image: icon) : Text(''),

            SizedBox(width: 2,),
            Text(title,style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack),),
            SizedBox(width:isPost ? 2 : 80,),
            number==1 ?  Expanded(flex:1,child: select()) : number==2 ? Expanded(flex:1,child: select2()) : Text('')

          ],),
      ),
    );
  }
  Widget select(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(options.length, (index) {
        bool isSelected = selectedIndex == index;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                selectedIndex = index;
              });
              index==0 ? widget.changeScreen(0): index==1 ? widget.changeScreen(10) : _autoToday();
              _saveSelectedIndex(index); // ذخیره انتخاب

            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 3.0),
              backgroundColor: SolidColorMain.simia_whiteAndBlack,
              foregroundColor: SolidColorMain.simia_whiteAndBlack,

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: isSelected ? SolidColorMain.simia_Blue : SolidColorMain.simia_BackwhiteAndBlack,width: 1)

              ),
              elevation: isSelected ? 4 : 0,
            ),
            child: Row(

              children: [
                // index==0 ? Image(image:box.read(today)==night ? Assets.icons.sun.provider():  Assets.icons.nightSun.provider()) : index==1 ? Image(image:box.read(today)==night ? Assets.icons.daymonth.provider():Assets.icons.moonBlack.provider()): Text(''),
                Text(options[index],style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appColorWhite: SolidColor.dr_appBlack,fontSize: 10.0,fontWeight: FontWeight.w100,)),
              ],
            ),
          ),
        );
      }),
    );
  }
  Widget select2(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(options2.length, (index) {
        bool isSelected = selectedIndex2 == index;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                selectedIndex2 = index;
              });
              _saveSelectedIndex2(index);
            },
            style: ElevatedButton.styleFrom(
              textStyle: AppStyle.mainTextStyleLogo.copyWith(color:box.read(today)==night ? SolidColor.dr_appBlack: SolidColor.dr_appColorWhite),
              backgroundColor: box.read(today)==night ? SolidColor.dr_appBlack: SolidColor.dr_appColorWhite,
              foregroundColor: box.read(today)==night ? SolidColor.dr_appBlack: SolidColor.dr_appColorWhite,
              padding: EdgeInsets.symmetric(vertical: 2.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: isSelected ? box.read(today)==night ? SolidColor.dr_appBlue1 : SolidColor.dr_appButton : SolidColor.dr_appBlack1,width: 1)

              ),

              elevation: isSelected ? 4 : 0,
            ),
            child: Text(options2[index],style: AppStyle.mainTextStyleLogo.copyWith(color: box.read(today)==night ? SolidColor.dr_appColorWhite: SolidColor.dr_appBlack,fontSize: 10.0,fontWeight: FontWeight.w100,)),
          ),
        );
      }),
    );
  }
  void _autoToday(){
    box.write(auto, auto);
    final hour = DateTime.now().hour;
    if (hour < 6 || hour >= 18) {
      box.write(today, night);
      widget.changeScreen(10);
    }else{
      widget.changeScreen(0);
      box.write(today, day);
    }
  }
}
