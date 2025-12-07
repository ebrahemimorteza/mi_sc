import 'dart:convert';
import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:atrak/repository/jjTools.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/Solid_color.dart';
import 'package:atrak/view/component_screen/button_screen.dart';
import 'package:atrak/view/component_screen/line_screen.dart';
import 'package:atrak/view/component_screen/size_screen.dart';
import 'package:atrak/view/component_screen/snake-screen.dart';
import 'package:atrak/view/component_screen/style.dart';
import 'package:atrak/view/component_screen/textFiled_screen.dart';
import 'package:atrak/view/component_screen/title_screen.dart';
import 'package:atrak/view/home_screen/header_screen.dart';
import 'package:atrak/gen/assets.gen.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/line_screen.dart';
import 'package:atrak/view/component_screen/solidColor.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
import 'package:atrak/view/component_screen/style.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';


class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key,required this.back});
final Function(int) back;
  @override
  _ImagePickerExampleState createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  File? _image;
 bool _isFeild = false;
 bool _isFeildPass = false;
  bool hasUpperCase = false;
  bool hasSpecialChar = false;
  bool hasMinLength = false;
  bool _isSelectLoading = false;
  List<Map<String,dynamic>> activityLog=[];
  final Map<String, TextEditingController> passController = {
    '': TextEditingController(),
    'current_password': TextEditingController(),
    'new_password': TextEditingController(),
    'confirmPassword': TextEditingController(),
  };
  final Map<String, TextEditingController> profileController = {
    'name': TextEditingController(),
    'last_name': TextEditingController(),
    'phone': TextEditingController(),
    'email': TextEditingController(),
  };
  void checkPassword(String password) {
    setState(() {
      hasUpperCase = password.contains(RegExp(r'[A-Z]'));
      hasSpecialChar = password.contains(RegExp(r'[!@#\$&*~%^]'));
      hasMinLength = password.length >= 8;
    });
  }
  Widget buildCheckItem(bool condition, String text,ImageProvider icon) {
    return Row(mainAxisAlignment:MainAxisAlignment.start,children: [
      condition ? Image(image: icon) : SizedBox(width: 20,),
      Text(text,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14.0,color: SolidColorMain.simia_BackwhiteAndBlack),)
    ],);
  }
  @override
  void initState() {
    super.initState();
    _set();
    _getActivityUsers();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTab = _tabController.index;
      });
    });
  }
  void _set(){
    profileController['name']!.text = box.read(name)??"";
    profileController['last_name']!.text = box.read(last_name)??"";
    profileController['phone']!.text = box.read(phone)??"";
    profileController['email']!.text = box.read(email)??"";
  }
  Widget _buildTab(int index, String text,size) {
    bool isSelected = _currentTab == index;
    return Container(
      width: size.width/3,
      height: 30,
      decoration: BoxDecoration(
        color: isSelected ? SolidColorMain.simia_PaleBlue : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: isSelected ? SolidColorMain.simia_Blue : Colors.transparent,
            width: 5,
          ),
        ),
      ),
      child: Tab(child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(text,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 12,color: SolidColorMain.simia_BackwhiteAndBlack),),
      ),),
    );
  }
  var box = GetStorage();
  late TabController _tabController;
  int _currentTab = 0;


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.only(top:5.0),
      child: Container(
        child: Column(
          children: [
          TitleScreen().title(size, context, MyStrings.nashr_profile,false,(val){widget.back(1);}),
          SizedBox(height: 1,),
          prof(size),
          SizedBox(height: 1,),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: PreferredSize(
              preferredSize: Size.fromHeight(10),
              child: Container(
                width: size.width/1.10,
                // color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.transparent, // چون خودمون بردر می‌سازیم
                  dividerColor: Colors.transparent,
                  labelPadding: EdgeInsets.symmetric(horizontal: 0.5),
                  // padding: EdgeInsets.only(left: 50),
                  isScrollable: false,
                  tabs: [
                    _buildTab(0, MyStrings.nashr_tab1,size),
                    _buildTab(1, MyStrings.nashr_tab2,size),
                    _buildTab(2, MyStrings.nashr_tab3,size),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 1,),
          tab(size),

        ],),
      ),
    );
  }
  Widget prof(Size size){
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Container(
          width: size.width/1.10,
          height: 111.0,
          margin: EdgeInsets.all(1.0),
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            gradient: box.read(today)==night ? null
                :  LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF001498),  // سفید
                Color(0xFF0A2BFF),  // آبی روشن
              ],
            ),
            color: box.read(today)==night ? SolidColorMain.simia_Blue  : null,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Expanded(
                    //   flex: 0,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 8.0),
                    //     child: Container(
                    //       width: 46,
                    //       height: 46,
                    //       decoration: BoxDecoration(borderRadius : BorderRadius.all(Radius.circular(40.0)) ,shape: BoxShape.rectangle,color:SolidColorMain.simia_BackwhiteAndBlack,border: Border.all(color: SolidColorMain.simia_cancleAndPlus,width: 1),),
                    //       child: box.read(name)==null ? Image(image: Assets.icons.pic.provider()) : ClipRRect(
                    //         borderRadius: BorderRadius.circular(40.0),
                    //         child: Image.network('${JJ.serverUpload}${box.read(photo)}',
                    //           // width: 100,
                    //           // height: 100,
                    //           cacheHeight: 261,
                    //           cacheWidth: 261,),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(children:[
                          Text(box.read(name)==null ? 'مهندس ثالثی': "${box.read(name)}",style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14.0,color: SolidColorMain.simia_white),),
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Text(box.read(name)==null ? 'ادمین': box.read(name),style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14.0,color: SolidColorMain.simia_white),),
                          ),

                        ]),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Container(
                          width: 90,
                          height: 28,
                          decoration: BoxDecoration(borderRadius : BorderRadius.all(Radius.circular(10.0)) ,shape: BoxShape.rectangle,color:SolidColorMain.simia_whiteOpacity,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // InkWell(onTap:_pickImage,child: Image(image: Assets.icons.changepic.provider(),width: 25,)),

                                _image != null
                                    ? ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.file(_image!, width: 200, height: 200, fit: BoxFit.cover),
                                )
                                    : Text('ویرایش تصویر',style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 12.0,color:SolidColorMain.simia_white)),
                                SizedBox(height: 20),

                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Text('اخرین وررود به سیستم',style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14.0,color: SolidColorMain.simia_white),),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Text('12.30',style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14.0,color: SolidColorMain.simia_white),),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Text('1404/03/05',style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14.0,color: SolidColorMain.simia_white),),
                      ),
                    )
                  ],),
                // Image(image: icon),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget tab(size){
    return Container(
      width: size.width/1.10,
      height: size.height*0.43,
      margin: EdgeInsets.all(1.0),
      padding: EdgeInsets.all(0),

      child: TabBarView(
        controller: _tabController,
        children: [
          Stack(
            children: [
              Container(
              height: size.height*0.37,
              decoration: BoxDecoration(
                color:SolidColorMain.simia_PaleBlue,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // CustomInputField(hintText: '',icon:box.read(today)==night ? Assets.icons.nightWhiteUser : Assets.icons.profile,controler: profileController['name'],lableText: MyStrings.nashr_firstname,isPost: true,width: AppSize.widthStandard,isIcon: false),
                    // CustomInputField(hintText: '',icon:box.read(today)==night ? Assets.icons.nightWhiteUser : Assets.icons.profile,controler: profileController['last_name'],lableText: MyStrings.nashr_lastName,isPost: true,width: AppSize.widthStandard,isIcon: false),
                    // CustomInputField(hintText: '',icon:box.read(today)==night ? Assets.icons.nightWhiteUser : Assets.icons.profile,controler: profileController['phone'],lableText: MyStrings.nashr_call,isPost: true,width: AppSize.widthStandard,isIcon: false),
                    // CustomInputField(hintText: '',icon:box.read(today)==night ? Assets.icons.nightWhiteUser : Assets.icons.profile,controler: profileController['email'],lableText: MyStrings.nashr_email,isPost: false,width: AppSize.widthStandard,isIcon: false),
                    _isFeild ? Text(MyStrings.nashr_loading_warningInput,style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_red),):Text('')
                  ],
                ),
              ),
            ),
              Positioned(
                bottom:1,right:0,left:0,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                    ZoomTapAnimation(onTap:(){_updateProfile();},child: ButtonScreen(title: MyStrings.nashr_edit,color: SolidColorMain.simia_Blue,colorBorder: SolidColorMain.simia_Blue,colorText: SolidColorMain.simia_white,icon: "",height: 40,width: size.width/1.80,isPost: false,isClick: _isSelectLoading ? true :false)),
                    ZoomTapAnimation(child: ButtonScreen(title: MyStrings.nashr_cancle,color: SolidColorMain.simia_cancleAndPlus,colorBorder: SolidColorMain.simia_cancleAndPlus,colorText: SolidColorMain.simia_BackwhiteAndBlack,icon: "",height: 40,width: size.width/3.30,isPost: false,)),
                  ],),
                ),
              )
            ]
          ),
          Stack(
            children: [
              Container(
              height: size.height*0.37,
              decoration: BoxDecoration(
                color:SolidColorMain.simia_PaleBlue,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // CustomInputField(hintText: MyStrings.nashr_passE,icon:box.read(today)==night ? Assets.icons.nightWhiteUser : Assets.icons.profile,controler: passController['current_password'],lableText: MyStrings.nashr_passProfile,isPost: true,width: AppSize.widthStandard,isIcon: false,),
                  // CustomInputField(hintText: MyStrings.nashr_passE,icon:box.read(today)==night ? Assets.icons.nightWhiteUser : Assets.icons.profile,controler: passController['new_password'],lableText: MyStrings.nashr_newPassProfile,isPost: true,width: AppSize.widthStandard,isIcon: false,change: checkPassword,),
                  // CustomInputField(hintText: MyStrings.nashr_passE,icon:box.read(today)==night ? Assets.icons.nightWhiteUser : Assets.icons.profile,controler: passController['confirmPassword'],lableText: MyStrings.nashr_RepeatNewPassProfile,isPost: true,width: AppSize.widthStandard,isIcon: false),
                  // buildCheckItem(hasUpperCase, MyStrings.nashr_captal,hasUpperCase==true ? Assets.icons.tick.provider() : Assets.icons.zarb.provider()),
                  // buildCheckItem(hasSpecialChar, MyStrings.nashr_alphabet,hasSpecialChar==true ? Assets.icons.tick.provider() : Assets.icons.zarb.provider()),
                  // buildCheckItem(hasMinLength, MyStrings.nashr_8Char,hasMinLength==true ? Assets.icons.tick.provider() : Assets.icons.zarb.provider()),
                  _isFeildPass ? Text(MyStrings.nashr_loading_warningPassInput,style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_red),):Text('')
                ],
              ),
            ),
              Positioned(
                bottom:1,right:0,left:0,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                    ZoomTapAnimation(onTap:(){_changePassword(context);},child: ButtonScreen(title: MyStrings.nashr_edit,color: SolidColorMain.simia_Blue,colorBorder: SolidColorMain.simia_Blue,colorText: SolidColorMain.simia_white,icon: "",height: 40,width: size.width/1.80,isPost: false,isClick: _isSelectLoading ? true :false,)),
                    ButtonScreen(title: MyStrings.nashr_cancle,color: SolidColorMain.simia_cancleAndPlus,colorBorder: SolidColorMain.simia_cancleAndPlus,colorText: SolidColorMain.simia_BackwhiteAndBlack,icon: "",height: 40,width: size.width/3.30,isPost: false,),
                  ],),
                ),
              )
           ]
          ),
          Container(
            width: size.width/1.10,
            height: size.height*0.37,
            decoration: BoxDecoration(
              color:SolidColorMain.simia_PaleBlue,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ListView.builder(
                itemCount:activityLog.length,
                itemBuilder: (context,index){
                  return cardMe(size,activityLog[index]['browser'],activityLog[index]['device'],activityLog[index]['type'],activityLog[index]['created_at']);
                }
                ),
          ),
        ],
      ),
    );
  }
  Widget cardMe(size,type,device,status,date){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: size.width/1.20,
        height: 73.0,
        margin: EdgeInsets.all(1.0),
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
            border: Border.all(
              color: SolidColorMain.simia_whiteAndBlack,
              width: 0.1,
            ),
          color:SolidColorMain.simia_whiteAndBlack,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 4.0),
                  //   child: Container(
                  //     width: 48,
                  //     height: 53,
                  //     margin: EdgeInsets.all(0.0),
                  //     padding: EdgeInsets.all(0),
                  //     decoration: BoxDecoration(
                  //       color:box.read(today)==night ? SolidColor.dr_appButton.withOpacity(0.1) : SolidColor.dr_appButton.withOpacity(0.2),
                  //       borderRadius: BorderRadius.circular(20.0),
                  //     ),
                  //     child: Image(image:box.read(today)==night ? Assets.icons.blackVector.provider() : Assets.icons.whiteVector.provider())
                  //     ,),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Text(device,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
                      SizedBox(height: 10.0,),
                      Text(status,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14.0,color: status=="login" ?SolidColorMain.simia_green : SolidColorMain.simia_red),),
                    ],),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(type,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
                    SizedBox(height: 10.0,),
                    Text(date,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 14.0,color: SolidColorMain.simia_BackwhiteAndBlack),),
                  ],),
              ),
            ),
          ],
        ),
      ),
    );
  }
  //method help
  Future<String?> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await File(pickedFile.path).readAsBytes();
      String file = base64Encode(bytes);
      final tok = box.read(token);
      final Map<String, dynamic> jsonBody = {
        "file_base64": "data:image/png;base64,$file",
        "file_type": "image/png"
      };
      try {
        final result = await JJ().jjUploadFile(
          jsonBody,
          "uploadFile",
        );

        final json = result;
        print(json);
        // final SharedPreferences prefs = await SharedPreferences.getInstance();
        // اینجا می‌تونی json رو ذخیره یا پردازش کنی
        return json; // یا هر خروجی که لازم داری
      } catch (e) {
        print("Upload error: $e");
        return null;
      }
    }
    return null; // اگه عکس انتخاب نشد // اگه کاربر عکسی انتخاب نکرد
  }
  Future<String?> _updateProfile() async {
    setState(() {
      _isSelectLoading=true;
    });
    for (var key in profileController.keys) {
      var val = profileController[key]?.text;
      if (key == "name") {
        if (val == '') {
          setState(() {
            _isFeild=true;
            _isSelectLoading=false;
          });
          return "";
        }
      }
      if (key == "last_name") {
        if (val == '') {
          setState(() {
            _isFeild=true;
            _isSelectLoading=false;
          });
          return "";
        }
      }
      if (key == "phone") {
        if (val == '') {
          setState(() {
            _isFeild=true;
            _isSelectLoading=false;
          });
          return "";
        }
      }
    }

    final Map<String, dynamic> jsonBody = {
      "name": profileController['name']!.text,
      "last_name": profileController['last_name']!.text,
      "phone": profileController['phone']!.text,
      "email": profileController['email']!.text,
      "photo_base64": "data:image/png;base64,"
    };
    final tok = box.read(token); // ← توکن رو اینجا بزار
    print(jsonBody);
    final result = await JJ().jjPutJson(
      jsonBody,
      "updateProfile",
    );

    try {
      final json = jsonDecode(result);
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      print(json['code']);
      if (json.isEmpty) {
        _isSelectLoading=false;
        // await prefs.setString("user_token", "");
      } else if(json['code']==200){
        SnakeScreen.showCustomSnackBar(context,MyStrings.nashr_title_snackBar);
        setState(() {
          _isSelectLoading=false;
          box.write(name,profileController['name']!.text);
          box.write(last_name,profileController['last_name']!.text);
          box.write(phone,profileController['phone']!.text);
          box.write(email,profileController['email']!.text);
          _set();
        });
        // می‌تونی بگی موفقیت‌آمیز بود
      }
      // اگه می‌خوای UI آپدیت شه
      setState(() {
        // مثلاً isLoggedOut = true
      });
    } catch (e) {
      print("❌ خطا در json parsing: $e");
    }
  }
  Future<String?> _changePassword(context) async {
    setState(() {
      _isSelectLoading=true;
    });
    for (var key in passController.keys) {
      var val = passController[key]?.text;
      if (key == "current_password") {
        if (val == '') {
          setState(() {
            _isFeildPass=true;
          });
          return "";
        }
      }
      if (key == "new_password") {
        if (val == '') {
          setState(() {
            _isFeildPass=true;
          });
          return "";
        }
      }
      if (key == "confirmPassword") {
        if (val == '') {
          setState(() {
            _isFeildPass=true;
          });
          return "";
        }
      }
    }
    if (passController['new_password']?.text == passController['confirmPassword']?.text) {
      if (val == '') {
        setState(() {
          _isFeildPass=true;
          _isSelectLoading=false;
        });
        return "";
      }
    }
    if(hasUpperCase==false || hasSpecialChar==false || hasMinLength==false){
      setState(() {
        _isFeildPass=true;
        _isSelectLoading=false;
      });
    }
    final Map<String, dynamic> jsonBody = {
      "current_password": passController['current_password']!.text,
      "new_password": passController['new_password']!.text,
    };
    final tok = box.read(token); // ← توکن رو اینجا بزار
    print(jsonBody);
    final result = await JJ().jjPostJson2(
      jsonBody,
      "changePassword",
    );

    try {
      final json = jsonDecode(result);
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      print(json['code']);
      if (json.isEmpty) {
        _isSelectLoading=false;
        // await prefs.setString("user_token", "");
      } else if(json['code']==200){
        SnakeScreen.showCustomSnackBar(context,MyStrings.nashr_title_snackBar);
        setState(() {
          _isFeildPass=false;
          hasUpperCase = false;
          hasSpecialChar = false;
          hasMinLength = false;
          _isSelectLoading=false;
        });
        // می‌تونی بگی موفقیت‌آمیز بود
      }
    } catch (e) {
      print("❌ خطا در json parsing: $e");
    }
  }
  Future<String?> _getActivityUsers() async {

    final Map<String, dynamic> jsonBody = {
      "limit": 50,
      "offset": 0,
      "from_date": "2025-01-01",
      "to_date": "2025-07-10"
    };
    final result = await JJ().jjGetJson(
      jsonBody,
      "getUserActivityLogs",
    );
    try {
      final json = jsonDecode(result);
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      print(json['code']);
      if (json.isEmpty) {
        _isSelectLoading=false;
        // await prefs.setString("user_token", "");
      } else if(json['code']==200){
        print(json['data']);
        activityLog = List<Map<String, dynamic>>.from(json["data"]);
        // می‌تونی بگی موفقیت‌آمیز بود
      }
    } catch (e) {
      print("❌ خطا در json parsing: $e");
    }
  }
}
