import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/usecases/register_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc({required this.registerUseCase}) : super(RegisterInitial()) {
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }

  Future<void> _onRegisterButtonPressed(
    RegisterButtonPressed event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());

    final failureOrUser = await registerUseCase(
      RegisterParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    failureOrUser.fold(
      (failure) {
        String message = 'Unexpected Error';
        if (failure is AuthFailure) {
          message = (failure as AuthFailure).message;
        }
        emit(RegisterFailure(message: message));
      },
      (user) => emit(RegisterSuccess()),
    );
  }
}
