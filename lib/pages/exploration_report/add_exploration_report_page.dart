import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:teknoloji_kimya_servis/api/post_apis.dart';
import 'package:teknoloji_kimya_servis/blocs/exploration/exploration_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/flushbar_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';
import 'package:teknoloji_kimya_servis/pages/users_page/choose_user_page.dart';
import 'package:teknoloji_kimya_servis/providers/exploration%20report.dart';
import 'package:teknoloji_kimya_servis/utils/debouncer.dart';
import 'package:teknoloji_kimya_servis/views/general/my_raised_button.dart';
import 'package:teknoloji_kimya_servis/views/general/my_text_field.dart';

import 'draw_page.dart';

class AddExplorationReportPage extends StatefulWidget {
  AddExplorationReportPage({Key key}) : super(key: key);

  @override
  _AddExplorationReportPageState createState() =>
      _AddExplorationReportPageState();
}

class _AddExplorationReportPageState extends State<AddExplorationReportPage> {
  TextEditingController _person;
  TextEditingController _sektor;
  TextEditingController _suAnalizParametreleri;
  TextEditingController _dalgicPompaKwHp;
  TextEditingController _tesisatBaglantiCapi;
  TextEditingController _suBasinciBar;
  TextEditingController _genlesmeTankiBilgisi;
  TextEditingController _m3saatdebi;
  TextEditingController _suBasinci35bar;
  TextEditingController _dosenecekTesisatMetraji;
  TextEditingController _bypassliTesisat;
  TextEditingController _sisteminKurulacagiAlanNotlari;
  TextEditingController _birimSuAmbalajiBasinaKacParaTlAdet;

  ExplorationReportProvider _explorationReportProviderLF;

  FocusNode _personNameFocus = FocusNode();

  bool _showFab = true;
  ScrollController _scrollController;

