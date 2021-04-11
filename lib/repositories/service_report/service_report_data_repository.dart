import 'package:flutter/cupertino.dart';
import 'package:teknoloji_kimya_servis/models/api_sale.dart';
import 'package:teknoloji_kimya_servis/models/api_spare_part.dart';

class ServiceReportDataRepository {
  List<ApiSparePartData> spareParts;
  List<TextEditingController> counts;
  ApiSaleData sale;
  String description = "";
  int raporValue = 0;
  int anaTesisatVeyaIcmeSuyuValue = 0;
  int kurumsalValue = 0;
  int bireyselValue = 0;
  int tezgahAltiKasaValue = 0;
  int tezgahAltiKapaliKasaValue = 0;
  bool filtrelerValue = false;
  bool yumusatmaValue = false;
  bool karbonValue = false;
  bool klorlamaValue = false;
  bool kumValue = false;
  bool endustriyelROValue = false;
  bool ultravioleValue = false;
  bool hizmetCinsiValue = false;
  bool servisHizmetiValue = false;
  bool icmeSuyuSistemleriValue = false;
  bool filtrelerTemizlendiValue = false;
  bool filtrelerDegistirildiValue = false;
  bool filtrelerGeriYikamaYapildiValue = false;
  bool yumusatmaZamanAyariValue = false;
  bool yumusatmaSizdirmazlikValue = false;
  bool yumusatmaCikisSuyuValue = false;
  bool yumusatmaTuzSeviyesiValue = false;
  bool yumusatmaRecineValue = false;
  bool karbonZamanAyariValue = false;
  bool karbonSizdirmazlikValue = false;
  bool karbonTersYikamaValue = false;
  bool karbonKarbonMineraliValue = false;
  bool kumZamanAyariValue = false;
  bool kumSizdirmazlikValue = false;
  bool kumTersYikamaValue = false;
  bool kumMineralValue = false;
  bool klorCekvalflerValue = false;
  bool klorOlcumValue = false;
  bool klorIlaveValue = false;
  bool klorSizdirmazlikValue = false;
  bool endustriyelROGuvenlikValue = false;
  bool endustriyelROMembranValue = false;
  bool endustriyelROKimyasalValue = false;
  bool endustriyelROSizdirmazlikValue = false;
  bool uvLambaKontrolValue = false;
  bool uvSizdirmazlikValue = false;
  bool uvVoltajRegulatoruValue = false;
  bool uvLambaDegistirildiValue = false;
  bool uvQuvartsKilifValue = false;
  bool servisYeriServisteValue = false;
  bool servisYeriYerindeValue = false;
  bool hizmetCinsiGarantiValue = false;
  bool hizmetCinsiIlkValue = false;
  bool hizmetCinsiNormalValue = false;
  bool setUstuFotoselValue = false;
  bool setUstuPompaValue = false;
  bool tezgahAltiFotoselValue = false;
  bool tezgahAltiPompaValue = false;
  bool acikKasaValue = false;
  bool kapaliKasaValue = false;
  bool kapaliKasaAkilliValue = false;
  bool kapaliKasaKlasikValue = false;
  bool aritmaliSebilFotoselValue = false;
  bool anaTesisatYumusatmaValue = false;
  bool anaTesisatYumusatmaZamanAyariValue = false;
  bool anaTesisatYumusatmaSizdirmazlikValue = false;
  bool anaTesisatYumusatmaCikisSuyuValue = false;
  bool anaTesisatYumusatmaTuzSeviyesiValue = false;
  bool anaTesisatYumusatmaRecineValue = false;
  bool anaTesisatKumValue = false;
  bool anaTesisatKumZamanAyariValue = false;
  bool anaTesisatKumSizdirmazlikValue = false;
  bool anaTesisatKumTersYikamaValue = false;
  bool anaTesisatKumMineralValue = false;
  bool anaTesisatKarbonValue = false;
  bool anaTesisatKarbonZamanAyariValue = false;
  bool anaTesisatKarbonSizdirmazlikValue = false;
  bool anaTesisatKarbonTersYikamaValue = false;
  bool anaTesisatKarbonKarbonMineraliValue = false;
  bool anaTesisatFiltrelerValue = false;
  bool anaTesisatFiltrelerTemizlendiValue = false;
  bool anaTesisatFiltrelerDegistirildiValue = false;
  bool anaTesisatFiltrelerGeriYikamaYapildiValue = false;
}
