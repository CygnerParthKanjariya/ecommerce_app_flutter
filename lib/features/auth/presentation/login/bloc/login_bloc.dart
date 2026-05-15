import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    final failureOrUser = await loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );

    failureOrUser.fold((failure) {
      String message = 'Invalid Credentials';
      emit(LoginFailure(message: message));
    }, (user) => emit(LoginSuccess()));
  }
}
