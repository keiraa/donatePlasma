import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plasmabank/requisities/styles.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.03),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text('Your History',style: kTitle,),
                    SizedBox(
                      width: 80,
                      child: Divider(
                        color: Color(0xffef9a9a),
                        thickness: 2,
                      ),
                    )
                  ],
                ),
              ),
            ),
//              Flexible(
//                  child: StreamBuilder<QuerySnapshot>(
//                      stream: isSelected[0]?firestore.collection('users').snapshots():firestore.collection('ongoing').document(_user.uid).collection(_user.uid).snapshots(),
//                      builder: (context,snapshot){
//                        if(snapshot.connectionState == ConnectionState.waiting){
//                          return CircularProgressIndicator();
//                        }
//                        if(snapshot.hasData)
//                        {
//                          List<Widget> usersList = [];
//                          final users = snapshot.data.documents;
//                          for(var user in users)
//                          {
//                            var img = user.data['image'];
//                            var name = user.data['nickname'];
//                            var msg = user.data['msg'];
//                            var time = user.data['time'];
//                            var uid = user.data['uid'];
//                            if(uid!=_user.uid){
//                              usersList.add(UserView(img: img,msg: msg,name: name ,time: time,uid: uid,puid: _user.uid,));
//                            }
//                          }
//                          return ListView(
//                            children: usersList,
//                          );
//                        }
//                        return Container();
//                      }
//                  )
//              ),
            UserView(),
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