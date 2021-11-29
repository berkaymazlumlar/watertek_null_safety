import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eralpsoftware/eralpsoftware.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teknoloji_kimya_servis/api/post_apis.dart';
import 'package:teknoloji_kimya_servis/api/put_apis.dart';
import 'package:teknoloji_kimya_servis/helpers/camera_or_gallery_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/flushbar_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';
import 'package:teknoloji_kimya_servis/pages/request_page/create_request_video_player.dart';
import 'package:teknoloji_kimya_servis/pages/request_page/request_images.dart';
import 'package:teknoloji_kimya_servis/pages/work_order/show_work_order_image.dart';
import 'package:teknoloji_kimya_servis/repositories/auth/auth_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';
import 'package:teknoloji_kimya_servis/views/general/my_text_field.dart';
import 'package:video_player/video_player.dart';

ImagePicker _imagePicker = ImagePicker();
AuthRepository _authRepository = locator<AuthRepository>();

class CreateRequestPage extends StatefulWidget {
  @override
  _CreateRequestPageState createState() => _CreateRequestPageState();
}

class _CreateRequestPageState extends State<CreateRequestPage> {
  String _pickedVideo;
  String _pickedPhoto;
  final List<PickedFile> _pickedPhotos = [];
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Talep Oluştur'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              _pushToDatabase();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyTextField(
                controller: _titleController,
                hintText: "Bir başlık yazın",
                labelText: "Başlık",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyTextField(
                controller: _descriptionController,
                maxLines: 5,
                hintText: "Bir açıklama yazın",
                labelText: "Açıklama",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  onTap: () async {
                    await _onPhotoTapped(context);
                  },
                  leading: Icon(
                    Icons.camera_alt,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    "Fotoğraf ekleyin",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("Maksimum 5 fotoğraf"),
                ),
              ),
            ),
            _pickedPhotos.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _pickedPhotos.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                NavigatorHelper(context).goTo(
                                  ShowRequestImage(
                                    imagePath: _pickedPhotos[index].path,
                                  ),
                                );
                              },
                              child: RequestImages(
                                path: _pickedPhotos[index].path,
                              ),
                              onLongPress: () async {
                                await _deleteImage(context, index);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
              child: _pickedVideo == null
                  ? Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 8,
                      child: ListTile(
                        onTap: () async {
                          await _onVideoTapped(context);
                        },
                        leading: Icon(
                          Icons.videocam,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Text(
                          "Video ekleyin",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text("Maksimum 10 saniye"),
                      ),
                    )
                  : Container(
                      color: Colors.black,
                      height: 200,
                      child: CreatRequestVideoPlayer(
                        video: File(_pickedVideo),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future _onVideoTapped(BuildContext context) async {
    final int _cameraOrGallery =
        await CameraOrGalleryHelper.showBottomSheet(context);

    if (_cameraOrGallery == null) {
      return;
    }
    final _pickedFile = await _imagePicker.getVideo(
      source: _cameraOrGallery == 0 ? ImageSource.camera : ImageSource.gallery,
      maxDuration: Duration(seconds: 10),
    );
    if (_pickedFile == null) {
      return;
    }

    // print(_pickedFile.path);
    // if (File(_pickedFile.path).lengthSync() > 20000000) {
    //   try {
    //     Eralp.startProgress(
    //       maxSecond: 999,
    //       child: Center(
    //         child:
    //             Text("Video boyutu çok yüksek. SIKIŞTIRILIYOR"),
    //       ),
    //     );
    //     await VideoCompress.deleteAllCache();

    //     MediaInfo mediaInfo = await VideoCompress.compressVideo(
    //       _pickedFile.path,
    //       quality: VideoQuality.LowQuality,
    //       deleteOrigin: false, // It's false by default
    //     );
    //     print(
    //         "mediaInfo length: ${(await mediaInfo.file.length())}");

    //     if (await mediaInfo.file.length() > 20000000) {
    //       FlushbarHelper.createError(
    //           title: "Başarısız",
    //           message: "Video'nun boyutu çok yüksek.")
    //         ..show(context);
    //       return;
    //     }
    //   } catch (e) {
    //     return;
    //   } finally {
    //     EralpHelper.stopProgress();
    //   }
    // }

    if (File(_pickedFile.path).lengthSync() > 20000000) {
      print("BOYUTTTTTTTTTTTT: ${File(_pickedFile.path).lengthSync()}");
      FlushbarHelper.createError(
          title: "Başarısız", message: "Video'nun boyutu çok yüksek.")
        ..show(context);
      return;
    }
    _pickedVideo = _pickedFile.path;
    print("picked file degistirildi");
    print("picked video path: $_pickedVideo");
    setState(() {});
  }

  Future _onPhotoTapped(BuildContext context) async {
    final int _cameraOrGallery =
        await CameraOrGalleryHelper.showBottomSheet(context);

    if (_cameraOrGallery == null) {
      return;
    }
    final _pickedFile = await _imagePicker.getImage(
      source: _cameraOrGallery == 0 ? ImageSource.camera : ImageSource.gallery,
    );
    if (_pickedFile == null) {
      return;
    }

    if (File(_pickedFile.path).lengthSync() > 40000000) {
      FlushbarHelper.createError(
          title: "Başarısız", message: "Fotoğrafın boyutu çok yüksek.")
        ..show(context);
      return;
    }
    _pickedPhoto = _pickedFile.path;
    _pickedPhotos.add(_pickedFile);
    print("picked file degistirildi");
    print("picked video path: $_pickedPhoto");
    setState(() {});
  }

  Future<void> _pushToDatabase() async {
    /// 1= veritabanina talebi olustur
    /// 2= olusan talebin id'sini al
    /// 3= olusan talebin id'si ile video varsa video, foto
    ///  varsa foto'yu firebase'ye idsi talep id'si olarak yukle

    if (_descriptionController.text == null ||
        _descriptionController.text.length < 1) {
      FlushbarHelper.createInformation(
          title: "Başarısız", message: "Lütfen bir açıklama girin.")
        ..show(context);
      return;
    }

    try {
      EralpHelper.startProgress();
      final _response = await PostApi.addCustomerRequest(
        title: "${_titleController.text}",
        description: "${_descriptionController.text}",
        userId: "${_authRepository.apiUser.data.id}",
        videoUrl: "",
      );
      if (_response is! int) {
        FlushbarHelper.createInformation(
            title: "Başarısız",
            message: "Talep oluşturulamadı. Hata: $_response")
          ..show(context);
        EralpHelper.stopProgress();
        return;
      }

      print("pickedVideo: $_pickedVideo");
      if (_pickedVideo != null) {
        EralpHelper.startProgress();
        final reference =
            FirebaseStorage.instance.ref().child("${DateTime.now()}");
        final uploadTask =
            reference.putData(File(_pickedVideo).readAsBytesSync());
        String url = await (await uploadTask.whenComplete(
          () {
            print("completed");
          },
        ))
            .ref
            .getDownloadURL();
        print("url: $url");

        final _putResponse = await PutApi.putCustomerRequestVideoUrl(
          customerRequestId: _response,
          videoUrl: url,
        );
        if (_putResponse is! bool) {
          FlushbarHelper.createInformation(
              title: "Başarısız",
              message: "Video yüklenemedi. Hata: $_response")
            ..show(context);
          EralpHelper.stopProgress();
          return;
        }
      }

      for (var _pickedPhoto in _pickedPhotos) {
        try {
          EralpHelper.startProgress();
          final reference =
              FirebaseStorage.instance.ref().child("${DateTime.now()}.png");
          final uploadTask = reference.putFile(
            File(_pickedPhoto.path),
          );
          String url = await (await uploadTask.whenComplete(() {
            print("completed");
          }))
              .ref
              .getDownloadURL();
          print("url: $url");

          await FirebaseFirestore.instance.collection('customer_images').add(
            {
              "request_id": "$_response",
              "userId": "${_authRepository.apiUser.data.id}",
              "image_path": "$url",
              "created_at": "${DateTime.now()}",
            },
          );
          Navigator.pop(context);
          MyFlushbarHelper(context: context).showSuccessFlushbar(
            title: "Başarılı",
            message: "Talep oluşturma işleminiz başarılı",
          );
        } on Exception catch (e) {
          FlushbarHelper.createError(
              title: "Başarısız", message: "Fotoğraf yüklenemedi")
            ..show(context);
        } finally {
          EralpHelper.stopProgress();
        }
      }
    } catch (e) {
    } finally {
      EralpHelper.stopProgress();
    }
  }

  GestureDetector buildGestureDetector(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _onPhotoTapped(context);
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

  _deleteImage(BuildContext context, int index) {
    _pickedPhotos.removeAt(index);
  }
}
