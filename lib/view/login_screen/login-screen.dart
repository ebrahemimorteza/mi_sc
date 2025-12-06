import 'dart:convert';
import 'dart:io';

import 'package:atrak/view/home_screen/main_screen.dart';
import 'package:atrak/view/login_screen/test.dart';
import 'package:device_info_plus/device_info_plus.dart';
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
import 'package:atrak/view/component_screen/size_screen.dart';
import 'package:atrak/view/component_screen/solidColor.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
import 'package:atrak/view/component_screen/style.dart';
import 'package:atrak/view/component_screen/card_screen.dart';
import 'package:atrak/view/component_screen/textFiled_screen.dart';
import 'package:atrak/view/home_screen/background_screen.dart';
import 'package:atrak/view/login_screen/verification_screen.dart';
import 'package:local_auth/local_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';



class LoginScreen extends StatefulWidget{
  State<LoginScreen> createState() => _SpashScreenState();


}
class _SpashScreenState extends State<LoginScreen>{
  // **dbStorage**//
  var box = GetStorage();
  // **localvar**//
  double valueSizeScreen = 0.0;
  bool _isSelectLoading = true;
  bool _isFeild = true;
  bool _isLock = true;
  // **controller**//
  final Map<String, TextEditingController> loginController = {
    'username': TextEditingController(),
    'password': TextEditingController(),
  };
  static var size;

