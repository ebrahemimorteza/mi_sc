import 'dart:ui';

import 'package:get_storage/get_storage.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';

class SolidColorMain{
  static var box =GetStorage();

  static Color get simia_Background =>
      box.read(today) == night ? Color(0xFF31354A) : Color(0xFF122CD2);

  static Color get simia_Blue =>
      box.read(today) == night ? Color(0xFF4350A2) : Color(0xFF122CD2);

  static Color get simia_whiteAndBlack =>
      box.read(today) == night ? Color(0xFF262835) : Color(0xFFFDFDFF);// برعکس رنگ زمینه

  static Color get simia_BackwhiteAndBlack =>
      box.read(today) == night ? Color(0xFFFDFDFF) : Color(0xFF262835);

  static Color get simia_PaleBlue =>
      box.read(today) == night ? Color(0x1A1431E9) : Color(0x1A122CD2);

  static Color get simia_Title =>
      box.read(today) == night ? Color(0xFFFFFFFF): Color(0xFF000000) ;

  static Color get simia_subTitle =>
      box.read(today) == night ? Color(0xFFE0E0E0) : Color(0x991F1F1F);

  static Color get simia_cancleAndPlus =>
      box.read(today) == night ? Color(0x1AE0E0E0) : Color(0x1A1F1F1F);

  static Color get simia_lable =>
      box.read(today) == night ? Color(0xCCE0E0E0) : Color(0xCC1F1F1F);

  static Color get simia_backgorudBox =>
      box.read(today) == night ? Color(0x33000B51) : Color(0x33C8CFFF);

  static Color get simia_red =>
      Color(0xFFFF2D2D);

  static Color get simia_PaleRed =>
      Color(0x1AFF4747);

  static Color get simia_green =>
      Color(0xFF12DA00);

  static Color get simia_PaleGreen =>
      Color(0x1A10C000);

  static Color get simia_orange =>
      Color(0xFFD28812);

  static Color get simia_PaleOrange =>
      Color(0x1AD28812);

  static Color get simia_blueRole =>
      Color(0xCC122CD2);

  static Color get simia_whiteOpacity =>
      Color(0x1AFDFDFF);

  static Color get simia_white =>
      Color(0xFFFDFDFF);
}
