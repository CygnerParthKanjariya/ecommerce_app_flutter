
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failures.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/login.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../../../core/usecases/usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
      final LoginUseCase usecase;

      LoginBloc({required this.usecase}) : super(LoginInitial()){}
}
