import 'dart:async';
import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsupdate_newversion/blocs/auth_bloc.dart';
import 'package:newsupdate_newversion/login.dart';
import 'package:newsupdate_newversion/theme.dart';
import 'package:newsupdate_newversion/webview.dart';
import 'package:provider/provider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsupdate_newversion/countries.dart';
import 'package:http/http.dart'as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'CovidUpdate/globalcovid.dart';
import 'drawercontent/AboutUs.dart';
var categories = 'general';
var change = 'no';
var url;
var _defaultCountrycode='in';
final FirebaseAuth _auth = FirebaseAuth.instance;
String username = _auth.currentUser.email.toString();
final FirebaseFirestore DBreference = FirebaseFirestore.instance;
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
final TextEditingController Nickname= TextEditingController();
class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  StreamSubscription<User> loginStateSubscription;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 74, vsync: this)
      ..addListener(() {
        setState(() {

        });
      });
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser == null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return LoginScreen();
        }));
      }
    });
  }

  final Completer<WebViewController> _completer = Completer<
      WebViewController>();

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  var googleuserimage;
  var googleusername;
  var googleuseremail;
  var useremail;

  Widget build(BuildContext context) {
    CollectionReference ref = Firestore.instance.collection(
        '${_auth.currentUser.email.toString()}');
    final authBloc = Provider.of<AuthBloc>(context);
    return new Scaffold(
      body: FutureBuilder(
        future: change == 'no'
            ? http.get(
            'http://newsapi.org/v2/top-headlines?country=$_defaultCountrycode&category=general&apiKey=50cd87a239064bb39c8d5c4343253080')
            : http.get(
            'http://newsapi.org/v2/top-headlines?country=$_defaultCountrycode&category=$categories&apiKey=50cd87a239064bb39c8d5c4343253080'),
        builder: (context, AsyncSnapshot newsData) =>
        newsData.connectionState == ConnectionState.waiting ?
        Center(
          child: CircularProgressIndicator(),
        ) : newsData.hasData ?
        CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200.0,
              pinned: true,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                  title: ColorizeAnimatedTextKit(
                    repeatForever: true,
                    speed: Duration(milliseconds: 300),
                    pause: Duration(milliseconds: 200),
                    text: [
                      "NewsUpdate - $categories",
                      "NewsUpdate - $categories",
                      "NewsUpdate - $categories",
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
                  background: Image.asset('assets/images/menuimages.jpg',
                    fit: BoxFit.cover,
                  )
              ),
              /*actions: [
              IconButton(
                icon: Icon(Icons.brightness_6),
                onPressed: (){
                  ThemeProvider themeProvider = Provider.of<ThemeProvider>(context , listen: false);
                  themeProvider.swapTheme();
                },
              )
            ],*/
            ),
            SliverFillRemaining(
              fillOverscroll: true,
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: json.decode(newsData.data.body)['articles'].length,
                itemBuilder: (context, index) =>
                    Card(
                      borderOnForeground: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 20.0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            url = json.decode(
                                newsData.data.body)['articles'][index]['url'];
                            Navigator.pushReplacement(
                              context, MaterialPageRoute(
                                builder: (context) {
                                  return ChangeNotifierProvider(
                                    create: (_) => ThemeNotifier(),
                                    child: Consumer<ThemeNotifier>(
                                      builder: (context, ThemeNotifier notifier, child) {
                                        return MaterialApp(
                                          debugShowCheckedModeBanner: false,
                                          theme: notifier.darkTheme ? dark : light,
                                          home: Scaffold(
                                            appBar: AppBar(
                                              leading: IconButton(icon: Icon(
                                                Icons.arrow_back,),
                                                  onPressed: () {
                                                    Navigator.pushReplacement(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                              return Home();
                                                            }));
                                                  }),
                                              title: ColorizeAnimatedTextKit(
                                                repeatForever: true,
                                                pause: Duration(milliseconds: 200),
                                                text: [
                                                  "News",
                                                  "News",
                                                  "News",
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
                                              actions: [
                                                Builder(
                                                  builder: (context) =>
                                                      IconButton(icon: Icon(Icons.copy,
                                                        ),
                                                        onPressed: () async {
                                                          await FlutterClipboard.copy(
                                                              'This Url Link is from \'NewsUpdate App\' \n'
                                                                  '   Here is the news link!! \n'
                                                                  '${url.toString()}');
                                                          Scaffold.of(context)
                                                              .showSnackBar(SnackBar(
                                                            content: Text(
                                                                'Link is Copied'),));
                                                        },
                                                      ),
                                                ),
                                              ],
                                            ),
                                            body: WebView(
                                              initialUrl: url,
                                              javascriptMode: JavascriptMode
                                                  .unrestricted,
                                              onWebViewCreated: ((
                                                  WebViewController webViewController) {
                                                setState(() {
                                                  _completer.complete(
                                                      webViewController);
                                                });
                                              }),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }),);
                          },

                          child: Column(
                            children: [
                              Text('Source from - ${json.decode(newsData.data
                                  .body)['articles'][index]['source']['name']
                                  .toString()}'),
                              Image.network(
                                json.decode(
                                    newsData.data.body)['articles'][index]
                                ['urlToImage'] ??
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png",
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;
                                  return Container(
                                    height: 200,
                                    width: double.infinity,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: progress.expectedTotalBytes !=
                                            null
                                            ? progress.cumulativeBytesLoaded /
                                            progress.expectedTotalBytes
                                            : null,
                                      ),
                                    ),
                                  );
                                },

                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(json.decode(newsData.data
                                  .body)['articles'][index]['title'],
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20.0),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(FontAwesomeIcons.solidBookmark),
                                    color: Colors.blue[900],
                                    onPressed: () {
                                      String newstitle = json.decode(
                                          newsData.data
                                              .body)['articles'][index]['title'];
                                      String newsurl = json.decode(newsData.data
                                          .body)['articles'][index]['url'];
                                      String newsimage = json.decode(
                                          newsData.data
                                              .body)['articles'][index]['urlToImage'] ??
                                          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png";
                                      ref.add({
                                        'title': newstitle,
                                        'newsurl': newsurl,
                                        'newsimage': newsimage,
                                      }).whenComplete(() =>
                                          Scaffold.of(context).showSnackBar(
                                              SnackBar(content: Text(
                                                  'Bookmarked!!'))));
                                    },
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

              ),
            ),
          ],
        ) : Center(
          child: CircularProgressIndicator(),
        ),
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            StreamBuilder<User>(
                stream: authBloc.currentUser,
                builder: (context, snapshots) {
                  if (snapshots.hasData) {
                    if (snapshots.data.photoURL == null) {
                      useremail = snapshots.data.email;
                      return UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(image: AssetImage(
                              'assets/images/menuimages.jpg')
                            , fit: BoxFit.cover,
                          ),
                        ),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/images/userimage.jpg'),
                          radius: 40.0,
                        ),
                        accountName: Text('Anonymous Login',
                            style: GoogleFonts.kanit(fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.black)),
                        accountEmail: Text(snapshots.data.email.toString(),
                            style: GoogleFonts.kanit(fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,)),
                      );
                    }
                    else if (snapshots.data.photoURL != null) {
                      googleuseremail = snapshots.data.email;
                      googleusername = snapshots.data.displayName;
                      googleuserimage = snapshots.data.photoURL;
                      return UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(image: AssetImage(
                              'assets/images/menuimages.jpg')
                            , fit: BoxFit.cover,
                          ),
                        ),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: NetworkImage(snapshots.data
                              .photoURL),
                          radius: 40.0,
                        ),

                        accountName:
                        Text(snapshots.data.displayName.toString(),
                            style: GoogleFonts.kanit(fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,)),
                        accountEmail: Text(snapshots.data.email.toString(),
                            style: GoogleFonts.kanit(fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,)),
                      );
                    }
                  }
                  else if (!snapshots.hasData) {
                    if (googleuserimage == null) {
                      return UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(image: AssetImage(
                              'assets/images/menuimages.jpg')
                            , fit: BoxFit.cover,
                          ),
                        ),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/images/userimage.jpg'),
                          radius: 40.0,
                        ),
                        accountName:
                        Text('Anonymous login', style: GoogleFonts.kanit(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,)),
                        accountEmail: Text(useremail.toString(),
                            style: GoogleFonts.kanit(fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,)),
                      );
                    }
                    else if (googleuserimage != null) {
                      return UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(image: AssetImage(
                              'assets/images/menuimages.jpg')
                            , fit: BoxFit.cover,
                          ),
                        ),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: NetworkImage(googleuserimage),
                          radius: 40.0,
                        ),
                        accountName:
                        Text(googleusername.toString(),
                            style: GoogleFonts.kanit(fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,)),
                        accountEmail: Text(googleuseremail.toString(),
                            style: GoogleFonts.kanit(fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,)),
                      );
                    }
                  }
                  return CircularProgressIndicator();
                }
            ),


            ListTile(
              title: Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) =>
                      SwitchListTile(
                        activeColor: Colors.white,
                        activeTrackColor: Colors.red,
                        inactiveThumbColor: Colors.black,
                        inactiveTrackColor: Colors.green,
                        onChanged: (val) {
                          notifier.toggleTheme();
                        },
                        value: notifier.darkTheme,
                      ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.newspaper),
              title: Text(
                'Categories', style: GoogleFonts.kanit(fontSize: 25.0,),),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) =>
                      AlertDialog(
                        title:ColorizeAnimatedTextKit(
                          repeatForever: true,
                          pause: Duration(milliseconds: 200),
                          text: [
                            "Categories",
                            "Categories",
                            "Categories",
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
                        content: Column(
                          children: [
                            FlatButton(
                                onPressed: () {
                                  setState(() {
                                    categories = 'general';
                                    change = 'yes';
                                  });
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                        return Home();
                                      }));
                                }, child: Text('General')),
                            Divider(color: Colors.grey, thickness: 2.0,),
                            FlatButton(onPressed: () {
                              setState(() {
                                categories = 'entertainment';
                                change = 'yes';
                              });
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                    return Home();
                                  }));
                            }, child: Text('Entertainment')),
                            Divider(color: Colors.grey, thickness: 2.0,),
                            FlatButton(onPressed: () {
                              setState(() {
                                categories = 'sports';
                                change = 'yes';
                              });
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                    return Home();
                                  }));
                            }, child: Text('Sports')),
                            Divider(color: Colors.grey, thickness: 2.0,),
                            FlatButton(onPressed: () {
                              setState(() {
                                categories = 'technology';
                                change = 'yes';
                              });
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                    return Home();
                                  }));
                            }, child: Text('Technology')),
                            Divider(color: Colors.grey, thickness: 2.0,),
                            FlatButton(onPressed: () {
                              setState(() {
                                categories = 'science';
                                change = 'yes';
                              });
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                    return Home();
                                  }));
                            }, child: Text('Science')),
                            Divider(color: Colors.grey, thickness: 2.0,),
                            FlatButton(onPressed: () {
                              setState(() {
                                categories = 'health';
                                change = 'yes';
                              });
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                    return Home();
                                  }));
                            }, child: Text('Health')),
                            Divider(color: Colors.grey, thickness: 2.0,),
                            FlatButton(onPressed: () {
                              setState(() {
                                categories = 'business';
                                change = 'yes';
                              });
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                    return Home();
                                  }));
                            }, child: Text('Business')),
                          ],
                        ),
                        actions: [
                          FlatButton(onPressed: () {
                            Navigator.pop(context);
                          }, child: Text('cancel', style: GoogleFonts.kanit(
                              fontWeight: FontWeight.bold, fontSize: 18.0),)),
                        ],
                      ),
                );
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.locationArrow),
              title: Text(
                'Location', style: GoogleFonts.kanit(fontSize: 25.0,),),
              onTap: () async {
                var countrycode = await Navigator.push(
                    context, MaterialPageRoute(builder: (context) {
                  return Countries();
                }));
                if (countrycode
                    .toString()
                    .isNotEmpty) {
                  setState(() {
                    _defaultCountrycode = countrycode;
                  });
                }
                else if (countrycode
                    .toString()
                    .isEmpty) {
                  setState(() {
                    _defaultCountrycode = 'in';
                  });
                }
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.solidBookmark),
              title: Text(
                'Bookmarks', style: GoogleFonts.kanit(fontSize: 25.0),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Bookmark();
                }));
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.virus),
              title: Text(
                'CovidUpdate', style: GoogleFonts.kanit(fontSize: 25.0),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return GlobalCovid();
                }));
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.addressCard),
              title: Text(
                'AboutUs', style: GoogleFonts.kanit(fontSize: 25.0,),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Aboutus();
                }));
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.signOutAlt),
              title: Text('Logout', style: GoogleFonts.kanit(fontSize: 25.0,),),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) =>
                      AlertDialog(
                        title: Text('Are you sure you want to Logout ?',
                          style: GoogleFonts.kanit(),),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                authBloc.logout();
                              },
                              child: Text('Yes', style: GoogleFonts.kanit(
                                  fontSize: 20.0,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(width: 20.0,),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text('No', style: GoogleFonts.kanit(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontSize: 20.0),),
                            ),
                          ],
                        ),

                      ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
