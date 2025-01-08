import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  StreamSubscription<List<ConnectivityResult>>? subscription;
  InternetBloc() : super(InternetInitial()) {
    on<OnConnected>(
      (event, emit) => emit(Connected(message: "Đã kết nối internet")),
    );
    on<OnNotConnected>(
      (event, emit) => emit(NotConnected(message: "Vui lòng kết nối internet")),
    );

    subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.mobile)) {
        add(OnConnected());
      } else {
        add(OnNotConnected());
      }
    });
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
