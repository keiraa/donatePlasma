import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plasmabank/requisities/DonorView.dart';
import 'package:plasmabank/requisities/PatientView.dart';
import 'package:plasmabank/requisities/styles.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    return Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height*0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    GestureDetector(onTap:(){toggleMenu(0);},child: Text('Donor',style: TextStyle(color: Color(0xff756d7f),fontSize: 18),)),
                    Visibility(visible: isSelected[0],child: SizedBox(width: 45,child: Divider(thickness: 2,color: Color(0xf0ff5252),))),
                  ],
                ),
                Column(
                  children: <Widget>[
                    GestureDetector(onTap:(){toggleMenu(1);},child: Text('Patient',style: TextStyle(color: Color(0xff756d7f),fontSize: 18),)),
                    Visibility(visible: isSelected[1],child: SizedBox(width: 45,child: Divider(thickness: 2,color: Color(0xf0ff5252),)))
                  ],
                )
              ],
            ),
            SizedBox(height: 20,),
            Flexible(
                child: StreamBuilder<QuerySnapshot>(
                    stream: isSelected[0]?firestore.collection('donor').snapshots()
                        :
                    firestore.collection('patient').snapshots(),


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
                          var document=data.documentID;
                          print(document);
                          if(_user.uid==uid)
                          {
                            usersList.add(
                                isSelected[0]?DonorView(name: name,age: age,gender: genders[gender],
                                  city: city,neededDate: '19/01/2000',bloodGroup: bloodGroup,treatment: treatment,contact: contact,
                                  lastTested: lastTested,state: state, pincode: pincode, bp: bp, diabetes:diabetes, created: created,
                                  preMedical: preMedical, recoverDate: recoverdate, isRecovered: isRecovered,document: document,isdelete: true,
                                ):
                                PatientView(
                                  name: name, age: age, bloodGroup: bloodGroup, gender: genders[gender], lastTested: lastTested,
                                  relation: relation, hospital: hospital, contact: contact, city: city, state: state, pincode: pincode,
                                  bp: bp, diabetes: diabetes, preMedical: preMedical, extraDetails: moreDetails, neededDate: '19/05/2020',document: document,isdelete: true,

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


class UserView extends StatefulWidget {
  UserView({this.time,this.msg,this.name,this.img,this.uid,this.puid});
  final String img,name,msg,time,uid,puid;

  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  bool isPressed = false;
  IconData down = Icons.keyboard_arrow_down,up = Icons.keyboard_arrow_up;

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('Hm');
    return Container(
        decoration: BoxDecoration(
          color: Color(0xffffebee),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(10),
        child: InkWell(
          onTap: (){
//            var code;
//            if(puid.hashCode > uid.hashCode)
//              code = '$puid-$uid';
//            else
//              code = '$uid-$puid';
//            Firestore.instance.collection('ongoing').document(puid).collection(puid).document(code).setData({
//              'image':img,
//              'nickname':name,
//              'msg':msg,
//              'time':formatter.format(DateTime.now()),
//              'uid':uid
//            });
//            Navigator.push(context, MaterialPageRoute(builder: (context)=> Chat(code: code,image: img,name: name,puid: puid,)));
          },
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Color(0xf0ff5252),
                    child: Text('D',style: kGenderSelected,),
                    radius: 25,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Ravi (20 years M)',style: TextStyle(fontSize: 25,color: Color(0xff756d7f)),),
                            SizedBox(height: 18,),
                            Text('Visakhapatnam',style: kInfoText,),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height*0.09,
                        width: MediaQuery.of(context).size.width*0.12,
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerRight,
                              child: Image(
                                image: AssetImage('images/BloodDrop.png'),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 17,left: 8),
                                child: Center(child: Text('AB+',style: kDateStyle.copyWith(fontSize: 15),))
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            isPressed = !isPressed;
                          });
                        },
                        child: Icon(
                          isPressed?up:down,
                          size: 30,
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 20,),
              Visibility(
                visible: isPressed,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.04),
                  child: Row(
                    children: <Widget>[
                      Text('Needed By:',style: kLabelStyle,),
                      SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                      Text('19/5/2020',style: kDateStyle.copyWith(color: Colors.black),)
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}