part of 'spare_part_list_bloc.dart';

abstract class SparePartListState extends Equatable {
  const SparePartListState();

  @override
  List<Object> get props => [];
}

class SparePartListInitialState extends SparePartListState {}

class SparePartListLoadedState extends SparePartListState {
  final ApiSparePart sparePartList;
  SparePartListLoadedState({@required this.sparePartList});
}

class SparePartListErrorState extends SparePartListState {
  final String error;

  SparePartListErrorState({@required this.error});
}
