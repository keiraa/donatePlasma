import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plasmabank/pages/donorRegister.dart';
import 'package:plasmabank/pages/patientRegister.dart';
import 'package:plasmabank/requisities/styles.dart';



class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<bool> toggle = [true,false];
  List<Widget> togglePages = [DonorRegister(),PatientRegister()];
  int selectedIndex =0;
  void toggleFunction(int k)
  {
    for(int i=0;i<2;i++)
    {
      toggle[i]=false;
      if(i==k)
      {
        toggle[i]=true;
        selectedIndex = i;
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xf0ff5252),
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Save a Life',style: kMainTitle,),
                    Icon(Icons.favorite,color: Color(0xffc62828),)
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.04,
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap:(){
                                  setState(() {
                                    toggleFunction(0);
                                  });
                                },
                                child: Card(
                                  elevation: toggle[0]?10:0,
                                  color: toggle[0]?Color(0xffef9a9a):Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
                                  margin:EdgeInsets.zero,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Center(
                                        child: Text(
                                          'Donor',
                                          style: toggle[0]?kToggleSelected:kToggleNotSelected,
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    toggleFunction(1);
                                  });
                                },
                                child: Card(
                                  elevation: toggle[1]?10:0,
                                  color: toggle[1]?Color(0xffef9a9a):Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(20))),
                                  margin:EdgeInsets.zero,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Center(
                                        child: Text(
                                          'Patient',
                                          style: toggle[1]?kToggleSelected:kToggleNotSelected,
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: togglePages[selectedIndex],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}




