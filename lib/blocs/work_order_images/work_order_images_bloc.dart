import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/models/work_order_image.dart';

part 'work_order_images_event.dart';
part 'work_order_images_state.dart';

class WorkOrderImagesBloc extends Bloc<WorkOrderImagesEvent, WorkOrderImagesState> {
  WorkOrderImagesBloc() : super(WorkOrderImagesInitialState());


  @override
  Stream<WorkOrderImagesState> mapEventToState(
    WorkOrderImagesEvent event,
  ) async* {
   if(event is GetWorkOrderImagesEvent){
     try {
       final response = await FirebaseFirestore.instance
           .collection("work_order_images")
           .where("work_order_id", isEqualTo: event.workOrderId.toString())
           .get();
       if (response.docs.length >= 1) {
         final List<WorkOrderImage> workOrderImages = [];
         for(var doc in response.docs){
           workOrderImages.add(WorkOrderImage.fromJson(doc));
         }
         yield WorkOrderImagesLoadedState(workOrderImages: workOrderImages);
       } else if (response.docs.length == 0) {
         yield WorkOrderImagesZeroState();
       } else {
         yield WorkOrderImagesErrorState(error: "Bir hata oluştu");
       }
     } on Exception catch (e) {
      yield WorkOrderImagesErrorState(error: e.toString());
     } finally {
       EralpHelper.stopProgress();
     }
   }
   if(event is ClearWorkOrderImagesEvent){
     yield WorkOrderImagesInitialState();
   }
  }
}
