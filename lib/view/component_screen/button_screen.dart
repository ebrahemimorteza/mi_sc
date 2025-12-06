
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:atrak/gen/assets.gen.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/size_screen.dart';
import 'package:atrak/view/component_screen/solidColor.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
import 'package:atrak/view/component_screen/style.dart';
// import 'package:get_storage/get_storage.dart';

class ButtonScreen extends StatefulWidget {
  ButtonScreen({super.key,required this.title,required this.color,required this.colorBorder,required this.colorText
    ,required this.icon,required this.width,required this.height,required this.isPost,this.butt,this.butt2,this.isClick});
  String ? title;
  Color ? color;
  Color ? colorBorder;
  Color ? colorText;
  final icon;
  double width;
  double height;
  bool isPost;
  final isClick;
  final butt;
  final butt2;
  @override
  _ButtonScreen createState() => _ButtonScreen();
}

class _ButtonScreen extends State<ButtonScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final focusNode = FocusNode();
  var box = GetStorage();

  @override
  void initState() {
    super.initState();
   _initlized();
  }
  void _initlized(){
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end:widget.isPost ?  1.02 : 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sizeScreenMain = box.read(sizeScreen);
    var size = MediaQuery.sizeOf(context);
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: child,
          );
        },
        child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Container(
                  width:widget.width,
                  height: widget.height,
                  decoration: BoxDecoration(borderRadius : BorderRadius.all(Radius.circular(widget.isPost == false ? 5.0 :40.0)) ,shape: BoxShape.rectangle,color:widget.color,border: Border.all(color:widget.colorBorder!,width: 1),),
                ),
              ),
              widget.butt2==true ? Padding(
                padding: const EdgeInsets.only(left: 148.0),
                child: Image(image: box.read(today)==night ?  Assets.icons.blackPlus.provider() : Assets.icons.blackPlus.provider()),
              ):Text(''),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(widget.title!,style: AppStyle.mainTextStyleLogo.copyWith(color:widget.colorText,fontSize: 13.0,fontWeight: FontWeight.w100 ),),
              ),
              widget.isClick==true ? Padding(
                padding: const EdgeInsets.only(top:5.0,right:90),
                child: SizedBox(
                  width:15,
                  height:15,
                  child: LoadingIndicator(
                    indicatorType: Indicator.lineSpinFadeLoader, /// Required, The loading type of the widget
                    colors: const [Colors.white],       /// Optional, The color collections
                    strokeWidth: 0.0005,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                    // backgroundColor: Colors.black,      /// Optional, Background of the widget
                    // pathBackgroundColor: Colors.black   /// Optional, the stroke backgroundColor
                  ),
                ),
              ):Text(''),
            ]
        ),
      ),
    );
  }
}