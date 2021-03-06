import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:plasmabank/requisities/styles.dart';


class DonorRegister extends StatefulWidget {
  @override
  _DonorRegisterState createState() => _DonorRegisterState();
}

class _DonorRegisterState extends State<DonorRegister> {
  List<bool> toggleGender = [true,false,false];
  int selectedGender = 0;
  List<String> treatments = ['Home Quarantined','Hospitalized'];
  bool isNumber = true,isPincode=true;
  List<String> bloodGroups = ['A+','B+','AB+','O+','A-','B-','AB-','O-'];
  DateFormat formatter = DateFormat.yMd();
  DateTime now = DateTime.now();
  List<DateTime> dates;


  //Form Variables
  String selectedBloodGroup = 'A+';
  String selectedTreatment = 'Home Quarantined';
  List<String> genders = ['M','F','O'];
  bool isBP=false,isDiabetic=false,isCovid=false,isPreCondition= false;
  DateTime testDate = DateTime.now();
  DateTime recoverDate = DateTime.now();

  String name,age,city,state,pincode,preMedical,contact;

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
    dates = [testDate,recoverDate];
  }

  Future<void> _selectDate(int i,BuildContext context) async{
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: dates[i],
      firstDate: DateTime(2019,11),
      lastDate: now,
    );
    if(picked != null && picked!=dates[i])
    {
      setState(() {
        dates[i] = picked;
      });
    }
  }

  void toggleFunctionGender(int k)
  {
    for(int i=0;i<3;i++)
    {
      toggleGender[i]=false;
      if(i==k)
      {
        toggleGender[i]=true;
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
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecor.copyWith(
                      hintText: 'Name of the Donor'
                  ),
                  onChanged: (value){
                    name = value;
                  },
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
                  'City',
                  style: kLabelStyle,
                ),
              ),
              SizedBox(width: 15,),
              Flexible(
                child: TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value){
                    city = value;
                  },
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
                    pincode = value.trim();
                    if(value.length == 6)
                    {
                      setState(() {
                        isPincode = true;
                      });
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

        SizedBox(
          height: MediaQuery.of(context).size.height*0.06,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Please share your Medical Status',
            style: kInfoText,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.025,
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
        Container(
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(child: Text('Are you a COVID Patient',style: kLabelStyle,)),
                Container(
                  child: Switch(
                    value: isCovid,
                    inactiveThumbColor: Colors.white,
                    activeColor: Color(0xffef9a9a),
                    onChanged: (value){
                      setState(() {
                        isCovid = value;
                      });
                    },
                  ),
                ),
              ],
            )
        ),
        Visibility(
          visible: isCovid,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text('Last Tested',style: kLabelStyle,),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xffef9a9a),
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                      ),
                      child: Text(formatter.format(dates[0]),style: kDateStyle,),
                    ),
                    InkWell(
                      onTap: ()=> _selectDate(0, context),
                      child: Container(
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
        ),
        Visibility(
          visible: isCovid,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Container(
                    child: Text('Recovered Date',style: kLabelStyle,),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xffef9a9a),
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                      ),
                      child: Text(formatter.format(dates[1]),style: kDateStyle,),
                    ),
                    InkWell(
                      onTap: () => _selectDate(1, context),
                      child: Container(
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
        ),
        Visibility(
          visible: isCovid,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Treatment',
                  style: kLabelStyle,
                ),
                SizedBox(width: 15,),
                Container(
                  width: 200,
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
                    value: selectedTreatment,
                    items: treatments.map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String value){
                      setState(() {
                        selectedTreatment = value;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
        Center(
          child: GestureDetector(
            onTap: (){
              setState(() {
                if(selectedBloodGroup==null||selectedTreatment==null||name==null|| age==null|| selectedGender==null||  city==null||state==null||pincode==null)
                {
                }
                else {
                  try {
                    Firestore.instance.collection("donor").add({
                      'name': name,
                      'age': age,
                      'bloodgroup':selectedBloodGroup,
                      'gender': selectedGender,
                      'city': city,
                      'state': state,
                      'pincode': pincode,
                      'bp':isBP,
                      'diabetes':isDiabetic,
                      'preMedical': preMedical,
                      'lasttested':testDate,
                      'recoverdate':recoverDate,
                      'treatment': selectedTreatment,
                      'uid': uid,
                      'created': now,
                      'completed': 0
                    }).then((value) => null);
                  }catch(e)
                  {
                    print(e);
                  }
                }
              });
            },
            child: Card(
              elevation: 15,
              color: Color(0xf0ff5252),
              child: Padding(
                padding: EdgeInsets.all(13),
                child: Text(
                  'Add Donor',
                  style: kGenderSelected.copyWith(
                      fontSize: 20
                  ),
                ),
              ),
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















class FieldLikeContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Container(
                height: MediaQuery.of(context).size.height*0.065,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xffffebee),
                ),
                child: Center(
                  child: Text(
                    'City',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
