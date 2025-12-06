import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:atrak/tools/rout.dart';
import 'package:atrak/tools/routes.dart';
import 'package:atrak/view/component_screen/solidColor.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
bool isNightByClock() {
  final hour = DateTime.now().hour;
  // مثال: از 18 تا 6 شب حساب کنیم (قابل تغییر)
  print(hour < 6 || hour >= 18);
  print("hour < 6 || hour >= 18");
  return hour < 6 || hour >= 18;
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final prefs = await SharedPreferences.getInstance();
  // final savedTheme = prefs.getString("theme_mode") ?? "system";

  bool isDark = false;
  var box = GetStorage();
  if(box.read(auto)==auto){
  final hour = DateTime.now().hour;
  if (hour < 6 || hour >= 18) {
    isDark=true;
    box.write(today, night);
  }else{
    box.write(today, day);
    }
  }
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );
  //color to Status and navigate
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: SolidColor.dr_appColorWhite,
  //   statusBarIconBrightness: Brightness.light,
  //   // systemNavigationBarColor: SolidColor.statusBar,
  //   // systemNavigationBarColor: Color(0xFFb6ebef),
  //   systemNavigationBarColor: SolidColor.softTurquoise,
  //   systemNavigationBarIconBrightness: Brightness.light,
  // ));
  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp({super.key, required this.isDark});
  var box = GetStorage();


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // قفل کردن به حالت عمودی (پرتره)
    ]);



    print("########");
    print(isDark ? "الان شبه 🌙" : "الان روزه ☀️");
    print("########");
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.red,
        systemStatusBarContrastEnforced: true,
        systemNavigationBarContrastEnforced: true,
        // statusBarBrightness: ,
        systemNavigationBarDividerColor: Colors.red,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: SolidColor.softTurquoise,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: MaterialApp(
        title: 'atrak',


        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('fa'), // persian
        ],
        debugShowCheckedModeBanner: false,
        initialRoute: Screens.root,
        routes: routes,
        // builder: (BuildContext context, Widget? child) {
        //   return FlutterEasyLoading(child: child);//loading
        // },
      ),
    );
  }
}

