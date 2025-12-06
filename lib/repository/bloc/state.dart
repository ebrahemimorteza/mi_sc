
import 'package:atrak/model/Message_model.dart';
import 'package:equatable/equatable.dart';

import '../../model/Car_model.dart';
/* state to category Bar*/
abstract class Bar_bloc_state extends Equatable{}
//وضعیت های مختلف و برای هر وضعیت یک کلاس

//وضعیت 1
class Bar_bloc_state_loading extends Bar_bloc_state{
  @override
  // TODO: implement props
  //لیستی از ابجکت ها از نوع پراپس
  //پراپ ها یعنی خصوصیلت یک کلاس
  //کلاس ایکیوتبل هر دفعه میاد نمونه های ساخت  شده از کلاس را بررسی میکنه که تفاوت هارو پیدا کنه اگه تفاوتی بود به یو ای اطلاع بده
  List<Object?> get props => [];

}

/* state to CarScreen */
/* state to category sal*/
abstract class Car_bloc_state extends Equatable{}
//وضعیت های مختلف و برای هر وضعیت یک کلاس

//وضعیت 1
class Car_bloc_state_loading extends Car_bloc_state{
  @override
  // TODO: implement props
  //لیستی از ابجکت ها از نوع پراپس
  //پراپ ها یعنی خصوصیلت یک کلاس
  //کلاس ایکیوتبل هر دفعه میاد نمونه های ساخت  شده از کلاس را بررسی میکنه که تفاوت هارو پیدا کنه اگه تفاوتی بود به یو ای اطلاع بده
  List<Object?> get props => [];

}
class Car_bloc_state_loaded extends Car_bloc_state{
  final List<Car_model> car;
  Car_bloc_state_loaded(this.car);
  @override
  // TODO: implement props
  List<Object?> get props => [car];

}
class Car_bloc_state_Error extends Car_bloc_state{
  final String error_text;
  Car_bloc_state_Error(this.error_text);

  @override
  // TODO: implement props
  List<Object?> get props => [error_text];

}

/* state to Anbar*/
abstract class Message_bloc_state extends Equatable{}
//وضعیت های مختلف و برای هر وضعیت یک کلاس

//وضعیت 1
class Message_bloc_state_loading extends Message_bloc_state{
  @override
  // TODO: implement props
  //لیستی از ابجکت ها از نوع پراپس
  //پراپ ها یعنی خصوصیلت یک کلاس
  //کلاس ایکیوتبل هر دفعه میاد نمونه های ساخت  شده از کلاس را بررسی میکنه که تفاوت هارو پیدا کنه اگه تفاوتی بود به یو ای اطلاع بده
  List<Object?> get props => [];

}
class Message_bloc_state_loaded extends Message_bloc_state{
  final List<Message_model> message;
  Message_bloc_state_loaded(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];

}
class Message_bloc_state_Error extends Message_bloc_state{
  final String error_text;
  Message_bloc_state_Error(this.error_text);

  @override
  // TODO: implement props
  List<Object?> get props => [error_text];

}

