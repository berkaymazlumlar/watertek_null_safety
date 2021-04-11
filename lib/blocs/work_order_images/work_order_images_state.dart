part of 'work_order_images_bloc.dart';

abstract class WorkOrderImagesState extends Equatable {
  const WorkOrderImagesState();
}

class WorkOrderImagesInitialState extends WorkOrderImagesState {
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class WorkOrderImagesLoadedState extends WorkOrderImagesState {
  final List<WorkOrderImage> workOrderImages;
  WorkOrderImagesLoadedState({@required this.workOrderImages});

  @override
  List<Object> get props => [workOrderImages];
}
class WorkOrderImagesZeroState extends WorkOrderImagesState {
  @override
  List<Object> get props => [];
}

class WorkOrderImagesErrorState extends WorkOrderImagesState {
  final String error;

  WorkOrderImagesErrorState({@required this.error});

  @override
  List<Object> get props => [error];
}
