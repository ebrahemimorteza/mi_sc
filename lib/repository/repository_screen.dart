import 'dart:convert';

import 'package:atrak/model/Message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:atrak/repository/jjTools.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';

import '../model/Car_model.dart';


class Repository {
  var box = GetStorage();
  //push to model Bar
  //push to model sal
  Future<List<String>> getSalaray() async {
    List<String> car_list = [];
    var params = "do=SalarayAttrack.getContent&id="+box.read(token);
    if (car_list.isEmpty) {
      await JJ().jjAjax(params).then((result) async {
        print(result);
        final json = jsonDecode(result);
        if (json==400) {
          // JJ.jjToast(MyStrings.dr_warning);
        } else {
          for (var element in json) {
            car_list.add(element);
          }
        }
      });
    }
    return car_list;
  }
  //push to model message
  Future<List<Message_model>> getMessage() async {
    List<Message_model> meaasge_list = [];
    var params = "do=Messenger.messageForApp&id="+box.read(token);
    if (meaasge_list.isEmpty) {
      await JJ().jjAjax(params).then((result) async {
        print(result);
        final json = jsonDecode(result);
        if (json==400) {
          // JJ.jjToast(MyStrings.dr_warning);
        } else {
          for (var element in json) {
            meaasge_list.add(Message_model.fromJson(element));
          }
        }
      });
    }
    print("meaasge_list");
    print(meaasge_list);
    return meaasge_list;
  }
  //push to model Bar
  Future<List<Car_model>> getCar() async {
    List<Car_model> car_list = [];
    // To get data I wrote an extension method bellow

    // final Map<String, dynamic> jsonBody = {
    //   "limit": 50,
    //   "offset": 0,//"integer (optional, default: 0)",
    //   "status": 0
    // };
    print(" >> ${box.read(token)}");
    var params = "do=SalarayAttrack.getContent&id="+box.read(token);
    if (car_list.isEmpty) {
      await JJ().jjAjax(params).then((result) async {
        print("ppppppp1");
        print(result);
        final json = jsonDecode(result);
        print("json");
        print(json);
        if (json==400) {
          // JJ.jjToast(MyStrings.dr_warning);
        } else {
          for (var element in json) {
            car_list.add(Car_model.fromJson(element));
          }
        }
      });
    }
    return car_list;
  }
  //push to model Bar

  //push to model Bar

  //push to model Bar

}
