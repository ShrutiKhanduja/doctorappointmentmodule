import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

String _email;


class _ResetPasswordState extends State<ResetPassword> {
  static final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    final pHeight=MediaQuery.of(context).size.height;
    final pWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,

      body:

      Stack(
        children: <Widget>[
          Positioned(
            top:0.0,
            right:0.0,
            child:Container(
              height:pHeight*0.17,
              width:pWidth*0.35,
              decoration:BoxDecoration(
                color:Colors.lightBlue[800],
                borderRadius:BorderRadius.only(
                  bottomLeft:Radius.circular(pHeight*0.3),
                ),
              ),
            ),
          ),
          Positioned(
              top:16.0,
              right:16.0,
              child:
              Container(

                child: Image(
                    image:AssetImage('android/images/injection.png')
                ),
              )

          ),
          Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.all(25.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: Image(

                        image: AssetImage('android/images/heart4.png')

                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('PATIENT',
                      style:TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue[800],

                      ),

                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Email',
                        prefixIcon:Icon(Icons.email),
                        enabledBorder:OutlineInputBorder(
                          borderRadius:BorderRadius.circular(30),
                          borderSide:BorderSide(
                              color:Colors.lightBlue[800],
                              width:2.0
                          ),),
                        border:OutlineInputBorder(
                            borderRadius:BorderRadius.circular(30),
                            borderSide:BorderSide(
                                color:Colors.lightBlue[800],
                                width:3.0
                            )
                        ) ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (!EmailValidator.validate(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (value) => _email = value,
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width:400.0,
                    child: RaisedButton(
                      child: Text('Reset Password'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        color: Colors.lightBlue[800],
                        textColor: Colors.white,
                        elevation: 7.0,

                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          FirebaseAuth mAuth = FirebaseAuth.instance;
                          await mAuth.sendPasswordResetEmail(email: _email);
                        }

                      }
                    ),
                  ),
                ]),
          ),
        ),
  ],
      ),

    );
  }
}
