import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {

  String result = 'Are you want to scan it!';

  Future _scanQR() async {
    try{
     String qrResult = await BarcodeScanner.scan();
     setState((){
        result = qrResult;
     });
    }on PlatformException catch(e){
      if (e.code == BarcodeScanner.CameraAccessDenied) {
       setState(() {
         result = "some error with camera permission";
       });
      }else {
        setState(() {
          result = "Unkwon Error $e";
        });
      }
    }on FormatException {
      setState(() {
        result = "Oops! You pressed the backbutton before scan";
      });
    }catch(e){
      setState(() {
        result = e;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('QR Scanner'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10.0),
                  child: Image(
                    image: AssetImage('images/scan.jpg'),
                    fit: BoxFit.cover,
                  )
              ),
              Text(
                  result,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.camera_alt),
            label: Text('Scan'),
          onPressed: _scanQR,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
