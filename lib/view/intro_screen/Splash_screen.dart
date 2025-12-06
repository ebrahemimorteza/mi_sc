import 'package:atrak/view/component_screen/solidColor.dart';
import 'package:atrak/view/component_screen/style.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:atrak/gen/assets.gen.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/button_screen.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
import 'package:atrak/view/home_screen/background_screen.dart';
import 'package:atrak/view/home_screen/main_screen.dart';
import 'package:local_auth/local_auth.dart';

import '../component_screen/Solid_color.dart';
import '../login_screen/login-screen.dart';



class splashScreen extends StatefulWidget{
  State<splashScreen> createState() => _SpashScreenState();


}
class _SpashScreenState extends State<splashScreen>{
  var box = GetStorage();
  final LocalAuthentication auth = LocalAuthentication();
  double valueSizeScreen = 0.0;
  String _link = '';
  String _id = '';
// ذخیره زمان لاگین
//   box.write('session_time', DateTime.now().toIso8601String());

// هر بار که اپ باز شد یا نیاز بود:
  Future checkSessionValidity() async{
    final storedTime = box.read(session_time);
    if (storedTime != null) {
      final lastTime = DateTime.parse(storedTime);
      final now = DateTime.now();
      final diff = now.difference(lastTime);

      if (diff.inHours >= 3) {
        // Session منقضی شده
        box.remove(token); // یا هر داده‌ای که Sessionه
        print('Session expired');
      }
    }
  }
  @override
  void initState(){
    super.initState();

    checkSessionValidity();
    box.read(today) == null ? box.write(today,day) : "";
  }
  // دریافت دیپ لینک
  Future<void> initAppLinks(context,isPost) async {
    Future.delayed(Duration(seconds:3)).then((value){
      box.write(sizeScreen, valueSizeScreen);

      _goToLogin();
      // Navigator.of(globalContext).pushReplacement(MaterialPageRoute(builder: (context)=>box.read(language) == null ? OnBoardingPage() : MainScreen(rout: 0,)));
    });
  }
  void routing(context){
    Future.delayed(Duration(seconds: 3)).then((value){
      box.write(sizeScreen, valueSizeScreen);
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainScreen(rout: 0,)));
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>box.read(token) == null ? MainScreen() : MainScreen()));
    });
  }
  void routingWithPage(context){
    print("valueSizeScreen >>>>>>>>>>>>>>$valueSizeScreen<<<<<<<<<<<< valueSizeScreen");
    Future.delayed(Duration(seconds: 1)).then((value){
      box.write(sizeScreen, valueSizeScreen);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainScreen()));
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>box.read(language) == null ? IntroScreenDefaultState(sizeScreen: valueSizeScreen,) : MainScreen(sizeScreen: valueSizeScreen,)));
    });
  }
  static bool _isRootLogin = false;
  static bool _isRootProfile = false;
  static bool _isRootPlacement = false;
  static bool _isRootCart = false;
  static var globalContext;
  static var size;
  Future<String?> getUrlWeb() async{
    // خواندن URL فعلی مرورگر
    Uri currentUri = Uri.base;
    debugPrint('<><><><><><><><><><><><><>');
    debugPrint('$currentUri');
    debugPrint('<><><><><><><><><><><><><>');
    String? type = currentUri.queryParameters['type'];
    // بررسی URL ساده
    var tok = box.read(token);
    if (type == 'loginApplication') {
      if(tok==null){
        _isRootLogin = true;
      }else{
        _isRootProfile = true;
      }
    } // بررسی URL ساده
    else if (type ==  'placement') {
      _isRootPlacement = true;
    }else {
      String? id = currentUri.queryParameters['id'];
      String? lang = currentUri.queryParameters['lang'];
      if(id!=null){
        _isRootCart = true;

      }
    }


  }
  @override
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print(box.read(today));
    initAppLinks(context,true);
    // getUrlWeb();
    globalContext=context;
    print(box.read(today));
    size = MediaQuery.sizeOf(context);
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            // box.read(token)==null ? "" :initAppLinks(context,false);
            if (constraints.maxWidth < 900) {
              valueSizeScreen = constraints.maxWidth;
              // Mobile layout
              return Stack(
                children: [
                  Background(),
                  Center(
                    child: Image(
                      image:
                      Assets.images.logo.provider(),
                      width: 200,
                      height: 200,
                      // fit: BoxFit.cover,
                    ),
                  ),
                  
                  // محتوای اصلی روی عکس
                  Positioned(right: 0,left: 0,bottom:20,child:Center(child: Text(MyStrings.nashr_url_titleBehkavosh,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 12,color: SolidColorMain.simia_blueRole),))),
                ],
              );
            } else {
              valueSizeScreen = constraints.maxWidth;
              // Tablet and browser layout
              return Stack(
                children: [
                  Background(),
                  Center(
                    child: Image(
                      image:
                      Assets.images.logo.provider(),
                      width: 200,
                      height: 200,
                      // fit: BoxFit.cover,
                    ),
                  ),
                  // محتوای اصلی روی عکس
                  Positioned(right: 0,left: 0,bottom:20,child:Center(child: Text(MyStrings.nashr_url_titleBehkavosh,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14,color: SolidColorMain.simia_blueRole),))),
                ],
              );
            }
          },
        ),
      ),
    );
  }
  Future<void> _checkLogin() async {
    final loggedIn = box.read(token) ?? false;

    if (loggedIn==false) {
      bool didAuthenticate = false;
      final canCheck = await auth.canCheckBiometrics;
      final isDeviceSupported = await auth.isDeviceSupported();
      // کاربر وارد نشده، بره صفحه ورود معمولی
      _goToLogin();
      print(canCheck);
      print(auth.getAvailableBiometrics());
      if (canCheck && isDeviceSupported) {
        didAuthenticate = await auth.authenticate(
          localizedReason: 'لطفا برای ورود اثر انگشت یا فیس آیدی بزنید',
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
          ),
        );
      }
    } else {
      print("auth");
      // کاربر قبلا وارد شده، درخواست احراز هویت بیومتریک کن
      bool didAuthenticate = false;
      try {
        print("check finger print >>>>>> -");
      // if(box.read(autoFinger)){
        final canCheck = await auth.canCheckBiometrics;
        final isDeviceSupported = await auth.isDeviceSupported();
       print(canCheck);
       print(auth.getAvailableBiometrics());
        if (canCheck && isDeviceSupported) {
          didAuthenticate = await auth.authenticate(
            localizedReason: 'لطفا برای ورود اثر انگشت یا فیس آیدی بزنید',
            options: const AuthenticationOptions(
              biometricOnly: true,
              stickyAuth: true,
            ),
          );
        }
      // }else{
        _goToLogin();
      // }
      } catch (e) {
        didAuthenticate = false;
      }
      if (didAuthenticate) {
        // _goToHome();
      } else {
        // اگر احراز هویت بیومتریک موفق نبود، به صفحه ورود عادی برگرد
        _goToLogin();
      }
    }
  }

  void _goToLogin() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>box.read(token) == null  ? LoginScreen() : MainScreen()));
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(builder: (_) => const LoginPage()),
    // );
  }

  void _goToHome() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainScreen()));
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(builder: (_) => const HomePage()),
    // );
  }
}