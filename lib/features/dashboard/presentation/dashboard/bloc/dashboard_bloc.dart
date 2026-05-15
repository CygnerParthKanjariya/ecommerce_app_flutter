import '../../../domain/usecases/dashboard_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failures.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardUseCase usecase;

  DashboardBloc({required this.usecase}) : super(DashboardInitial()) {}
}
