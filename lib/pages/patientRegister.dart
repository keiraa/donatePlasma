import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:plasmabank/backend/getJSONdata.dart';
import 'package:plasmabank/pages/Inteface.dart';
import 'package:plasmabank/requisities/styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PatientRegister extends StatefulWidget {
  @override
  _PatientRegisterState createState() => _PatientRegisterState();
}

class _PatientRegisterState extends State<PatientRegister> {
  List<bool> toggleGender = [true,false,false];
  int selectedGender = 0;
  bool isNumber = true,isPincode=true;
  List<String> bloodGroups = ['A+','B+','AB+','O+','A-','B-','AB-','O-'];
  List<String> relations = ['Parents','Grand Parents','Husband','Wife','Son','Daughter','Sibiling','Relative','Friend','Aquaintance','Stranger'];
  DateFormat formatter = DateFormat.yMd();
  DateTime now = DateTime.now();

  MyJSON myJson = MyJSON();
  double isSpinning = 0;

  //Form Variables
  String selectedBloodGroup = 'A+';
  String selectedRelation = 'Parents';
  List<String> genders = ['M','F','O'];
  DateTime testDate = DateTime.now();
  bool isBP=false,isDiabetic=false,isPreCondition = false;
  String name,age,hospital,contact,city,state,pinCode,preMedical,moreDetails;
  var uid;


