import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddInventBtn extends FloatingActionButton{

  AddInventBtn():super(
        onPressed: () {
          Firestore.instance.collection('food').document()
            .setData({ 'name': 'Food'});
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      );
}