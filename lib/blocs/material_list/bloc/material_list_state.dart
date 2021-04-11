part of 'material_list_bloc.dart';

abstract class MaterialListState extends Equatable {
  const MaterialListState();

  @override
  List<Object> get props => [];
}

class MaterialListInitialState extends MaterialListState {}

class MaterialListLoadedState extends MaterialListState {
  final ApiMaterial materialList;
  MaterialListLoadedState({@required this.materialList});
}

class MaterialListErrorState extends MaterialListState {
  final String error;

  MaterialListErrorState({@required this.error});
}
