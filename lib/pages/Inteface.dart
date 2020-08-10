import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plasmabank/requisities/styles.dart';

class UsersDisplay extends StatefulWidget {
  @override
  _UsersDisplayState createState() => _UsersDisplayState();
}

class _UsersDisplayState extends State<UsersDisplay> {
  int selectedInd=0;
  String messages = 'Messages';
  int selectedIndex=0;
  bool searchBar = false;
  List<bool> isSelected = [true,false];
  List<String> isSelectedMessage = ["users","users"];

//  void getUser() async{
//    FirebaseAuth _auth = FirebaseAuth.instance;
//    _user = await _auth.currentUser();
//  }

  void toggleMenu(int ind){
    setState(() {
      selectedIndex = ind;
      for(int i=0;i<2;i++)
      {
        if(i==ind)
          isSelected[i] = true;
        else
          isSelected[i] = false;
      }
      messages = isSelectedMessage[ind];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xf0ff5252),
        elevation: 0,
        title: searchBar?TextField(
          decoration: kSearchFieldDecor,
          style: kInfoText.copyWith(color: Colors.white),
          cursorColor: Colors.white,
        ):Center(child: Text('Available',style: kGenderSelected,),),
        leading: Icon(
          Icons.arrow_back,
          size: 30,
          color: Colors.white,
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: (){
                if(searchBar)
                  {
                    //TODO: Searching Functionality

                    setState(() {
                      searchBar = false;
                    });
                  }
                else
                  {
                    setState(() {
                      searchBar = true;
                    });
                  }
              },
              child: Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
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
      ),
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBorderColor: Colors.white,
          selectedItemBackgroundColor: Color(0xf0ff5252),
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
          showSelectedItemShadow: false,
          barHeight: 70,
        ),
        selectedIndex: selectedIndex,
        onSelectTab: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          FFNavigationBarItem(
            iconData: Icons.home,
            label: ' ',
          ),
          FFNavigationBarItem(
            iconData: Icons.message,
            label: ' ',
//              selectedBackgroundColor: Colors.orange,
          ),
          FFNavigationBarItem(
            iconData: Icons.language,
            label: ' ',
//              selectedBackgroundColor: Colors.purple,
          ),
        ],
      ),
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
                                child: Center(child: Text('A+',style: kDateStyle,))
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

