// To parse this JSON data, do
//
//     final apiExploration = apiExplorationFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ApiExploration apiExplorationFromJson(String str) =>
    ApiExploration.fromJson(json.decode(str));

String apiExplorationToJson(ApiExploration data) => json.encode(data.toJson());

class ApiExploration {
  ApiExploration({
    @required this.count,
    @required this.body,
  });

  final int count;
  final List<ApiExplorationData> body;

  factory ApiExploration.fromJson(Map<String, dynamic> json) => ApiExploration(
        count: json["count"] == null ? null : json["count"],
        body: json["body"] == null
            ? null
            : List<ApiExplorationData>.from(
                json["body"].map((x) => ApiExplorationData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "body": body == null
            ? null
            : List<dynamic>.from(body.map((x) => x.toJson())),
      };
}

class ApiExplorationData {
  ApiExplorationData({
    @required this.id,
    @required this.userId,
    @required this.person,
    @required this.sektor,
    @required this.suAnalizParametreleri,
    @required this.dalgicPompaKwHp,
    @required this.tesisatBaglantiCapi,
    @required this.suBasinciBar,
    @required this.genlesmeTankiBilgisi,
    @required this.m3Saatdebi,
    @required this.suBasinci35Bar,
    @required this.dosenecekTesisatMetraji,
    @required this.sisteminKurulacagiAlanNotlari,
    @required this.birimSuAmbalajiBasinaKacParaTlAdet,
    @required this.date,
    @required this.aritilacakSuKaynagi,
    @required this.tesisGirisindeSuDepolaniyor,
    @required this.yeraltiBetonDepo,
    @required this.polyesterDepo,
    @required this.plastikDepo,
    @required this.modulerPaslanmazCelikDepo,
    @required this.modulerGalvanizDepo,
    @required this.suKaynagiTesisGirisindeAnaHattaAritiliyor,
    @required this.klorlamaSistemi,
    @required this.mekanikFiltre,
    @required this.otomatikKumFiltresi,
    @required this.otomatikHidrosilikonFiltre,
    @required this.otomatikSuYumustama,
    @required this.aktifKarbonFiltre,
    @required this.demirManganGiderimi,
    @required this.arsenikGiderimi,
    @required this.suKaynagiArtezyenVeyaKuyuSuyu,
    @required this.icmeSuyuHattindaKullanilacakMateryal,
    @required this.sisteminKurulacagiAlan,
    @required this.isletmeKisiSayisi,
    @required this.isletmeVardiyaSayisi,
    @required this.aylikDamacanaTuketimSayisi,
    @required this.yillikDamacanaTuketimSayisi,
    @required this.aylikPetSiseSuSayisi,
    @required this.yillikPetSiseSuSayisi,
    @required this.aylikBardakSuSayisi,
    @required this.yillikBardakSuSayisi,
    @required this.tankerleTasimaKaynakSuyu,
    @required this.yillikTankerleTasimaKaynakSuyu,
    @required this.isletmedekiDamacanaliSebilSayisi,
    @required this.endustriyelSebilSayisi,
    @required this.sistemSecimi,
    @required this.sistemTipi,
    @required this.bypassliTesisat,
    @required this.pdfSayisi,
    @required this.fotoSayisi,
    @required this.companyName,
    @required this.companyPhone,
  });

  final int id;
  final int userId;
  final String person;
  final String sektor;
  final String suAnalizParametreleri;
  final String dalgicPompaKwHp;
  final String tesisatBaglantiCapi;
  final String suBasinciBar;
  final String genlesmeTankiBilgisi;
  final String m3Saatdebi;
  final String suBasinci35Bar;
  final String dosenecekTesisatMetraji;
  final String sisteminKurulacagiAlanNotlari;
  final String birimSuAmbalajiBasinaKacParaTlAdet;
  final DateTime date;
  final int aritilacakSuKaynagi;
  final int tesisGirisindeSuDepolaniyor;
  final int yeraltiBetonDepo;
  final int polyesterDepo;
  final int plastikDepo;
  final int modulerPaslanmazCelikDepo;
  final int modulerGalvanizDepo;
  final int suKaynagiTesisGirisindeAnaHattaAritiliyor;
  final int klorlamaSistemi;
  final int mekanikFiltre;
  final int otomatikKumFiltresi;
  final int otomatikHidrosilikonFiltre;
  final int otomatikSuYumustama;
  final int aktifKarbonFiltre;
  final int demirManganGiderimi;
  final int arsenikGiderimi;
  final int suKaynagiArtezyenVeyaKuyuSuyu;
  final int icmeSuyuHattindaKullanilacakMateryal;
  final int sisteminKurulacagiAlan;
  final int isletmeKisiSayisi;
  final int isletmeVardiyaSayisi;
  final int aylikDamacanaTuketimSayisi;
  final int yillikDamacanaTuketimSayisi;
  final int aylikPetSiseSuSayisi;
  final int yillikPetSiseSuSayisi;
  final int aylikBardakSuSayisi;
  final int yillikBardakSuSayisi;
  final int tankerleTasimaKaynakSuyu;
  final int yillikTankerleTasimaKaynakSuyu;
  final int isletmedekiDamacanaliSebilSayisi;
  final int endustriyelSebilSayisi;
  final int sistemSecimi;
  final int sistemTipi;
  final String bypassliTesisat;
  final int pdfSayisi;
  final int fotoSayisi;
  final String companyName;
  final String companyPhone;

  factory ApiExplorationData.fromJson(Map<String, dynamic> json) =>
      ApiExplorationData(
        id: json["id"] == null ? null : json["id"],
        userId: json["userId"] == null ? null : json["userId"],
        person: json["person"] == null ? null : json["person"],
        sektor: json["sektor"] == null ? null : json["sektor"],
        suAnalizParametreleri: json["suAnalizParametreleri"] == null
            ? null
            : json["suAnalizParametreleri"],
        dalgicPompaKwHp:
            json["dalgicPompaKwHp"] == null ? null : json["dalgicPompaKwHp"],
        tesisatBaglantiCapi: json["tesisatBaglantiCapi"] == null
            ? null
            : json["tesisatBaglantiCapi"],
        suBasinciBar:
            json["suBasinciBar"] == null ? null : json["suBasinciBar"],
        genlesmeTankiBilgisi: json["genlesmeTankiBilgisi"] == null
            ? null
            : json["genlesmeTankiBilgisi"],
        m3Saatdebi: json["m3saatdebi"] == null ? null : json["m3saatdebi"],
        suBasinci35Bar:
            json["suBasinci35bar"] == null ? null : json["suBasinci35bar"],
        dosenecekTesisatMetraji: json["dosenecekTesisatMetraji"] == null
            ? null
            : json["dosenecekTesisatMetraji"],
        sisteminKurulacagiAlanNotlari:
            json["sisteminKurulacagiAlanNotlari"] == null
                ? null
                : json["sisteminKurulacagiAlanNotlari"],
        birimSuAmbalajiBasinaKacParaTlAdet:
            json["birimSuAmbalajiBasinaKacParaTlAdet"] == null
                ? null
                : json["birimSuAmbalajiBasinaKacParaTlAdet"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        aritilacakSuKaynagi: json["aritilacakSuKaynagi"] == null
            ? null
            : json["aritilacakSuKaynagi"],
        tesisGirisindeSuDepolaniyor: json["tesisGirisindeSuDepolaniyor"] == null
            ? null
            : json["tesisGirisindeSuDepolaniyor"],
        yeraltiBetonDepo:
            json["yeraltiBetonDepo"] == null ? null : json["yeraltiBetonDepo"],
        polyesterDepo:
            json["polyesterDepo"] == null ? null : json["polyesterDepo"],
        plastikDepo: json["plastikDepo"] == null ? null : json["plastikDepo"],
        modulerPaslanmazCelikDepo: json["modulerPaslanmazCelikDepo"] == null
            ? null
            : json["modulerPaslanmazCelikDepo"],
        modulerGalvanizDepo: json["modulerGalvanizDepo"] == null
            ? null
            : json["modulerGalvanizDepo"],
        suKaynagiTesisGirisindeAnaHattaAritiliyor:
            json["suKaynagiTesisGirisindeAnaHattaAritiliyor"] == null
                ? null
                : json["suKaynagiTesisGirisindeAnaHattaAritiliyor"],
        klorlamaSistemi:
            json["klorlamaSistemi"] == null ? null : json["klorlamaSistemi"],
        mekanikFiltre:
            json["mekanikFiltre"] == null ? null : json["mekanikFiltre"],
        otomatikKumFiltresi: json["otomatikKumFiltresi"] == null
            ? null
            : json["otomatikKumFiltresi"],
        otomatikHidrosilikonFiltre: json["otomatikHidrosilikonFiltre"] == null
            ? null
            : json["otomatikHidrosilikonFiltre"],
        otomatikSuYumustama: json["otomatikSuYumustama"] == null
            ? null
            : json["otomatikSuYumustama"],
        aktifKarbonFiltre: json["aktifKarbonFiltre"] == null
            ? null
            : json["aktifKarbonFiltre"],
        demirManganGiderimi: json["demirManganGiderimi"] == null
            ? null
            : json["demirManganGiderimi"],
        arsenikGiderimi:
            json["arsenikGiderimi"] == null ? null : json["arsenikGiderimi"],
        suKaynagiArtezyenVeyaKuyuSuyu:
            json["suKaynagiArtezyenVeyaKuyuSuyu"] == null
                ? null
                : json["suKaynagiArtezyenVeyaKuyuSuyu"],
        icmeSuyuHattindaKullanilacakMateryal:
            json["icmeSuyuHattindaKullanilacakMateryal"] == null
                ? null
                : json["icmeSuyuHattindaKullanilacakMateryal"],
        sisteminKurulacagiAlan: json["sisteminKurulacagiAlan"] == null
            ? null
            : json["sisteminKurulacagiAlan"],
        isletmeKisiSayisi: json["isletmeKisiSayisi"] == null
            ? null
            : json["isletmeKisiSayisi"],
        isletmeVardiyaSayisi: json["isletmeVardiyaSayisi"] == null
            ? null
            : json["isletmeVardiyaSayisi"],
        aylikDamacanaTuketimSayisi: json["aylikDamacanaTuketimSayisi"] == null
            ? null
            : json["aylikDamacanaTuketimSayisi"],
        yillikDamacanaTuketimSayisi: json["yillikDamacanaTuketimSayisi"] == null
            ? null
            : json["yillikDamacanaTuketimSayisi"],
        aylikPetSiseSuSayisi: json["aylikPetSiseSuSayisi"] == null
            ? null
            : json["aylikPetSiseSuSayisi"],
        yillikPetSiseSuSayisi: json["yillikPetSiseSuSayisi"] == null
            ? null
            : json["yillikPetSiseSuSayisi"],
        aylikBardakSuSayisi: json["aylikBardakSuSayisi"] == null
            ? null
            : json["aylikBardakSuSayisi"],
        yillikBardakSuSayisi: json["yillikBardakSuSayisi"] == null
            ? null
            : json["yillikBardakSuSayisi"],
        tankerleTasimaKaynakSuyu: json["tankerleTasimaKaynakSuyu"] == null
            ? null
            : json["tankerleTasimaKaynakSuyu"],
        yillikTankerleTasimaKaynakSuyu:
            json["yillikTankerleTasimaKaynakSuyu"] == null
                ? null
                : json["yillikTankerleTasimaKaynakSuyu"],
        isletmedekiDamacanaliSebilSayisi:
            json["isletmedekiDamacanaliSebilSayisi"] == null
                ? null
                : json["isletmedekiDamacanaliSebilSayisi"],
        endustriyelSebilSayisi: json["endustriyelSebilSayisi"] == null
            ? null
            : json["endustriyelSebilSayisi"],
        sistemSecimi:
            json["sistemSecimi"] == null ? null : json["sistemSecimi"],
        sistemTipi: json["sistemTipi"] == null ? null : json["sistemTipi"],
        bypassliTesisat:
            json["bypassliTesisat"] == null ? null : json["bypassliTesisat"],
        pdfSayisi: json["pdfSayisi"] == null ? null : json["pdfSayisi"],
        fotoSayisi: json["fotoSayisi"] == null ? null : json["fotoSayisi"],
        companyName: json["companyName"] == null ? null : json["companyName"],
        companyPhone:
            json["companyPhone"] == null ? null : json["companyPhone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "userId": userId == null ? null : userId,
        "person": person == null ? null : person,
        "sektor": sektor == null ? null : sektor,
        "suAnalizParametreleri":
            suAnalizParametreleri == null ? null : suAnalizParametreleri,
        "dalgicPompaKwHp": dalgicPompaKwHp == null ? null : dalgicPompaKwHp,
        "tesisatBaglantiCapi":
            tesisatBaglantiCapi == null ? null : tesisatBaglantiCapi,
        "suBasinciBar": suBasinciBar == null ? null : suBasinciBar,
        "genlesmeTankiBilgisi":
            genlesmeTankiBilgisi == null ? null : genlesmeTankiBilgisi,
        "m3saatdebi": m3Saatdebi == null ? null : m3Saatdebi,
        "suBasinci35bar": suBasinci35Bar == null ? null : suBasinci35Bar,
        "dosenecekTesisatMetraji":
            dosenecekTesisatMetraji == null ? null : dosenecekTesisatMetraji,
        "sisteminKurulacagiAlanNotlari": sisteminKurulacagiAlanNotlari == null
            ? null
            : sisteminKurulacagiAlanNotlari,
        "birimSuAmbalajiBasinaKacParaTlAdet":
            birimSuAmbalajiBasinaKacParaTlAdet == null
                ? null
                : birimSuAmbalajiBasinaKacParaTlAdet,
        "date": date == null ? null : date.toIso8601String(),
        "aritilacakSuKaynagi":
            aritilacakSuKaynagi == null ? null : aritilacakSuKaynagi,
        "tesisGirisindeSuDepolaniyor": tesisGirisindeSuDepolaniyor == null
            ? null
            : tesisGirisindeSuDepolaniyor,
        "yeraltiBetonDepo": yeraltiBetonDepo == null ? null : yeraltiBetonDepo,
        "polyesterDepo": polyesterDepo == null ? null : polyesterDepo,
        "plastikDepo": plastikDepo == null ? null : plastikDepo,
        "modulerPaslanmazCelikDepo": modulerPaslanmazCelikDepo == null
            ? null
            : modulerPaslanmazCelikDepo,
        "modulerGalvanizDepo":
            modulerGalvanizDepo == null ? null : modulerGalvanizDepo,
        "suKaynagiTesisGirisindeAnaHattaAritiliyor":
            suKaynagiTesisGirisindeAnaHattaAritiliyor == null
                ? null
                : suKaynagiTesisGirisindeAnaHattaAritiliyor,
        "klorlamaSistemi": klorlamaSistemi == null ? null : klorlamaSistemi,
        "mekanikFiltre": mekanikFiltre == null ? null : mekanikFiltre,
        "otomatikKumFiltresi":
            otomatikKumFiltresi == null ? null : otomatikKumFiltresi,
        "otomatikHidrosilikonFiltre": otomatikHidrosilikonFiltre == null
            ? null
            : otomatikHidrosilikonFiltre,
        "otomatikSuYumustama":
            otomatikSuYumustama == null ? null : otomatikSuYumustama,
        "aktifKarbonFiltre":
            aktifKarbonFiltre == null ? null : aktifKarbonFiltre,
        "demirManganGiderimi":
            demirManganGiderimi == null ? null : demirManganGiderimi,
        "arsenikGiderimi": arsenikGiderimi == null ? null : arsenikGiderimi,
        "suKaynagiArtezyenVeyaKuyuSuyu": suKaynagiArtezyenVeyaKuyuSuyu == null
            ? null
            : suKaynagiArtezyenVeyaKuyuSuyu,
        "icmeSuyuHattindaKullanilacakMateryal":
            icmeSuyuHattindaKullanilacakMateryal == null
                ? null
                : icmeSuyuHattindaKullanilacakMateryal,
        "sisteminKurulacagiAlan":
            sisteminKurulacagiAlan == null ? null : sisteminKurulacagiAlan,
        "isletmeKisiSayisi":
            isletmeKisiSayisi == null ? null : isletmeKisiSayisi,
        "isletmeVardiyaSayisi":
            isletmeVardiyaSayisi == null ? null : isletmeVardiyaSayisi,
        "aylikDamacanaTuketimSayisi": aylikDamacanaTuketimSayisi == null
            ? null
            : aylikDamacanaTuketimSayisi,
        "yillikDamacanaTuketimSayisi": yillikDamacanaTuketimSayisi == null
            ? null
            : yillikDamacanaTuketimSayisi,
        "aylikPetSiseSuSayisi":
            aylikPetSiseSuSayisi == null ? null : aylikPetSiseSuSayisi,
        "yillikPetSiseSuSayisi":
            yillikPetSiseSuSayisi == null ? null : yillikPetSiseSuSayisi,
        "aylikBardakSuSayisi":
            aylikBardakSuSayisi == null ? null : aylikBardakSuSayisi,
        "yillikBardakSuSayisi":
            yillikBardakSuSayisi == null ? null : yillikBardakSuSayisi,
        "tankerleTasimaKaynakSuyu":
            tankerleTasimaKaynakSuyu == null ? null : tankerleTasimaKaynakSuyu,
        "yillikTankerleTasimaKaynakSuyu": yillikTankerleTasimaKaynakSuyu == null
            ? null
            : yillikTankerleTasimaKaynakSuyu,
        "isletmedekiDamacanaliSebilSayisi":
            isletmedekiDamacanaliSebilSayisi == null
                ? null
                : isletmedekiDamacanaliSebilSayisi,
        "endustriyelSebilSayisi":
            endustriyelSebilSayisi == null ? null : endustriyelSebilSayisi,
        "sistemSecimi": sistemSecimi == null ? null : sistemSecimi,
        "sistemTipi": sistemTipi == null ? null : sistemTipi,
        "bypassliTesisat": bypassliTesisat == null ? null : bypassliTesisat,
        "pdfSayisi": pdfSayisi == null ? null : pdfSayisi,
        "fotoSayisi": fotoSayisi == null ? null : fotoSayisi,
        "companyName": companyName == null ? null : companyName,
        "companyPhone": companyPhone == null ? null : companyPhone,
      };
}
