import 'package:equatable/equatable.dart';

abstract class Message_bloc_event extends Equatable{
  const Message_bloc_event();
}
/* event to Bar*/
class Message_bloc_event_loading extends Message_bloc_event{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
/*  event to Car */
abstract class Car_bloc_event extends Equatable{
  const Car_bloc_event();
}
class Car_bloc_event_loading extends Car_bloc_event{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


