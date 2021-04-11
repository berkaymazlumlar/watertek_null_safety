part of 'company_list_bloc.dart';

abstract class CompanyListEvent extends Equatable {
  const CompanyListEvent();

  @override
  List<Object> get props => [];
}

class GetCompanyListEvent extends CompanyListEvent {}

class AddCompanyListEvent extends CompanyListEvent {}

class ClearCompanyListEvent extends CompanyListEvent {}
