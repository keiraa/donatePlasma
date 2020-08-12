import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plasmabank/requisities/styles.dart';


class BoardPage extends StatefulWidget {
  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {

  Firestore firestore = Firestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  List<bool> isSelected = [true,false];

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
                    GestureDetector(onTap:(){toggleMenu(0);},child: Text('Donors',style: TextStyle(color: Color(0xff756d7f),fontSize: 18),)),
                    Visibility(visible: isSelected[0],child: SizedBox(width: 45,child: Divider(thickness: 2,color: Color(0xf0ff5252),)))
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
                      stream: isSelected[0]?firestore.collection('donor').snapshots():firestore.collection('patient').snapshots(),
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
                            var name = data.data['name'];
                            var age = data.data['age'];
                            var gender = data.data['gender'];
                            var city = data.data['city'];
                            var bloodGroup = data.data['bloodgroup'];
                            var genders = ['M','F','O'];
                            var uid = data.data['uid'];
                            usersList.add(UserView(name: name,age: age,gender: genders[gender-1],city: city,neededDate: '19/01/2000',bloodGroup: bloodGroup,));
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
  UserView({this.name,this.city,this.age,this.bloodGroup,this.gender,this.neededDate});
  final String name,age,gender,city,bloodGroup,neededDate;

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
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
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
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${widget.name} (${widget.age} years ${widget.gender})',style: TextStyle(fontSize: 25,color: Color(0xff756d7f)),),
                            SizedBox(height: 18,),
                            Text('${widget.city}',style: kInfoText,),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerRight,
                            child: Image(
                              image: AssetImage('images/BloodDrop.png'),
                              width: 80,
                              height: 70,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                height: 30,
                                width: 40,
                                margin: EdgeInsets.only(top: 33,left: 20),
                                child: Center(child: Text('${widget.bloodGroup}',style: kDateStyle,))
                            ),
                          )
                        ],
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
                      Text('${widget.neededDate}',style: kDateStyle.copyWith(color: Colors.black),)
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

