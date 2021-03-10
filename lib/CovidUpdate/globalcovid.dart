import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:newsupdate_newversion/CovidUpdate/countrycovid.dart';
String countryvalue;
Future<Covid> fetchData() async{
  final response = await http.get('https://disease.sh/v3/covid-19/all?yesterday=false');
  if(response.statusCode == 200)
  {
    return Covid.fromJson(json.decode(response.body));
  }
  else
  {
    throw Exception('Failed to load Covid');
  }
}
Future<Covidyesterday> fetchData_y() async{
  final response = await http.get('https://disease.sh/v3/covid-19/all?yesterday=true');
  if(response.statusCode == 200)
  {
    return Covidyesterday.fromJson(json.decode(response.body));
  }
  else
  {
    throw Exception('Failed to load Covid');
  }
}
class Covid{
  final int cases;
  final int deaths;
  final int recovered;
  final int active;
  final int updated;
  final int todayCases;
  final int todayDeaths;
  final int todayRecovered;
  final int critical;
  final int population;
  final int tests;
  final int affectedCountries;
  Covid({this.cases, this.deaths, this.recovered, this.active, this.updated , this.todayDeaths,this.todayRecovered,this.critical,this.todayCases
    ,this.tests,this.population,this.affectedCountries
  });
  factory Covid.fromJson(Map<String,dynamic> jsno){
    return Covid(
      cases: jsno['cases'],
      deaths: jsno['deaths'],
      recovered: jsno['recovered'],
      active: jsno['active'],
      updated: jsno['updated'],
      todayCases: jsno['todayCases'],
      todayDeaths: jsno['todayDeaths'],
      todayRecovered: jsno['todayRecovered'],
      critical: jsno['critical'],
      population: jsno['population'],
      tests: jsno['tests'],
      affectedCountries: jsno['affectedCountries'],
    );
  }
}
class Covidyesterday{
  final int cases;
  final int deaths;
  final int recovered;
  final int active;
  final int updated;
  final int todayCases;
  final int todayDeaths;
  final int todayRecovered;
  final int critical;
  final int population;
  final int tests;
  final int affectedCountries;
  Covidyesterday({this.cases, this.deaths, this.recovered, this.active, this.updated , this.todayDeaths,this.todayRecovered,this.critical,this.todayCases
    ,this.tests,this.population,this.affectedCountries
  });
  factory Covidyesterday.fromJson(Map<String,dynamic> jsno){
    return Covidyesterday(
      cases: jsno['cases'],
      deaths: jsno['deaths'],
      recovered: jsno['recovered'],
      active: jsno['active'],
      updated: jsno['updated'],
      todayCases: jsno['todayCases'],
      todayDeaths: jsno['todayDeaths'],
      todayRecovered: jsno['todayRecovered'],
      critical: jsno['critical'],
      population: jsno['population'],
      tests: jsno['tests'],
      affectedCountries: jsno['affectedCountries'],
    );
  }
}
class GlobalCovid extends StatefulWidget {
  @override
  _GlobalCovidState createState() => _GlobalCovidState();
}

