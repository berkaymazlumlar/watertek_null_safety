import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_request.dart';
import 'package:teknoloji_kimya_servis/pages/request_page/request_images.dart';
import 'package:teknoloji_kimya_servis/pages/request_page/show_request_image.dart';
import 'package:teknoloji_kimya_servis/pages/request_page/show_request_video.dart';

class RequestDetailPage extends StatefulWidget {
  final ApiCustomerRequestData apiCustomerRequestData;
  const RequestDetailPage({
    Key key,
    this.apiCustomerRequestData,
  }) : super(key: key);
  @override
  _RequestDetailPageState createState() => _RequestDetailPageState();
}

class _RequestDetailPageState extends State<RequestDetailPage> {
  final List<String> imageUrls = [];
  String videoUrl;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("customer_images")
        .where("request_id",
            isEqualTo: widget.apiCustomerRequestData.id.toString())
        .get()
        .then((value) {
      print(value.docs.length);
      for (var doc in value.docs) {
        imageUrls.add(doc.data()["image_path"]);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Talep Detayı"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            buildContainer(
                key: "Başlık",
                value: "${widget.apiCustomerRequestData.title}",
                color: Colors.grey[300]),
            buildContainer(
              key: "Müşteri Adı",
              value: "${widget.apiCustomerRequestData.userFullname}",
            ),
            buildContainer(
              key: "Müşteri Telefon",
              value: "${widget.apiCustomerRequestData.userphone}",
              color: Colors.grey[300],
            ),
            buildContainer(
              key: "Talep Tarihi",
              value:
                  "${DateHelper.getStringDateHourTR(widget.apiCustomerRequestData.createdAt)}",
            ),
            SizedBox(
              height: 15,
            ),
            Card(
              margin: EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      "Açıklama",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Text("${widget.apiCustomerRequestData.description}"),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            imageUrls.length <= 0
                ? Container()
                : Card(
                    margin: EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                          child: Text(
                            "Fotoğraflar",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                          child: Container(
                            height: 100,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: imageUrls.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    NavigatorHelper(context)
                                        .goTo(ShowRequestImage(
                                      imageUrl: imageUrls[index],
                                    ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: RequestImagesNetwork(
                                        path: imageUrls[index],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            SizedBox(
              height: 15,
            ),
            widget.apiCustomerRequestData.videoUrl.length <= 1
                ? Container()
                : Card(
                    margin: EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                          child: Text(
                            "Video",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                          child: Container(
                            color: Colors.black,
                            height: 200,
                            child: CreatRequestNetworkVideoPlayer(
                              video: widget.apiCustomerRequestData.videoUrl,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Container buildContainer({String key, String value, Color color}) {
    return Container(
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$key ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("$value"),
        ],
      ),
    );
  }
}
