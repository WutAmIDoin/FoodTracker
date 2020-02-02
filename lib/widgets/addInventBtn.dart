import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_tracker/screens/addInventoryScreen.dart';

class AddInventBtn extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return FloatingActionButton(
      onPressed: () {
          Navigator.push(context, CupertinoPageRoute(
                builder: (_) => AddInventoryScreen(false,null)));
      },
      child: Icon(Icons.add),);
  }
}