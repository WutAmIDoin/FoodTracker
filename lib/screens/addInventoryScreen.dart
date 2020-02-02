import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddInventoryScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return _Form();
  }
}

class _Form extends StatefulWidget{
  @override
  _FormState createState() {
    return _FormState();
  }
}

class _FormState extends State<_Form>{

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final quantityController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Food"),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              if(_formKey.currentState.validate()){
                Firestore.instance.collection('food').document()
                  .setData({ 'name': nameController.text, 'quantity': double.parse(quantityController.text)});
              }
              Navigator.pop(context);
            },
            icon: Icon(Icons.check),
            )
        ],),
        body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child:Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Food Name'),
                  validator: (value){
                    if(value.isEmpty){
                      return "Please enter a non-empty value";
                    }
                    return null;
                  },
                  controller: nameController,
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Quantity'),
                  validator: (value){
                    if(value.isEmpty){
                      return "Please enter a non-empty value";
                    }
                    else if (double.tryParse(value) == null){
                      return "Please enter a number";
                    }
                    return null;
                  },
                  controller: quantityController,
                ),
              ]
            )
          )
        )

      );
  }
}