  final Debouncer _debouncer = Debouncer(delay: Duration(milliseconds: 50));

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      _debounce(
        _scrollController.position.userScrollDirection ==
            ScrollDirection.forward,
      );
    });
    _explorationReportProviderLF =
        Provider.of<ExplorationReportProvider>(context, listen: false);
    _person = TextEditingController();
    _sektor = TextEditingController();
    _suAnalizParametreleri = TextEditingController();
    _dalgicPompaKwHp = TextEditingController();
    _tesisatBaglantiCapi = TextEditingController();
    _suBasinciBar = TextEditingController();
    _genlesmeTankiBilgisi = TextEditingController();
    _m3saatdebi = TextEditingController();
    _suBasinci35bar = TextEditingController();
    _dosenecekTesisatMetraji = TextEditingController();
    _bypassliTesisat = TextEditingController();
    _sisteminKurulacagiAlanNotlari = TextEditingController();
    _birimSuAmbalajiBasinaKacParaTlAdet = TextEditingController();

    _explorationReportProviderLF.person = _person;
    _explorationReportProviderLF.sektor = _sektor;
    _explorationReportProviderLF.suAnalizParametreleri = _suAnalizParametreleri;
    _explorationReportProviderLF.dalgicPompaKwHp = _dalgicPompaKwHp;
    _explorationReportProviderLF.tesisatBaglantiCapi = _tesisatBaglantiCapi;
    _explorationReportProviderLF.suBasinciBar = _suBasinciBar;
    _explorationReportProviderLF.genlesmeTankiBilgisi = _genlesmeTankiBilgisi;
    _explorationReportProviderLF.m3saatdebi = _m3saatdebi;
    _explorationReportProviderLF.suBasinci35bar = _suBasinci35bar;
    _explorationReportProviderLF.dosenecekTesisatMetraji =
        _dosenecekTesisatMetraji;
    _explorationReportProviderLF.bypassliTesisat = _bypassliTesisat;
    _explorationReportProviderLF.sisteminKurulacagiAlanNotlari =
        _sisteminKurulacagiAlanNotlari;
    _explorationReportProviderLF.birimSuAmbalajiBasinaKacParaTlAdet =
        _birimSuAmbalajiBasinaKacParaTlAdet;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _explorationReportProviderLF.clearDraw();
      _explorationReportProviderLF.clearPdf();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _explorationReportProvider =
        Provider.of<ExplorationReportProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Keşif Raporu Ekle'),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.picture_as_pdf),
          //   onPressed: () async {
          //     await _addPdf(_explorationReportProvider);
          //   },
          // ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              await _pushToApi(_explorationReportProvider, context);
            },
          ),
        ],
      ),
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.all(8),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                NavigatorHelper(context).goTo(
                  ChooseUserPage(
                    onCompanyChoosed: (company) {
                      _explorationReportProvider.apiCompany = company;
                      Navigator.pop(context);
                    },
                  ),
                );
              },
              child: AbsorbPointer(
                absorbing: true,
                child: MyTextField(
                  // decoration: InputDecoration(

                  // ),
                  hintText: _explorationReportProvider.apiCompany == null
                      ? "Müşteri seç"
                      : "${_explorationReportProvider.apiCompany.fullName}",
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextField(
              controller: _explorationReportProvider.person,
              hintText: "Kişi ismi",
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextField(
              controller: _explorationReportProvider.sektor,
              hintText: "Sektör",
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          // GestureDetector(
          //   onTap: () async {
          //     final _date = await showDatePicker(
          //       context: context,
          //       initialDate: DateTime.now(),
          //       firstDate: DateTime.now().subtract(
          //         Duration(days: 365),
          //       ),
          //       lastDate: DateTime.now().add(
          //         Duration(days: 365),
          //       ),
          //     );
          //     if (_date != null) {
          //       _explorationReportProviderLF.date = _date;
          //     }
          //   },
          //   child: AbsorbPointer(
          //     absorbing: true,
          //     child: TextFormField(
          //       decoration: InputDecoration(
          //         hintText: _explorationReportProvider.date == null
          //             ? "Tarih"
          //             : DateHelper.getStringDateTR(
          //                 _explorationReportProvider.date),
          //         hintStyle: _explorationReportProvider.date == null
          //             ? null
          //             : TextStyle(color: Colors.black),
          //       ),
          //       textCapitalization: TextCapitalization.sentences,
          //     ),
          //   ),
          // ),
          _buildDivider(context),
          _buildTitle("Sistem Tipi"),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                      "${_explorationReportProvider.getKullanimSuyuMuIcmeSuyuMu(0)}"),
                  value: 0,
                  groupValue:
                      _explorationReportProvider.kullanimSuyuMuIcmeSuyuMu,
                  onChanged: (value) {
                    _explorationReportProviderLF.kullanimSuyuMuIcmeSuyuMu =
                        value;
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                      "${_explorationReportProvider.getKullanimSuyuMuIcmeSuyuMu(1)}"),
                  value: 1,
                  groupValue:
                      _explorationReportProvider.kullanimSuyuMuIcmeSuyuMu,
                  onChanged: (value) {
                    _explorationReportProviderLF.kullanimSuyuMuIcmeSuyuMu =
                        value;
                  },
                ),
              ),
            ],
          ),
          _buildDivider(context),
          _buildTitle("Arıtılacak Suyun Kaynağı"),
          RadioListTile(
            title:
                Text("${_explorationReportProvider.getAritilacakSuKaynagi(0)}"),
            value: 0,
            groupValue: _explorationReportProvider.aritilacakSuKaynagi,
            onChanged: (value) {
              _explorationReportProviderLF.aritilacakSuKaynagi = value;
            },
          ),
          RadioListTile(
            title:
                Text("${_explorationReportProvider.getAritilacakSuKaynagi(1)}"),
            value: 1,
            groupValue: _explorationReportProvider.aritilacakSuKaynagi,
            onChanged: (value) {
              _explorationReportProviderLF.aritilacakSuKaynagi = value;
            },
          ),
          _buildDivider(context),
          _buildTitle("Su Analiz Değerleri"),
          MyTextField(
            controller: _explorationReportProvider.suAnalizParametreleri,
            hintText: "Su analiz parametrelerini girin",
            textCapitalization: TextCapitalization.sentences,
            maxLines: null,
          ),
          _buildDivider(context),
          _buildBoolTitle(
            "Tesis girişinde su depolanıyor mu?",
            _explorationReportProvider.tesisGirisindeSuDepolaniyor,
            () {
              _explorationReportProvider.tesisGirisindeSuDepolaniyor =
                  !_explorationReportProvider.tesisGirisindeSuDepolaniyor;
            },
          ),
          _buildTesisGirisindeSuDepolaniyorColumn(
              _explorationReportProvider, context),
          _buildDivider(context),
          _buildBoolTitle(
            "Mevcut su kaynağı tesis girişinde ana hatta arıtılıyor mu?",
            _explorationReportProvider
                .suKaynagiTesisGirisindeAnaHattaAritiliyor,
            () {
              _explorationReportProvider
                      .suKaynagiTesisGirisindeAnaHattaAritiliyor =
                  !_explorationReportProvider
                      .suKaynagiTesisGirisindeAnaHattaAritiliyor;
            },
          ),
          _buildSuKaynagiTesisatGirisindeAnaHattaAritiliyorColumn(
              _explorationReportProvider),
          _buildDivider(context),
          _buildBoolTitle(
            "Su kaynağı artezyen veya kuyu suyu mu?",
            _explorationReportProvider.suKaynagiArtezyenVeyaKuyuSuyu,
            () {
              _explorationReportProvider.suKaynagiArtezyenVeyaKuyuSuyu =
                  !_explorationReportProvider.suKaynagiArtezyenVeyaKuyuSuyu;
            },
          ),
          _buildSuKaynagiArtezyenVeyaKuyuSuyuColumn(_explorationReportProvider),
          _buildDivider(context),
          _buildTitle(
            "İçme suyu hattında kullanılacak tesisat materyali",
          ),
          _explorationReportProvider.kullanimSuyuMuIcmeSuyuMu == 0
              ? Container()
              : RadioListTile(
                  title: Text(
                      "${_explorationReportProvider.getIcmeSuyuHattindaKullanilacakMateryal(0)}"),
                  value: 0,
                  groupValue: _explorationReportProvider
                      .icmeSuyuHattindaKullanilacakMateryal,
                  onChanged: (value) {
                    _explorationReportProviderLF
                        .icmeSuyuHattindaKullanilacakMateryal = value;
                  },
                ),
          RadioListTile(
            title: Text(
                "${_explorationReportProvider.getIcmeSuyuHattindaKullanilacakMateryal(1)}"),
            value: 1,
            groupValue:
                _explorationReportProvider.icmeSuyuHattindaKullanilacakMateryal,
            onChanged: (value) {
              _explorationReportProviderLF
                  .icmeSuyuHattindaKullanilacakMateryal = value;
            },
          ),
          RadioListTile(
            title: Text(
                "${_explorationReportProvider.getIcmeSuyuHattindaKullanilacakMateryal(2)}"),
            value: 2,
            groupValue:
                _explorationReportProvider.icmeSuyuHattindaKullanilacakMateryal,
            onChanged: (value) {
              _explorationReportProviderLF
                  .icmeSuyuHattindaKullanilacakMateryal = value;
            },
          ),
          _explorationReportProvider.kullanimSuyuMuIcmeSuyuMu == 0
              ? Container()
              : RadioListTile(
                  title: Text(
                      "${_explorationReportProvider.getIcmeSuyuHattindaKullanilacakMateryal(3)}"),
                  value: 3,
                  groupValue: _explorationReportProvider
                      .icmeSuyuHattindaKullanilacakMateryal,
                  onChanged: (value) {
                    _explorationReportProviderLF
                        .icmeSuyuHattindaKullanilacakMateryal = value;
                  },
                ),
          _buildDivider(context),
          _buildTitle(
            _explorationReportProvider.kullanimSuyuMuIcmeSuyuMu == 1
                ? "Döşenecek tesisat metrajı (.. metre)"
                : "Bypasslı tesisat",
          ),
          _explorationReportProvider.kullanimSuyuMuIcmeSuyuMu == 1
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyTextField(
                    controller: _dosenecekTesisatMetraji,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    hintText: "Lütfen metre cinsinden girin",
                    keyboardType: TextInputType.number,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyTextField(
                    controller: _bypassliTesisat,
                    hintText: "Not",
                  ),
                ),
          _buildDivider(context),
          _buildTitle(
            "Sistemin kurulacağı alan",
          ),
          RadioListTile(
            title: Text(
                "${_explorationReportProvider.getSisteminKurulacagiAlan(0)}"),
            value: 0,
            groupValue: _explorationReportProvider.sisteminKurulacagiAlan,
            onChanged: (value) {
              _explorationReportProviderLF.sisteminKurulacagiAlan = value;
            },
          ),
          RadioListTile(
            title: Text(
                "${_explorationReportProvider.getSisteminKurulacagiAlan(1)}"),
            value: 1,
            groupValue: _explorationReportProvider.sisteminKurulacagiAlan,
            onChanged: (value) {
              _explorationReportProviderLF.sisteminKurulacagiAlan = value;
            },
          ),
          RadioListTile(
            title: Text(
                "${_explorationReportProvider.getSisteminKurulacagiAlan(2)}"),
            value: 2,
            groupValue: _explorationReportProvider.sisteminKurulacagiAlan,
            onChanged: (value) {
              _explorationReportProviderLF.sisteminKurulacagiAlan = value;
            },
          ),
          RadioListTile(
            title: Text(
                "${_explorationReportProvider.getSisteminKurulacagiAlan(3)}"),
            value: 3,
            groupValue: _explorationReportProvider.sisteminKurulacagiAlan,
            onChanged: (value) {
              _explorationReportProviderLF.sisteminKurulacagiAlan = value;
            },
          ),
          RadioListTile(
            title: Text(
                "${_explorationReportProvider.getSisteminKurulacagiAlan(4)}"),
            value: 4,
            groupValue: _explorationReportProvider.sisteminKurulacagiAlan,
            onChanged: (value) {
              _explorationReportProviderLF.sisteminKurulacagiAlan = value;
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextField(
              controller: _sisteminKurulacagiAlanNotlari,
              // decoration: InputDecoration(
              hintText:
                  "Sistemin kurulacağı alan ile girmek istediğiniz notlar(en X genişlik X yükseklik değerleri vb)",
              // ),
              textCapitalization: TextCapitalization.sentences,
              maxLines: 3,
            ),
          ),
          _buildDivider(context),
          _explorationReportProvider.kullanimSuyuMuIcmeSuyuMu == 0
              ? Container()
              : _buildTitle(
                  "İşletmede çalışan kişi/vardiya sayısı",
                ),
          _explorationReportProvider.kullanimSuyuMuIcmeSuyuMu == 0
              ? Container()
              : MyRaisedButton(
                  // color: Theme.of(context).primaryColor,
                  onPressed: () {
                    _showIsletmeKisiVardiyaModal(context);
                  },
                  buttonText:
                      "${_explorationReportProvider.isletmeKisiSayisi} Kişi/${_explorationReportProvider.isletmeVardiyaSayisi} Vardiya",

                  // child: Text(
                  //   "${_explorationReportProvider.isletmeKisiSayisi} Kişi/${_explorationReportProvider.isletmeVardiyaSayisi} Vardiya",
                  //   style: TextStyle(color: Colors.white),
                  // ),
                ),
          _buildDivider(context),
          _buildTitle(
            "Personelin ve ziyaretçilerin çay, kahve ve içme suyu ihtiyacı nasıl temin ediliyor?",
          ),
          SizedBox(height: 4),
          MyRaisedButton(
            // color: Theme.of(context).primaryColor,
            onPressed: () {
              _showCayKahveIcmeSuyuIhtiyaciModal(context, 0);
            },
            buttonText:
                "Damacana su ile - Aylık:${_explorationReportProvider.aylikDamacanaTuketimSayisi}, Yıllık:${_explorationReportProvider.yillikDamacanaTuketimSayisi}",

            // child: Text(
            //   "Damacana su ile - Aylık:${_explorationReportProvider.aylikDamacanaTuketimSayisi}, Yıllık:${_explorationReportProvider.yillikDamacanaTuketimSayisi}",
            //   style: TextStyle(color: Colors.white),
            // ),
          ),
          SizedBox(height: 4),

          MyRaisedButton(
            // color: Theme.of(context).primaryColor,
            onPressed: () {
              _showCayKahveIcmeSuyuIhtiyaciModal(context, 1);
            },
            buttonText:
                "Pet şişe su ile - Aylık:${_explorationReportProvider.aylikPetSiseSuSayisi}, Yıllık:${_explorationReportProvider.yillikPetSiseSuSayisi}",

            // child: Text(
            //   "Pet şişe su ile - Aylık:${_explorationReportProvider.aylikPetSiseSuSayisi}, Yıllık:${_explorationReportProvider.yillikPetSiseSuSayisi}",
            //   style: TextStyle(color: Colors.white),
            // ),
          ),
          SizedBox(height: 4),

          MyRaisedButton(
            // color: Theme.of(context).primaryColor,
            onPressed: () {
              _showCayKahveIcmeSuyuIhtiyaciModal(context, 2);
            },
            buttonText:
                "Bardak su ile - Aylık:${_explorationReportProvider.aylikBardakSuSayisi}, Yıllık:${_explorationReportProvider.yillikBardakSuSayisi}",

            // child: Text(
            //   "Bardak su ile - Aylık:${_explorationReportProvider.aylikBardakSuSayisi}, Yıllık:${_explorationReportProvider.yillikBardakSuSayisi}",
            //   style: TextStyle(color: Colors.white),
            // ),
          ),
          SizedBox(height: 4),

          MyRaisedButton(
            // color: Theme.of(context).primaryColor,
            onPressed: () {
              _showCayKahveIcmeSuyuIhtiyaciModal(context, 3);
            },
            buttonText:
                "Tankerle taşıma kaynak suyu - Aylık:${_explorationReportProvider.tankerleTasimaKaynakSuyu}, Yıllık:${_explorationReportProvider.yillikTankerleTasimaKaynakSuyu}",

            // child: Text(
            //   "Tankerle taşıma kaynak suyu - Aylık:${_explorationReportProvider.tankerleTasimaKaynakSuyu}, Yıllık:${_explorationReportProvider.yillikTankerleTasimaKaynakSuyu}",
            //   style: TextStyle(color: Colors.white),
            // ),
          ),
          SizedBox(height: 4),

          _buildDivider(context),
          _buildTitle(
            "Birim su ambalajı başına kaç para ödüyorsunuz?",
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextField(
              controller: _birimSuAmbalajiBasinaKacParaTlAdet,
              // decoration: InputDecoration(
              hintText: "TL/Adet cinsinden giriniz",
              // ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          _buildDivider(context),
          _buildTitle(
            "İşletmede kaç adet sebil bulunuyor?",
          ),
          _buildKacAdetSuSebiliBulunuyorColumn(
              _explorationReportProvider, context),
          _buildDivider(context),
          _explorationReportProvider.kullanimSuyuMuIcmeSuyuMu == 1
              ? Container()
              : _buildTitle(
                  "Sistem seçimi",
                ),
          _explorationReportProvider.kullanimSuyuMuIcmeSuyuMu == 1
              ? Container()
              : RadioListTile(
                  title:
                      Text("${_explorationReportProvider.getSistemSecimi(0)}"),
                  value: 0,
                  groupValue: _explorationReportProvider.sistemSecimi,
                  onChanged: (value) {
                    _explorationReportProviderLF.sistemSecimi = value;
                  },
                ),
          _explorationReportProvider.kullanimSuyuMuIcmeSuyuMu == 1
              ? Container()
              : RadioListTile(
                  title:
                      Text("${_explorationReportProvider.getSistemSecimi(1)}"),
                  value: 1,
                  groupValue: _explorationReportProvider.sistemSecimi,
                  onChanged: (value) {
                    _explorationReportProviderLF.sistemSecimi = value;
                  },
                ),
          SizedBox(height: 32),
        ],
      ),
      floatingActionButton: SpeedDial(
        // animatedIcon: AnimatedIcons.menu_close,
        // animatedIconTheme: IconThemeData(size: 22.0),
        /// This is ignored if animatedIcon is non null
        icon: Icons.add,
        activeIcon: Icons.close,
        buttonSize: 56.0,
        visible: _showFab,
        closeManually: false,
        renderOverlay: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(
              Icons.picture_as_pdf,
              color: _explorationReportProvider.pdfs.length <= 0
                  ? Colors.black
                  : Colors.white,
            ),
            backgroundColor: _explorationReportProvider.pdfs.length <= 0
                ? Colors.white
                : Theme.of(context).primaryColor,
            label: _explorationReportProvider.pdfs.length <= 0
                ? "Pdf ekle"
                : "${_explorationReportProvider.pdfs.length} pdf eklendi",
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () async {
              if (_explorationReportProvider.pdfs.length <= 0) {
                await _addPdf(_explorationReportProvider);
                return;
              }
              showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    title: Text(
                      "Aktif pdf'i kaldırıp yeni pdf eklemek mi istiyorsunuz?",
                    ),
                    actions: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                        onPressed: () {
                          _explorationReportProviderLF.clearPdf();
                          Navigator.pop(ctx);
                          _addPdf(_explorationReportProvider);
                        },
                        child: Text(
                          "Evet",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                        },
                        child: Text("İptal"),
                      ),
                      TextButton(
                        onPressed: () {
                          _explorationReportProviderLF.clearPdf();
                          Navigator.pop(ctx);
                        },
                        child: Text("Sil"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          SpeedDialChild(
            child: Icon(
              Icons.photo_album,
              color: _explorationReportProvider.draws.length <= 0
                  ? Colors.black
                  : Colors.white,
            ),
            backgroundColor: _explorationReportProvider.draws.length <= 0
                ? Colors.white
                : Theme.of(context).primaryColor,
            label: _explorationReportProvider.draws.length <= 0
                ? "Çizim ekle"
                : "${_explorationReportProvider.draws.length} çizim eklendi",
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              if (_explorationReportProvider.draws.length <= 0) {
                NavigatorHelper(context).goTo(
                  DrawExplorationReportPage(),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      actions: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(ctx);
                            NavigatorHelper(context).goTo(
                              DrawExplorationReportPage(),
                            );
                          },
                          child: Text(
                            "Çizim ekle",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _explorationReportProviderLF.clearDraw();
                            Navigator.pop(ctx);
                          },
                          child: Text("Çizimleri sil"),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future _addPdf(ExplorationReportProvider _explorationReportProvider) async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File _pdf = File(result.files.single.path);
      _explorationReportProvider.addPdf(_pdf);
    } else {
      // User canceled the picker
    }
  }

  Future _pushToApi(ExplorationReportProvider _explorationReportProvider,
      BuildContext context) async {
    if (_explorationReportProvider.apiCompany == null) {
      FlushbarHelper.createError(message: "Müşteri seçmeden ilerleyemezsiniz")
        ..show(context);
      return;
    }
    try {
      EralpHelper.startProgress();
      final _response = await PostApi.addExplorationReport(
        map: {
          "userId": _explorationReportProvider.apiCompany.id,
          "person": "${_explorationReportProviderLF.person.text}",
          "sektor": "${_explorationReportProviderLF.sektor.text}",
          "suAnalizParametreleri":
              "${_explorationReportProviderLF.suAnalizParametreleri.text}",
          "dalgicPompaKwHp":
              "${_explorationReportProviderLF.dalgicPompaKwHp.text}",
          "tesisatBaglantiCapi":
              "${_explorationReportProviderLF.tesisatBaglantiCapi.text}",
          "suBasinciBar": "${_explorationReportProviderLF.suBasinciBar.text}",
          "genlesmeTankiBilgisi":
              "${_explorationReportProviderLF.genlesmeTankiBilgisi.text}",
          "m3saatdebi": "${_explorationReportProviderLF.m3saatdebi.text}",
          "suBasinci35bar":
              "${_explorationReportProviderLF.suBasinci35bar.text}",
          "dosenecekTesisatMetraji":
              "${_explorationReportProviderLF.dosenecekTesisatMetraji.text}",
          "sisteminKurulacagiAlanNotlari":
              "${_explorationReportProviderLF.sisteminKurulacagiAlanNotlari.text}",
          "birimSuAmbalajiBasinaKacParaTlAdet":
              "${_explorationReportProviderLF.birimSuAmbalajiBasinaKacParaTlAdet.text}",
          "aritilacakSuKaynagi":
              "${_explorationReportProviderLF.aritilacakSuKaynagi}",
          "tesisGirisindeSuDepolaniyor":
              "${_explorationReportProviderLF.tesisGirisindeSuDepolaniyor ? 1 : 0}",
          "yeraltiBetonDepo":
              "${_explorationReportProviderLF.yeraltiBetonDepo}",
          "polyesterDepo": "${_explorationReportProviderLF.polyesterDepo}",
          "plastikDepo": "${_explorationReportProviderLF.plastikDepo}",
          "modulerPaslanmazCelikDepo":
              "${_explorationReportProviderLF.modulerPaslanmazCelikDepo}",
          "modulerGalvanizDepo":
              "${_explorationReportProviderLF.modulerGalvanizDepo}",
          "suKaynagiTesisGirisindeAnaHattaAritiliyor":
              "${_explorationReportProviderLF.suKaynagiTesisGirisindeAnaHattaAritiliyor ? 1 : 0}",
          "klorlamaSistemi":
              "${_explorationReportProviderLF.klorlamaSistemi ? 1 : 0}",
          "mekanikFiltre":
              "${_explorationReportProviderLF.mekanikFiltre ? 1 : 0}",
          "otomatikKumFiltresi":
              "${_explorationReportProviderLF.otomatikKumFiltresi ? 1 : 0}",
          "otomatikHidrosilikonFiltre":
              "${_explorationReportProviderLF.otomatikHidrosilikonFiltre ? 1 : 0}",
          "otomatikSuYumustama":
              "${_explorationReportProviderLF.otomatikSuYumustama ? 1 : 0}",
          "aktifKarbonFiltre":
              "${_explorationReportProviderLF.aktifKarbonFiltre ? 1 : 0}",
          "demirManganGiderimi":
              "${_explorationReportProviderLF.demirManganGiderimi ? 1 : 0}",
          "arsenikGiderimi":
              "${_explorationReportProviderLF.arsenikGiderimi ? 1 : 0}",
          "suKaynagiArtezyenVeyaKuyuSuyu":
              "${_explorationReportProviderLF.suKaynagiArtezyenVeyaKuyuSuyu ? 1 : 0}",
          "icmeSuyuHattindaKullanilacakMateryal":
              "${_explorationReportProviderLF.icmeSuyuHattindaKullanilacakMateryal}",
          "sisteminKurulacagiAlan":
              "${_explorationReportProviderLF.sisteminKurulacagiAlan}",
          "isletmeKisiSayisi":
              "${_explorationReportProviderLF.isletmeKisiSayisi}",
          "isletmeVardiyaSayisi":
              "${_explorationReportProviderLF.isletmeVardiyaSayisi}",
          "aylikDamacanaTuketimSayisi":
              "${_explorationReportProviderLF.aylikDamacanaTuketimSayisi}",
          "yillikDamacanaTuketimSayisi":
              "${_explorationReportProviderLF.yillikDamacanaTuketimSayisi}",
          "aylikPetSiseSuSayisi":
              "${_explorationReportProviderLF.aylikPetSiseSuSayisi}",
          "yillikPetSiseSuSayisi":
              "${_explorationReportProviderLF.yillikPetSiseSuSayisi}",
          "aylikBardakSuSayisi":
              "${_explorationReportProviderLF.aylikBardakSuSayisi}",
          "yillikBardakSuSayisi":
              "${_explorationReportProviderLF.yillikBardakSuSayisi}",
          "tankerleTasimaKaynakSuyu":
              "${_explorationReportProviderLF.tankerleTasimaKaynakSuyu}",
          "yillikTankerleTasimaKaynakSuyu":
              "${_explorationReportProviderLF.yillikTankerleTasimaKaynakSuyu}",
          "isletmedekiDamacanaliSebilSayisi":
              "${_explorationReportProviderLF.isletmedekiDamacanaliSebilSayisi}",
          "endustriyelSebilSayisi":
              "${_explorationReportProviderLF.endustriyelSebilSayisi}",
          "sistemSecimi": "${_explorationReportProviderLF.sistemSecimi}",

          ///Sonradan istenenler
          "sistemTipi":
              "${_explorationReportProvider.kullanimSuyuMuIcmeSuyuMu}",
          "bypassliTesisat":
              "${_explorationReportProvider.bypassliTesisat.text}",
          "pdfSayisi": "${_explorationReportProvider.pdfs.length}",
          "fotoSayisi": "${_explorationReportProvider.draws.length}",
        },
      );
      if (_response is int) {
        BlocProvider.of<ExplorationBloc>(context).add(
          ClearExplorationEvent(),
        );
        Navigator.pop(context);
        MyFlushbarHelper(context: context).showSuccessFlushbar(
          title: "Başarılı",
          message: "Keşif raporu başarıyla oluşturuldu",
        );

        if (_explorationReportProvider.pdfs.isNotEmpty) {
          try {
            final reference =
                FirebaseStorage.instance.ref().child("${DateTime.now()}.pdf");
            final uploadTask = reference.putFile(
              File(_explorationReportProvider.pdfs.first.path),
            );
            String url = await (await uploadTask.whenComplete(() {
              print("completed");
            }))
                .ref
                .getDownloadURL();
            print("url: $url");

            await FirebaseFirestore.instance.collection('exploration_pdf').add(
              {
                "exploration_id": "$_response",
                "pdf_path": "$url",
                "created_at": "${DateTime.now()}",
              },
            );
          } on Exception catch (e) {
            FlushbarHelper.createError(
                title: "Başarısız", message: "Pdf yüklenemedi")
              ..show(context);
          }
        }
        for (var draw in _explorationReportProvider.draws) {
          try {
            final reference =
                FirebaseStorage.instance.ref().child("${DateTime.now()}.png]");
            final Directory systemTempDir = Directory.systemTemp;
            final File file = await new File(
                    '${systemTempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png')
                .create();
            file.writeAsBytes(draw);
            final uploadTask = reference.putFile(
              File(file.path),
            );
            String url = await (await uploadTask.whenComplete(() {
              print("completed");
            }))
                .ref
                .getDownloadURL();
            print("url: $url");

            await FirebaseFirestore.instance.collection('exploration_draw').add(
              {
                "exploration_id": "$_response",
                "draw_path": "$url",
                "created_at": "${DateTime.now()}",
              },
            );
          } on Exception catch (e, trace) {
            print("cizim yuklenemedi: $e, trace: $trace");

            FlushbarHelper.createError(
                title: "Başarısız", message: "Çizim yüklenemedi")
              ..show(context);
          }
        }
      }
    } catch (e, trace) {
      print("genel hata: $e, trace: $trace");

      MyFlushbarHelper(context: context).showErrorFlushbar(
        title: "Başarısız",
        message: "Keşif raporu oluşturulamadı: $e",
      );
    } finally {
      EralpHelper.stopProgress();
    }
  }

  Widget _buildKacAdetSuSebiliBulunuyorColumn(
    ExplorationReportProvider _explorationReportProvider,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 4),
        MyRaisedButton(
          onPressed: () async {
            await _showNumberPicker(
              context,
              (int value) {
                _explorationReportProvider.isletmedekiDamacanaliSebilSayisi =
                    value;
              },
              isAdet: true,
            );
            FocusScope.of(context).unfocus();
          },
          buttonText:
              "Damacanalı sebil = ${_explorationReportProvider.isletmedekiDamacanaliSebilSayisi} adet",

          // color: Theme.of(context).primaryColor,
          // child: Text(
          //   "Damacanalı sebil = ${_explorationReportProvider.isletmedekiDamacanaliSebilSayisi} adet",
          //   style: TextStyle(color: Colors.white),
          // ),
        ),
        SizedBox(height: 4),
        MyRaisedButton(
          onPressed: () async {
            await _showNumberPicker(
              context,
              (int value) {
                _explorationReportProvider.endustriyelSebilSayisi = value;
              },
              isAdet: true,
            );
            FocusScope.of(context).unfocus();
          },
          buttonText:
              "Endüstriyel su sebili = ${_explorationReportProvider.endustriyelSebilSayisi} adet",

          // color: Theme.of(context).primaryColor,
          // child: Text(
          //   "Endüstriyel su sebili = ${_explorationReportProvider.endustriyelSebilSayisi} adet",
          //   style: TextStyle(color: Colors.white),
          // ),
        ),
      ],
    );
  }

  Future _showCayKahveIcmeSuyuIhtiyaciModal(BuildContext context, int index) {
    return showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 250,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text(
                              "Aylık tüketim",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 200,
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                              initialItem: index == 0
                                  ? _explorationReportProviderLF
                                      .aylikDamacanaTuketimSayisi
                                  : index == 1
                                      ? _explorationReportProviderLF
                                          .aylikPetSiseSuSayisi
                                      : index == 2
                                          ? _explorationReportProviderLF
                                              .aylikBardakSuSayisi
                                          : _explorationReportProviderLF
                                              .tankerleTasimaKaynakSuyu,
                            ),
                            onSelectedItemChanged: (val) {
                              index == 0
                                  ? _explorationReportProviderLF
                                      .aylikDamacanaTuketimSayisi = val
                                  : index == 1
                                      ? _explorationReportProviderLF
                                          .aylikPetSiseSuSayisi = val
                                      : index == 2
                                          ? _explorationReportProviderLF
                                              .aylikBardakSuSayisi = val
                                          : _explorationReportProviderLF
                                              .tankerleTasimaKaynakSuyu = val;
                            },
                            children: List.generate(
                              100,
                              (index) => Text("$index"),
                            ),
                            itemExtent: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 250,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text(
                              "Yıllık tüketim",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 200,
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                              initialItem: index == 0
                                  ? _explorationReportProviderLF
                                      .yillikDamacanaTuketimSayisi
                                  : index == 1
                                      ? _explorationReportProviderLF
                                          .yillikPetSiseSuSayisi
                                      : index == 2
                                          ? _explorationReportProviderLF
                                              .yillikBardakSuSayisi
                                          : _explorationReportProviderLF
                                              .yillikTankerleTasimaKaynakSuyu,
                            ),
                            onSelectedItemChanged: (val) {
                              index == 0
                                  ? _explorationReportProviderLF
                                      .yillikDamacanaTuketimSayisi = val
                                  : index == 1
                                      ? _explorationReportProviderLF
                                          .yillikPetSiseSuSayisi = val
                                      : index == 2
                                          ? _explorationReportProviderLF
                                              .yillikBardakSuSayisi = val
                                          : _explorationReportProviderLF
                                                  .yillikTankerleTasimaKaynakSuyu =
                                              val;
                            },
                            children: List.generate(
                              100,
                              (index) => Text("$index"),
                            ),
                            itemExtent: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future _showIsletmeKisiVardiyaModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 250,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text(
                              "Kişi sayısı",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 200,
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                              initialItem: _explorationReportProviderLF
                                  .isletmeKisiSayisi,
                            ),
                            onSelectedItemChanged: (val) {
                              _explorationReportProviderLF.isletmeKisiSayisi =
                                  val;
                            },
                            children: List.generate(
                              100,
                              (index) => Text("$index"),
                            ),
                            itemExtent: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 250,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text(
                              "Vardiya sayısı",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 200,
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                              initialItem: _explorationReportProviderLF
                                  .isletmeVardiyaSayisi,
                            ),
                            onSelectedItemChanged: (val) {
                              _explorationReportProviderLF
                                  .isletmeVardiyaSayisi = val;
                            },
                            children: List.generate(
                              100,
                              (index) => Text("$index"),
                            ),
                            itemExtent: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildSuKaynagiArtezyenVeyaKuyuSuyuColumn(
      ExplorationReportProvider _explorationReportProvider) {
    return _explorationReportProvider.suKaynagiArtezyenVeyaKuyuSuyu == false
        ? Container()
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextField(
                  controller: _explorationReportProvider.dalgicPompaKwHp,
                  // decoration: InputDecoration(
                  hintText: "Dalgıç pompa kaç kw kaç hp",
                  // ),
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextField(
                  controller: _explorationReportProvider.tesisatBaglantiCapi,
                  // decoration: InputDecoration(
                  hintText: "Tesisat bağlantı çapı",
                  // ),
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextField(
                  controller: _explorationReportProvider.suBasinciBar,
                  // decoration: InputDecoration(
                  hintText: "Su basıncı kaç bar",
                  // ),
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextField(
                  controller: _explorationReportProvider.genlesmeTankiBilgisi,
                  // decoration: InputDecoration(
                  hintText: "Genleşme tankı bilgisi",
                  // ),
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextField(
                  controller: _explorationReportProvider.m3saatdebi,
                  // decoration: InputDecoration(
                  hintText: "M3/h debi",
                  // ),
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextField(
                  controller: _explorationReportProvider.suBasinci35bar,
                  // decoration: InputDecoration(
                  hintText: "Su basıncı(3-5 bar; 4-6 bar)",
                  // ),
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                ),
              ),
            ],
          );
  }

  Widget _buildTesisGirisindeSuDepolaniyorColumn(
      ExplorationReportProvider _explorationReportProvider,
      BuildContext context) {
    return _explorationReportProvider.tesisGirisindeSuDepolaniyor == false
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MyRaisedButton(
                onPressed: () async {
                  await _showNumberPicker(
                    context,
                    (int value) {
                      _explorationReportProvider.yeraltiBetonDepo = value;
                    },
                  );
                  FocusScope.of(context).unfocus();
                },
                buttonText:
                    "Yeraltı beton depo = ${_explorationReportProvider.yeraltiBetonDepo} lt",

                // color: Theme.of(context).primaryColor,
                // child: Text(
                //   "Yeraltı beton depo = ${_explorationReportProvider.yeraltiBetonDepo} lt",
                //   style: TextStyle(color: Colors.white),
                // ),
              ),
              SizedBox(height: 4),
              MyRaisedButton(
                onPressed: () async {
                  await _showNumberPicker(
                    context,
                    (int value) {
                      _explorationReportProvider.polyesterDepo = value;
                    },
                  );
                  FocusScope.of(context).unfocus();
                },
                buttonText:
                    "Polyester depo = ${_explorationReportProvider.polyesterDepo} lt",

                // color: Theme.of(context).primaryColor,
                // child: Text(
                //   "Polyester depo = ${_explorationReportProvider.polyesterDepo} lt",
                //   style: TextStyle(color: Colors.white),
                // ),
              ),
              SizedBox(height: 4),
              MyRaisedButton(
                onPressed: () async {
                  await _showNumberPicker(
                    context,
                    (int value) {
                      _explorationReportProvider.plastikDepo = value;
                    },
                  );
                  FocusScope.of(context).unfocus();
                },
                buttonText:
                    "PE plastik depo = ${_explorationReportProvider.plastikDepo} lt",
                // color: Theme.of(context).primaryColor,
                // child: Text(
                //   "PE plastik depo = ${_explorationReportProvider.plastikDepo} lt",
                //   style: TextStyle(color: Colors.white),
                // ),
              ),
              SizedBox(height: 4),
              MyRaisedButton(
                onPressed: () async {
                  await _showNumberPicker(
                    context,
                    (int value) {
                      _explorationReportProvider.modulerPaslanmazCelikDepo =
                          value;
                    },
                  );
                  FocusScope.of(context).unfocus();
                },
                buttonText:
                    "Modüler paslanmaz çelik depo = ${_explorationReportProvider.modulerPaslanmazCelikDepo} lt",

                // color: Theme.of(context).primaryColor,
                // child: Text(
                //   "Modüler paslanmaz çelik depo = ${_explorationReportProvider.modulerPaslanmazCelikDepo} lt",
                //   style: TextStyle(color: Colors.white),
                // ),
              ),
              SizedBox(height: 4),
              MyRaisedButton(
                onPressed: () async {
                  await _showNumberPicker(
                    context,
                    (int value) {
                      _explorationReportProvider.modulerGalvanizDepo = value;
                    },
                  );
                  FocusScope.of(context).unfocus();
                },
                buttonText:
                    "Modüler galvaniz depo = ${_explorationReportProvider.modulerGalvanizDepo} lt",

                // color: Theme.of(context).primaryColor,
                // child: Text(
                //   "Modüler galvaniz depo = ${_explorationReportProvider.modulerGalvanizDepo} lt",
                //   style: TextStyle(color: Colors.white),
                // ),
              ),
            ],
          );
  }

  Widget _buildSuKaynagiTesisatGirisindeAnaHattaAritiliyorColumn(
      ExplorationReportProvider _explorationReportProvider) {
    return _explorationReportProvider
                .suKaynagiTesisGirisindeAnaHattaAritiliyor ==
            false
        ? Container()
        : Column(
            children: [
              SwitchListTile(
                title: Text("Klorlama sistemi"),
                value: _explorationReportProvider.klorlamaSistemi,
                onChanged: (value) {
                  _explorationReportProvider.klorlamaSistemi =
                      !_explorationReportProvider.klorlamaSistemi;
                },
              ),
              Divider(),
              SwitchListTile(
                title: Text("Mekanik filtre"),
                value: _explorationReportProvider.mekanikFiltre,
                onChanged: (value) {
                  _explorationReportProvider.mekanikFiltre =
                      !_explorationReportProvider.mekanikFiltre;
                },
              ),
              Divider(),
              SwitchListTile(
                title: Text("Otomatik kum filtre"),
                value: _explorationReportProvider.otomatikKumFiltresi,
                onChanged: (value) {
                  _explorationReportProvider.otomatikKumFiltresi =
                      !_explorationReportProvider.otomatikKumFiltresi;
                },
              ),
              Divider(),
              SwitchListTile(
                title: Text("Otomatik hidrosiklon filtre"),
                value: _explorationReportProvider.otomatikHidrosilikonFiltre,
                onChanged: (value) {
                  _explorationReportProvider.otomatikHidrosilikonFiltre =
                      !_explorationReportProvider.otomatikHidrosilikonFiltre;
                },
              ),
              Divider(),
              SwitchListTile(
                title: Text("Otomatik su yumuşatma"),
                value: _explorationReportProvider.otomatikSuYumustama,
                onChanged: (value) {
                  _explorationReportProvider.otomatikSuYumustama =
                      !_explorationReportProvider.otomatikSuYumustama;
                },
              ),
              Divider(),
              SwitchListTile(
                title: Text("Aktif karbon filtre"),
                value: _explorationReportProvider.aktifKarbonFiltre,
                onChanged: (value) {
                  _explorationReportProvider.aktifKarbonFiltre =
                      !_explorationReportProvider.aktifKarbonFiltre;
                },
              ),
              Divider(),
              SwitchListTile(
                title: Text("Demir mangan giderimi"),
                value: _explorationReportProvider.demirManganGiderimi,
                onChanged: (value) {
                  _explorationReportProvider.demirManganGiderimi =
                      !_explorationReportProvider.demirManganGiderimi;
                },
              ),
              Divider(),
              SwitchListTile(
                title: Text("Arsenik giderimi"),
                value: _explorationReportProvider.arsenikGiderimi,
                onChanged: (value) {
                  _explorationReportProvider.arsenikGiderimi =
                      !_explorationReportProvider.arsenikGiderimi;
                },
              ),
              Divider(),
            ],
          );
  }

  Widget _buildDivider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(),
    );
    return Divider(
      color: Theme.of(context).primaryColor,
      thickness: 5,
    );
  }

  Future _showNumberPicker(BuildContext context, Function onChanged,
      {bool isAdet}) async {
    TextEditingController _temp = TextEditingController();
    FocusNode _tempNode = FocusNode();
    final int _value = await showDialog(
      context: context,
      builder: (ctx) {
        FocusScope.of(context).requestFocus(_tempNode);
        return AlertDialog(
          title: Text(isAdet != null
              ? "Lütfen adet değerini girin"
              : "Lütfen litre değerini girin"),
          content: TextField(
            focusNode: _tempNode,
            controller: _temp,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
          ),
          actions: [
            FlatButton(
              child: Text("Iptal"),
              onPressed: () {
                Navigator.pop(ctx, 0);
              },
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                "Tamam",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(ctx, int.parse(_temp.text));
              },
            ),
          ],
        );
      },
    );
    FocusScope.of(context).unfocus();
    if (_value != null) {
      onChanged(_value);
    }
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        "$title",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          // decoration: TextDecoration.underline,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildBoolTitle(String title, bool value, Function onChanged) {
    return SwitchListTile(
      contentPadding: EdgeInsets.only(left: 8),
      value: value,
      onChanged: (value) {
        onChanged();
      },
      title: Text(
        "$title",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          // decoration: TextDecoration.underline,
          fontSize: 16,
        ),
      ),
    );
  }

  void _debounce(bool showFab) {
    _debouncer.debounce(() {
      print("showFab: $_showFab");
      _showFab = showFab;
      setState(() {});
    });
  }
}
