part of 'work_order_images_bloc.dart';

abstract class WorkOrderImagesEvent extends Equatable {
  const WorkOrderImagesEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetWorkOrderImagesEvent extends WorkOrderImagesEvent {
 final String workOrderId;
 final BuildContext context;

  GetWorkOrderImagesEvent({@required this.workOrderId, @required this.context});
}

class ClearWorkOrderImagesEvent extends WorkOrderImagesEvent {}
