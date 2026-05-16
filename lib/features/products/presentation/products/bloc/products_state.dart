part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Products> products;
  const ProductsLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

class ProductsError extends ProductsState {
  final Failure failure;

  const ProductsError({required this.failure});

  @override
  List<Object> get props => [failure];
}
