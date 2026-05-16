
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failures.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/products.dart';
import '../../../domain/usecases/products_usecase.dart';
import '../../../../../core/usecases/usecase.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
      final ProductsUseCase usecase;

      ProductsBloc({required this.usecase}) : super(ProductsInitial()){
            on<GetProductsEvent>(_getProducts);
      }

  Future<void> _getProducts(GetProductsEvent event, Emitter<ProductsState> emit) async {
            emit(ProductsLoading());

            final failureOrProducts = await usecase(ProductParams(endpoint: event.endpoint));

            failureOrProducts.fold(
                  (failure) => emit(ProductsError(failure: failure)),
                  (products) => emit(ProductsLoaded(products: products)),
            );
  }
}
