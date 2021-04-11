part of 'product_list_bloc.dart';

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object> get props => [];
}

class GetProductListEvent extends ProductListEvent {}

class ClearProductListEvent extends ProductListEvent {}

class SearchProductListEvent extends ProductListEvent {
  final String search;
  SearchProductListEvent({@required this.search});
}
