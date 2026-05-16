import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../auth/domain/usecases/check_session_usecase.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final CheckSessionUseCase checkSessionUseCase;

  SplashBloc({required this.checkSessionUseCase}) : super(SplashInitial()) {}
}
