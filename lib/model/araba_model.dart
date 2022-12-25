// To parse this JSON data, do
//
//     final arabaModel = arabaModelFromMap(jsonString);

import 'dart:convert';

ArabaModel arabaModelFromMap(String str) => ArabaModel.fromMap(json.decode(str));

String arabaModelToMap(ArabaModel data) => json.encode(data.toMap());

class ArabaModel {
    ArabaModel({
        required this.arabaAdi,
        required this.ulke,
        required this.kurulusYili,
        required this.model,
    });

    final String arabaAdi;
    final String ulke;
    final String kurulusYili;
    final List<Model> model;

    factory ArabaModel.fromMap(Map<String, dynamic> json) => ArabaModel(
        arabaAdi: json["araba_adi"],
        ulke: json["ulke"],
        kurulusYili: json["kurulus_yili"],
        model: List<Model>.from(json["model"].map((x) => Model.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "araba_adi": arabaAdi,
        "ulke": ulke,
        "kurulus_yili": kurulusYili,
        "model": List<dynamic>.from(model.map((x) => x.toMap())),
    };
}

class Model {
    Model({
        required this.modelAdi,
        required this.fiyat,
        required this.benzinli,
    });

    final String modelAdi;
    final int fiyat;
    final bool benzinli;

    factory Model.fromMap(Map<String, dynamic> json) => Model(
        modelAdi: json["model_adi"],
        fiyat: json["fiyat"],
        benzinli: json["benzinli"],
    );

    Map<String, dynamic> toMap() => {
        "model_adi": modelAdi,
        "fiyat": fiyat,
        "benzinli": benzinli,
    };
}
