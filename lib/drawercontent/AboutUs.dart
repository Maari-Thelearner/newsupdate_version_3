import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee_flutter/marquee_flutter.dart';
import 'pdfview.dart';

class Aboutus extends StatefulWidget {
  @override
  _AboutusState createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


        title: Text('AboutUs',),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
          Container(
          height: 30,
          child: new MarqueeWidget(
            text: "Thanks For Download My App \'NEWSUPDATE\' App Top Headline News across the world will"
            "be Update in my app.. For more Info about my app , you can able to View the app info file and read the details feature about my app..",
            textStyle: new TextStyle(fontSize: 16.0),
            scrollAxis: Axis.horizontal,
          ),
          ),
            SizedBox(height: 20.0,),
            Center(child:
            ColorizeAnimatedTextKit(
              text: ["Developer Details"],
              colors: [Colors.red,Colors.yellow,Colors.green,Colors.blue,Colors.indigo],
              textStyle: GoogleFonts.kanit(fontWeight: FontWeight.bold,fontSize: 20.0),
            ),
            ),
            SizedBox(height: 20.0,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [Text('1. DeveloperName:',style: GoogleFonts.kanit(fontSize: 15.0),),Text('Maari',style: GoogleFonts.kanit(fontSize: 15.0,fontWeight: FontWeight.bold))],),
            SizedBox(height: 20.0,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [Text('2. DevelopedIn:',style: GoogleFonts.kanit(fontSize: 15.0),),Text('Flutter',style: GoogleFonts.kanit(fontSize: 15.0,fontWeight: FontWeight.bold))],),
            SizedBox(height: 20.0,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [Text('3. Application name:',style: GoogleFonts.kanit(fontSize: 15.0),),Text('NewsUpdate',style: GoogleFonts.kanit(fontSize: 15.0,fontWeight: FontWeight.bold))],),
            SizedBox(height: 20.0,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [Text('4. Version:',style: GoogleFonts.kanit(fontSize: 15.0),),Text('v1.0',style: GoogleFonts.kanit(fontSize: 15.0,fontWeight: FontWeight.bold))],),
            SizedBox(height: 20.0,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [Text('5. OS Preferences:',style: GoogleFonts.kanit(fontSize: 15.0),),Text('Android and IOS',style: GoogleFonts.kanit(fontSize: 15.0,fontWeight: FontWeight.bold))],),
            SizedBox(height: 20.0,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [Text('6. OS versions:',style: GoogleFonts.kanit(fontSize: 15.0),),Text('Any',style: GoogleFonts.kanit(fontSize: 15.0,fontWeight: FontWeight.bold))],),
            SizedBox(height: 20.0,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [Text('7. Network access:',style: GoogleFonts.kanit(fontSize: 15.0),),Text('Yes',style: GoogleFonts.kanit(fontSize: 15.0,fontWeight: FontWeight.bold))],),
            SizedBox(height: 20.0,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [Text('8. Userdata access:',style: GoogleFonts.kanit(fontSize: 15.0),),Text('Yes',style: GoogleFonts.kanit(fontSize: 15.0,fontWeight: FontWeight.bold))],),
            SizedBox(height: 20.0,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [Text('9. Beta version:',style: GoogleFonts.kanit(fontSize: 15.0),),Text('Yes',style: GoogleFonts.kanit(fontSize: 15.0,fontWeight: FontWeight.bold))],),
            SizedBox(height: 20.0,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [Text('10. App Install:',style: GoogleFonts.kanit(fontSize: 15.0),),Text('Free',style: GoogleFonts.kanit(fontSize: 15.0,fontWeight: FontWeight.bold))],),
            SizedBox(height: 20.0,),
            MaterialButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return  Pdfview();
              }));
            }, child: Text('App Info',style: GoogleFonts.kanit(color: Colors.white),),
            color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

}


