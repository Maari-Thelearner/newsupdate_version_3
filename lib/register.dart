import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsupdate_newversion/services/auth_service.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height*0.6,
          width: MediaQuery.of(context).size.width*0.8,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 20.0,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ColorizeAnimatedTextKit(
                        repeatForever: true,
                        pause: Duration(milliseconds: 200),
                        text: [
                          "Register",
                          "Register",
                          "Register",
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
                  SizedBox(height: 40.0,),
                  Form(
                    key: form,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                              prefixIcon: Icon(FontAwesomeIcons.userAlt),
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
                            validator: (String val){
                              if(val.isEmpty){
                                return 'please enter the password';
                              }else if(val.length < 6)
                              {
                                return 'Length of your password atleast six';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              prefixIcon: Icon(FontAwesomeIcons.key),
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
                          RaisedButton(
                            elevation: 10.0,
                            color: Colors.green,
                            onPressed: () {
                              if (form.currentState.validate()) {
                                AuthService().signup(
                                    email.text.trim(), password.text.trim());
                              }
                              email.clear();
                              password.clear();
                            }
                            , child: Text('Register',style: GoogleFonts.kanit(color: Colors.white),),
                          ),
                          SizedBox(height: 20.0,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }
}
