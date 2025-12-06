import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/Solid_color.dart';
import 'package:atrak/view/component_screen/button_screen.dart';
import 'package:atrak/view/component_screen/solidColor.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
import 'package:atrak/view/component_screen/style.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({required this.hintText,required this.lableText, this.icon,required this.controler,this.isPost,this.isPost2,required this.search});

  Function(String) search;
  final hintText;
  final lableText;
  final icon;
  var controler;
  final isPost;
  final isPost2;

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<SearchScreen> {
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
    return Material(
      color: Colors.transparent,
      child: Directionality(
        textDirection: TextDirection.rtl, // متن از راست به چپ
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عنوان
            Container(
              width: widget.isPost2 ? size.width / 2.00 : size.width / 1.10,
              child: Text(
                widget.lableText,
                style: AppStyle.mainTextStyleLogo.copyWith(
                  fontSize: 12,
                  color: box.read(today) == day
                      ? SolidColor.dr_appBlack3
                      : SolidColor.dr_appColorWhite,
                ),
              ),
            ),
            SizedBox(height: 4), // فاصله بین عنوان و تکست‌فیلد

            // باکس ورودی
            Container(
              width: widget.isPost2 ? size.width / 2.50 : size.width / 1.10,
              height: 46,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: SolidColorMain.simia_whiteAndBlack,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _isFocused
                      ? Colors.green
                      : SolidColorMain.simia_cancleAndPlus,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: widget.controler,
                      focusNode: _focusNode,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        hintStyle: TextStyle(
                          color: box.read(today) == day
                              ? SolidColor.dr_appBlack1
                              : SolidColor.dr_appColorWhite,
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (val){
                        widget.search(val);
                      },
                    ),
                  ),
                  SizedBox(width: 8),

                  // نمایش آیکن فقط وقتی که isPost مقدار null باشه
                  if (widget.isPost == true && widget.icon != null)
                    Image(image: widget.icon.provider()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}