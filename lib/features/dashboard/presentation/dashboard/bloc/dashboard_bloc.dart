import 'dart:async';

import 'package:ecommerce_app/core/usecases/usecase.dart';

import '../../../domain/entities/categories.dart';
import '../../../domain/usecases/dashboard_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failures.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/usecases/get_categories_usecase.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  final DashboardUseCase usecase;

  DashboardBloc({required this.getCategoriesUseCase, required this.usecase}) : super(DashboardInitial()) {
    on<GetCategoriesEvent>(_getCategories);
  }

  Future<void> _getCategories(GetCategoriesEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
    final failureOrCategories = await getCategoriesUseCase(NoParams());
    failureOrCategories.fold((failure) {
      String message = 'Server Error';
      if (failure is ServerFailure) {
        message = failure.message;
      }
      emit(DashboardError(message: message));
    }, (categories) => emit(DashboardLoaded(categories: categories)));
  }
}
