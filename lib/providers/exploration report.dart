import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/models/api_user.dart';
import 'package:teknoloji_kimya_servis/models/api_users.dart';

class ExplorationReportProvider with ChangeNotifier {
  ApiUsersData _apiCompany;
  ApiUsersData get apiCompany => _apiCompany;
  set apiCompany(ApiUsersData apiCompany) {
    _apiCompany = apiCompany;
    notifyListeners();
  }

  final List<File> _pdfs = [];
  List<File> get pdfs => _pdfs;
  addPdf(File pdf) {
    _pdfs.add(pdf);
    notifyListeners();
  }

  clearPdf() {
    _pdfs.clear();
    notifyListeners();
  }

  final List<Uint8List> _draws = [];
  List<Uint8List> get draws => _draws;
  addDraw(Uint8List draw) {
    _draws.add(draw);
    notifyListeners();
  }

  clearDraw() {
    _draws.clear();
    notifyListeners();
  }

  int _kullanimSuyuMuIcmeSuyuMu = 0;
  int get kullanimSuyuMuIcmeSuyuMu => _kullanimSuyuMuIcmeSuyuMu;
  set kullanimSuyuMuIcmeSuyuMu(int kullanimSuyuMuIcmeSuyuMu) {
    _kullanimSuyuMuIcmeSuyuMu = kullanimSuyuMuIcmeSuyuMu;
    notifyListeners();
  }

  String getKullanimSuyuMuIcmeSuyuMu(int value) {
    return value == 0 ? "Kullanım suyu" : "İçme suyu";
  }

  TextEditingController _companyName;
  TextEditingController get companyName => _companyName;
  set companyName(TextEditingController value) {
    _companyName = value;
  }

  TextEditingController _person;
  TextEditingController get person => _person;
  set person(TextEditingController value) {
    _person = value;
  }

  TextEditingController _sektor;
  TextEditingController get sektor => _sektor;
  set sektor(TextEditingController value) {
    _sektor = value;
  }

  DateTime _date;
  DateTime get date => _date;
  set date(DateTime value) {
    _date = value;
    notifyListeners();
  }

  //0 == Artezyen ve kuyu suyu
  //1 == Sehir sebeke suyu
  int _aritilacakSuKaynagi = -1;
  int get aritilacakSuKaynagi => _aritilacakSuKaynagi;
  String getAritilacakSuKaynagi(int value) {
    return value == 0 ? "Artezyen ve kuyu suyu" : "Şehir şebeke suyu";
  }

  set aritilacakSuKaynagi(int value) {
    _aritilacakSuKaynagi = value;
    notifyListeners();
  }

  TextEditingController _suAnalizParametreleri;
  TextEditingController get suAnalizParametreleri => _suAnalizParametreleri;
  set suAnalizParametreleri(TextEditingController value) {
    _suAnalizParametreleri = value;
  }

  bool _tesisGirisindeSuDepolaniyor = false;
  bool get tesisGirisindeSuDepolaniyor => _tesisGirisindeSuDepolaniyor;
  set tesisGirisindeSuDepolaniyor(bool value) {
    _tesisGirisindeSuDepolaniyor = value;
    notifyListeners();
  }

  int _yeraltiBetonDepo = 0;
  int get yeraltiBetonDepo => _yeraltiBetonDepo;
  set yeraltiBetonDepo(int value) {
    _yeraltiBetonDepo = value;
    notifyListeners();
  }

  int _polyesterDepo = 0;
  int get polyesterDepo => _polyesterDepo;
  set polyesterDepo(int value) {
    _polyesterDepo = value;
    notifyListeners();
  }

  int _plastikDepo = 0;
  int get plastikDepo => _plastikDepo;
  set plastikDepo(int value) {
    _plastikDepo = value;
    notifyListeners();
  }

  int _modulerPaslanmazCelikDepo = 0;
  int get modulerPaslanmazCelikDepo => _modulerPaslanmazCelikDepo;
  set modulerPaslanmazCelikDepo(int value) {
    _modulerPaslanmazCelikDepo = value;
    notifyListeners();
  }

  int _modulerGalvanizDepo = 0;
  int get modulerGalvanizDepo => _modulerGalvanizDepo;
  set modulerGalvanizDepo(int value) {
    _modulerGalvanizDepo = value;
    notifyListeners();
  }

