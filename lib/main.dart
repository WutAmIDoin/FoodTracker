import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_tracker/screens//inventory/inventoryScreen.dart';
import 'package:food_tracker/screens/inventory/questions.dart';
import 'package:food_tracker/widgets/addInventBtn.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: "Food Track", firstTime: true,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  bool firstTime;
  MyHomePage({this.title,this.firstTime = false});
  @override
  MyHomePageState createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  int currentIndex = -1;
  final List<Widget> _bodies = [InventoryScreen(),Container(),Container()];
  final List<Widget> _floatingBtn =[AddInventBtn(),null,null];
  @override
  Widget build(BuildContext context) {
    if(currentIndex == -1){
      return Questions(this);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _bodies[currentIndex],
      floatingActionButton: _floatingBtn[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
      onTap: onTabTapped,
       currentIndex: currentIndex, // this will be set when a new tab is tapped
       items: [
         BottomNavigationBarItem(
           icon: new Icon(MdiIcons.fridge, size: 50),
           title: new Text('My Foods'),
         ),
         BottomNavigationBarItem(
           icon: new Icon(MdiIcons.fileDocumentBoxCheckOutline, size: 50),
           title: new Text('Necessiities'),
         ),
         BottomNavigationBarItem(
           icon: Icon(MdiIcons.ticketConfirmation, size: 50),
           title: Text('Coupons')
         )
       ],
     ),
    );
  }
  void onTabTapped(int index) {
   setState(() {
     currentIndex = index;
   });
 }
}