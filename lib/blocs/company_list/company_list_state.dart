part of 'company_list_bloc.dart';

abstract class CompanyListState extends Equatable {
  const CompanyListState();

  @override
  List<Object> get props => [];
}

class CompanyListInitialState extends CompanyListState {}

class CompanyListLoadingState extends CompanyListState {}

class CompanyListLoadedState extends CompanyListState {
  final ApiCompany companyList;
  CompanyListLoadedState({@required this.companyList});
}

class CompanyListErrorState extends CompanyListState {
  final String error;
  CompanyListErrorState({@required this.error});
}
