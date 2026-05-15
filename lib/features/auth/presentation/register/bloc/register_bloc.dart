
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/register.dart';
import '../../../domain/usecases/register_usecase.dart';
import '../../../../../core/usecases/usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
      final RegisterUseCase usecase;

      RegisterBloc({required this.usecase}) : super(RegisterInitial()){}
}