  bool _suKaynagiTesisGirisindeAnaHattaAritiliyor = false;
  bool get suKaynagiTesisGirisindeAnaHattaAritiliyor =>
      _suKaynagiTesisGirisindeAnaHattaAritiliyor;
  set suKaynagiTesisGirisindeAnaHattaAritiliyor(bool value) {
    _suKaynagiTesisGirisindeAnaHattaAritiliyor = value;
    notifyListeners();
  }

  bool _klorlamaSistemi = false;

  bool get klorlamaSistemi => _klorlamaSistemi;

  set klorlamaSistemi(bool klorlamaSistemi) {
    _klorlamaSistemi = klorlamaSistemi;
    notifyListeners();
  }

  bool _mekanikFiltre = false;

  bool get mekanikFiltre => _mekanikFiltre;

  set mekanikFiltre(bool mekanikFiltre) {
    _mekanikFiltre = mekanikFiltre;
    notifyListeners();
  }

  bool _otomatikKumFiltresi = false;

  bool get otomatikKumFiltresi => _otomatikKumFiltresi;

  set otomatikKumFiltresi(bool otomatikKumFiltresi) {
    _otomatikKumFiltresi = otomatikKumFiltresi;
    notifyListeners();
  }

  bool _otomatikHidrosilikonFiltre = false;

  bool get otomatikHidrosilikonFiltre => _otomatikHidrosilikonFiltre;

  set otomatikHidrosilikonFiltre(bool otomatikHidrosilikonFiltre) {
    _otomatikHidrosilikonFiltre = otomatikHidrosilikonFiltre;
    notifyListeners();
  }

  bool _otomatikSuYumustama = false;

  bool get otomatikSuYumustama => _otomatikSuYumustama;

  set otomatikSuYumustama(bool otomatikSuYumustama) {
    _otomatikSuYumustama = otomatikSuYumustama;
    notifyListeners();
  }

  bool _aktifKarbonFiltre = false;

  bool get aktifKarbonFiltre => _aktifKarbonFiltre;

  set aktifKarbonFiltre(bool aktifKarbonFiltre) {
    _aktifKarbonFiltre = aktifKarbonFiltre;
    notifyListeners();
  }

  bool _demirManganGiderimi = false;

  bool get demirManganGiderimi => _demirManganGiderimi;

  set demirManganGiderimi(bool demirManganGiderimi) {
    _demirManganGiderimi = demirManganGiderimi;
    notifyListeners();
  }

  bool _arsenikGiderimi = false;

  bool get arsenikGiderimi => _arsenikGiderimi;

  set arsenikGiderimi(bool arsenikGiderimi) {
    _arsenikGiderimi = arsenikGiderimi;
    notifyListeners();
  }

  bool _suKaynagiArtezyenVeyaKuyuSuyu = false;

  bool get suKaynagiArtezyenVeyaKuyuSuyu => _suKaynagiArtezyenVeyaKuyuSuyu;

  set suKaynagiArtezyenVeyaKuyuSuyu(bool suKaynagiArtezyenVeyaKuyuSuyu) {
    _suKaynagiArtezyenVeyaKuyuSuyu = suKaynagiArtezyenVeyaKuyuSuyu;
    notifyListeners();
  }

  TextEditingController _dalgicPompaKwHp;

  TextEditingController get dalgicPompaKwHp => _dalgicPompaKwHp;

  set dalgicPompaKwHp(TextEditingController dalgicPompaKwHp) {
    _dalgicPompaKwHp = dalgicPompaKwHp;
  }

  TextEditingController _tesisatBaglantiCapi;

  TextEditingController get tesisatBaglantiCapi => _tesisatBaglantiCapi;

  set tesisatBaglantiCapi(TextEditingController tesisatBaglantiCapi) {
    _tesisatBaglantiCapi = tesisatBaglantiCapi;
  }

  TextEditingController _suBasinciBar;

  TextEditingController get suBasinciBar => _suBasinciBar;

  set suBasinciBar(TextEditingController suBasinciBar) {
    _suBasinciBar = suBasinciBar;
  }

  TextEditingController _genlesmeTankiBilgisi;

  TextEditingController get genlesmeTankiBilgisi => _genlesmeTankiBilgisi;

  set genlesmeTankiBilgisi(TextEditingController genlesmeTankiBilgisi) {
    _genlesmeTankiBilgisi = genlesmeTankiBilgisi;
  }

