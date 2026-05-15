import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../../../../auth/domain/usecases/check_session_usecase.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final CheckSessionUseCase checkSessionUseCase;

  SplashBloc({required this.checkSessionUseCase}) : super(SplashInitial()) {
    on<SplashStarted>(_onSplashStarted);
  }

  Future<void> _onSplashStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoading());

    // Artificial delay for splash screen aesthetics
    await Future.delayed(const Duration(seconds: 2));

    final result = await checkSessionUseCase(NoParams());

    result.fold(
      (failure) => emit(SplashNavigateToLogin()),
      (user) => emit(SplashNavigateToDashboard()),
    );
  }
}
