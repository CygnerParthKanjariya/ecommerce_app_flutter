part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class GetProductsEvent extends ProductsEvent {
  final String endpoint;

  const GetProductsEvent({required this.endpoint});

  @override
  List<Object> get props => [endpoint];
}
