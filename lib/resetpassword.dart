import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}
String _email;
class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Center(child: Text('Reset Password')),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        margin: EdgeInsets.all(25.0),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
                decoration: InputDecoration(hintText: 'Email'),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                }
             ),

    SizedBox(height :20.0),
    RaisedButton(
    child:Text('Reset Password'),
    color:Colors.blue,
    textColor:Colors.white,
    elevation: 7.0,
        onPressed:()async {
          FirebaseAuth mAuth= FirebaseAuth.instance;
            await mAuth.sendPasswordResetEmail(email: _email);

          }

,   ),]
        ),
      ),);
  }
}