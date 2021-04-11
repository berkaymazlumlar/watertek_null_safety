part of 'spare_part_list_bloc.dart';

abstract class SparePartListEvent extends Equatable {
  const SparePartListEvent();

  @override
  List<Object> get props => [];
}

class GetSparePartListEvent extends SparePartListEvent {}

class ClearSparePartListEvent extends SparePartListEvent {}
