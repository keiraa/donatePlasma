import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plasmabank/requisities/styles.dart';



class DonorView extends StatefulWidget {
  DonorView({this.name,this.city,this.age,this.bloodGroup,this.gender,this.neededDate,this.contact,this.state,this.lastTested,this.treatment,this.pincode,this.bp,this.diabetes,this.preMedical,this.created,this.isRecovered,this.recoverDate});
  final String name,age,gender,city,bloodGroup,neededDate,treatment,contact,state,pincode,preMedical;
  final bool bp,diabetes,isRecovered;
  final Timestamp lastTested,created,recoverDate;

  @override
  _DonorViewState createState() => _DonorViewState();
}

class _DonorViewState extends State<DonorView> {
  bool isPressed = false;
  DateFormat formatter = DateFormat.yMd();

  IconData down = Icons.keyboard_arrow_down,up = Icons.keyboard_arrow_up;

  @override
  Widget build(BuildContext context) {
    DateTime recoverDate = widget.isRecovered?widget.recoverDate.toDate():DateTime.now();
    DateTime lastTested = widget.lastTested.toDate();
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
          child: Container(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width*0.09,
                          height: MediaQuery.of(context).size.height*0.09,
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerRight,
                                child: Image(
                                  image: AssetImage('images/BloodDrop.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                    height: 30,
                                    width: 40,
                                    margin: EdgeInsets.only(top: 15),
                                    child: Center(child: Text('${widget.bloodGroup}',style: kDateStyle,))
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width*0.03,),
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
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Last Tested:',style: kLabelStyle,),
                              SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                              Container(
                                  width: MediaQuery.of(context).size.width*0.35,
                                  child: Text('${formatter.format(lastTested)}',style: kDateStyle.copyWith(color: Colors.black),)
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Treatment:',style: kLabelStyle,),
                              SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                              Container(
                                  width: MediaQuery.of(context).size.width*0.35,
                                  child: Text('${widget.treatment}',style: kDateStyle.copyWith(color: Colors.black),)
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Contact:',style: kLabelStyle,),
                              SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                              Container(
                                  width: MediaQuery.of(context).size.width*0.35,
                                  child: Text('${widget.contact}',style: kDateStyle.copyWith(color: Colors.black),)
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('State:',style: kLabelStyle,),
                              SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                              Container(
                                  width: MediaQuery.of(context).size.width*0.35,
                                  child: Text('${widget.state}',style: kDateStyle.copyWith(color: Colors.black),)
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Pincode:',style: kLabelStyle,),
                              SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                              Container(
                                  width: MediaQuery.of(context).size.width*0.35,
                                  child: Text('${widget.pincode}',style: kDateStyle.copyWith(color: Colors.black),)
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('BP:',style: kLabelStyle,),
                              SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                              Container(
                                  width: MediaQuery.of(context).size.width*0.35,
                                  child: Text('${widget.bp?'Yes':'No'}',style: kDateStyle.copyWith(color: Colors.black),)
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Diabetes:',style: kLabelStyle,),
                              SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                              Container(
                                  width: MediaQuery.of(context).size.width*0.35,
                                  child: Text('${widget.diabetes?'Yes':'No'}',style: kDateStyle.copyWith(color: Colors.black),)
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Pre-Medical:',style: kLabelStyle,),
                              SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                              Flexible(
                                child: Container(
                                    width: MediaQuery.of(context).size.width*0.35,
                                    child: Text('${widget.preMedical.length!=0?widget.preMedical:'No History'}',style: kDateStyle.copyWith(color: Colors.black),)
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Recovered Date:',style: kLabelStyle,),
                              SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                              Flexible(
                                child: Container(
                                    width: MediaQuery.of(context).size.width*0.35,
                                    child: Text('${widget.isRecovered?formatter.format(recoverDate):'Not Recovered'}',style: kDateStyle.copyWith(color: Colors.black),)
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
