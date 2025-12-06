import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/Solid_color.dart';
import 'package:atrak/view/component_screen/button_screen.dart';
import 'package:atrak/view/component_screen/solidColor.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
import 'package:atrak/view/component_screen/style.dart';

class SelectoptionScreen extends StatefulWidget {
  SelectoptionScreen({required this.hintText,required this.lableText, this.icon, this.iconLable,required this.controler,this.isPost,this.hei,this.hei2,this.heiFilter});

  final hintText;
  final lableText;
  final icon;
  final iconLable;
  var controler;
  final isPost;
  final hei;//discription modal
  final hei2;//discription modal
  final heiFilter;//discription modal

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<SelectoptionScreen> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  final List<String> numbers = List.generate(10, (index) => (index + 1).toString());

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
            width:widget.heiFilter == true ? size.width/4.00 : widget.hei2 == true ? size.width/2.30 :widget.hei == true ? size.width/1.65 : size.width/1.20,
            height:42,
            // height:widget.hei == true ? 80 : 42,
            // padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color:widget.isPost==true ? box.read(today)==night ? SolidColor.dr_appBlack : SolidColor.dr_appColorWhite :  _isFocused ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              // border: Border.all(
              //   color:_isFocused ? Colors.green : SolidColorMain.simia_cancleAndPlus,
              //   width: 1.5,
              // ),
            ),
            child: Row(
              children: [
                // SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: "1", // مقدار پیش‌فرض که یکی از گزینه‌هاست
                    items: numbers.map((val) {
                      return DropdownMenuItem(
                        value: val,
                        child: Text(val),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        widget.controler.text = value;
                      }
                    },
                    borderRadius: BorderRadius.circular(40),
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                        color: box.read(today) == day
                            ? SolidColor.dr_appBlack
                            : SolidColor.dr_appColorWhite,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.green, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: SolidColorMain.simia_cancleAndPlus, width: 1.5),
                      ),
                      filled: true,
                      fillColor: SolidColorMain.simia_whiteAndBlack,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}