  get auth => null;
  @override
  void initState(){
    super.initState();
    box.read(token)==null ? "" :initAppLinks(context,false);
  }
  @override
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // getUrlWeb();
    print(box.read(today));
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
                        Positioned(right: 0,left: 0,top:180,child: Center(child: Text(MyStrings.nashr_info,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 16,color:SolidColorMain.simia_subTitle),))),
                        Positioned(right: 0,left: 0,top:300,child: Center(child: CustomInputField(hintText: MyStrings.nashr_userE,icon:box.read(today)==night ? Assets.icons.nightWhiteUser : Assets.icons.profile,controler: loginController['username'],lableText: MyStrings.nashr_user,width: AppSize.widthStandard,isIcon: true,))),
                        Positioned(right: 0,left: 0,top:400,child: Center(child: CustomInputField(hintText: MyStrings.nashr_passE,icon: box.read(today)==night ? Assets.icons.lockNight : Assets.icons.lockDay,controler: loginController['password'],lableText: MyStrings.nashr_pass,width: AppSize.widthStandard,isIcon: true))),
                        Positioned(right: 0,left: 0,top:470,child: Center(child: Text(MyStrings.nashr_role,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 12,color: SolidColorMain.simia_blueRole),))),
                        Positioned(right: 0,left: 0,top:490,child: Center(child: _isFeild ? Text('') :Text(MyStrings.nashr_warning,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 12,color: Colors.red),))),
                        Positioned(right: 0,left: 0,top:510,child: Center(child: _isLock ? Text('') :Text("اکانت شما قفل شده است به ادمین پیام دهید",style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 12,color: Colors.red),))),

                        Positioned(right: 0,left: 0,top:550,child:Stack(
                          alignment: Alignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(image: Assets.icons.finger.provider()),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () async {
                                await auth.authenticate(
                                  localizedReason: 'لطفا اثر انگشت خود را اسکن کنید',
                                  options: const AuthenticationOptions(
                                    biometricOnly: true,
                                  ),
                                );
                              },
                              child: const Text("اسکن اثر انگشت"),
                            ),
                          ],
                        ),
                        ),
                        // محتوای اصلی روی عکس
                        Positioned(right: 0,left: 0,bottom:20,child: ZoomTapAnimation(onTap:(){_login(context);} ,child: Stack(children: [
                          ButtonScreen(title:_isSelectLoading ?  MyStrings.nashr_login : MyStrings.nashr_login2,color: SolidColorMain.simia_Blue,colorBorder: SolidColorMain.simia_Blue,colorText: Colors.white,icon: "",height: 45,width: size.width/1.30,isPost: false,isClick: _isSelectLoading ? false : true,),
                        ]))),
                        // Positioned(right: 30,top:20,child: ZoomTapAnimation(onTap:(){_launchPhoneApp("09300000000");} ,child: CardScreen().cardButton(size,context,3.0,5.0,SolidColorMain.simia_whiteAndBlack,SolidColorMain.simia_subTitle,10.0,box.read(today)==night ? Assets.icons.headphoneNight.provider():Assets.icons.headphoneDay.provider(),MyStrings.nashr_suporter_takhlyeh,SolidColorMain.simia_BackwhiteAndBlack,true))),

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
                        ZoomTapAnimation(onTap:(){_login(context);},child: ButtonScreen(title: MyStrings.nashr_login,color: SolidColorMain.simia_Blue,colorBorder: SolidColorMain.simia_Blue,colorText: Colors.white,icon: "",height: 45,width: size.width/1.30,isPost: true,)),
                      ],
                    );
                  }
                },
              ),]
        ),
      ),
    );
  }
  void _launchPhoneApp(phoneInvite) async {
    final url = 'tel:$phoneInvite';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  // **function login**//
  Future<String?> _login(context) async {
    setState(() {
      _isSelectLoading=!_isSelectLoading;
    });

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    dynamic deviceData;
    //
    // //** TODO for mobile
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceData = androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceData = iosInfo.utsname.machine;
    } else if (kIsWeb) {
      // اینجا باید یک مقدار مناسب برای دستگاه‌های وب تعریف کنید
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      deviceData = webBrowserInfo.userAgent;
    } else {
    }
      deviceData = 'Unknown device';
    for (var key in loginController.keys) {
      var val = loginController[key]?.text;
      if (key == "username") {
        if (val == '') {
          setState(() {
            _isSelectLoading=true;
            _isFeild=false;
          });
          return "";
        }
      }
      if (key == "password") {
        if (val == '') {
          setState(() {
            _isSelectLoading=true;
            _isFeild=false;
          });
          return "";
        }
      }
    }
    print("xgfh>>>>>>>>>>> 33 22 ");
    var params = "do=Access_User.loginUserInHome&user_divice1="+deviceData+"&typeDevice=isPhone&user_divice1=new&user_mobile="+loginController['username']!.text+"&user_pass="+loginController['password']!.text;
    setState(() {});
    await JJ().jjAjax(params).then((result) async {
      final json = jsonDecode(result);
      // SharedPreferences? localStorage;
      // localStorage = await SharedPreferences.getInstance();
      if (json.isEmpty) {
        // showProgressIndicator = false;
        // widget.isPost=false;
        setState(() {}); // for refresh changes
        JJ.user_token = "";
        // EasyLoading.dismiss();
        // localStorage.setString("user_token", "");
      } else {
        setState(() {
          // widget.isPost=false;
          // showProgressIndicator = false;
        });
        // EasyLoading.dismiss();
        if (json[0]["status"] == 'tenure') {
          setState(() {
            _isSelectLoading=true;
            _isLock=false;
          });
          // _shModal.jjModal().showModal(
          //     globalContext, size, MyStrings.dr_deviceWrong, Assets.images.modalNoBtn.provider(),false);
          return "";
        }
        else {
          setState(() {
            // showProgressIndicator = false;
          });
          // EasyLoading.dismiss();
          print(json);
          JJ.user_token = json[0].toString();
          box.write(name, json[0]["user_name"]);
          box.write(token, json[0]["user_id"]);
          box.write(photo, json[0]["user_pic"]);
          // // box.write(invite, json[0]["code_invitefriend"]);
          // box.write(name, json[0]["user_name"]);
          box.write(mobile, json[0]["user_mobile"]);
          // box.write(linkapp, json[0]["linkapp"]);

          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>VerificationScreen(mobile_num: loginController['username']!.text,)));
          // widget.changescreen(0,false);
        }
      }
    });
  }
  // دریافت دیپ لینک
  Future<void> initAppLinks(context,isPost) async {
    print("dhbksdfhsd eksfhefhwe");

    Future.delayed(Duration(seconds: isPost ? 0 : 0)).then((value){
      box.write(sizeScreen, valueSizeScreen);
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>VerificationScreen(mobile_num: loginController['username']!.text,)));
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainScreen()));
      // Navigator.of(globalContext).pushReplacement(MaterialPageRoute(builder: (context)=>box.read(language) == null ? OnBoardingPage() : MainScreen(rout: 0,)));
    });

  }
}