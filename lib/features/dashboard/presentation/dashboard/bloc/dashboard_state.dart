part of 'dashboard_bloc.dart';

abstract
class DashboardState extends Equatable {
const DashboardState();

@override
List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {


const DashboardLoaded();

@override
List<Object> get props => [];
}

class DashboardError extends DashboardState {
final Failure failure;

const DashboardError({required this.failure});

@override
List<Object> get props => [failure];
}
