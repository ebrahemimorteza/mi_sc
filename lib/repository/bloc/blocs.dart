
import 'package:atrak/model/Message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:atrak/repository/bloc/event.dart';
import 'package:atrak/repository/bloc/state.dart';
import 'package:atrak/repository/repository_screen.dart';
/* class bloc to message */
class Message_bloc
    extends Bloc<Message_bloc_event, Message_bloc_state> {
  late final Repository _repository;

  Message_bloc(this._repository)
      : super(Message_bloc_state_loading()) {
    print("........................................");
    on<Message_bloc_event_loading>((event, emit) async {
      emit(Message_bloc_state_loading());
      try {
        final category = await _repository.getMessage();
        emit(Message_bloc_state_loaded(category));
      } catch (e) {
        emit(Message_bloc_state_Error(e.toString()));
      }
    });
  }
}
/* class bloc to Car */
class Car_bloc
    extends Bloc<Car_bloc_event, Car_bloc_state> {
  late final Repository _repository;

  Car_bloc(this._repository)
      : super(Car_bloc_state_loading()) {
    print("........................................");
    on<Car_bloc_event_loading>((event, emit) async {
      emit(Car_bloc_state_loading());
      try {
        final car = await _repository.getCar();
        emit(Car_bloc_state_loaded(car));
      } catch (e) {
        emit(Car_bloc_state_Error(e.toString()));
      }
    });
  }
}


