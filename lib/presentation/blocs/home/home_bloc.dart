import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc({required this.homeRepository}) : super(HomeInitial()) {
    on<LoadHomes>(_onHomeInProcess);
  }

  Future<void> _onHomeInProcess(
      LoadHomes event, Emitter<HomeState> emit) async {
    emit(HomeInProcess());
  }
}
