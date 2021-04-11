import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_exploration.dart';
import 'package:teknoloji_kimya_servis/pages/exploration_report/show_draws_page.dart';
import 'package:teknoloji_kimya_servis/pages/exploration_report/show_pdf_page.dart';

class ExplorationReportDetailPage extends StatefulWidget {
  final ApiExplorationData apiExplorationData;
  ExplorationReportDetailPage({Key key, @required this.apiExplorationData})
      : super(key: key);

  @override
  _ExplorationReportDetailPageState createState() =>
      _ExplorationReportDetailPageState();
}

class _ExplorationReportDetailPageState
    extends State<ExplorationReportDetailPage> {
  @override
  Widget build(BuildContext context) {
    final _data = widget.apiExplorationData;
    return Scaffold(
      appBar: AppBar(
        title: Text('Keşif Raporu Detay'),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16,
                  ),
                  child: _data.fotoSayisi > 0
                      ? ElevatedButton(
                          onPressed: () {
                            NavigatorHelper(context).goTo(
                              ShowDrawsPage(
                                explorationId: _data.id,
                              ),
                            );
                          },
                          child: Text("${_data.fotoSayisi} çizim"),
                        )
                      : Opacity(
                          opacity: 0.5,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey),
                            ),
                            onPressed: () {},
                            child: Text("Çizim yok"),
                          ),
                        ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16,
                  ),
                  child: _data.pdfSayisi > 0
                      ? ElevatedButton(
                          onPressed: () {
                            NavigatorHelper(context).goTo(
                              ShowExplorationPdfPage(
                                explorationId: _data.id,
                              ),
                            );
                          },
                          child: Text("${_data.pdfSayisi} pdf"),
                        )
                      : Opacity(
                          opacity: 0.5,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey),
                            ),
                            onPressed: () {},
                            child: Text("Pdf yok"),
                          ),
                        ),
                ),
              ),
            ],
          ),
          _buildListTile(key: "Müşteri ismi", value: "${_data.companyName}"),
          _buildListTile(key: "Kişi ismi", value: "${_data.person}"),
          _buildListTile(key: "Sektör", value: "${_data.sektor}"),
          _buildListTile(
              key: "Arıtılacak Suyun Kaynağı",
              value: _data.aritilacakSuKaynagi == -1
                  ? ""
                  : _data.aritilacakSuKaynagi == 0
                      ? "Artezyen ve kuyu suyu"
                      : "Şehir şebeke suyu"),
          _buildListTile(
              key: "Su Analiz Değerleri",
              value: "${_data.suAnalizParametreleri}"),
          _data.tesisGirisindeSuDepolaniyor == 0
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        "Tesisat girişinde su depolanıyor",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    _buildListTile(
                        key: "Yeraltı beton depo",
                        value: "${_data.yeraltiBetonDepo} litre"),
                    _buildListTile(
                        key: "Polyester depo",
                        value: "${_data.polyesterDepo} litre"),
                    _buildListTile(
                        key: "PE plastik depo",
                        value: "${_data.plastikDepo} litre"),
                    _buildListTile(
                        key: "Modüler paslanmaz çelik depo",
                        value: "${_data.modulerPaslanmazCelikDepo} litre"),
                    _buildListTile(
                        key: "Modüler galvaniz depo",
                        value: "${_data.modulerGalvanizDepo} litre"),
                    Divider(),
                  ],
                ),
          _data.suKaynagiTesisGirisindeAnaHattaAritiliyor == 0
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        "Mevcut su kaynağı tesis girişinde ana hatta arıtılıyor",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    _buildText(
                      key: "Klorlama sistemi",
                      value: _data.klorlamaSistemi == 1,
                    ),
                    _buildText(
                      key: "Mekanik filtre",
                      value: _data.mekanikFiltre == 1,
                    ),
                    _buildText(
                      key: "Otomatik kum filtre",
                      value: _data.otomatikKumFiltresi == 1,
                    ),
                    _buildText(
                      key: "Otomatik hidrosiklon filtre",
                      value: _data.otomatikHidrosilikonFiltre == 1,
                    ),
                    _buildText(
                      key: "Otomatik su yumuşatma",
                      value: _data.otomatikSuYumustama == 1,
                    ),
                    _buildText(
                      key: "Aktif karbon filtre",
                      value: _data.aktifKarbonFiltre == 1,
                    ),
                    _buildText(
                      key: "Demir mangan giderimi",
                      value: _data.demirManganGiderimi == 1,
                    ),
                    _buildText(
                      key: "Arsenik giderimi",
                      value: _data.arsenikGiderimi == 1,
                    ),
                    Divider(),
                  ],
                ),
          _data.suKaynagiArtezyenVeyaKuyuSuyu == 0
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        "Su kaynağı artezyen veya kuyu suyu",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    _buildListTile(
                      key: "Dalgıç pompa kw hp bilgileri",
                      value: "${_data.dalgicPompaKwHp}",
                    ),
                    _buildListTile(
                      key: "Tesisat bağlantı çapı",
                      value: "${_data.tesisatBaglantiCapi}",
                    ),
                    _buildListTile(
                      key: "Su basıncı bar bilgileri",
                      value: "${_data.suBasinciBar}",
                    ),
                    _buildListTile(
                      key: "Genleşme tankı bilgisi",
                      value: "${_data.genlesmeTankiBilgisi}",
                    ),
                    _buildListTile(
                      key: "M3/h debi",
                      value: "${_data.m3Saatdebi}",
                    ),
                    _buildListTile(
                      key: "Su basıncı(3-5 bar, 4-6 bar)",
                      value: "${_data.suBasinci35Bar}",
                    ),
                    Divider(),
                  ],
                ),
          _buildListTile(
            key: "İçme suyu hattında kullanılacak tesisat materyali",
            value: _data.icmeSuyuHattindaKullanilacakMateryal == -1
                ? ""
                : _data.icmeSuyuHattindaKullanilacakMateryal == 0
                    ? "Paslanmaz çelik"
                    : _data.icmeSuyuHattindaKullanilacakMateryal == 1
                        ? "PPRC"
                        : _data.icmeSuyuHattindaKullanilacakMateryal == 2
                            ? "Quatherm PPRC(nfs'li)"
                            : "Pex boru",
          ),
          _buildListTile(
            key: "Döşenecek Tesisat Metrajı (.. metre)",
            value: "${_data.dosenecekTesisatMetraji}",
          ),
          _buildListTile(
            key: "Sistemin kurulacağı alan",
            value: _data.sisteminKurulacagiAlan == -1
                ? ""
                : _data.sisteminKurulacagiAlan == 0
                    ? "Hidrofor dairesi"
                    : _data.sisteminKurulacagiAlan == 1
                        ? "Kazan dairesi"
                        : _data.sisteminKurulacagiAlan == 2
                            ? "Ana su giriş hattı"
                            : _data.sisteminKurulacagiAlan == 3
                                ? "Üretim sahası"
                                : "Yemekhane",
          ),
          _buildListTile(
            key: "Sistemin Kurulacağı Alan Notları",
            value: "${_data.sisteminKurulacagiAlanNotlari}",
          ),
          _buildListTile(
            key: "İşletmede Çalışan Kişi/Vardiya Sayısı",
            value:
                "${_data.isletmeKisiSayisi} Kişi/${_data.isletmeVardiyaSayisi} Vardiya",
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  "Personelin ve ziyaretçilerin çay, kahve ve içme suyu ihtiyacı",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              _buildListTile(
                key: "Damacana Su İle",
                value:
                    "Aylık: ${_data.aylikDamacanaTuketimSayisi}, Yıllık: ${_data.yillikDamacanaTuketimSayisi}",
              ),
              _buildListTile(
                key: "Pet şişe Su İle",
                value:
                    "Aylık: ${_data.aylikPetSiseSuSayisi}, Yıllık: ${_data.yillikPetSiseSuSayisi}",
              ),
              _buildListTile(
                key: "Bardak Su İle",
                value:
                    "Aylık: ${_data.aylikBardakSuSayisi}, Yıllık: ${_data.yillikBardakSuSayisi}",
              ),
              _buildListTile(
                key: "Tankerle Taşıma Kaynak Suyu İle",
                value:
                    "Aylık: ${_data.tankerleTasimaKaynakSuyu}, Yıllık: ${_data.yillikTankerleTasimaKaynakSuyu}",
              ),
              Divider(),
            ],
          ),
          _buildListTile(
            key: "Birim Su Ambalajı Başına Ödenen Para",
            value: "${_data.birimSuAmbalajiBasinaKacParaTlAdet}",
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  "İşletmede Bulunan Sebil Sayısı",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              _buildListTile(
                key: "Damacanalı Sebil",
                value: "${_data.yillikDamacanaTuketimSayisi} adet",
              ),
              _buildListTile(
                key: "Endüstriyel Su Sebili",
                value: "${_data.endustriyelSebilSayisi} adet",
              ),
              Divider(),
            ],
          ),
          _buildListTile(
            key: "Sistem seçimi",
            value: _data.sistemSecimi == -1
                ? ""
                : _data.sistemSecimi == 0
                    ? "Tesisat üzeri sistem"
                    : "Depo sonrası sistem",
          ),
        ],
      ),
    );
  }

  Widget _buildText({String key, bool value}) {
    if (!value) return Container();
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        bottom: 4,
        top: 4,
      ),
      child: Text(
        "$key",
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildListTile({String key, String value}) {
    if (value == null || value.length <= 1) return Container();
    return ListTile(
      title: Text("$value"),
      subtitle: Text("$key"),
    );
  }
}
