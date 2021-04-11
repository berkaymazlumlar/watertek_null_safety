part of 'sale_bloc.dart';

abstract class SaleState extends Equatable {
  const SaleState();

  @override
  List<Object> get props => [];
}

class SaleInitialState extends SaleState {}

class SaleLoadedState extends SaleState {
  final ApiSale sale;
  SaleLoadedState({@required this.sale});
}

class SaleLoadingState extends SaleState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SaleFailureState extends SaleState {
  final String error;
  SaleFailureState({@required this.error});
}
