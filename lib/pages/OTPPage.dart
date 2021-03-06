import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:plasmabank/pages/Inteface.dart';
import 'package:plasmabank/pages/Register.dart';
import 'package:plasmabank/requisities/styles.dart';

class OTPPage extends StatefulWidget {
  OTPPage({@required this.phone});
  final String phone;
  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  TextEditingController controller;
  String otp,a;
  FirebaseAuth _auth = FirebaseAuth.instance;
 FirebaseUser user;
 bool loading = false;

  Future<bool> loginUser(BuildContext context) async {
    _auth.verifyPhoneNumber(
        phoneNumber: "+91" + widget.phone.trim(),
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          setState(() {
            loading = true;
          });
          //Navigator.of(context).pop();
          try{
            AuthResult result = await _auth.signInWithCredential(credential);
            user=result.user;
          }catch( e)
          {
            print (e);
          }

          //  await result.user.linkWithCredential(credential1);
          if (user != null) {
            Navigator.pop(context);
            Navigator.push(context,
                 MaterialPageRoute(builder: (context) => (UsersDisplay())));
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception) {
          print(exception.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          a = verificationId;
        },
        codeAutoRetrievalTimeout: null);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: <Widget>[
              ListView (
                children: <Widget>[
                  Center(
                    child: SvgPicture.asset(
                      'images/SuperLike.svg',
                      width: MediaQuery.of(context).size.width*0.5,
                      height: MediaQuery.of(context).size.height*0.35,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.2,
                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
                      child: Column(
                        children: <Widget>[
                          Text('Hello new User!',style: kMainLoginTitle.copyWith(fontSize: 35),),

                          SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                          Text(
                            'Thank you for being a part of Saving Lives',
                            textAlign: TextAlign.center,
                            style: kMainLoginTitle.copyWith(fontSize: 25),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                  Container(
                    height: MediaQuery.of(context).size.height*0.34,
                    decoration: BoxDecoration(
                      color: Color(0xf0ef9a9a),
                      borderRadius: BorderRadius.vertical(top:Radius.circular(10)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('OTP Verification',style: kToggleSelected.copyWith(fontSize: 25),),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.15),
                          child: Text(
                            'Have you recieved a six digit Verification Code?',
                            style: kToggleSelected.copyWith(fontSize: 18,fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          height: 55,
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1,vertical: MediaQuery.of(context).size.height*0.02),
                          child: PinCodeTextField(
                            length: 6,
                            obsecureText: false,
                            controller: controller,
                            backgroundColor: Color(0xf0ef9a9a),
                            animationType: AnimationType.fade,
                            enableActiveFill: true,
                            pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                fieldHeight: 50,
                                fieldWidth: 47,
                                activeColor: Color(0xffef5350),
                                selectedColor: Color(0xffe57373),
                                inactiveColor: Colors.white70,
                                activeFillColor: Color(0xffffebee),
                                inactiveFillColor: Color(0xffffebee),
                                selectedFillColor: Colors.white70
                            ),
                            onChanged: (value){
                              setState(() {
                                otp = value;
                              });
                            },
                            onCompleted: (value){
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () async{
                            //code is otp
                            final code1 = otp.trim();
                            AuthCredential credential = PhoneAuthProvider.getCredential(
                                verificationId: a, smsCode: code1);

                            AuthResult result =
                            await _auth.signInWithCredential(credential);

                            FirebaseUser user = result.user;

                            if (user != null) {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            } else {
                              print("Error");
                            }
                          },
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 9,vertical: 5),
                              child: Text('Verify',style: kToggleNotSelected.copyWith(fontSize: 26),),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Visibility(
                visible: loading,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2),
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffef9a9a)),),
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
