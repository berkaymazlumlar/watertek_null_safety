// To parse this JSON data, do
//
//     final apiServiceReport = apiServiceReportFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ApiServiceReport apiServiceReportFromJson(String str) =>
    ApiServiceReport.fromJson(json.decode(str));

String apiServiceReportToJson(ApiServiceReport data) =>
    json.encode(data.toJson());

class ApiServiceReport {
  ApiServiceReport({
    @required this.status,
    @required this.data,
  });

  final String status;
  final List<ApiServiceReportData> data;

  factory ApiServiceReport.fromJson(Map<String, dynamic> json) =>
      ApiServiceReport(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null
            ? null
            : List<ApiServiceReportData>.from(
                json["data"].map((x) => ApiServiceReportData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ApiServiceReportData {
  ApiServiceReportData({
    @required this.id,
    @required this.saleId,
    @required this.pdfUrl,
    @required this.createdAt,
    @required this.raporValue,
    @required this.kurumsalValue,
    @required this.bireyselValue,
    @required this.tezgahAltiKasaValue,
    @required this.tezgahAltiKapaliKasaValue,
    @required this.filtrelerValue,
    @required this.yumusatmaValue,
    @required this.karbonValue,
    @required this.klorlamaValue,
    @required this.kumValue,
    @required this.endustriyelRoValue,
    @required this.ultravioleValue,
    @required this.hizmetCinsiValue,
    @required this.servisHizmetiValue,
    @required this.icmeSuyuSistemleriValue,
    @required this.filtrelerTemizlendiValue,
    @required this.filtrelerDegistirildiValue,
    @required this.filtrelerGeriYikamaYapildiValue,
    @required this.yumusatmaZamanAyariValue,
    @required this.yumusatmaSizdirmazlikValue,
    @required this.yumusatmaCikisSuyuValue,
    @required this.yumusatmaTuzSeviyesiValue,
    @required this.yumusatmaRecineValue,
    @required this.karbonZamanAyariValue,
    @required this.karbonSizdirmazlikValue,
    @required this.karbonTersYikamaValue,
    @required this.karbonKarbonMineraliValue,
    @required this.kumZamanAyariValue,
    @required this.kumSizdirmazlikValue,
    @required this.kumTersYikamaValue,
    @required this.kumMineralValue,
    @required this.klorCekvalflerValue,
    @required this.klorOlcumValue,
    @required this.klorIlaveValue,
    @required this.klorSizdirmazlikValue,
    @required this.endustriyelRoGuvenlikValue,
    @required this.endustriyelRoMembranValue,
    @required this.endustriyelRoKimyasalValue,
    @required this.endustriyelRoSizdirmazlikValue,
    @required this.uvLambaKontrolValue,
    @required this.uvSizdirmazlikValue,
    @required this.uvVoltajRegulatoruValue,
    @required this.uvLambaDegistirildiValue,
    @required this.uvQuvartsKilifValue,
    @required this.servisYeriServisteValue,
    @required this.servisYeriYerindeValue,
    @required this.hizmetCinsiGarantiValue,
    @required this.hizmetCinsiIlkValue,
    @required this.hizmetCinsiNormalValue,
    @required this.setUstuFotoselValue,
    @required this.setUstuPompaValue,
    @required this.tezgahAltiFotoselValue,
    @required this.tezgahAltiPompaValue,
    @required this.acikKasaValue,
    @required this.kapaliKasaValue,
    @required this.kapaliKasaAkilliValue,
    @required this.kapaliKasaKlasikValue,
    @required this.aritmaliSebilFotoselValue,
    @required this.anaTesisatYumusatmaValue,
    @required this.anaTesisatYumusatmaZamanAyariValue,
    @required this.anaTesisatYumusatmaSizdirmazlikValue,
    @required this.anaTesisatYumusatmaCikisSuyuValue,
    @required this.anaTesisatYumusatmaTuzSeviyesiValue,
    @required this.anaTesisatYumusatmaRecineValue,
    @required this.anaTesisatKumValue,
    @required this.anaTesisatKumZamanAyariValue,
    @required this.anaTesisatKumSizdirmazlikValue,
    @required this.anaTesisatKumTersYikamaValue,
    @required this.anaTesisatKumMineralValue,
    @required this.anaTesisatKarbonValue,
    @required this.anaTesisatKarbonZamanAyariValue,
    @required this.anaTesisatKarbonSizdirmazlikValue,
    @required this.anaTesisatKarbonTersYikamaValue,
    @required this.anaTesisatKarbonKarbonMineraliValue,
    @required this.anaTesisatFiltrelerValue,
    @required this.anaTesisatFiltrelerTemizlendiValue,
    @required this.anaTesisatFiltrelerDegistirildiValue,
    @required this.anaTesisatFiltrelerGeriYikamaYapildiValue,
    @required this.anaTesisatVeyaIcmeSuyuValue,
    @required this.saleSetupDate,
    @required this.saleCreatedAt,
    @required this.saleBarcode,
    @required this.saleWarrantyDate,
    @required this.productName,
    @required this.productModel,
    @required this.companyName,
    @required this.companyPhone,
    @required this.description,
  });

  final int id;
  final int saleId;
  final String description;
  final DateTime createdAt;
  final dynamic pdfUrl;
  final int raporValue;
  final int kurumsalValue;
  final int bireyselValue;
  final int tezgahAltiKasaValue;
  final int tezgahAltiKapaliKasaValue;
  final int filtrelerValue;
  final int yumusatmaValue;
  final int karbonValue;
  final int klorlamaValue;
  final int kumValue;
  final int endustriyelRoValue;
  final int ultravioleValue;
  final int hizmetCinsiValue;
  final int servisHizmetiValue;
  final int icmeSuyuSistemleriValue;
  final int filtrelerTemizlendiValue;
  final int filtrelerDegistirildiValue;
  final int filtrelerGeriYikamaYapildiValue;
  final int yumusatmaZamanAyariValue;
  final int yumusatmaSizdirmazlikValue;
  final int yumusatmaCikisSuyuValue;
  final int yumusatmaTuzSeviyesiValue;
  final int yumusatmaRecineValue;
  final int karbonZamanAyariValue;
  final int karbonSizdirmazlikValue;
  final int karbonTersYikamaValue;
  final int karbonKarbonMineraliValue;
  final int kumZamanAyariValue;
  final int kumSizdirmazlikValue;
  final int kumTersYikamaValue;
  final int kumMineralValue;
  final int klorCekvalflerValue;
  final int klorOlcumValue;
  final int klorIlaveValue;
  final int klorSizdirmazlikValue;
  final int endustriyelRoGuvenlikValue;
  final int endustriyelRoMembranValue;
  final int endustriyelRoKimyasalValue;
  final int endustriyelRoSizdirmazlikValue;
  final int uvLambaKontrolValue;
  final int uvSizdirmazlikValue;
  final int uvVoltajRegulatoruValue;
  final int uvLambaDegistirildiValue;
  final int uvQuvartsKilifValue;
  final int servisYeriServisteValue;
  final int servisYeriYerindeValue;
  final int hizmetCinsiGarantiValue;
  final int hizmetCinsiIlkValue;
  final int hizmetCinsiNormalValue;
  final int setUstuFotoselValue;
  final int setUstuPompaValue;
  final int tezgahAltiFotoselValue;
  final int tezgahAltiPompaValue;
  final int acikKasaValue;
  final int kapaliKasaValue;
  final int kapaliKasaAkilliValue;
  final int kapaliKasaKlasikValue;
  final int aritmaliSebilFotoselValue;
  final dynamic anaTesisatYumusatmaValue;
  final dynamic anaTesisatYumusatmaZamanAyariValue;
  final dynamic anaTesisatYumusatmaSizdirmazlikValue;
  final dynamic anaTesisatYumusatmaCikisSuyuValue;
  final dynamic anaTesisatYumusatmaTuzSeviyesiValue;
  final dynamic anaTesisatYumusatmaRecineValue;
  final dynamic anaTesisatKumValue;
  final dynamic anaTesisatKumZamanAyariValue;
  final dynamic anaTesisatKumSizdirmazlikValue;
  final dynamic anaTesisatKumTersYikamaValue;
  final dynamic anaTesisatKumMineralValue;
  final dynamic anaTesisatKarbonValue;
  final dynamic anaTesisatKarbonZamanAyariValue;
  final dynamic anaTesisatKarbonSizdirmazlikValue;
  final dynamic anaTesisatKarbonTersYikamaValue;
  final dynamic anaTesisatKarbonKarbonMineraliValue;
  final dynamic anaTesisatFiltrelerValue;
  final dynamic anaTesisatFiltrelerTemizlendiValue;
  final dynamic anaTesisatFiltrelerDegistirildiValue;
  final dynamic anaTesisatFiltrelerGeriYikamaYapildiValue;
  final dynamic anaTesisatVeyaIcmeSuyuValue;
  final DateTime saleSetupDate;
  final DateTime saleCreatedAt;
  final String saleBarcode;
  final DateTime saleWarrantyDate;
  final String productName;
  final String productModel;
  final String companyName;
  final String companyPhone;

  factory ApiServiceReportData.fromJson(Map<String, dynamic> json) =>
      ApiServiceReportData(
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        id: json["id"] == null ? null : json["id"],
        saleId: json["saleId"] == null ? null : json["saleId"],
        pdfUrl: json["pdfUrl"],
        description: json["description"],
        raporValue: json["raporValue"] == null ? null : json["raporValue"],
        kurumsalValue:
            json["kurumsalValue"] == null ? null : json["kurumsalValue"],
        bireyselValue:
            json["bireyselValue"] == null ? null : json["bireyselValue"],
        tezgahAltiKasaValue: json["tezgahAltiKasaValue"] == null
            ? null
            : json["tezgahAltiKasaValue"],
        tezgahAltiKapaliKasaValue: json["tezgahAltiKapaliKasaValue"] == null
            ? null
            : json["tezgahAltiKapaliKasaValue"],
        filtrelerValue:
            json["filtrelerValue"] == null ? null : json["filtrelerValue"],
        yumusatmaValue:
            json["yumusatmaValue"] == null ? null : json["yumusatmaValue"],
        karbonValue: json["karbonValue"] == null ? null : json["karbonValue"],
        klorlamaValue:
            json["klorlamaValue"] == null ? null : json["klorlamaValue"],
        kumValue: json["kumValue"] == null ? null : json["kumValue"],
        endustriyelRoValue: json["endustriyelROValue"] == null
            ? null
            : json["endustriyelROValue"],
        ultravioleValue:
            json["ultravioleValue"] == null ? null : json["ultravioleValue"],
        hizmetCinsiValue:
            json["hizmetCinsiValue"] == null ? null : json["hizmetCinsiValue"],
        servisHizmetiValue: json["servisHizmetiValue"] == null
            ? null
            : json["servisHizmetiValue"],
        icmeSuyuSistemleriValue: json["icmeSuyuSistemleriValue"] == null
            ? null
            : json["icmeSuyuSistemleriValue"],
        filtrelerTemizlendiValue: json["filtrelerTemizlendiValue"] == null
            ? null
            : json["filtrelerTemizlendiValue"],
        filtrelerDegistirildiValue: json["filtrelerDegistirildiValue"] == null
            ? null
            : json["filtrelerDegistirildiValue"],
        filtrelerGeriYikamaYapildiValue:
            json["filtrelerGeriYikamaYapildiValue"] == null
                ? null
                : json["filtrelerGeriYikamaYapildiValue"],
        yumusatmaZamanAyariValue: json["yumusatmaZamanAyariValue"] == null
            ? null
            : json["yumusatmaZamanAyariValue"],
        yumusatmaSizdirmazlikValue: json["yumusatmaSizdirmazlikValue"] == null
            ? null
            : json["yumusatmaSizdirmazlikValue"],
        yumusatmaCikisSuyuValue: json["yumusatmaCikisSuyuValue"] == null
            ? null
            : json["yumusatmaCikisSuyuValue"],
        yumusatmaTuzSeviyesiValue: json["yumusatmaTuzSeviyesiValue"] == null
            ? null
            : json["yumusatmaTuzSeviyesiValue"],
        yumusatmaRecineValue: json["yumusatmaRecineValue"] == null
            ? null
            : json["yumusatmaRecineValue"],
        karbonZamanAyariValue: json["karbonZamanAyariValue"] == null
            ? null
            : json["karbonZamanAyariValue"],
        karbonSizdirmazlikValue: json["karbonSizdirmazlikValue"] == null
            ? null
            : json["karbonSizdirmazlikValue"],
        karbonTersYikamaValue: json["karbonTersYikamaValue"] == null
            ? null
            : json["karbonTersYikamaValue"],
        karbonKarbonMineraliValue: json["karbonKarbonMineraliValue"] == null
            ? null
            : json["karbonKarbonMineraliValue"],
        kumZamanAyariValue: json["kumZamanAyariValue"] == null
            ? null
            : json["kumZamanAyariValue"],
        kumSizdirmazlikValue: json["kumSizdirmazlikValue"] == null
            ? null
            : json["kumSizdirmazlikValue"],
        kumTersYikamaValue: json["kumTersYikamaValue"] == null
            ? null
            : json["kumTersYikamaValue"],
        kumMineralValue:
            json["kumMineralValue"] == null ? null : json["kumMineralValue"],
        klorCekvalflerValue: json["klorCekvalflerValue"] == null
            ? null
            : json["klorCekvalflerValue"],
        klorOlcumValue:
            json["klorOlcumValue"] == null ? null : json["klorOlcumValue"],
        klorIlaveValue:
            json["klorIlaveValue"] == null ? null : json["klorIlaveValue"],
        klorSizdirmazlikValue: json["klorSizdirmazlikValue"] == null
            ? null
            : json["klorSizdirmazlikValue"],
        endustriyelRoGuvenlikValue: json["endustriyelROGuvenlikValue"] == null
            ? null
            : json["endustriyelROGuvenlikValue"],
        endustriyelRoMembranValue: json["endustriyelROMembranValue"] == null
            ? null
            : json["endustriyelROMembranValue"],
        endustriyelRoKimyasalValue: json["endustriyelROKimyasalValue"] == null
            ? null
            : json["endustriyelROKimyasalValue"],
        endustriyelRoSizdirmazlikValue:
            json["endustriyelROSizdirmazlikValue"] == null
                ? null
                : json["endustriyelROSizdirmazlikValue"],
        uvLambaKontrolValue: json["uvLambaKontrolValue"] == null
            ? null
            : json["uvLambaKontrolValue"],
        uvSizdirmazlikValue: json["uvSizdirmazlikValue"] == null
            ? null
            : json["uvSizdirmazlikValue"],
        uvVoltajRegulatoruValue: json["uvVoltajRegulatoruValue"] == null
            ? null
            : json["uvVoltajRegulatoruValue"],
        uvLambaDegistirildiValue: json["uvLambaDegistirildiValue"] == null
            ? null
            : json["uvLambaDegistirildiValue"],
        uvQuvartsKilifValue: json["uvQuvartsKilifValue"] == null
            ? null
            : json["uvQuvartsKilifValue"],
        servisYeriServisteValue: json["servisYeriServisteValue"] == null
            ? null
            : json["servisYeriServisteValue"],
        servisYeriYerindeValue: json["servisYeriYerindeValue"] == null
            ? null
            : json["servisYeriYerindeValue"],
        hizmetCinsiGarantiValue: json["hizmetCinsiGarantiValue"] == null
            ? null
            : json["hizmetCinsiGarantiValue"],
        hizmetCinsiIlkValue: json["hizmetCinsiIlkValue"] == null
            ? null
            : json["hizmetCinsiIlkValue"],
        hizmetCinsiNormalValue: json["hizmetCinsiNormalValue"] == null
            ? null
            : json["hizmetCinsiNormalValue"],
        setUstuFotoselValue: json["setUstuFotoselValue"] == null
            ? null
            : json["setUstuFotoselValue"],
        setUstuPompaValue: json["setUstuPompaValue"] == null
            ? null
            : json["setUstuPompaValue"],
        tezgahAltiFotoselValue: json["tezgahAltiFotoselValue"] == null
            ? null
            : json["tezgahAltiFotoselValue"],
        tezgahAltiPompaValue: json["tezgahAltiPompaValue"] == null
            ? null
            : json["tezgahAltiPompaValue"],
        acikKasaValue:
            json["acikKasaValue"] == null ? null : json["acikKasaValue"],
        kapaliKasaValue:
            json["kapaliKasaValue"] == null ? null : json["kapaliKasaValue"],
        kapaliKasaAkilliValue: json["kapaliKasaAkilliValue"] == null
            ? null
            : json["kapaliKasaAkilliValue"],
        kapaliKasaKlasikValue: json["kapaliKasaKlasikValue"] == null
            ? null
            : json["kapaliKasaKlasikValue"],
        aritmaliSebilFotoselValue: json["aritmaliSebilFotoselValue"] == null
            ? null
            : json["aritmaliSebilFotoselValue"],
        anaTesisatYumusatmaValue: json["anaTesisatYumusatmaValue"],
        anaTesisatYumusatmaZamanAyariValue:
            json["anaTesisatYumusatmaZamanAyariValue"],
        anaTesisatYumusatmaSizdirmazlikValue:
            json["anaTesisatYumusatmaSizdirmazlikValue"],
        anaTesisatYumusatmaCikisSuyuValue:
            json["anaTesisatYumusatmaCikisSuyuValue"],
        anaTesisatYumusatmaTuzSeviyesiValue:
            json["anaTesisatYumusatmaTuzSeviyesiValue"],
        anaTesisatYumusatmaRecineValue: json["anaTesisatYumusatmaRecineValue"],
        anaTesisatKumValue: json["anaTesisatKumValue"],
        anaTesisatKumZamanAyariValue: json["anaTesisatKumZamanAyariValue"],
        anaTesisatKumSizdirmazlikValue: json["anaTesisatKumSizdirmazlikValue"],
        anaTesisatKumTersYikamaValue: json["anaTesisatKumTersYikamaValue"],
        anaTesisatKumMineralValue: json["anaTesisatKumMineralValue"],
        anaTesisatKarbonValue: json["anaTesisatKarbonValue"],
        anaTesisatKarbonZamanAyariValue:
            json["anaTesisatKarbonZamanAyariValue"],
        anaTesisatKarbonSizdirmazlikValue:
            json["anaTesisatKarbonSizdirmazlikValue"],
        anaTesisatKarbonTersYikamaValue:
            json["anaTesisatKarbonTersYikamaValue"],
        anaTesisatKarbonKarbonMineraliValue:
            json["anaTesisatKarbonKarbonMineraliValue"],
        anaTesisatFiltrelerValue: json["anaTesisatFiltrelerValue"],
        anaTesisatFiltrelerTemizlendiValue:
            json["anaTesisatFiltrelerTemizlendiValue"],
        anaTesisatFiltrelerDegistirildiValue:
            json["anaTesisatFiltrelerDegistirildiValue"],
        anaTesisatFiltrelerGeriYikamaYapildiValue:
            json["anaTesisatFiltrelerGeriYikamaYapildiValue"],
        anaTesisatVeyaIcmeSuyuValue: json["anaTesisatVeyaIcmeSuyuValue"],
        saleSetupDate: json["saleSetupDate"] == null
            ? null
            : DateTime.parse(json["saleSetupDate"]),
        saleCreatedAt: json["saleCreatedAt"] == null
            ? null
            : DateTime.parse(json["saleCreatedAt"]),
        saleBarcode: json["saleBarcode"] == null ? null : json["saleBarcode"],
        saleWarrantyDate: json["saleWarrantyDate"] == null
            ? null
            : DateTime.parse(json["saleWarrantyDate"]),
        productName: json["productName"] == null ? null : json["productName"],
        productModel:
            json["productModel"] == null ? null : json["productModel"],
        companyName: json["companyName"] == null ? null : json["companyName"],
        companyPhone:
            json["companyPhone"] == null ? null : json["companyPhone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "saleId": saleId == null ? null : saleId,
        "pdfUrl": pdfUrl,
        "description": description,
        "raporValue": raporValue == null ? null : raporValue,
        "kurumsalValue": kurumsalValue == null ? null : kurumsalValue,
        "bireyselValue": bireyselValue == null ? null : bireyselValue,
        "tezgahAltiKasaValue":
            tezgahAltiKasaValue == null ? null : tezgahAltiKasaValue,
        "tezgahAltiKapaliKasaValue": tezgahAltiKapaliKasaValue == null
            ? null
            : tezgahAltiKapaliKasaValue,
        "filtrelerValue": filtrelerValue == null ? null : filtrelerValue,
        "yumusatmaValue": yumusatmaValue == null ? null : yumusatmaValue,
        "karbonValue": karbonValue == null ? null : karbonValue,
        "klorlamaValue": klorlamaValue == null ? null : klorlamaValue,
        "kumValue": kumValue == null ? null : kumValue,
        "endustriyelROValue":
            endustriyelRoValue == null ? null : endustriyelRoValue,
        "ultravioleValue": ultravioleValue == null ? null : ultravioleValue,
        "hizmetCinsiValue": hizmetCinsiValue == null ? null : hizmetCinsiValue,
        "servisHizmetiValue":
            servisHizmetiValue == null ? null : servisHizmetiValue,
        "icmeSuyuSistemleriValue":
            icmeSuyuSistemleriValue == null ? null : icmeSuyuSistemleriValue,
        "filtrelerTemizlendiValue":
            filtrelerTemizlendiValue == null ? null : filtrelerTemizlendiValue,
        "filtrelerDegistirildiValue": filtrelerDegistirildiValue == null
            ? null
            : filtrelerDegistirildiValue,
        "filtrelerGeriYikamaYapildiValue":
            filtrelerGeriYikamaYapildiValue == null
                ? null
                : filtrelerGeriYikamaYapildiValue,
        "yumusatmaZamanAyariValue":
            yumusatmaZamanAyariValue == null ? null : yumusatmaZamanAyariValue,
        "yumusatmaSizdirmazlikValue": yumusatmaSizdirmazlikValue == null
            ? null
            : yumusatmaSizdirmazlikValue,
        "yumusatmaCikisSuyuValue":
            yumusatmaCikisSuyuValue == null ? null : yumusatmaCikisSuyuValue,
        "yumusatmaTuzSeviyesiValue": yumusatmaTuzSeviyesiValue == null
            ? null
            : yumusatmaTuzSeviyesiValue,
        "yumusatmaRecineValue":
            yumusatmaRecineValue == null ? null : yumusatmaRecineValue,
        "karbonZamanAyariValue":
            karbonZamanAyariValue == null ? null : karbonZamanAyariValue,
        "karbonSizdirmazlikValue":
            karbonSizdirmazlikValue == null ? null : karbonSizdirmazlikValue,
        "karbonTersYikamaValue":
            karbonTersYikamaValue == null ? null : karbonTersYikamaValue,
        "karbonKarbonMineraliValue": karbonKarbonMineraliValue == null
            ? null
            : karbonKarbonMineraliValue,
        "kumZamanAyariValue":
            kumZamanAyariValue == null ? null : kumZamanAyariValue,
        "kumSizdirmazlikValue":
            kumSizdirmazlikValue == null ? null : kumSizdirmazlikValue,
        "kumTersYikamaValue":
            kumTersYikamaValue == null ? null : kumTersYikamaValue,
        "kumMineralValue": kumMineralValue == null ? null : kumMineralValue,
        "klorCekvalflerValue":
            klorCekvalflerValue == null ? null : klorCekvalflerValue,
        "klorOlcumValue": klorOlcumValue == null ? null : klorOlcumValue,
        "klorIlaveValue": klorIlaveValue == null ? null : klorIlaveValue,
        "klorSizdirmazlikValue":
            klorSizdirmazlikValue == null ? null : klorSizdirmazlikValue,
        "endustriyelROGuvenlikValue": endustriyelRoGuvenlikValue == null
            ? null
            : endustriyelRoGuvenlikValue,
        "endustriyelROMembranValue": endustriyelRoMembranValue == null
            ? null
            : endustriyelRoMembranValue,
        "endustriyelROKimyasalValue": endustriyelRoKimyasalValue == null
            ? null
            : endustriyelRoKimyasalValue,
        "endustriyelROSizdirmazlikValue": endustriyelRoSizdirmazlikValue == null
            ? null
            : endustriyelRoSizdirmazlikValue,
        "uvLambaKontrolValue":
            uvLambaKontrolValue == null ? null : uvLambaKontrolValue,
        "uvSizdirmazlikValue":
            uvSizdirmazlikValue == null ? null : uvSizdirmazlikValue,
        "uvVoltajRegulatoruValue":
            uvVoltajRegulatoruValue == null ? null : uvVoltajRegulatoruValue,
        "uvLambaDegistirildiValue":
            uvLambaDegistirildiValue == null ? null : uvLambaDegistirildiValue,
        "uvQuvartsKilifValue":
            uvQuvartsKilifValue == null ? null : uvQuvartsKilifValue,
        "servisYeriServisteValue":
            servisYeriServisteValue == null ? null : servisYeriServisteValue,
        "servisYeriYerindeValue":
            servisYeriYerindeValue == null ? null : servisYeriYerindeValue,
        "hizmetCinsiGarantiValue":
            hizmetCinsiGarantiValue == null ? null : hizmetCinsiGarantiValue,
        "hizmetCinsiIlkValue":
            hizmetCinsiIlkValue == null ? null : hizmetCinsiIlkValue,
        "hizmetCinsiNormalValue":
            hizmetCinsiNormalValue == null ? null : hizmetCinsiNormalValue,
        "setUstuFotoselValue":
            setUstuFotoselValue == null ? null : setUstuFotoselValue,
        "setUstuPompaValue":
            setUstuPompaValue == null ? null : setUstuPompaValue,
        "tezgahAltiFotoselValue":
            tezgahAltiFotoselValue == null ? null : tezgahAltiFotoselValue,
        "tezgahAltiPompaValue":
            tezgahAltiPompaValue == null ? null : tezgahAltiPompaValue,
        "acikKasaValue": acikKasaValue == null ? null : acikKasaValue,
        "kapaliKasaValue": kapaliKasaValue == null ? null : kapaliKasaValue,
        "kapaliKasaAkilliValue":
            kapaliKasaAkilliValue == null ? null : kapaliKasaAkilliValue,
        "kapaliKasaKlasikValue":
            kapaliKasaKlasikValue == null ? null : kapaliKasaKlasikValue,
        "aritmaliSebilFotoselValue": aritmaliSebilFotoselValue == null
            ? null
            : aritmaliSebilFotoselValue,
        "anaTesisatYumusatmaZamanAyariValue":
            anaTesisatYumusatmaZamanAyariValue,
        "anaTesisatYumusatmaSizdirmazlikValue":
            anaTesisatYumusatmaSizdirmazlikValue,
        "anaTesisatYumusatmaCikisSuyuValue": anaTesisatYumusatmaCikisSuyuValue,
        "anaTesisatYumusatmaTuzSeviyesiValue":
            anaTesisatYumusatmaTuzSeviyesiValue,
        "anaTesisatYumusatmaRecineValue": anaTesisatYumusatmaRecineValue,
        "anaTesisatKumValue": anaTesisatKumValue,
        "anaTesisatKumZamanAyariValue": anaTesisatKumZamanAyariValue,
        "anaTesisatKumSizdirmazlikValue": anaTesisatKumSizdirmazlikValue,
        "anaTesisatKumTersYikamaValue": anaTesisatKumTersYikamaValue,
        "anaTesisatKumMineralValue": anaTesisatKumMineralValue,
        "anaTesisatKarbonValue": anaTesisatKarbonValue,
        "anaTesisatKarbonZamanAyariValue": anaTesisatKarbonZamanAyariValue,
        "anaTesisatKarbonSizdirmazlikValue": anaTesisatKarbonSizdirmazlikValue,
        "anaTesisatKarbonTersYikamaValue": anaTesisatKarbonTersYikamaValue,
        "anaTesisatKarbonKarbonMineraliValue":
            anaTesisatKarbonKarbonMineraliValue,
        "anaTesisatFiltrelerValue": anaTesisatFiltrelerValue,
        "anaTesisatFiltrelerTemizlendiValue":
            anaTesisatFiltrelerTemizlendiValue,
        "anaTesisatFiltrelerDegistirildiValue":
            anaTesisatFiltrelerDegistirildiValue,
        "anaTesisatFiltrelerGeriYikamaYapildiValue":
            anaTesisatFiltrelerGeriYikamaYapildiValue,
        "anaTesisatVeyaIcmeSuyuValue": anaTesisatVeyaIcmeSuyuValue,
        "saleSetupDate":
            saleSetupDate == null ? null : saleSetupDate.toIso8601String(),
        "saleCreatedAt":
            saleCreatedAt == null ? null : saleCreatedAt.toIso8601String(),
        "saleBarcode": saleBarcode == null ? null : saleBarcode,
        "saleWarrantyDate": saleWarrantyDate == null
            ? null
            : saleWarrantyDate.toIso8601String(),
        "productName": productName == null ? null : productName,
        "productModel": productModel == null ? null : productModel,
        "companyName": companyName == null ? null : companyName,
        "companyPhone": companyPhone == null ? null : companyPhone,
      };
}
