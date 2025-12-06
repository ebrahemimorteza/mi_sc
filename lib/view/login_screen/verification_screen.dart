import 'dart:convert';
import 'dart:io';

// import 'package:app_links/app_links.dart';
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_indicator/loading_indicator.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:atrak/gen/assets.gen.dart';
import 'package:atrak/repository/jjTools.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/Solid_color.dart';
import 'package:atrak/view/component_screen/button_screen.dart';
import 'package:atrak/view/component_screen/solidColor.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
import 'package:atrak/view/component_screen/style.dart';
import 'package:atrak/view/component_screen/textFiled_screen.dart';
import 'package:atrak/view/home_screen/background_screen.dart';
import 'package:atrak/view/home_screen/main_screen.dart';

import 'otpCodeLogin_screen.dart';



class VerificationScreen extends StatefulWidget{
  VerificationScreen({super.key,required this.mobile_num});
  String ? mobile_num;
  State<VerificationScreen> createState() => _SpashScreenState();


}
class _SpashScreenState extends State<VerificationScreen>{
  var box = GetStorage();
  double valueSizeScreen = 0.0;
  final Map<String, TextEditingController> loginController = {
    'user_mobile': TextEditingController(),
    'user_pass': TextEditingController(),
  };
  bool _isSelectLoading = true;
  bool _isFeild = true;
  Future<String?> Verficition(context) async {
    setState(() {
      _isSelectLoading=!_isSelectLoading;
    });

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
    //**
    //   WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
    //   deviceData = webBrowserInfo.userAgent;

    // var size = MediaQuery.sizeOf(globalContext);
    // setState(() {
    //
    // });
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? firebaseToken= (await prefs.get('device_token')) as String? ?? "";
    // // To get data I wrote an extension method bellow
    // // print(firebaseToken);
    // // var params = "do=Access_User.loginUserInHome&user_divice1="+deviceData+"&typeDevice=isBrowser&user_divice2=new";
    // //** TODO for mobile
    // var params = "do=Access_User.loginUserInHome&user_divice1=""&typeDevice=isPhone&user_divice1=new&user_firebaseToken="+firebaseToken!;
    // //**

    for (var key in loginController.keys) {
      var val = loginController[key]?.text;
      if (key == "username") {
        if (val == '') {
          setState(() {
            _isSelectLoading=!_isSelectLoading;
            _isFeild=!_isFeild;
          });
          return "";
        }
      }
      if (key == "password") {
        if (val == '') {
          setState(() {
            _isFeild=!_isFeild;
          });
          return "";
        }
      }
    }
    final Map<String, dynamic> jsonBody = {
      "username": loginController['username']?.text!,
      "password": loginController['password']?.text!,
      // "device": deviceData,
      "os": "",
      "app_version": MyStrings.nashr_version
    };
    setState(() {});
    await JJ().jjPostJson(jsonBody,"login").then((result) async {
      print("======>>$result");
      // SharedPreferences? localStorage;
      var json=jsonDecode(result);
      print("======>>>$json");
      print("======>>>${json['data']['token']}");
      var user=json['data']['user'];
      print("======>>>${user['name']}");
      print("======>>>${JJ.serverUpload}${user['photo']}");
      // localStorage = await SharedPreferences.getInstance();
      if (json.isEmpty) {
        setState(() {
          _isSelectLoading=!_isSelectLoading;
        });
        JJ.user_token = "";
        // localStorage.setString("user_token", "");
      } else {
        if(json['code']==200){

          initAppLinks(context,true);
          setState(() {
            _isSelectLoading=!_isSelectLoading;
          });
        }else{
          setState(() {
            _isSelectLoading=!_isSelectLoading;
          });
        }
      }
    });
  }
  @override
  void initState(){
    super.initState();
  }
  // دریافت دیپ لینک
  Future<void> initAppLinks(context,isPost) async {

    Future.delayed(Duration(seconds: isPost ? 0 : 3)).then((value){
      box.write(sizeScreen, valueSizeScreen);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainScreen()));
      // Navigator.of(globalContext).pushReplacement(MaterialPageRoute(builder: (context)=>box.read(language) == null ? OnBoardingPage() : MainScreen(rout: 0,)));
    });

  }

  static bool _isRootLogin = false;
  static bool _isRootProfile = false;
  static bool _isRootPlacement = false;
  static bool _isRootCart = false;
  static var globalContext;
  static var size;
  @override
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print("verfi >>>>>++");
    // getUrlWeb();
    print(box.read(today));
    globalContext=context;
    size = MediaQuery.sizeOf(context);
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
            children:[
              Background(),
              LayoutBuilder(
                builder: (context, constraints) {
                  // box.read(token)==null ? "" :initAppLinks(context,false);
                  if (constraints.maxWidth < 900) {
                    valueSizeScreen = constraints.maxWidth;
                    // Mobile layout
                    return Stack(
                      children: [
                        // Positioned.fill(
                        //   child: Transform.scale(
                        //     scale: 1.05, // کمی بزرگ‌تر از اندازه‌ی اصلی
                        //     child: Image(
                        //       image: box.read(today) == day
                        //           ? Assets.images.screenWhite.provider()
                        //           : Assets.images.screenBlack.provider(),
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),
                        Positioned(right: 0,left: 0,top:150,child: Center(child: Text(MyStrings.nashr_login,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 22,color: SolidColorMain.simia_Title),))),
                        Positioned(right: 0,left: 0,top:180,child: Center(child: Text(MyStrings.nashr_infoVer,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 16,color: SolidColorMain.simia_subTitle),))),
                        Positioned(right: 0,left: 0,top:280,child: Center(child: Text(MyStrings.nashr_infoSms,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14,color: SolidColorMain.simia_subTitle),))),
                        Positioned(right: 0,left: 0,top:300,child: Center(child: OtpCodeLoginScreen(mobile_num: widget.mobile_num,))),


                      ],
                    );
                  } else {
                    valueSizeScreen = constraints.maxWidth;
                    // Tablet and browser layout
                    return Stack(
                      children: [
                        // Positioned.fill(
                        //   child: Transform.scale(
                        //     scale: 1.05, // کمی بزرگ‌تر از اندازه‌ی اصلی
                        //     child: Image(
                        //       image: box.read(today) == day
                        //           ? Assets.images.screenWhite.provider()
                        //           : Assets.images.screenBlack.provider(),
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),
                        // محتوای اصلی روی عکس
                        // Positioned(right: 0,left: 0,bottom:20,child: InkWell(onTap:(){initAppLinks(context,true);} ,child: ButtonScreen(title: MyStrings.nashr_ok,icon: "",height: 0.7,width: 1.30,isPost: true,))),
                      ],
                    );
                  }
                },
              ),]
        ),
      ),
    );
  }
}