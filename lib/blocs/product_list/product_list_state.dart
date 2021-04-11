part of 'product_list_bloc.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

class ProductListInitialState extends ProductListState {}

class ProductListLoadingState extends ProductListState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ProductListLoadedState extends ProductListState {
  final ApiProduct productList;
  ProductListLoadedState({@required this.productList});
}

class ProductListErrorState extends ProductListState {
  final String error;

  ProductListErrorState({@required this.error});
}
