import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plasmabank/requisities/DonorView.dart';
import 'package:plasmabank/requisities/PatientView.dart';


class BoardPage extends StatefulWidget {
  BoardPage({this.searchedQuery,this.gender,this.bloodGroup});
  final String searchedQuery,bloodGroup,gender;
  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {

  Firestore firestore = Firestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  List<bool> isSelected = [true,false];
  int gender;

  void toggleMenu(int ind){
    setState(() {
      for(int i=0;i<2;i++)
      {
        if(i==ind)
          isSelected[i] = true;
        else
          isSelected[i] = false;
      }
    });
  }

  void getUser() async{
    _user = await _auth.currentUser();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }



  @override
  Widget build(BuildContext context) {
    gender = widget.gender=='M'?0:widget.gender=='F'?1:2;
    return Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height*0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    GestureDetector(onTap:(){toggleMenu(0);},child: Text('Donors',style: TextStyle(color: Color(0xff756d7f),fontSize: 18),)),
                    Visibility(visible: isSelected[0],child: SizedBox(width: 45,child: Divider(thickness: 2,color: Color(0xf0ff5252),))),
                  ],
                ),
                Column(
                  children: <Widget>[
                    GestureDetector(onTap:(){toggleMenu(1);},child: Text('Patients',style: TextStyle(color: Color(0xff756d7f),fontSize: 18),)),
                    Visibility(visible: isSelected[1],child: SizedBox(width: 45,child: Divider(thickness: 2,color: Color(0xf0ff5252),)))
                  ],
                )
              ],
            ),
            SizedBox(height: 20,),
              Flexible(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: isSelected[0]?(widget.searchedQuery.isEmpty?firestore.collection('donor').snapshots(): firestore.collection('donor').where("city",isEqualTo: widget.searchedQuery).where('bloodgroup',isEqualTo: widget.bloodGroup).where('gender',isEqualTo: gender).snapshots())
                          :
                      (widget.searchedQuery.isEmpty?firestore.collection('patient').snapshots(): firestore.collection('patient').where("city",isEqualTo: widget.searchedQuery).where('bloodgroup',isEqualTo: widget.bloodGroup).where('gender',isEqualTo: gender).snapshots()),
                      
                      
                      builder: (context,snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Center(child: CircularProgressIndicator());
                        }
                        if(snapshot.hasData)
                        {
                          List<Widget> usersList = [];
                          final docs = snapshot.data.documents;
                          for(var data in docs)
                          {
                            DateFormat formatter = DateFormat.yMd();
                            var name = data.data['name'];
                            var age = data.data['age'];
                            var gender = data.data['gender'];
                            var city = data.data['city'];
                            var bloodGroup = data.data['bloodgroup'];
                            var genders = ['M','F','O'];
                            var lastTested = isSelected[0]?data.data['lasttested']:data.data['lastTested'];
                            var treatment = data.data['treatment'];
                            var contact = data.data['contact'];
                            var state = data.data['state'];
                            var pincode = data.data['pincode'];
                            var bp = data.data['bp'];
                            var diabetes = data.data['diabetes'];
                            var preMedical = isSelected[0]?data.data['preMedical']:data.data['premedical'];
                            var isRecovered = data.data['isRecovered'];
                            var recoverdate = data.data['recoverdate'];
                            var relation = data.data['relation'];
                            var hospital = data.data['hospital'];
                            var created = data.data['created'];
                            var moreDetails = data.data['moredetails'];
                            var uid = data.data['uid'];
                            if(_user.uid != uid)
                              {
                                usersList.add(
                                    isSelected[0]?DonorView(name: name,age: age,gender: genders[gender],
                                  city: city,neededDate: '19/01/2000',bloodGroup: bloodGroup,treatment: treatment,contact: contact,
                                  lastTested: lastTested,state: state, pincode: pincode, bp: bp, diabetes:diabetes, created: created,
                                  preMedical: preMedical, recoverDate: recoverdate, isRecovered: isRecovered,
                                ):
                                        PatientView(
                                          name: name, age: age, bloodGroup: bloodGroup, gender: genders[gender], lastTested: lastTested,
                                          relation: relation, hospital: hospital, contact: contact, city: city, state: state, pincode: pincode,
                                          bp: bp, diabetes: diabetes, preMedical: preMedical, extraDetails: moreDetails, neededDate: '19/05/2020',

                                        )
                                );
                              }
                          }
                          if(usersList.isEmpty)
                            {
                              return Container(
                                child: Center(
                                  child: Text(
                                    '🙁 No Records Found',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.grey
                                    ),
                                  ),
                                ),
                              );
                            }
                          return ListView(
                            children: usersList,
                          );
                        }
                        return Container();
                      }
                  )
              ),
          ],
        )
    );
  }
}