class _GlobalCovidState extends State<GlobalCovid> {
  Future<Covid> futureCovid;
  Future<Covidyesterday> futureCovid_y;
  @override
  void initState() {
    futureCovid=fetchData();
    futureCovid_y=fetchData_y();
    super.initState();
  }
  String _dataValue(int timeInMillis)
  {
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    var formattedDate = DateFormat("dd-MM-yyyy hh:mm:ss").format(date);
    return formattedDate.toString();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<Covid>(
                future: futureCovid,
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      return Column(
                        children: [
                          AppBar(
                            iconTheme: IconThemeData(color: Colors.black),
                            toolbarHeight: 150.0,
                            title: Text('GlobalCovidUpdate',style: GoogleFonts.kanit(),),
                            centerTitle: true,
                          ),
                          DropdownSearch<String>(
                              mode: Mode.BOTTOM_SHEET,
                              popupBackgroundColor: Theme.of(context).buttonColor,
                              items: [
                                'Afghanistan',
                                'Albania',
                                'Algeria',
                                'Andorra',
                                'Angola',
                                'Antigua & Deps',
                                'Argentina',
                                'Armenia',
                                'Australia',
                                'Austria',
                                'Azerbaijan',
                                'Bahamas',
                                'Bahrain',
                                'Bangladesh',
                                'Barbados',
                                'Belarus',
                                'Belgium',
                                'Belize',
                                'Benin',
                                'Bhutan',
                                'Bolivia',
                                'Bosnia Herzegovina',
                                'Botswana',
                                'Brazil',
                                'Brunei',
                                'Bulgaria',
                                'Burkina',
                                'Burundi',
                                'Cambodia',
                                'Cameroon',
                                'Canada',
                                'Cape Verde',
                                'Central African Rep',
                                'Chad',
                                'Chile',
                                'China',
                                'Colombia',
                                'Comoros',
                                'Congo',
                                'Congo {Democratic Rep}',
                                'Costa Rica',
                                'Croatia',
                                'Cuba',
                                'Cyprus',
                                'Czech Republic',
                                'Denmark',
                                'Djibouti',
                                'Dominica',
                                'Dominican Republic',
                                'East Timor',
                                'Ecuador',
                                'Egypt',
                                'El Salvador',
                                'Equatorial Guinea',
                                'Eritrea',
                                'Estonia',
                                'Ethiopia',
                                'Fiji',
                                'Finland',
                                'France',
                                'Gabon',
                                'Gambia',
                                'Georgia',
                                'Germany',
                                'Ghana',
                                'Greece',
                                'Grenada',
                                'Guatemala',
                                'Guinea',
                                'Guinea-Bissau',
                                'Guyana',
                                'Haiti',
                                'Honduras',
                                'Hungary',
                                'Iceland',
                                'India',
                                'Indonesia',
                                'Iran',
                                'Iraq',
                                'Ireland {Republic}',
                                'Israel',
                                'Italy',
                                'Ivory Coast',
                                'Jamaica',
                                'Japan',
                                'Jordan',
                                'Kazakhstan',
                                'Kenya',
                                'Kiribati',
                                'Korea North',
                                'Korea South',
                                'Kosovo',
                                'Kuwait',
                                'Kyrgyzstan',
                                'Laos',
                                'Latvia',
                                'Lebanon',
                                'Lesotho',
                                'Liberia',
                                'Libya',
                                'Liechtenstein',
                                'Lithuania',
                                'Luxembourg',
                                'Macedonia',
                                'Madagascar',
                                'Malawi',
                                'Malaysia',
                                'Maldives',
                                'Mali',
                                'Malta',
                                'Marshall Islands',
                                'Mauritania',
                                'Mauritius',
                                'Mexico',
                                'Micronesia',
                                'Moldova',
                                'Monaco',
                                'Mongolia',
                                'Montenegro',
                                'Morocco',
                                'Mozambique',
                                'Myanmar, {Burma}',
                                'Namibia',
                                'Nauru',
                                'Nepal',
                                'Netherlands',
                                'New Zealand',
                                'Nicaragua',
                                'Niger',
                                'Nigeria',
                                'Norway',
                                'Oman',
                                'Pakistan',
                                'Palau',
                                'Panama',
                                'Papua New Guinea',
                                'Paraguay',
                                'Peru',
                                'Philippines',
                                'Poland',
                                'Portugal',
                                'Qatar',
                                'Romania',
                                'Russian Federation',
                                'Rwanda',
                                'St Kitts & Nevis',
                                'St Lucia',
                                'Saint Vincent & the Grena',
                                'San Marino',
                                'Sao Tome & Principe',
                                'Saudi Arabia',
                                'Senegal',
                                'Serbia',
                                'Seychelles',
                                'Sierra Leone',
                                'Singapore',
                                'Slovakia',
                                'Slovenia',
                                'Solomon Islands',
                                'Somalia',
                                'South Africa',
                                'South Sudan',
                                'Spain',
                                'Sri Lanka',
                                'Sudan',
                                'Suriname',
                                'Swaziland',
                                'Sweden',
                                'Switzerland',
                                'Syria',
                                'Taiwan',
                                'Tajikistan',
                                'Tanzania',
                                'Thailand',
                                'Togo',
                                'Tonga',
                                'Trinidad & Tobago',
                                'Tunisia',
                                'Turkey',
                                'Turkmenistan',
                                'Tuvalu',
                                'Uganda',
                                'Ukraine',
                                'United Arab Emirates',
                                'United Kingdom',
                                'United States',
                                'Uruguay',
                                'Uzbekistan',
                                'Vanuatu',
                                'Vatican City',
                                'Venezuela',
                                'Vietnam',
                                'Yemen',
                                'Zambia',
                                'Zimbabwe'],
                              onChanged: (value){
                               setState(() {
                                 countryvalue = value;
                               });
                              },
                              selectedItem: "Select Country",
                          ),
                          RaisedButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return Countrycovid();
                            }));
                          },
                          child: countryvalue == null ? Text('Show Country Covid Data') : Text('Show $countryvalue Covid Data'),
                          ),
                          SizedBox(height: 50.0,),
                          Center(child: Text('Today',style: GoogleFonts.kanit(fontSize: 20.0,fontWeight: FontWeight.bold),),),
                          DataTable(
                            columnSpacing: 100.0,
                            columns: [
                              DataColumn(label: Text('')),
                              DataColumn(label: Text('')),
                            ],
                            rows: [
                              DataRow(cells: [
                                DataCell(Text('1. Cases')),
                                DataCell(Text(snapshot.data.cases.toString())),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('2. Deaths')),
                                DataCell(Text(snapshot.data.deaths.toString())),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('3. Recovered')),
                                DataCell(Text(snapshot.data.recovered.toString())),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('4. Active')),
                                DataCell(Text(snapshot.data.active.toString())),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('5. TodayCases')),
                                DataCell(Text(snapshot.data.todayCases.toString())),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('6. TodayDeaths')),
                                DataCell(Text(snapshot.data.todayDeaths.toString())),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('6. TodayRecovery')),
                                DataCell(Text(snapshot.data.todayRecovered.toString())),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('7. Critical')),
                                DataCell(Text(snapshot.data.critical.toString())),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('8. TodayTests')),
                                DataCell(Text(snapshot.data.tests.toString())),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('9. Affected Countries')),
                                DataCell(Text(snapshot.data.affectedCountries.toString())),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('10. World Population')),
                                DataCell(Text(snapshot.data.population.toString())),
                              ]),
                            ],
                          ),
                        ],
                      );
                    }
                    else if(snapshot.hasError){
                      return Text('${snapshot.error}');
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
              ),
              SizedBox(height: 100.0,child: Divider(thickness: 1.0,color: Colors.grey,),),
              FutureBuilder<Covidyesterday>(
                future: futureCovid_y,
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return Column(
                      children: [
                        Center(child: Text('Yesterday',style: GoogleFonts.kanit(fontWeight: FontWeight.bold,fontSize: 20.0),),),
                        DataTable(
                          columnSpacing: 100.0,

                          columns: [
                            DataColumn(label: Text('')),
                            DataColumn(label: Text('')),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text('1. Cases')),
                              DataCell(Text(snapshot.data.cases.toString())),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('2. Deaths')),
                              DataCell(Text(snapshot.data.deaths.toString())),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('3. Recovered')),
                              DataCell(Text(snapshot.data.recovered.toString())),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('4. Active')),
                              DataCell(Text(snapshot.data.active.toString())),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('5. YesterdayCases')),
                              DataCell(Text(snapshot.data.todayCases.toString())),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('6. YesterdayDeaths')),
                              DataCell(Text(snapshot.data.todayDeaths.toString())),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('6. YesterdayRecovery')),
                              DataCell(Text(snapshot.data.todayRecovered.toString())),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('7. Critical')),
                              DataCell(Text(snapshot.data.critical.toString())),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('8. Tests')),
                              DataCell(Text(snapshot.data.tests.toString())),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('9. Affected Countries')),
                              DataCell(Text(snapshot.data.affectedCountries.toString())),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('10. World Population')),
                              DataCell(Text(snapshot.data.population.toString())),
                            ]),
                          ],
                        ),
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },),
            ],
          ),
        ),
      ),
    );
  }
}
