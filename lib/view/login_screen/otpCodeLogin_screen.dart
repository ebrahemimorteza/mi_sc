import 'dart:async';
import 'dart:convert';


import 'package:atrak/gen/assets.gen.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/button_screen.dart';
import 'package:atrak/view/home_screen/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pinput/pinput.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:atrak/repository/jjTools.dart';
import 'package:atrak/view/component_screen/Solid_color.dart';
import 'package:atrak/view/component_screen/size_screen.dart';
import 'package:atrak/view/component_screen/solidColor.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
import 'package:atrak/view/component_screen/style.dart';
import 'package:atrak/view/login_screen/verification_screen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

// import 'package:sms_autofill/sms_autofill.dart';
// import 'package:englishapp/view/homeScreen/modal_screen.dart' as _shModal;
import 'package:sms_autofill/sms_autofill.dart';

class OtpCodeLoginScreen extends StatefulWidget {
  OtpCodeLoginScreen({Key? Key,required this.mobile_num}) : super(key: Key);
  String ? mobile_num;

  @override
  State<OtpCodeLoginScreen> createState() => _OtpCodeLoginScreenState();
}

class _OtpCodeLoginScreenState extends State<OtpCodeLoginScreen> {
  late Timer _timer;
  int _minutes = 2;
  int _seconds = 0;
  bool _isStatus = false;
  bool showProgressIndicator = false;
  var globalContext;
  bool _obscureText = false;
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  var box = GetStorage();
  String _code = "";
  String signature = "{{2nwPOl/gGU1}}";
  final Map<String, TextEditingController> vrifyController = {
    'code': TextEditingController(),
    'user_mobile': TextEditingController(),
  };

  String get timerText {
    String minutesStr = _minutes.toString().padLeft(2, '0');
    String secondsStr = _seconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  String? appSignature;
  String? otpCode;

  @override
  void initState() {
    super.initState();
    startTimer();
    listenerSmsOtp();
  }
  Future<void> getAppSignature() async {
    // TODO : change when use web or android,ios
    String appSignature = await SmsAutoFill().getAppSignature;
    setState(() {
      signature = appSignature;
    });
  }


  @override
  void codeUpdated() {
    setState(() {
      // otpCode = code!;
    });
  }

  void listenerSmsOtp() async {
    final x = await SmsAutoFill().listenForCode();
    print(SmsAutoFill().code.listen((code) {
      otpCode = code;
      pinController.setText(otpCode!);
    }));
    // دریافت آخرین پیامک دریافتی با استفاده از پکیج sms_autofill
  }

  @override
  void dispose() {
    _timer.cancel();
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_minutes == 0 && _seconds == 0) {
          timer.cancel();
          _isStatus = true;
          // Timer reached zero
          // Perform any necessary actions here
        } else if (_seconds == 0) {
          _minutes--;
          _seconds = 59;
        } else {
          _seconds--;
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    print(box.read(today));
    var size = MediaQuery.sizeOf(context);
    double sizeScreenMain = box.read(sizeScreen);
    globalContext=context;
    var focusedBorderColor = SolidColorMain.simia_Blue;
    var fillColor = SolidColorMain.simia_whiteAndBlack;
    var fillColorOnchange = SolidColorMain.simia_PaleBlue;
    var borderColor = SolidColorMain.simia_Blue;
    var defaultPinThemeDark = PinTheme(
      width: 78,
      height: 78,
      textStyle: TextStyle(
          fontSize: 22,
          color:   SolidColor.dr_appButton.withOpacity(0.1),
    ), decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(1.0),
    // border: Border(bottom: BorderSide(color: borderColor,width: 4.0)),
        color: fillColor),
    );
    var defaultPinTheme = PinTheme(
      width: 78,
      height: 78,
      textStyle:TextStyle(
        fontSize: 22,
        color: SolidColorMain.simia_BackwhiteAndBlack,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.0),
          // border: Border(bottom: BorderSide(color: borderColor,width: 4.0)),
          color: fillColor),
    );

