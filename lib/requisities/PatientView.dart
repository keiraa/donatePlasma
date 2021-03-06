import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:plasmabank/requisities/styles.dart';

class PatientView extends StatefulWidget {
  PatientView({this.name,this.city,this.age,this.bloodGroup,this.gender,this.neededDate,this.contact,this.state,this.lastTested,this.hospital,this.relation,this.pincode,this.bp,this.diabetes,this.preMedical,this.created,this.extraDetails,this.document,this.isdelete});
  final String name,age,gender,city,bloodGroup,neededDate,relation,hospital,contact,state,pincode,preMedical,extraDetails,document;
  final bool bp,diabetes,isdelete;
  final Timestamp lastTested,created;

  @override
  _PatientViewState createState() => _PatientViewState();
}

class _PatientViewState extends State<PatientView> {
  bool isPressed = false;

  IconData down = Icons.keyboard_arrow_down,up = Icons.keyboard_arrow_up;
  delete(){
    Firestore.instance.collection("patient").document(widget.document).delete();
    Fluttertoast.showToast(
        msg: "Deleted Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0
    );
  }
  @override
  Widget build(BuildContext context) {
    DateTime lastTested = widget.lastTested.toDate();
    DateFormat formatter = DateFormat.yMd();
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
                            Text('Needed By:',style: kLabelStyle,),
                            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                            Container(
                                width: MediaQuery.of(context).size.width*0.35,
                                child: Text('${widget.neededDate}',style: kDateStyle.copyWith(color: Colors.black),)
                            )
                          ],
                        ),
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
                            Text('Relation:',style: kLabelStyle,),
                            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                            Container(
                                width: MediaQuery.of(context).size.width*0.35,
                                child: Text('${widget.relation}',style: kDateStyle.copyWith(color: Colors.black),)
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Hospital:',style: kLabelStyle,),
                            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                            Flexible(
                              child: Container(
                                  width: MediaQuery.of(context).size.width*0.35,
                                  child: Text('${widget.hospital}',style: kDateStyle.copyWith(color: Colors.black),)
                              ),
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
                            Text('Extra Details:',style: kLabelStyle,),
                            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                            Flexible(
                              child: Container(
                                  width: MediaQuery.of(context).size.width*0.35,
                                  child: Text('${widget.extraDetails}',style: kDateStyle.copyWith(color: Colors.black),)
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[

                            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                            Flexible(
                              child: Visibility(
                                visible: widget.isdelete,
                                child: GestureDetector(
                                  onTap: () async {
                                    await delete();
                                  },
                                  child: Container(

                                      width: MediaQuery.of(context).size.width*0.35,
                                      child: Card(
                                        elevation: 15,
                                        color: Color(0xf0ff5252),
                                        child: Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Center(
                                            child: Text(
                                              'Delete',
                                              style: kGenderSelected.copyWith(
                                                  fontSize: 15
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                  ),
                                ),
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
        )
    );
  }
}

