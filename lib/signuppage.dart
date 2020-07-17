import 'package:doctorappointmentmodule/services/usermanagement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        body:Form(
            key: _formKey,
            child:Container(
                padding: EdgeInsets.all(25.0),
                child:Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                            decoration: InputDecoration(labelText:'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(!EmailValidator.validate(value)){
                              return'Please enter a valid email';

                            }
                            return null;

                          },
                          onSaved: (value)=>_email=value,
                        ),
                        SizedBox(height:15.0),
                        TextFormField(
                            decoration: InputDecoration(hintText:'Password'),
                          validator:(value){
                            if(value.isEmpty){
                              return 'Invalid Password';
                            }
                            return null;
                          },
                          onSaved:(value)=>_password=value,

                          obscureText: true,

                        ),
                        SizedBox(height :20.0),
                        RaisedButton(
                          child:Text('Sign Up'),
                          color:Colors.blue,
                          textColor:Colors.white,
                          elevation: 7.0,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                  email: _email,
                                  password: _password
                              ).then((AuthResult) async {
                                FirebaseUser newUser = await FirebaseAuth
                                    .instance.currentUser();
                                UserManagement().storeNewUser(newUser, context);
                                newUser.sendEmailVerification();
                              }).catchError((e) {
                                print(e);
                              });
                            }
                          }
                        ),

                      ],
                    ),
                  ),
                )
            )
        )

    ) ;
  }
}
