import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';
import 'package:emojis/emojis.dart'; // to use Emoji collection
import 'package:emojis/emoji.dart'; // to use Emoji utilities
import 'globalcovid.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Countrycovid extends StatefulWidget {
  @override
  _CountrycovidState createState() => _CountrycovidState();
}

class _CountrycovidState extends State<Countrycovid> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
     body: SingleChildScrollView(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           FutureBuilder(
                   future: http.get('https://corona.lmao.ninja/v2/countries/$countryvalue?yesterday=false'),
                   builder: (context,snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting ?
                        Column( mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          CircularProgressIndicator(),
                        ],) :
                        snapshot.hasData ?
                            Column(
                              children: [
                                AppBar(
                                  iconTheme: IconThemeData(color: Colors.black),
                                  toolbarHeight: 150.0,
                                  title: Text('$countryvalue CovidUpdate',style: GoogleFonts.kanit(),),
                                  centerTitle: true,
                                ),
                                Text('Today',style: GoogleFonts.kanit(fontSize: 20.0,fontWeight: FontWeight.bold),),
                                DataTable(
                                  columnSpacing: 100.0,
                                  columns: [
                                    DataColumn(label: Text('')),
                                    DataColumn(label: Text('')),
                                  ],
                                  rows: [
                                    DataRow(cells: [
                                      DataCell(Text('1. Cases')),
                                      DataCell(Text(json.decode(snapshot.data.body)['cases'].toString())),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('2. Deaths')),
                                      DataCell(Text(json.decode(snapshot.data.body)['deaths'].toString())),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('3. Recovered')),
                                      DataCell(Text(json.decode(snapshot.data.body)['recovered'].toString())),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('4. Active')),
                                      DataCell(Text(json.decode(snapshot.data.body)['active'].toString())),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('5. TodayCases')),
                                      DataCell(Text(json.decode(snapshot.data.body)['todayCases'].toString())),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('6. TodayDeaths')),
                                      DataCell(Text(json.decode(snapshot.data.body)['todayDeaths'].toString())),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('6. TodayRecovery')),
                                      DataCell(Text(json.decode(snapshot.data.body)['todayRecovered'].toString())),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('7. Critical')),
                                      DataCell(Text(json.decode(snapshot.data.body)['critical'].toString())),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('8. Tests')),
                                      DataCell(Text(json.decode(snapshot.data.body)['tests'].toString())),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('10. $countryvalue Population')),
                                      DataCell(Text(json.decode(snapshot.data.body)['population'].toString())),
                                    ]),
                                  ],
                                ),
                              ],
                            ) : Center(child: Container(),)
               ),
           FutureBuilder(
               future: http.get('https://corona.lmao.ninja/v2/countries/$countryvalue?yesterday=true'),
               builder: (context,snapshot) =>
               snapshot.connectionState == ConnectionState.waiting ?
               Container() :
               snapshot.hasData ?
               Column(
                 children: [
                   Text('Yesterday',style: GoogleFonts.kanit(fontWeight: FontWeight.bold,fontSize: 20.0),),
                   DataTable(
                     columnSpacing: 100.0,
                     columns: [
                       DataColumn(label: Text('')),
                       DataColumn(label: Text('')),
                     ],
                     rows: [
                       DataRow(cells: [
                         DataCell(Text('1. Cases')),
                         DataCell(Text(json.decode(snapshot.data.body)['cases'].toString())),
                       ]),
                       DataRow(cells: [
                         DataCell(Text('2. Deaths')),
                         DataCell(Text(json.decode(snapshot.data.body)['deaths'].toString())),
                       ]),
                       DataRow(cells: [
                         DataCell(Text('3. Recovered')),
                         DataCell(Text(json.decode(snapshot.data.body)['recovered'].toString())),
                       ]),
                       DataRow(cells: [
                         DataCell(Text('4. Active')),
                         DataCell(Text(json.decode(snapshot.data.body)['active'].toString())),
                       ]),
                       DataRow(cells: [
                         DataCell(Text('5. TodayCases')),
                         DataCell(Text(json.decode(snapshot.data.body)['todayCases'].toString())),
                       ]),
                       DataRow(cells: [
                         DataCell(Text('6. TodayDeaths')),
                         DataCell(Text(json.decode(snapshot.data.body)['todayDeaths'].toString())),
                       ]),
                       DataRow(cells: [
                         DataCell(Text('6. TodayRecovery')),
                         DataCell(Text(json.decode(snapshot.data.body)['todayRecovered'].toString())),
                       ]),
                       DataRow(cells: [
                         DataCell(Text('7. Critical')),
                         DataCell(Text(json.decode(snapshot.data.body)['critical'].toString())),
                       ]),
                       DataRow(cells: [
                         DataCell(Text('8. Tests')),
                         DataCell(Text(json.decode(snapshot.data.body)['tests'].toString())),
                       ]),
                       DataRow(cells: [
                         DataCell(Text('10. $countryvalue Population')),
                         DataCell(Text(json.decode(snapshot.data.body)['population'].toString())),
                       ]),
                     ],
                   ),
                 ],
               ) : Center(child: Container(),)
           ),
         ],
       ),
     ),
    )
    );
  }
}
