import 'dart:convert';

import 'package:flutter/material.dart';
import 'model/araba_model.dart';

class LocalJson extends StatefulWidget{
  const LocalJson({Key? key}) : super(key: key);

  @override
  State<LocalJson> createState() => _LocalJsonState();
}

class _LocalJsonState extends State<LocalJson> {

  String _title = 'Local Json işleleri';

  late Future<List<ArabaModel>> _listeyiDoldur;
  @override
  void initState() {
    super.initState();
    _listeyiDoldur = arabalarJsonOku();
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:  Text(_title),
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: () {
          setState(() {
            _title = 'FAB Tıklandı';
          });
        },
        child: const Icon(Icons.add),
      ),
      // ignore: prefer_const_constructors
      body: FutureBuilder<List<ArabaModel>>(
        future: _listeyiDoldur,
        initialData: [
          ArabaModel(arabaAdi: 'aaa', ulke: 'sad', kurulusYili: "1988", model: [
            Model(modelAdi: 'sdsd', fiyat: 123, benzinli: true)
          ])
        ],
        builder: (context, snapshot) {
          if (snapshot.hasData){
            List<ArabaModel> arabaListesi = snapshot.data!;
            return ListView.builder(
              
              itemCount: arabaListesi.length,
              itemBuilder: (context, index){
                ArabaModel oankiAraba = arabaListesi[index];
                return ListTile(
                  title: Text(oankiAraba.arabaAdi),
                  subtitle: Text(oankiAraba.ulke),
                  leading: CircleAvatar(
                    child: Text(oankiAraba.model[0].fiyat.toString()),
                  )
                );
              }
            );
          }else if (snapshot.hasError){
            return  Center(child: Text(snapshot.error.toString()));
          }
          else{
            return const Center(child: CircularProgressIndicator(),);
          }
        }
      )
    );
  }

 Future<List<ArabaModel>> arabalarJsonOku ()async{
  try{
    String okunanString = await DefaultAssetBundle.of(context).loadString('assets/data/arabalar.json');
  

 var jsonObeject = jsonDecode(okunanString.toString());
//  List arabaListesi = jsonObeject;
//   print(arabaListesi[0]["model"][0]['fiyat'].toString());
//   print(arabaListesi[0]["model"][0]['model_adi'].toString());
  List<ArabaModel> tumArabalar = (jsonObeject as List).map((arabaMap) => ArabaModel.fromMap(arabaMap)).toList();
  debugPrint(tumArabalar[0].arabaAdi);

  return tumArabalar;
  }
  catch(e){
    debugPrint('Hata: $e');
    return Future.error(e.toString());
  
   
  }
}
}