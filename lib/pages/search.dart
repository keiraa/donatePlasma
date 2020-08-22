import 'package:flutter/material.dart';


class search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("search app"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),onPressed: (){
            showSearch(context: context, delegate: DataSearch());
          })
        ],
      ),
      drawer: Drawer(),
    );
  }
}
