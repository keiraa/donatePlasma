import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plasmabank/pages/Board.dart';
import 'package:plasmabank/pages/Profile.dart';
import 'package:plasmabank/pages/Register.dart';
import 'package:plasmabank/requisities/styles.dart';

class UsersDisplay extends StatefulWidget {
  @override
  _UsersDisplayState createState() => _UsersDisplayState();
}

class _UsersDisplayState extends State<UsersDisplay> {
  int selectedIndex=1;
  bool searchBar = false;

  List<Widget> screens = [RegisterPage(),BoardPage(),ProfilePage()];
  List<String> headings = ['Forms','Board','Profile'];

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
      body: screens[selectedIndex],
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
    );
  }
}
