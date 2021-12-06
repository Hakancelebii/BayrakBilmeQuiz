import 'dart:collection';

import 'package:bayrakquizuygulamasi/bayraklar.dart';
import 'package:bayrakquizuygulamasi/bayraklardao.dart';
import 'package:bayrakquizuygulamasi/sonucekrani.dart';
import 'package:flutter/material.dart';

class QuizEkrani extends StatefulWidget {
  const QuizEkrani({Key? key}) : super(key: key);

  @override
  _QuizEkraniState createState() => _QuizEkraniState();
}

class _QuizEkraniState extends State<QuizEkrani> {
  var sorular = <Bayraklar>[];
  var yanlisSecenekler =<Bayraklar>[];
  late Bayraklar dogruSoru;
  var tumSecenekler=HashSet<Bayraklar>();
  int soruSayac=0;
  int dogruSayac=0;
  int yanlisSayac=0;

  String BayrakresimAdi="placeholder.png";
  String ButtonAyazi="";
  String ButtonByazi="";
  String ButtonCyazi="";
  String ButtonDyazi="";

  @override
  void initState() {
    super.initState();
    sorulariAl();
  }

  Future<void> sorulariAl() async{
    sorular = await Bayraklardao().rastgele5Getir();
    soruYukle();
  }
  Future<void> soruYukle() async {
    dogruSoru = sorular[soruSayac];
    BayrakresimAdi = dogruSoru.bayrak_resim;
    yanlisSecenekler =
    await Bayraklardao().rastgele3YanlisGetir(dogruSoru.bayrak_id);
    tumSecenekler.clear();
    tumSecenekler.add(dogruSoru);
    tumSecenekler.add(yanlisSecenekler[0]);
    tumSecenekler.add(yanlisSecenekler[1]);
    tumSecenekler.add(yanlisSecenekler[2]);

    ButtonAyazi = tumSecenekler
        .elementAt(0)
        .bayrak_ad;
    ButtonByazi = tumSecenekler
        .elementAt(1)
        .bayrak_ad;
    ButtonCyazi = tumSecenekler
        .elementAt(2)
        .bayrak_ad;
    ButtonDyazi = tumSecenekler
        .elementAt(3)
        .bayrak_ad;
    setState(() {});
  }

    void sorusayackontrol() {
      soruSayac = soruSayac + 1;
      if (soruSayac != 5) {
        soruYukle();
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => SonucEkrani(Dogrusayisi: dogruSayac,)));
      }
    }
    void dogruKontrol(String buttonyazi){
      if(dogruSoru.bayrak_ad==buttonyazi){
dogruSayac=dogruSayac+1;
      }else{
        yanlisSayac=yanlisSayac+1;
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Ekrani"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Doğru : $dogruSayac ",style: TextStyle(fontSize: 18),),
                Text("Yanlış :$yanlisSayac ",style: TextStyle(fontSize: 18),),
              ],
            ),
            soruSayac!=5 ? Text("${soruSayac+1} .SORU ",style: TextStyle(fontSize: 30),): Text("5.SORU ",style: TextStyle(fontSize: 30),),
            Image.asset("resimler/$BayrakresimAdi"),
            SizedBox(height: 50,width: 250,
              child: ElevatedButton(onPressed: (){
                dogruKontrol(ButtonAyazi);
                sorusayackontrol();

              }, child: Text(ButtonAyazi)),
            ),
            SizedBox(height: 50,width: 250,
              child: ElevatedButton(onPressed: (){
                dogruKontrol(ButtonByazi);
                sorusayackontrol();
              }, child: Text(ButtonByazi)),
            ),
            SizedBox(height: 50,width: 250,
              child: ElevatedButton(onPressed: (){
                dogruKontrol(ButtonCyazi);
                sorusayackontrol();
              }, child: Text(ButtonCyazi)),
            ),
            SizedBox(height: 50,width: 250,
              child: ElevatedButton(onPressed: (){
                dogruKontrol(ButtonDyazi);
                sorusayackontrol();
              }, child: Text(ButtonDyazi)),
            ),
          ],
        ),
      ),

    );
  }
}
