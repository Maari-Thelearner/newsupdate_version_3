import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Countries extends StatefulWidget {
  @override
  _CountriesState createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  List<Map> _countries = [
    {"name": "Argentina", "code": "ar"},
    {"name": "Argentina","code":"au"},
    {"name": "Austria","code":"at"},
    {"name": "Belgium","code":"be"},
    {"name": "Brazil","code":"br"},
    {"name": "Bulgaria","code":"bg"},
    {"name": "Canada","code":"ca"},
    {"name": "China","code":"cn"},
    {"name": "Colombia","code":"co"},
    {"name": "Cuba","code":"cu"},
    {"name": "Czech Republic","code":"cz"},
    {"name": "Egypt","code":"eg"},
    {"name": "France","code":"fr"},
    {"name": "Germany","code":"de"},
    {"name": "Greece","code":"gr"},
    {"name": "Hong Kong","code":"hk"},
    {"name": "Hungary","code":"hu"},
    {"name": "India","code":"in"},
    {"name": "Indonesia","code":"id"},
    {"name": "Ireland", "code":"ie"},
    {"name":"Israel","code":"il"},
    {"name":"Italy","code":"it"},
    {"name":"Japan","code":"jp"},
    {"name":"Latvia","code":"lv"},
    {"name":"Lithuania","code":"lt"},
    {"name":"Malaysia","code":"my"},
    {"name":"Mexico","code":"mx"},
    {"name":"Morocco","code":"ma"},
    {"name":"Netherlands","code":"nl"},
    {"name":"New Zealand","code":"nz"},
    {"name":"Nigeria","code":"ng"},
    {"name":"Norway","code":"no"},
    {"name":"Philippines","code":"ph"},
    {"name":"Poland","code":"pl"},
    {"name":"Portugal","code":"pt"},
    {"name":"Romania","code":"ro"},
    {"name":"Russia","code":"ru"},
    {"name":"Saudi Arabia","code":"sa"},
    {"name":"Serbia","code":"rs"},
    {"name":"Singapore","code":"sg"},
    {"name":"Slovakia","code":"sk"},
    {"name":"Slovenia","code":"si"},
    {"name":"South Africa","code":"za"},
    {"name":"South Korea","code":"kr"},
    {"name":"Sweden","code":"se"},
    {"name":"Switzerland","code":"ch"},
    {"name":"Taiwan","code":"tw"},
    {"name":"Thailand","code":"th"},
    {"name":"Turkey","code":"tr"},
    {"name":"UAE","code":"ae"},
    {"name":"Ukraine","code":"ua"},
    {"name":"United Kingdom","code":"gb"},
    {"name":"United States","code":"us"},
    {"name":"Venuzuela","code":"ve"}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.black),
            expandedHeight: 200.0,
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              title:  ColorizeAnimatedTextKit(
                repeatForever: true,
                speed: Duration(milliseconds: 300),
                pause: Duration(milliseconds: 200),
                text: [
                  "Countries",
                  "Countries",
                  "Countries",
                ],
                textStyle: GoogleFonts.kanit(
                  fontSize: 20.0,
                ),
                colors: [
                  Colors.black,
                  Colors.white,
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
              background: Image.asset('assets/images/countryimage.jpg',
              fit: BoxFit.cover,
              )
            ),
            backgroundColor: Colors.white,
          ),
          SliverFillRemaining(
            child: ListView.builder(
              itemCount: _countries.length,
              itemBuilder: (context,index) =>
                  ListTile(
                    selectedTileColor: Colors.green,
                    onTap: (){
                      Navigator.of(context).pop(_countries[index]['code']);
                    },
                    title: Center(child: Text(_countries[index]['name'],style: GoogleFonts.kanit(fontSize: 20.0,fontWeight: FontWeight.bold,),)),
                    subtitle: Divider(color: Colors.grey,thickness: 2.0,),
                  ),
            ),
          ),
        ],
      ),
    );
  }

}


