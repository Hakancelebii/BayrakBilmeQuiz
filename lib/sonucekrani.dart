import 'package:flutter/material.dart';

class SonucEkrani extends StatefulWidget {
  int Dogrusayisi;


  SonucEkrani({required this.Dogrusayisi});

  @override
  _SonucEkraniState createState() => _SonucEkraniState();
}

class _SonucEkraniState extends State<SonucEkrani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sonuc Ekrani"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("${widget.Dogrusayisi} DOĞRU ${5-widget.Dogrusayisi} YANLIŞ",style: TextStyle(fontSize: 30),),
            Text(" % ${((widget.Dogrusayisi*100)/5).toInt()} BAŞARI",style: TextStyle(fontSize: 30,color: Colors.pink),),
            SizedBox(height: 50,width: 250,
              child: ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("TEKRAR DENE ")),
            ),


          ],
        ),
      ),

    );
  }
}