    var search_in;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Container(
          width:sizeScreenMain < AppSize.dr_size_tablet ?  size.width / 1.20 : size.width / 4.20,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Directionality(
                  // Specify direction if desired
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    length: 5,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    controller: pinController,//comment in test
                    // listenForMultipleSmsOnAndroid: true,
                    defaultPinTheme:box.read(today)==night ? defaultPinThemeDark : defaultPinTheme,
                    separatorBuilder: (index) => const SizedBox(width: 12),
                    validator: (value) {
                      return value == otpCode!
                          ? 'کد شما صحیح است'
                          : 'کد شما صحیح نیست';
                    },
                    onClipboardFound: (value) {
                      pinController.setText(value);
                    },
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) {
                      OtpVrify(pin);
                    },
                    onChanged: (value) {
                      if (value.length == 5) {
                        // دریافت پیامک کامل شده است
                        // انجام عملیات پر کردن خودکار ورودی پین
                        pinController.text = value;
                      }
                      debugPrint('onChanged: $value');
                    },
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 1,
                          color: focusedBorderColor,
                        ),
                      ],
                    ),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(8),
                        border: Border(bottom: BorderSide(color: borderColor,width: 4.0)),                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: fillColorOnchange,
                        borderRadius: BorderRadius.circular(1.0),
                        border: Border(bottom: BorderSide(color: borderColor,width: 4.0)),                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyBorderWith(
                      border: Border.all(color: Colors.green),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ZoomTapAnimation(
                      child: TextButton(
                        onPressed: () {
                          focusNode.unfocus();
                        },
                        child: _isStatus == true
                            ? TextButton(
                          onPressed: () {
                            sendrequest();
                            formKey.currentState!.validate();
                          },
                          child: Text('ارسال مجدد', style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_subTitle,fontSize: 13.0),),
                        )
                            : Text(timerText, style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_subTitle,fontSize: 13.0 )),
                      ),
                    ),
                  ],
                ),
                // محتوای اصلی روی عکس
                Padding(
                  padding: const EdgeInsets.only(top:158.0),
                  child: ZoomTapAnimation(onTap:(){OtpVrify(otpCode);},child: ButtonScreen(title:MyStrings.nashr_ok,color: SolidColorMain.simia_Blue,colorBorder: SolidColorMain.simia_Blue,colorText: Colors.white,icon: "",height: 45,width: size.width/1.30,isPost: true,)),
                ),
                // TextButton(
                //   onPressed: () {
                //     focusNode.unfocus();
                //   },
                //   child: Image(
                //     image: Assets.images.sendcode.provider(),
                //   ),
                // ),
                //
                // ZoomTapAnimation(
                //   child: TextButton(
                //     onPressed: () {
                //       focusNode.unfocus();
                //       showProgressIndicator == false ? OtpVrify(otpCode) : '';
                //       formKey.currentState!.validate();
                //     },
                //     child: Image(image: Assets.images.confirmation.provider()),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 200,
        )
      ]),
    );
  }

  Future<String?> OtpVrify(pin) async {
    var size = MediaQuery.sizeOf(context);
    setState(() {
      showProgressIndicator = true;
    });

    // To get data I wrote an extension method bellow
    var params;
    if (otpCode == "") {
      setState(() {
        showProgressIndicator = false;
      });
      return "";
    } else if(otpCode == null){
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainScreen()));
      // params = "do=Access_User.Validation&code=" +
      //     pin +
      //     "&user_mobile=" +
      //     widget.mobile_num!;
    }
    else{
      Future.delayed(Duration(seconds: 1)).then((value){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainScreen()));
      });
    }
    //   params = "do=Access_User.Validation&code=" +
    //       otpCode! +
    //       "&user_mobile=" +
    //       widget.mobile_num!;
    // }
    // setState(() {});
    // await JJ().jjAjax(params).then((result) async {
    //   final json = jsonDecode(result);
    //   SharedPreferences? localStorage;
    //   localStorage = await SharedPreferences.getInstance();
    //   if (json.isEmpty) {
    //     setState(() {}); // for refresh changes
    //     JJ.user_token = "";
    //     localStorage.setString("user_token", "");
    //   } else {
    //     if (json[0]["status"] == 'noUser') {
    //
    //       setState(() {
    //         showProgressIndicator = false;
    //       });
    //     } else {
    //       box.write(token, json[0]["user_token"]);
    //       box.write(name, json[0]["user_name"]);
    Future.delayed(Duration(seconds: 1)).then((value){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainScreen()));
    });
          // showDialog(
          //   context: context,
          //   barrierDismissible: false,
          //   // builder: (BuildContext context) => Browser(url: 'https://demo.dr-english.ir/Server?do=FormAnswerSet.add_new&userId=80&formAnswers_formId=1901&formAnswers_LastformId=1883&type=IOS', type: 'bb'),
          //   builder: (BuildContext context) => Welcome(
          //     price: json[0]["number_msg"], name: json[0]["user_name"],changescreen: widget.changescreen,),
          // );

    //     }
    //   }
    // });
  }
  Future<String?> sendrequest() async {

    _isStatus = false;
    _minutes=2;
    startTimer();
    var params = "do=Access_User.sendVerifySMSRepeat&number=" +box.read(mobile);
    await JJ().jjAjax(params).then((result) async {
      final json = jsonDecode(result);
      // SharedPreferences? localStorage;
      // localStorage = await SharedPreferences.getInstance();
      if (json.isEmpty) {
        JJ.user_token = "";
        // localStorage.setString("user_token", "");
      } else {}
    });
  }
}
