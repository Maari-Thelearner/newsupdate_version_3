import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class CovidState extends StatefulWidget {
  @override
  _CovidStateState createState() => _CovidStateState();
}

class _CovidStateState extends State<CovidState> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('Covid India'),
        backgroundColor: Colors.blue[900],
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: http.get('https://api.covid19india.org/state_district_wise.json'),
              builder: (context, snapshot){
              if(snapshot.hasData){
                return Column(
                  children: [
                    Text(json.decode(snapshot.data.body)['State Unassigned']['Andaman and Nicobar Islands']['']),
                  ],
                );
              }
              else if(snapshot.hasError){
                return Text('Sorry error');
              }
              return Center(child: Text('hello'),);
              }),
        ],
      ),
    ));
  }
}
