part of 'material_list_bloc.dart';

abstract class MaterialListEvent extends Equatable {
  const MaterialListEvent();

  @override
  List<Object> get props => [];
}

class GetMaterialListEvent extends MaterialListEvent {}

class ClearMaterialListEvent extends MaterialListEvent {}
