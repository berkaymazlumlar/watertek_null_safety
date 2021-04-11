part of 'sale_bloc.dart';

abstract class SaleEvent extends Equatable {
  const SaleEvent();

  @override
  List<Object> get props => [];
}

class GetSaleEvent extends SaleEvent {}

class ClearSaleEvent extends SaleEvent {}

class SearchSaleEvent extends SaleEvent {
  final String search;
  SearchSaleEvent({@required this.search});
}