  void getuser()
 async  {
       var user= await FirebaseAuth.instance.currentUser();
        uid=user.uid;
       }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  getuser();
  }

  Future<void> _selectDate(BuildContext context) async{
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: testDate,
      firstDate: DateTime(2019,11),
      lastDate: now,
    );
    if(picked != null && picked!=testDate)
    {
      setState(() {
        testDate = picked;
      });
    }
  }

  void toggleFunctionGender(int k) {
    for (int i = 0; i < 3; i++) {
      toggleGender[i] = false;
      if (i == k) {
        toggleGender[i] = true;
        selectedGender = i;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 30,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 15),
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*0.19,
                child: Text(
                  'Name',
                  style: kLabelStyle,
                ),
              ),
              SizedBox(width: 15,),
              Flexible(
                child: TextField(
                  onChanged: (value){
                    name = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecor.copyWith(
                      hintText: 'Name of the Patient'
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Age',
                      style: kLabelStyle,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.01,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.15,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value){
                          age = value;
                        },
                        textAlign: TextAlign.center,
                        maxLength: 2,
                        decoration: kTextFieldDecor.copyWith(
                          hintText: '15',
                          counterText: '',
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.04,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Blood Group',
                      style: kLabelStyle,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.01,),
                    Container(
                      height: MediaQuery.of(context).size.height*0.06,
                      padding: EdgeInsets.symmetric(horizontal: 7,vertical: 5),
                      width: MediaQuery.of(context).size.width*0.19,
                      decoration: BoxDecoration(
                        color: Color(0xffef9a9a),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: DropdownButton(
                        isExpanded: false,
                        dropdownColor: Color(0xffef9a9a),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                          color: Colors.white,
                        ),
                        underline: SizedBox(),
                        value: selectedBloodGroup,
                        items: bloodGroups.map<DropdownMenuItem<String>>((String value){
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String value){
                          setState(() {
                            selectedBloodGroup = value;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ],
            )
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 15,horizontal: MediaQuery.of(context).size.width*0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Gender',
                style: kLabelStyle,
              ),
              SizedBox(
                width: 30,
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        toggleFunctionGender(0);
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      child: Card(
                        color: toggleGender[0]?Color(0xffef9a9a):Colors.white,
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Center(
                            child: Text('M',style: toggleGender[0]?kGenderSelected:kGenderNotSelected,),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        toggleFunctionGender(1);
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      child: Card(
                        color: toggleGender[1]?Color(0xffef9a9a):Colors.white,
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Center(
                            child: Text('F',style: toggleGender[1]?kGenderSelected:kGenderNotSelected,),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        toggleFunctionGender(2);
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      child: Card(
                        color: toggleGender[2]?Color(0xffef9a9a):Colors.white,
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Center(
                            child: Text('O',style: TextStyle(fontWeight: FontWeight.w700,color: toggleGender[2]?Colors.white:Color(0xffef9a9a),fontSize: 30),),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Container(
                  child: Text('Last Tested',style: kLabelStyle,),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width*0.45,
                    height: 45,
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xffef9a9a),
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                    ),
                    child: Center(child: Text(formatter.format(testDate),style: kDateStyle,)),
                  ),
                  InkWell(
                    onTap: ()=> _selectDate(context),
                    child: Container(
                      height: 45,
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color(0xffffcdd2),
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
                      ),
                      child: Icon(
                        FontAwesomeIcons.calendarAlt,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Relation',
                style: kLabelStyle,
              ),
              SizedBox(width: 15,),
              Container(
                width: MediaQuery.of(context).size.width*0.55,
                height: 50,
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xffef9a9a),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: DropdownButton(
                  isExpanded: true,
                  dropdownColor: Color(0xffef9a9a),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: Colors.white,
                  ),
                  underline: SizedBox(),
                  value: selectedRelation,
                  items: relations.map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String value){
                    setState(() {
                      selectedRelation = value;
                    });
                  },
                ),
              )
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 15),
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*0.19,
                child: Text(
                  'Hospital Name',
                  style: kLabelStyle,
                ),
              ),
              SizedBox(width: 15,),
              Flexible(
                child: TextField(
                  onChanged: (value){
                    hospital = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecor.copyWith(
                      hintText: 'Hospital Name'
                  ),
                ),
              )
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 15),
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*0.19,
                child: Text(
                  'Contact Number',
                  style: kLabelStyle,
                ),
              ),
              SizedBox(width: 15,),
              Flexible(
                child: TextField(
                  maxLength: 10,
                  onChanged: (value){
                    contact = value;
                    if(value.length==10)
                      {
                        setState(() {
                          isNumber = true;
                        });
                      }
                    if(value.length<10)
                      {
                        setState(() {
                          isNumber = false;
                          print('hello');
                        });
                      }
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.phone,
                  decoration: kTextFieldDecor.copyWith(
                    hintText: 'XXXXXXXX',
                    counterText: '',
                    errorText: isNumber?null:'Please enter a 10 Digit Number'
                  ),
                ),
              )
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 15),
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*0.19,
                child: Text(
                  'Pincode',
                  style: kLabelStyle,
                ),
              ),
              SizedBox(width: 15,),
              Flexible(
                child: TextField(
                  onChanged: (value){
                    pinCode = value.trim();
                    if(value.length == 6)
                    {
                      setState(() {
                        isPincode = true;
                      });
                      myJson.getData(pinCode);
                    }
                    else{
                      setState(() {
                        isPincode = false;
                      });
                    }
                  },
                  textAlign: TextAlign.center,
                  maxLength: 6,
                  keyboardType: TextInputType.phone,
                  decoration: kTextFieldDecor.copyWith(
                      hintText: 'Ex: 530017',
                      counterText: '',
                      errorText: isPincode?null:'Please enter a valid Pincode'
                  ),
                ),
              )
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 15),
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*0.19,
                child: Text(
                  'City',
                  style: kLabelStyle,
                ),
              ),
              SizedBox(width: 15,),
              Flexible(
                child: TextField(
                  onChanged: (value){
                    city = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecor.copyWith(
                      hintText: 'Ex: Visakhapatnam'
                  ),
                ),
              )
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 15),
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*0.19,
                child: Text(
                  'State',
                  style: kLabelStyle,
                ),
              ),
              SizedBox(width: 15,),
              Flexible(
                child: TextField(
                  onChanged: (value){
                    state = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecor.copyWith(
                      hintText: 'Ex: Andhra Pradesh'
                  ),
                ),
              )
            ],
          ),
        ),



        SizedBox(
          height: MediaQuery.of(context).size.height*0.05,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Please select based on your previous records',
            style: kInfoText,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.05,
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Blood Pressure',style: kLabelStyle,),
                Container(
                  child: Switch(
                    value: isBP,
                    inactiveThumbColor: Colors.white,
                    activeColor: Color(0xffef9a9a),
                    onChanged: (value){
                      setState(() {
                        isBP = value;
                      });
                    },
                  ),
                ),
              ],
            )
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Diabetes',style: kLabelStyle,),
                Container(
                  child: Switch(
                    value: isDiabetic,
                    inactiveThumbColor: Colors.white,
                    activeColor: Color(0xffef9a9a),
                    onChanged: (value){
                      setState(() {
                        isDiabetic = value;
                      });
                    },
                  ),
                ),
              ],
            )
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(child: Text('Have any other pre-conditions',style: kLabelStyle,)),
                Container(
                  child: Switch(
                    value: isPreCondition,
                    inactiveThumbColor: Colors.white,
                    activeColor: Color(0xffef9a9a),
                    onChanged: (value){
                      setState(() {
                        isPreCondition = value;
                      });
                    },
                  ),
                ),
              ],
            )
        ),
        Visibility(
          visible: isPreCondition,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 15),
            child: Row(
              children: <Widget>[
                Text(
                  'Conditions',
                  style: kLabelStyle,
                ),
                SizedBox(width: 15,),
                Flexible(
                  child: TextField(
                    onChanged: (value){
                      preMedical = value;
                    },
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecor.copyWith(
                        hintText: 'Ex: Mental Illness'
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height*0.01,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'More Details',
                style: kLabelStyle,
              ),
              SizedBox(height: 15,),
              TextField(
                onChanged: (value){
                  moreDetails = value;
                },
                textAlign: TextAlign.center,
                maxLines: 3,
                decoration: kTextFieldDecor.copyWith(
                    hintText: 'Ex: Patient is Pregnant woman in need of Blood Plasma Immediately'
                ),
              )
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
        Center(
          child: GestureDetector(
            onTap: () async{
              var result= await Firestore.instance.collection('indiancities').document('cities').get();
              print( await result.data['places'].toList());
              var cities=result.data['places'].toList();
              setState(() {
                isSpinning = 20;
              });
              if(selectedBloodGroup==null||name==null|| age==null|| selectedGender==null||  city==null||state==null||pinCode==null)
              {
              }
              else {
                try {
                  if (!cities.contains(myJson.getState()))
                  {
                    Firestore.instance.collection('indiancities').document(
                        'cities').updateData({
                      'places': FieldValue.arrayUnion([myJson.getState()])
                    });
                  }
                  if (!cities.contains(myJson.getRegion()))
                  {
                    Firestore.instance.collection('indiancities').document(
                        'cities').updateData({
                      'places': FieldValue.arrayUnion([myJson.getRegion()])
                    });
                  }
                  if (!cities.contains(myJson.getDistrict()))
                  {
                    Firestore.instance.collection('indiancities').document(
                        'cities').updateData({
                      'places': FieldValue.arrayUnion([myJson.getDistrict()])
                    });
                  }
                  if (!cities.contains(myJson.getDivision()))
                  {
                    Firestore.instance.collection('indiancities').document(
                        'cities').updateData({
                      'places': FieldValue.arrayUnion([myJson.getDivision()])
                    });
                  }
                  if (!cities.contains(myJson.getCity()))
                  {
                    Firestore.instance.collection('indiancities').document(
                        'cities').updateData({
                      'places': FieldValue.arrayUnion([myJson.getCity()])
                    });
                  }

                  Firestore.instance.collection("patient").add({
                    'name': name,
                    'age': age,
                    'bloodgroup':selectedBloodGroup,
                    'gender': selectedGender,
                    'lastTested': testDate,
                    'relation': selectedRelation,
                    'hospital': hospital,
                    'contact':contact,
                    'city': city,
                    'state': state,
                    'pincode': pinCode,
                    'bp':isBP,
                    'diabetes':isDiabetic,
                    'premedical': isPreCondition?preMedical:'',
                    'moredetails': moreDetails,
                    'uid': uid,
                    'created': now,
                    'completed': 0

                  }).then((value) {
                    setState(() {
                      isSpinning = 0;
                    });
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UsersDisplay()));
                  });
                }catch(e)
                {
                  print(e);
                }
              }
            },
            child: Card(
              elevation: 15,
              color: Color(0xf0ff5252),
              child: Padding(
                padding: EdgeInsets.all(13),
                child: Text(
                  'Add Patient',
                  style: kGenderSelected.copyWith(
                      fontSize: 20
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Center(
            child: SpinKitThreeBounce(
              color: Color(0xf0ff5252),
              size: isSpinning,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.1,
        )
      ],
    );
  }
}