import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/Solid_color.dart';
import 'package:atrak/view/component_screen/button_screen.dart';
import 'package:atrak/view/component_screen/size_screen.dart';
import 'package:atrak/view/component_screen/solidColor.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
import 'package:atrak/view/component_screen/style.dart';

class CustomInputField extends StatefulWidget {
   CustomInputField({required this.hintText,required this.lableText, this.icon,required this.controler,this.isPost,required this.isIcon,required this.width,this.change});
  final hintText;
  final lableText;
  final icon;
  var controler;
  final isPost;
  final isIcon;
  var width;
  final ValueChanged<String>? change;


  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;


  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }
  var box = GetStorage();
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Directionality(
      textDirection: TextDirection.rtl, // متن از راست به چپ
      child: Column(
        children: [
          Container(
            width:size.width/widget.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.lableText,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 12,color: SolidColorMain.simia_Title),),
              ],
            ),
          ),
          Container(
            width:size.width/widget.width,
            height:widget.hintText==MyStrings.nashr_tb_disKhesaratKala  ? AppSize.heightMid : AppSize.heightStandard,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color:widget.isPost==true ? SolidColorMain.simia_whiteAndBlack :  _isFocused ? SolidColorMain.simia_whiteAndBlack  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color:_isFocused ? Colors.green : SolidColorMain.simia_cancleAndPlus,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                widget.isIcon==true ? Image(image:widget.icon.provider()) : Text('') , // آیکن سمت راست
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    style: TextStyle(color: SolidColorMain.simia_subTitle,fontSize: 12.0,),
                    controller: widget.controler,
                    textDirection: TextDirection.ltr,
                    obscureText: widget.hintText==MyStrings.nashr_passE ? true:false,
                    focusNode: _focusNode,
                    textAlign: TextAlign.left, // hint بره سمت چپ
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                        color: SolidColorMain.simia_subTitle,
                        fontSize: 12.0,
                        fontFamily: "YekanBakhMid",
                      ),
                      border: InputBorder.none,
                      isDense: true, // باعث فشرده‌تر شدن padding میشه
                      contentPadding: EdgeInsets.symmetric(vertical: 0), // اینو تنظیم کن تا بالا نیاد
                    ),
                    onChanged: (val){
                      widget.change!.call(val);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}