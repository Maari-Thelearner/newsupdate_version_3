import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsupdate_newversion/home.dart';
import 'package:newsupdate_newversion/blocs/auth_bloc.dart';
import 'package:newsupdate_newversion/register.dart';
import 'package:newsupdate_newversion/services/auth_service.dart';
import 'package:provider/provider.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  StreamSubscription<User> loginStateSubscription;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = new TextEditingController();
    final TextEditingController password = new TextEditingController();
    final authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ColorizeAnimatedTextKit(
                repeatForever: true,
                pause: Duration(milliseconds: 200),
                text: [
                  "NewsUpdate",
                  "NewsUpdate",
                  "NewsUpdate",
                ],
                textStyle: GoogleFonts.kanit(
                  fontSize: 40.0,
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
              GestureDetector(
                onTap: (){
                  showDialog(
                    barrierColor: Colors.blueGrey,
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(icon: Icon(FontAwesomeIcons.timesCircle,color: Colors.red,), onPressed: (){
                                Navigator.pop(context);
                              }),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ColorizeAnimatedTextKit(
                                repeatForever: true,
                                pause: Duration(milliseconds: 200),
                                text: [
                                  "Login",
                                  "Login",
                                  "Login",
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
                            ],
                          ),
                        ],
                      ),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Form(
                                key: formkey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: email,
                                      validator: (String val){
                                        if(val.isEmpty){
                                          return 'Please Enter the email';
                                        }else if(!val.contains('@')){
                                          return 'please enter valid email';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(FontAwesomeIcons.userAlt,),
                                        filled: true,
                                        labelText: 'UserEmail',
                                        labelStyle: GoogleFonts.kanit(color: Colors.blue[900]),
                                        hintText: 'Enter the Email ID',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.transparent),
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(),
                                          borderRadius: BorderRadius.all(Radius.circular(30)),

                                        ),
                                      ),
                                    ),
                                   SizedBox(height: 20.0,),
                                   TextFormField(
                                     controller: password,
                                     keyboardType: TextInputType.visiblePassword,
                                     validator: (String val){
                                       if(val.isEmpty){
                                         return 'Please Enter the email';
                                       }else if(val.length < 6)
                                         {
                                           return 'Length of your password atleast six';
                                         }
                                       return null;
                                     },
                                     obscureText: true,
                                     decoration: InputDecoration(
                                       prefixIcon: Icon(FontAwesomeIcons.key,),
                                       filled: true,
                                       labelText: 'Password',
                                       labelStyle: GoogleFonts.kanit(color: Colors.blue[900]),
                                       hintText: 'Enter the Password',
                                       enabledBorder: OutlineInputBorder(
                                         borderSide: BorderSide(color: Colors.transparent),
                                         borderRadius: BorderRadius.all(Radius.circular(20)),
                                       ),
                                       focusedBorder: OutlineInputBorder(
                                         borderSide: BorderSide(),
                                         borderRadius: BorderRadius.all(Radius.circular(30)),

                                       ),
                                     ),
                                   ),
                                    SizedBox(height: 20.0,),
                                   /* RaisedButton(onPressed: () {
                                      AuthService().signup(
                                          email.text.trim(), password.text.trim());
                                    }
                                      , child: Text('Create'),
                                    ),*/
                                    RaisedButton(onPressed: () {
                                      if(formkey.currentState.validate()){
                                        AuthService().signin(
                                            email.text.trim(), password.text.trim());
                                      }
                                      email.clear();
                                      password.clear();
                                    }
                                      ,color: Colors.blue[400], child: Text('Login',style: GoogleFonts.kanit(color: Color(0xFFFFFFFF)),),
                                    ),
                                    SizedBox(height: 20.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                            onTap: (){
                                              email.clear();
                                              password.clear();
                                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                                return Register();
                                              }));
                                            },
                                            child: Text('Register',style: GoogleFonts.kanit(fontSize: 18.0),)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            Divider(thickness: 2.0,color: Colors.grey,),
                            SignInButton(
                              Buttons.GoogleDark,
                              onPressed: () => authBloc.loginGoogle(),
                            ),
                          ],
                        ),
                      ),

                    ),
                  );
                },
                child: Image.asset('assets/icon/icon.png',
                height: 200.0,
                  width: 200.0,
                ),
              ),
          SizedBox(
            width: 200.0,
            child: TextLiquidFill(
              text: 'Click Newspaper\n     Get Started',
              waveColor: Colors.blueAccent,
              textStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              boxBackgroundColor: Colors.white60,
              boxHeight: 100.0,
            ),
          ),
            ],
          ),
        )
    );
  }

}

