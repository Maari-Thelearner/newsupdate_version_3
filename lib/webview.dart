import 'dart:async';
import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsupdate_newversion/home.dart';
import 'package:webview_flutter/webview_flutter.dart';
var urlname;
class Bookmark extends StatefulWidget {
  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference ref = Firestore.instance.collection(username);
  final Completer<WebViewController> _completer= Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ColorizeAnimatedTextKit(
          repeatForever: true,
          pause: Duration(milliseconds: 200),
          text: [
            "Bookmarks",
            "Bookmarks",
            "Bookmarks",
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
      floatingActionButton: FloatingActionButton(child: Icon(FontAwesomeIcons.trash),backgroundColor: Colors.red,onPressed: (){
        ref.getDocuments().then((snapshot) {
          for (DocumentSnapshot doc in snapshot.documents) {
            doc.reference.delete();
          }
        });
      },),
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          return  ListView.builder(
              itemCount: snapshot.hasData ? snapshot.data.docs.length : 0,
              itemBuilder: (_,index){
                return GestureDetector(
                onTap: () {
    urlname= snapshot.data.docs[index].data()['newsurl'];
    Navigator.pushReplacement(context, MaterialPageRoute(
    builder: (context){

    return Scaffold(
    appBar: AppBar(
    leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,), onPressed: (){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
    return Home();
    }));
    }),
    backgroundColor: Colors.white,
    title: Text('news data',style: TextStyle(color: Colors.black),),
    centerTitle: true,
    actions: [
    Builder(
    builder:(context) => IconButton(icon: Icon(Icons.copy,color: Colors.black  ,),
    onPressed: () async{
    await FlutterClipboard.copy('This Url Link is from \'NewsUpdate App\' \n'
    ' To Download this App\n'
    '  Click the below Link and Download the app \n'
    '  http://newsupdate.freevar.com/newsupdate/app.apk \n'
    'You can download this on AmazonAppstore as well\n'
    '   Here is the news link!! \n'
    '${url.toString()}');
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Link is Copied'),));
    },
    ),
    ),
    ],
    ),
    body: WebView(
    initialUrl: urlname,
    javascriptMode: JavascriptMode.unrestricted,
    onWebViewCreated: ((WebViewController webViewController){
    setState(() {
    _completer.complete(webViewController);
    });
    }),
    ),
    );
    }),);
    },
                  onLongPress: (){
                    String id  = snapshot.data.docs[index].id;
                    showDialog(context: context ,
                      builder: (_) => AlertDialog(
                        title: Text('Are you want to delete?'),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlatButton(onPressed: (){
                              ref.doc(id).delete().then((value) => Scaffold.of(context).showSnackBar(SnackBar(content: Text('Content Deleted.'))))
                                  .catchError((error) => Scaffold.of(context).showSnackBar(SnackBar(content: Text('Failed to delete .. Error : $error'))));
                              Navigator.pop(context);
                            }, child: Text('Yes',style: GoogleFonts.kanit(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20.0),),),
                            FlatButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text('No',style: GoogleFonts.kanit(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 20.0),)),
                          ],
                        ),
                      )
                    );
                  },
                  child: Card(
                    borderOnForeground: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 20.0,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(snapshot.data.docs[index].data()['newsimage'],
                            loadingBuilder: (context , child, progress){
                              if(progress == null) return child;
                              return Container(
                                height: 200,
                                width: double.infinity,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: progress.expectedTotalBytes != null
                                        ? progress.cumulativeBytesLoaded /
                                        progress.expectedTotalBytes
                                        : Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png'),
                                  ),
                                ),
                              );
                            },
                          ),
                          Text(snapshot.data.docs[index].data()['title'],style: GoogleFonts.kanit(fontSize: 20.0),),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
