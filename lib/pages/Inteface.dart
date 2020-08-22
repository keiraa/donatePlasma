import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plasmabank/backend/getJSONdata.dart';
import 'package:plasmabank/pages/Board.dart';
import 'package:plasmabank/pages/Profile.dart';
import 'package:plasmabank/pages/Register.dart';
import 'package:plasmabank/requisities/styles.dart';


List citiesGlobal;


class UsersDisplay extends StatefulWidget {
  @override
  _UsersDisplayState createState() => _UsersDisplayState();
}

class _UsersDisplayState extends State<UsersDisplay> {
  int selectedIndex=1;
  bool searchBar = false;

  List<Widget> screens = [RegisterPage(),BoardPage(),ProfilePage()];
  List<String> headings = ['Forms','Board','Profile'];
  List<String> bloodGroups = ['A+','B+','AB+','O+','A-','B-','AB-','O-'];
  String selectedBloodGroup = 'A+';
  String selectedGender = 'M';
  List<String> gender = ['M','F','O'];

  Future<bool> onWillPop(){
    if(searchBar)
      {
        setState(() {
          searchBar = !searchBar;
        });
      }
    else
      {
        return Future.value(true);
      }
    return Future.value(false);
  }


  getData() async{
    var result= await Firestore.instance.collection('indiancities').document('cities').get();
    print( await result.data['places'].toList());
    citiesGlobal=result.data['places'].toList();
    print(citiesGlobal);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: selectedIndex==0?PreferredSize(
          preferredSize: Size(0,0),
          child: Container(),
        ):
        AppBar(
          backgroundColor: Color(0xf0ff5252),
          elevation: 0,
          title: searchBar?TextField(
            decoration: kSearchFieldDecor,
            style: kInfoText.copyWith(color: Colors.white),
            cursorColor: Colors.white,
          ):Center(child: Text(headings[selectedIndex],style: kGenderSelected,),),
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
                  setState(() {
                    searchBar = !searchBar;
                  });
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Visibility(
              visible: searchBar,
              child: Container(
                color: Color(0xf0ff5252),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Container(
                      height:50,
                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.13,vertical: 15),
                      child: GestureDetector(
                        onTap: (){
                          showSearch(context: context, delegate: DataSearch());
                        },
                        child: Card(
                          margin: EdgeInsets.zero,
                          child: Center(
                            child: Text(
                                DataSearch.finalValue.isEmpty?'Select your City':DataSearch.finalValue,
                              style: TextStyle(
                                color: Color(0xf0ff5252),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.075,vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Blood Group: ',
                                style: kLabelStyle.copyWith(color: Colors.white),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width*0.01,),
                              Container(
                                height: MediaQuery.of(context).size.height*0.05,
                                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                                width: MediaQuery.of(context).size.width*0.16,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: DropdownButton(
                                  style: TextStyle(
                                    color: Color(0xf0ff1744),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                    color: Color(0xf0ff1744),
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
                          Row(
                            children: <Widget>[
                              Text(
                                'Gender',
                                style: kLabelStyle.copyWith(color: Colors.white),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width*0.01,),
                              Container(
                                height: MediaQuery.of(context).size.height*0.05,
                                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                                width: MediaQuery.of(context).size.width*0.16,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: DropdownButton(
                                  style: TextStyle(
                                    color: Color(0xf0ff1744),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                    color: Color(0xf0ff1744),
                                  ),
                                  underline: SizedBox(),
                                  value: selectedGender,
                                  items: gender.map<DropdownMenuItem<String>>((String value){
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String value){
                                    setState(() {
                                      selectedGender = value;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        width: 100,
                        height: 50,
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          elevation: 20,
                          child: Center(
                            child: Text(
                              'Search',
                              style: TextStyle(
                                color: Color(0xffd50000),
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: selectedIndex!=0,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.01),
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                child: Icon(
                  Icons.info,
                  color: Colors.red,
                  size: 25,
                ),
              ),
            ),
            Expanded(child: screens[selectedIndex])
          ],
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
              iconData: FontAwesomeIcons.listAlt,
              label: ' ',
            ),
            FFNavigationBarItem(
              iconData: FontAwesomeIcons.mapMarkerAlt,
              label: ' ',
//              selectedBackgroundColor: Colors.orange,
            ),
            FFNavigationBarItem(
              iconData: FontAwesomeIcons.userAlt,
              label: ' ',
//              selectedBackgroundColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}


class DataSearch extends SearchDelegate<String>{
  static String finalValue = "";

  List cities = citiesGlobal;

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return[
      IconButton(icon: Icon(Icons.clear), onPressed:(){
        query="";
        finalValue = query;
        close(context, query);
      } )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },

    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final suggestionlist= cities.where((p)=> p.toString().toLowerCase().startsWith(query)).toList();
    return ListView.builder(itemBuilder: (context,index)=> ListTile(
      onTap: (){
        query = suggestionlist[index];
        finalValue = query;
        showResults(context);
        close(context, query);
      },
      leading :Icon(Icons.location_city),
      title: RichText(
          text: TextSpan(
            text: suggestionlist[index].substring(0,query.length),
            style: TextStyle(
                color: Colors.black,fontWeight: FontWeight.bold
            ),
            children:  [TextSpan(
                text: suggestionlist[index].substring(query.length),
                style: TextStyle(color: Colors.grey)
            )
            ],
          )
      ),
    ),
      itemCount: suggestionlist.length,
    );
  }

}
