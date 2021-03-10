import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'api_service.dart';

class Pdfview extends StatefulWidget {
  @override
  _PdfviewState createState() => _PdfviewState();
}

class _PdfviewState extends State<Pdfview> {
  String _localfile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Apiservice.LoadPdf().then((value){
      setState(() {
        _localfile = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  ColorizeAnimatedTextKit(
          repeatForever: true,
          pause: Duration(milliseconds: 200),
          text: [
            "App info",
            "App info",
            "App info",
          ],
          textStyle: GoogleFonts.kanit(
            fontSize: 30.0,
          ),
          colors: [
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
            Colors.blue,
            Colors.indigo,
            Colors.purple,
          ],
          textAlign: TextAlign.start,
        ),
        centerTitle: true,
      ),
      body: _localfile!=null ? Container(
        child: PDFView(
          filePath: _localfile,
        ),
      ) : Center(child: CircularProgressIndicator(
        semanticsLabel: 'Loading....',
        semanticsValue: 'Please Wait.. Loading..',
      )),
    );
  }
}
