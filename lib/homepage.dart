import 'package:cloud_firestore/cloud_firestore.dart';
import'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'services/Crud.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add,
              color: Colors.white,),
                onPressed: () {
                  addDialog(context);
                }

            )
          ],
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            StreamBuilder(
                stream: Firestore.instance.collection('Doctor').snapshots(),
                builder: _doctorList

            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                child:Text('Sign out'),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0)),
    color: Colors.lightBlue[800],
    textColor: Colors.white,
    elevation: 7.0,
              onPressed: (){
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed('/loginpage');
              },),
            ),
            SizedBox(height: 10.0),
            InkWell(
              child: Center(
                child: Text('Store files here',
                    style:TextStyle(
                        color:Colors.grey,
                        fontWeight: FontWeight.bold
                    )),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed('/storage');
              },
            ),


          ],
        )
    );
  }

    Widget _doctorList(BuildContext context,
        AsyncSnapshot<QuerySnapshot>snapshot) {
      if (snapshot.hasData) {
        return Expanded(
          child: SizedBox(
            height:200.0,
            child: ListView.builder(
              itemCount: snapshot.data.documents.length,
              padding: EdgeInsets.all(5.0),
              itemBuilder: (context, i) {
                DocumentSnapshot doctors = snapshot.data.documents[i];
                return ListTile(
                  title: Text(doctors.data['Doctor\'s name']),
                  subtitle: Text(doctors.data['Specialisation']),

                );
              },
            ),
          ),
        );
      }
    }



  QuerySnapshot doctors;
  String patientName;
  String disease;
  crudMethods crudObj = new crudMethods();

  Future<bool> addDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add details', style: TextStyle(fontSize: 15.0)),
            content: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: 'Enter Patient Name'),
                  onChanged: (value) {
                    this.patientName = value;
                  },
                ),
                SizedBox(height: 5.0),
                TextField(
                  decoration: InputDecoration(
                      hintText: 'Enter the specialist searching for'),
                  onChanged: (value) {
                    this.disease = value;
                  },
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Done'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  Map <String, dynamic> patientData = {
                    'PatientName': this.patientName,
                    'Specialist Searching': this.disease
                  };
                  crudObj.addData(patientData).then((result) {
                    dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },

              )
            ],
          );
        });
  }


  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Done', style: TextStyle(fontSize: 15.0)),
              content: Text('Added'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Alright'),
                  textColor: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ]
          );
        });
  }
}