  TextEditingController _m3saatdebi;

  TextEditingController get m3saatdebi => _m3saatdebi;

  set m3saatdebi(TextEditingController m3saatdebi) {
    _m3saatdebi = m3saatdebi;
  }

  TextEditingController _suBasinci35bar;

  TextEditingController get suBasinci35bar => _suBasinci35bar;

  set suBasinci35bar(TextEditingController suBasinci) {
    _suBasinci35bar = suBasinci;
  }

  //0 = paslanmaz celik
  //1 = pprc
  //2 = quatherm pprc(nfs'li)
  //3 = pex boru
  int _icmeSuyuHattindaKullanilacakMateryal = -1;

  String getIcmeSuyuHattindaKullanilacakMateryal(int value) {
    if (value == 0) {
      return "Paslanmaz çelik";
    }
    if (value == 1) {
      return "PPRC";
    }
    if (value == 2) {
      return "Aquatherm PPRC(NFS'li)";
    }
    if (value == 3) {
      return "PEX boru";
    }
    return "";
  }

  int get icmeSuyuHattindaKullanilacakMateryal =>
      _icmeSuyuHattindaKullanilacakMateryal;

  set icmeSuyuHattindaKullanilacakMateryal(
      int icmeSuyuHattindaKullanilacakMateryal) {
    _icmeSuyuHattindaKullanilacakMateryal =
        icmeSuyuHattindaKullanilacakMateryal;
    notifyListeners();
  }

  TextEditingController _dosenecekTesisatMetraji = TextEditingController();

  TextEditingController get dosenecekTesisatMetraji => _dosenecekTesisatMetraji;

  set dosenecekTesisatMetraji(TextEditingController dosenecekTesisatMetraji) {
    _dosenecekTesisatMetraji = dosenecekTesisatMetraji;
  }

  TextEditingController _bypassliTesisat;
  TextEditingController get bypassliTesisat => _bypassliTesisat;
  set bypassliTesisat(TextEditingController bypassliTesisat) {
    _bypassliTesisat = bypassliTesisat;
  }

  //0 = hidrofor dairesi
  //1 = kazan dairesi
  //2 = ana su giris hatti
  //3 = uretim sahasi
  //4 = yemekhane
  int _sisteminKurulacagiAlan = -1;
  String getSisteminKurulacagiAlan(int value) {
    if (value == 0) {
      return "Hidrofor dairesi";
    }
    if (value == 1) {
      return "Kazan dairesi";
    }
    if (value == 2) {
      return "Ana su giriş hattı";
    }
    if (value == 3) {
      return "Üretim sahası";
    }
    if (value == 4) {
      return "Yemekhane";
    }
    return "";
  }

  int get sisteminKurulacagiAlan => _sisteminKurulacagiAlan;

  set sisteminKurulacagiAlan(int sisteminKurulacagiAlan) {
    _sisteminKurulacagiAlan = sisteminKurulacagiAlan;
    notifyListeners();
  }

  TextEditingController _sisteminKurulacagiAlanNotlari;

  TextEditingController get sisteminKurulacagiAlanNotlari =>
      _sisteminKurulacagiAlanNotlari;

  set sisteminKurulacagiAlanNotlari(
      TextEditingController sisteminKurulacagiAlanNotlari) {
    _sisteminKurulacagiAlanNotlari = sisteminKurulacagiAlanNotlari;
  }

  int _isletmeKisiSayisi = 0;

  int get isletmeKisiSayisi => _isletmeKisiSayisi;

  set isletmeKisiSayisi(int isletmeKisiSayisi) {
    _isletmeKisiSayisi = isletmeKisiSayisi;
    notifyListeners();
  }

  int _isletmeVardiyaSayisi = 0;

  int get isletmeVardiyaSayisi => _isletmeVardiyaSayisi;

  set isletmeVardiyaSayisi(int isletmeVardiyaSayisi) {
    _isletmeVardiyaSayisi = isletmeVardiyaSayisi;
    notifyListeners();
  }

  int _aylikDamacanaTuketimSayisi = 0;

  int get aylikDamacanaTuketimSayisi => _aylikDamacanaTuketimSayisi;

  set aylikDamacanaTuketimSayisi(int aylikDamacanaTuketimSayisi) {
    _aylikDamacanaTuketimSayisi = aylikDamacanaTuketimSayisi;
    notifyListeners();
  }

