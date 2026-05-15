part of 'splash_bloc.dart';

abstract
class SplashState extends Equatable {
const SplashState();

@override
List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashLoaded extends SplashState {


const SplashLoaded();

@override
List<Object> get props => [];
}

class SplashError extends SplashState {
final Failure failure;

const SplashError({required this.failure});

@override
List<Object> get props => [failure];
}
