import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum FoodScreens {all, expiring, expired}

class MyFoodScreen extends StatelessWidget{

  MyFoodScreen(this.currentScreen);
  final FoodScreens currentScreen;

  @override
  Widget build(BuildContext context){
    Stream<QuerySnapshot> stream;
    switch(currentScreen){
      case FoodScreens.all:
        stream = Firestore.instance.collection('food').snapshots();
        break;
      default:
        stream = Firestore.instance
          .collection('food')
          .where("name", isEqualTo: "Food")
          .snapshots();
        break;

    }
    return StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          else if (snapshot.connectionState == ConnectionState.waiting) {
            return new Text('Loading...');
          }
          else{
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document['name']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        highlightColor: Colors.white10,
                        onPressed: () => {},
                        icon: new Icon(Icons.edit, color: Colors.black),
                      ),
                      IconButton(
                        highlightColor: Colors.white10,
                        onPressed: () => {
                          Firestore.instance.collection("food").document(document.documentID).delete()
                        },
                        icon: new Icon(Icons.delete, color: Colors.black),
                      ),

                    ],
                  ),
                );
              }).toList(),
            );
          }
        },
      );
  }
}