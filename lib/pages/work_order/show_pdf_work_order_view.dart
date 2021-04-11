import 'package:flutter/material.dart';
import 'package:pdf_flutter/pdf_flutter.dart';
import 'package:teknoloji_kimya_servis/repositories/work_order_repository/work_order_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

WorkOrderRepository _workOrderRepository = locator<WorkOrderRepository>();

class ShowPdfWorkOrderView extends StatefulWidget {
  ShowPdfWorkOrderView({Key key}) : super(key: key);

  @override
  _ShowPdfWorkOrderViewState createState() => _ShowPdfWorkOrderViewState();
}

class _ShowPdfWorkOrderViewState extends State<ShowPdfWorkOrderView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PDF.network(
        '${_workOrderRepository.apiWorkOrderData.pdfUrl}',
        width: _size.width * 0.99,
        height: _size.height * 0.5,
        placeHolder: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
