import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'loginpage.dart';
import'signuppage.dart';
import'homepage.dart';
import 'resetpassword.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getflutter/getflutter.dart';

import 'storage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      routes:<String, WidgetBuilder> {
    '/loginpage':(BuildContext context)=>  LoginPage(),
    '/signup':(BuildContext context)=> SignupPage(),
        '/homepage':(BuildContext context)=> HomePage(),
        '/resetpassword':(BuildContext context)=>  ResetPassword(),
        '/storage':(BuildContext context)=>  Storage(),
    },
    );
  }
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer( Duration(seconds: 5),(){
      FirebaseAuth.instance.currentUser().then((user)
      {
        if(user==null) {
          Navigator.of(context)
              .pushReplacementNamed('/loginpage');
        }
        else{
          Navigator.of(context)
              .pushReplacementNamed('/homepage');
        }
      });

    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        fit:StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color:Colors.lightBlue[800]),

          ),
          Column(
            mainAxisAlignment:MainAxisAlignment.start,
            children:<Widget>[
              Expanded(
                flex:2,
                child:Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children:<Widget>[
                    Image(
                      image:AssetImage('android/images/doctor.png')
                    ),
                 Padding(
                   padding:EdgeInsets.only(top:10.0),
                 ),
                    Text(
                      'DoctorAppointment',style: GoogleFonts.signika(
                      color:Colors.white,
                      fontSize:25.0,
                      fontWeight: FontWeight.bold
                    ),
                    )
                  ]
                )
              ),
              Expanded(
                flex:1,
                child:Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: <Widget>[
                    GFLoader(
                   type:GFLoaderType.ios,
                   ),
                    Padding(
                      padding:EdgeInsets.only(top:20.0),
                    ),
                    Center(
                      child: Text(" Now accessing appointments\n made easy ",style:GoogleFonts.signika(
                        color:Colors.white,fontSize:14.0,fontWeight:FontWeight.bold),
                      ),
                    )
    ],),
    )

                ],
      )
             ] )

          );



  }
}

