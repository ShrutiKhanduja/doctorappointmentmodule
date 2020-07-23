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
   static final _formKey = GlobalKey<FormState>();
   bool _passwordObscured;
  @override
void initState(){
    _passwordObscured=true;
  }
  Widget build(BuildContext context) {
    final pHeight=MediaQuery.of(context).size.height;
    final pWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
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
            padding: EdgeInsets.all(25.0),
            child: Center(
              child:
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: Image(
                            image: AssetImage('android/images/heart4.png',)
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
                         ),
                       ) ,
                    border:OutlineInputBorder(
                      borderRadius:BorderRadius.circular(30),
                      borderSide:BorderSide(
                        color:Colors.lightBlue[800],
                        width:3.0
                      )
                    )
                        ),
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
                        decoration: InputDecoration(hintText: 'Password',
                          prefixIcon:Icon(Icons.lock),
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
                            ),
                        suffixIcon:IconButton(
                          icon:Icon(
                            _passwordObscured?Icons.visibility_off:Icons.visibility,
                            color:Colors.grey
                          ),
                          onPressed:(){
                            setState(() {
                              _passwordObscured=!_passwordObscured;
                            });
                          }
                         )
                        ),
                        validator:(value){
                          if(value.isEmpty){
                            return 'Invalid Password';
                          }
                          return null;
                        },
                        onSaved:(value)=>_password=value,
                        obscureText: _passwordObscured,

                      ),
                      SizedBox(height: 20.0),
                      Container(
                        width: 400.0,
                        height:45.0,
                        child: RaisedButton(
                            child: Text('Login',
                            style: TextStyle(
                              fontSize: 15.0
                            )),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            color: Colors.lightBlue[800],
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
                      ),
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
                      SizedBox(height:70.0),
                      Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Don\'t have an account?'),
                          SizedBox(
                            width:5.0
                          ),
                          InkWell(
                              child: Center(
                                child: Text('SignUp',
                               style:TextStyle(
                                 color:Colors.lightBlue[800],
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
            ),
          ),
  ],
      ),
        );
  }
}
