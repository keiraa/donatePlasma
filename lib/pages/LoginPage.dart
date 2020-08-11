import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plasmabank/requisities/styles.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height*0.04,
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.065,
                child: Center(
                  child: Text('Blood Plasma dB',style: kMainTitle.copyWith(color: Color(0xf0ff5252),fontSize: 45),),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.0265,
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text('...A part of trana.live project',style: kTagTitle.copyWith(color: Color(0xf0ff5252)),),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 25),
                  height: MediaQuery.of(context).size.height*0.3775,
                  width: 400,
                  child: Image(
                    image: AssetImage('images/LoginImage.png'),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.12,
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
                child: Center(
                  child: Text(
                    'Be a "Hero" in someone\'s life by donating Blood and Plasma',
                    textAlign: TextAlign.center,
                    style: kMainTitle.copyWith(
                      fontSize: 25,
                      color: Color(0xf0ff5252)
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.0135,
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.234,
                decoration: BoxDecoration(
                  color: Color(0xf0ef9a9a),
                  borderRadius: BorderRadius.vertical(top:Radius.circular(10)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Please Enter Your Phone Number',style: kToggleSelected,),
                    Container(
                      height: 55,
                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.15,vertical: MediaQuery.of(context).size.height*0.02),
                      child: TextField(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                        ),
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecor.copyWith(
                          fillColor: Colors.white70,
                          hintText: '+91-XXXXXXXXXX',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 20
                          )
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(9),
                        child: Text('Login',style: kToggleNotSelected.copyWith(fontSize: 26),),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
