part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterLoaded extends RegisterState {
  const RegisterLoaded();

  @override
  List<Object> get props => [];
}

class RegisterError extends RegisterState {
  final Failure failure;

  const RegisterError({required this.failure});

  @override
  List<Object> get props => [failure];
}
