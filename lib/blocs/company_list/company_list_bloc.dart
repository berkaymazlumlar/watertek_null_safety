import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/models/api_company.dart';
import 'package:teknoloji_kimya_servis/models/company.dart';
import 'package:teknoloji_kimya_servis/repositories/company_repository/company_list_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

part 'company_list_event.dart';
part 'company_list_state.dart';

class CompanyListBloc extends Bloc<CompanyListEvent, CompanyListState> {
  CompanyListBloc() : super(CompanyListInitialState());

  final CompanyListRepository _companyListRepository =
      locator<CompanyListRepository>();

  @override
  Stream<CompanyListState> mapEventToState(
    CompanyListEvent event,
  ) async* {
    if (event is GetCompanyListEvent) {
      try {
        yield CompanyListLoadingState();
        final _myCompanies = await _companyListRepository.getCompanyList();
        yield CompanyListLoadedState(companyList: _myCompanies);
      } catch (e) {
        yield CompanyListErrorState(error: "$e");
      }
    }
    if (event is AddCompanyListEvent) {}
    if (event is ClearCompanyListEvent) {
      yield CompanyListInitialState();
    }
  }
}
