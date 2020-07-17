import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:email_validator/email_validator.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(25.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(

                      decoration: InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value){
                        if(!EmailValidator.validate(value)){
                          return'Please enter a valid email';

                        }
                        return null;

                      },
                      onSaved: (value)=>_email=value,

                    ),
                    SizedBox(height: 15.0),
                    TextFormField(

                      decoration: InputDecoration(labelText: 'Password'),
                      validator:(value){
                        if(value.isEmpty){
                          return 'Invalid Password';
                        }
                        return null;
                      },
                      onSaved:(value)=>_password=value,

                      obscureText: true,

                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        child: Text('Login'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        color: Colors.blue,
                        textColor: Colors.white,
                        elevation: 7.0,
                        onPressed: () {

                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();

                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: _email, password: _password)
                                .then((AuthResult) async {
                              FirebaseUser user =
                                  await FirebaseAuth.instance.currentUser();
                              if (user.isEmailVerified) {
                                Navigator.of(context)
                                    .pushReplacementNamed('/homepage');
                              }
                            }).catchError((e) {
                              switch(e.code){
                                case "ERROR_WRONG_PASSWORD":
                                  Alert(
                                    context: context,
                                    type: AlertType.error,
                                    title: "Wrong Password",
                                    desc:'Please enter a valid password',
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "Ok",
                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        width: 120,
                                      )
                                    ],
                                  ).show();
                                  break;
                                case "ERROR_USER_NOT_FOUND":
                                  Alert(
                                    context: context,
                                    type: AlertType.error,
                                    title: "User Not Found",
                                    desc: "Please try again",
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "Ok",
                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        width: 120,
                                      )
                                    ],
                                  ).show();
                                  break;
                              }
                            });
                          }
                        }),
                    SizedBox(
                      height: 15.0,
                    ),
                    InkWell(
                      child: Center(
                        child: Text('Forgot Password?',
                        style:TextStyle(
                          color:Colors.grey,
                          fontWeight: FontWeight.bold
                        )),

                      ),

                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/resetpassword');
                      },
                    ),
                    SizedBox(height: 150.0),
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Don\'t have an account?'),
                        InkWell(
                            child: Center(
                              child: Text('SignUp',
                             style:TextStyle(
                               color:Colors.blue,
                               fontWeight: FontWeight.bold

                             ) ),
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/signup');
                            }),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