  int _yillikDamacanaTuketimSayisi = 0;

  int get yillikDamacanaTuketimSayisi => _yillikDamacanaTuketimSayisi;

  set yillikDamacanaTuketimSayisi(int yillikDamacanaTuketimSayisi) {
    _yillikDamacanaTuketimSayisi = yillikDamacanaTuketimSayisi;
    notifyListeners();
  }

  int _aylikPetSiseSuSayisi = 0;

  int get aylikPetSiseSuSayisi => _aylikPetSiseSuSayisi;

  set aylikPetSiseSuSayisi(int aylikPetSiseSuSayisi) {
    _aylikPetSiseSuSayisi = aylikPetSiseSuSayisi;
    notifyListeners();
  }

  int _yillikPetSiseSuSayisi = 0;

  int get yillikPetSiseSuSayisi => _yillikPetSiseSuSayisi;

  set yillikPetSiseSuSayisi(int yillikPetSiseSuSayisi) {
    _yillikPetSiseSuSayisi = yillikPetSiseSuSayisi;
    notifyListeners();
  }

  int _aylikBardakSuSayisi = 0;

  int get aylikBardakSuSayisi => _aylikBardakSuSayisi;

  set aylikBardakSuSayisi(int aylikBardakSuSayisi) {
    _aylikBardakSuSayisi = aylikBardakSuSayisi;
    notifyListeners();
  }

  int _yillikBardakSuSayisi = 0;

  int get yillikBardakSuSayisi => _yillikBardakSuSayisi;

  set yillikBardakSuSayisi(int yillikBardakSuSayisi) {
    _yillikBardakSuSayisi = yillikBardakSuSayisi;
    notifyListeners();
  }

  int _tankerleTasimaKaynakSuyu = 0;

  int get tankerleTasimaKaynakSuyu => _tankerleTasimaKaynakSuyu;

  set tankerleTasimaKaynakSuyu(int tankerleTasimaKaynakSuyu) {
    _tankerleTasimaKaynakSuyu = tankerleTasimaKaynakSuyu;
    notifyListeners();
  }

  int _yillikTankerleTasimaKaynakSuyu = 0;

  int get yillikTankerleTasimaKaynakSuyu => _yillikTankerleTasimaKaynakSuyu;

  set yillikTankerleTasimaKaynakSuyu(int yillikTankerleTasimaKaynakSuyu) {
    _yillikTankerleTasimaKaynakSuyu = yillikTankerleTasimaKaynakSuyu;
    notifyListeners();
  }

  TextEditingController _birimSuAmbalajiBasinaKacParaTlAdet;

  TextEditingController get birimSuAmbalajiBasinaKacParaTlAdet =>
      _birimSuAmbalajiBasinaKacParaTlAdet;

  set birimSuAmbalajiBasinaKacParaTlAdet(
      TextEditingController birimSuAmbalajiBasinaKacParaTlAdet) {
    _birimSuAmbalajiBasinaKacParaTlAdet = birimSuAmbalajiBasinaKacParaTlAdet;
  }

  int _isletmedekiDamacanaliSebilSayisi = 0;

  int get isletmedekiDamacanaliSebilSayisi => _isletmedekiDamacanaliSebilSayisi;

  set isletmedekiDamacanaliSebilSayisi(int isletmedekiSuSebiliSayisi) {
    _isletmedekiDamacanaliSebilSayisi = isletmedekiSuSebiliSayisi;
    notifyListeners();
  }

  int _endustriyelSebilSayisi = 0;

  int get endustriyelSebilSayisi => _endustriyelSebilSayisi;

  set endustriyelSebilSayisi(int endustriyelSebilSayisi) {
    _endustriyelSebilSayisi = endustriyelSebilSayisi;
    notifyListeners();
  }

  //0 = tesisat uzeri sistem
  //1 = depo sonrasi sistem
  int _sistemSecimi = -1;

  int get sistemSecimi => _sistemSecimi;
  String getSistemSecimi(int value) {
    if (value == 0) {
      return "Tesisat üzeri sistem";
    }
    if (value == 1) {
      return "Depo sonrası sistem";
    }

    return "";
  }

  set sistemSecimi(int sistemSecimi) {
    _sistemSecimi = sistemSecimi;
    notifyListeners();
  }
}
