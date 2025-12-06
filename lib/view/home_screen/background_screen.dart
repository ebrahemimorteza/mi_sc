import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:atrak/gen/assets.gen.dart';
import 'package:atrak/view/component_screen/solidColor.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';

import '../component_screen/Solid_color.dart';

class Background extends StatefulWidget {
  const Background({super.key});
  @override
  State<Background> createState() => _MainScreenState();
}

class _MainScreenState extends State<Background> {
  bool isDark=false;
  var box = GetStorage();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    // TODO: implement build
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        gradient: box.read(today)==night ? null
            :  LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFFFFF),  // سفید
            Color(0xFFBAD8FF),  // آبی روشن
          ],
        ),
        color: box.read(today)==night ? Color(0xFF31354A)  : null, // مشکی شب
      ),
      // child: child,
    );
}
}
