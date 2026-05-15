part of 'login_bloc.dart';

abstract
class LoginState extends Equatable {
const LoginState();

@override
List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {


const LoginLoaded();

@override
List<Object> get props => [];
}

class LoginError extends LoginState {
final Failure failure;

const LoginError({required this.failure});

@override
List<Object> get props => [failure];
}
