import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_flutter/pdf_flutter.dart';
import 'package:teknoloji_kimya_servis/blocs/work_order_images/work_order_images_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/work_order_updates/work_order_status_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/camera_or_gallery_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';
import 'package:teknoloji_kimya_servis/pages/work_order/show_pdf_work_order_view.dart';
import 'package:teknoloji_kimya_servis/pages/work_order/show_work_order_image.dart';
import 'package:teknoloji_kimya_servis/repositories/auth/auth_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/work_order_repository/work_order_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';
import 'package:image_picker/image_picker.dart';

class ShowWorkOrderDetail extends StatefulWidget {
  @override
  _ShowWorkOrderDetailState createState() => _ShowWorkOrderDetailState();
}

class _ShowWorkOrderDetailState extends State<ShowWorkOrderDetail> {
  AuthRepository _authRepository = locator<AuthRepository>();
  final picker = ImagePicker();
  final TextEditingController textEditingController = TextEditingController();
  WorkOrderRepository _workOrderRepository = locator<WorkOrderRepository>();
  String dropdownValue;

  @override
  void initState() {
    BlocProvider.of<WorkOrderImagesBloc>(context)
        .add(ClearWorkOrderImagesEvent());
    BlocProvider.of<WorkOrderStatusBloc>(context)
        .add(ClearWorkOrderStatusEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    print(_workOrderRepository.apiWorkOrderData.pdfUrl);
    return Scaffold(
      appBar: AppBar(
        title: Text("İş Emri"),
      ),
      body:
          //   ListTile(
          //     title: Text(
          //       "Çalışan adı: ${_workOrderRepository.apiWorkOrderData.workerName}",
          //     ),
          //   ),
          //   ListTile(
          //     title: Text(
          //       "Çalışan No: ${_workOrderRepository.apiWorkOrderData.workerPhone}",
          //     ),
          //   ),
          //   ListTile(
          //     title: Text(
          //       "Şirket adı: ${_workOrderRepository.apiWorkOrderData.companyName}",
          //     ),
          //   ),
          //   ListTile(
          //     title: Text(
          //       "Çalışan No: ${_workOrderRepository.apiWorkOrderData.companyPhone}",
          //     ),
          //   ),
          //   ListTile(
          //     title: Text(
          //       "İş Açıklaması: ${_workOrderRepository.apiWorkOrderData.taskDescription}",
          //     ),
          //   ),
          //   ListTile(
          //     title: Text(
          //       "İş Tarihi: ${DateHelper.getStringDateHourTR(_workOrderRepository.apiWorkOrderData.taskDate)}",
          //     ),
          //   ),
          //   ListTile(
          //     title: Text(
          //       "Oluşturma Tarihi: ${DateHelper.getStringDateHourTR(_workOrderRepository.apiWorkOrderData.createdDate)}",
          //     ),
          //   ),
          ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ShowPdfWorkOrderView(),
          ),
          BlocBuilder<WorkOrderImagesBloc, WorkOrderImagesState>(
            builder: (context, state) {
              if (state is WorkOrderImagesLoadedState) {
                return Container(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.workOrderImages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == state.workOrderImages.length) {
                        return buildGestureDetector(context);
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onLongPress: () async {
                            await _deleteImage(context, index);
                          },
                          onTap: () {
                            NavigatorHelper(context).goTo(
                              ShowWorkOrderImage(
                                imagePath:
                                    state.workOrderImages[index].imagePath,
                              ),
                            );
                          },
                          child: Container(
                            height: 140,
                            width: 70,
                            child: Image.network(
                              state.workOrderImages[index].imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              if (state is WorkOrderImagesInitialState) {
                BlocProvider.of<WorkOrderImagesBloc>(context).add(
                  GetWorkOrderImagesEvent(
                    workOrderId:
                        _workOrderRepository.apiWorkOrderData.id.toString(),
                    context: context,
                  ),
                );
              }
              if (state is WorkOrderImagesErrorState) {
                return Center(
                  child: RaisedButton(
                      child: Text("Yeniden Dene"),
                      onPressed: () {
                        BlocProvider.of<WorkOrderImagesBloc>(context).add(
                          ClearWorkOrderImagesEvent(),
                        );
                      }),
                );
              }
              if (state is WorkOrderImagesZeroState) {
                return buildGestureDetector(context);
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          dropdownColor: Colors.grey.shade200,
                          value: dropdownValue,
                          onChanged: (String newValue) {
                            dropdownValue = newValue;
                            setState(() {});
                          },
                          hint: Text("Bir güncelleme seçiniz"),
                          isExpanded: true,
                          items: [
                            DropdownMenuItem<String>(
                              child: Text("Ana Giriş Kapısı Bekleme"),
                              value: "Ana Giriş Kapısı Bekleme",
                            ),
                            DropdownMenuItem<String>(
                              child: Text("Fabrika Giriş Kapısı Bekleme"),
                              value: "Fabrika Giriş Kapısı Bekleme",
                            ),
                            DropdownMenuItem<String>(
                              child: Text("Isg Onay Bekleme"),
                              value: "Isg Onay Bekleme",
                            ),
                            DropdownMenuItem<String>(
                              child: Text("Yemek Molası"),
                              value: "Yemek Molası",
                            ),
                            DropdownMenuItem<String>(
                              child: Text("Çay Molası"),
                              value: "Çay Molası",
                            ),
                            DropdownMenuItem<String>(
                              child: Text("Tamamlandı"),
                              value: "Tamamlandı",
                            ),
                            DropdownMenuItem<String>(
                              child: Text("Dönüyorum"),
                              value: "Dönüyorum",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      try {
                        EralpHelper.startProgress();
                        final _response = await FirebaseFirestore.instance
                            .collection('work_order_status')
                            .add(
                          {
                            "id": "${DateTime.now().microsecondsSinceEpoch}",
                            "work_status": "$dropdownValue",
                            "worker_phone":
                                "${_authRepository.apiUser.data.phone}",
                            "worker_name":
                                "${_authRepository.apiUser.data.fullName}",
                            "work_order_id":
                                "${_workOrderRepository.apiWorkOrderData.id}",
                            "created_at": "${DateTime.now()}",
                          },
                        );
                        BlocProvider.of<WorkOrderStatusBloc>(context)
                            .add(ClearWorkOrderStatusEvent());
                        textEditingController.text = "";
                      } on Exception catch (e) {
                        FlushbarHelper.createError(
                            message: "İş durumu ekleme başarısız")
                          ..show(context);
                      } finally {
                        EralpHelper.stopProgress();
                      }
                    },
                    child: Text(
                      "Ekle",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLines: 10,
                        minLines: 1,
                        controller: textEditingController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.message),
                            hintText: "Bir güncelleme giriniz"),
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        try {
                          EralpHelper.startProgress();
                          final _response = await FirebaseFirestore.instance
                              .collection('work_order_status')
                              .add(
                            {
                              "id": "${DateTime.now().microsecondsSinceEpoch}",
                              "work_status": "${textEditingController.text}",
                              "worker_phone":
                                  "${_authRepository.apiUser.data.phone}",
                              "worker_name":
                                  "${_authRepository.apiUser.data.fullName}",
                              "work_order_id":
                                  "${_workOrderRepository.apiWorkOrderData.id}",
                              "created_at": "${DateTime.now()}",
                            },
                          );
                          BlocProvider.of<WorkOrderStatusBloc>(context)
                              .add(ClearWorkOrderStatusEvent());
                          textEditingController.text = "";
                        } on Exception catch (e) {
                          FlushbarHelper.createError(
                              message: "İş durumu ekleme başarısız")
                            ..show(context);
                        } finally {
                          EralpHelper.stopProgress();
                        }
                      },
                      child: Text(
                        "Ekle",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder<WorkOrderStatusBloc, WorkOrderStatusState>(
              builder: (context, state) {
            if (state is WorkOrderStatusLoadedState) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.workOrderStatusList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              state.workOrderStatusList[index].workerName,
                              style: TextStyle(fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          title: Text(
                              "${state.workOrderStatusList[index].workStatus}"),
                          subtitle: Text(DateHelper.getStringDateHourTR(
                              state.workOrderStatusList[index].createdAt)),
                        ),
                      );
                    }),
              );
            }
            if (state is WorkOrderStatusInitialState) {
              BlocProvider.of<WorkOrderStatusBloc>(context).add(
                GetWorkOrderStatusEvent(
                    workOrderId:
                        _workOrderRepository.apiWorkOrderData.id.toString()),
              );
            }
            if (state is WorkOrderStatusErrorState) {
              return Column(
                children: [
                  Text("Veriler yüklenemedi"),
                  RaisedButton(
                    child: Text("Hata: ${state.error}"),
                    onPressed: () {
                      BlocProvider.of<WorkOrderStatusBloc>(context).add(
                        ClearWorkOrderStatusEvent(),
                      );
                    },
                  ),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
        ],
      ),
    );
  }

  Future _deleteImage(BuildContext context, int index) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Fotoğraf silinecek"),
          content: Text("Emin misin?"),
          actions: [
            FlatButton(
              child: Text("GERI"),
              onPressed: () {
                Navigator.pop(ctx);
              },
            ),
            FlatButton(
              child: Text("TAMAM"),
              onPressed: () async {
                try {
                  final response = await FirebaseFirestore.instance
                      .collection("work_order_images")
                      .where("work_order_id",
                          isEqualTo: _workOrderRepository.apiWorkOrderData.id
                              .toString())
                      .get();

                  await FirebaseFirestore.instance
                      .collection('work_order_images')
                      .doc(response.docs[index].id)
                      .delete();
                  BlocProvider.of<WorkOrderImagesBloc>(context)
                      .add(ClearWorkOrderImagesEvent());
                  FlushbarHelper.createSuccess(
                    message: "Fotoğraf silme işlemi başarılı",
                  )..show(context);
                } on Exception catch (e) {
                  FlushbarHelper.createError(
                      message: "Fotoğraf silme işlemi başarısız")
                    ..show(context);
                } finally {
                  EralpHelper.stopProgress();
                }
                Navigator.pop(ctx);
              },
            ),
          ],
        );
      },
    );
  }

  GestureDetector buildGestureDetector(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final int _cameraOrGallery =
            await CameraOrGalleryHelper.showBottomSheet(context);

        if (_cameraOrGallery == null) {
          return;
        }
        final image = await picker.getImage(
          source:
              _cameraOrGallery == 0 ? ImageSource.camera : ImageSource.gallery,
          imageQuality: 90,
          maxHeight: 750,
          maxWidth: 750,
        );
        if (image == null) {
          return;
        }

        try {
          EralpHelper.startProgress();
          final reference =
              FirebaseStorage.instance.ref().child("${DateTime.now()}.png");
          final uploadTask = reference.putFile(
            File(image.path),
          );
          String url = await (await uploadTask.whenComplete(() {
            print("completed");
          }))
              .ref
              .getDownloadURL();
          print("url: $url");

          final _response = await FirebaseFirestore.instance
              .collection('work_order_images')
              .add(
            {
              "id": "${_workOrderRepository.apiWorkOrderData.id}",
              "image_path": "$url",
              "worker_phone": "${_authRepository.apiUser.data.phone}",
              "worker_name": "${_authRepository.apiUser.data.fullName}",
              "work_order_id": "${_workOrderRepository.apiWorkOrderData.id}",
              "created_at": "${DateTime.now()}",
            },
          );
          BlocProvider.of<WorkOrderImagesBloc>(context)
              .add(ClearWorkOrderImagesEvent());
          FlushbarHelper.createSuccess(
            message: "Fotoğraf yükleme işlemi başarılı",
          )..show(context);
        } on Exception catch (e) {
          FlushbarHelper.createError(
              message: "Fotoğraf yükleme işlemi başarısız")
            ..show(context);
        } finally {
          EralpHelper.stopProgress();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Icon(Icons.add_circle, size: 30, color: Colors.blue),
        ),
      ),
    );
  }
}
