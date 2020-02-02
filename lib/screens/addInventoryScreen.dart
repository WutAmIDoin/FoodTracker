import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddInventoryScreen extends StatelessWidget{

  final bool isEdit;
  final String docID;

  AddInventoryScreen(this.isEdit,this.docID);

  @override
  Widget build(BuildContext context){
    return _Form(isEdit,docID);
  }
}

class _Form extends StatefulWidget{

  StreamSubscription<DocumentSnapshot> subscription;
  DateTime date = DateTime.now();
  bool isFirst = true;
  final bool isEdit;
  final String docID;

  _Form(this.isEdit,this.docID);

  @override
  _FormState createState() {
    return _FormState();
  }
}

class _FormState extends State<_Form>{

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final expireController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.isEdit && widget.isFirst){
      widget.subscription = Firestore.instance.collection("food").document(widget.docID).snapshots()
      .listen((data) {
        nameController.text = data["name"];
        quantityController.text = data["quantity"].toString();
        expireController.text = data["expireDay"].toString();
        widget.isFirst = false;
        setState((){
          widget.date = DateTime.fromMillisecondsSinceEpoch(data["boughtDate"].millisecondsSinceEpoch);
        });
      }
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: widget.isEdit? Text("Edit Food") : Text("Add Food"),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              if(_formKey.currentState.validate()){
                if(widget.isEdit){
                  Firestore.instance.collection('food').document(widget.docID).updateData(
                    { 
                      'name': nameController.text,
                      'quantity': double.parse(quantityController.text),
                      'boughtDate': widget.date,
                      'expireDay':int.parse(expireController.text),
                    }
                  );
                }
              else{
                Firestore.instance.collection('food').document()
                  .setData({
                    'name': nameController.text,
                    'quantity': double.parse(quantityController.text),
                    'boughtDate': widget.date,
                    'expireDay':int.parse(expireController.text),

                  });
              }
              Navigator.pop(context);
              }
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
                SizedBox(height: 15.0),
                dateField(),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Day left before expire'),
                  validator: (value){
                    if(value.isEmpty){
                      return "Please enter a non-empty value";
                    }
                    else if (int.tryParse(value) == null){
                      return "Please enter a whole number";
                    }
                    return null;
                  },
                  controller: expireController,
                ),
              ]
            )
          )
        )
      );
  }

  Widget dateField() {
    return Row(
      children: [
        Text(
          'Select Buy Date:',
        ),
        Spacer(),
        FlatButton(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(
                  "${widget.date.day}/${widget.date.month}/${widget.date.year}",
                ),
              ),
              Icon(
                Icons.date_range,
                color: Colors.white,
              ),
            ],
          ),
          onPressed: () async {
            final _date = await _datePicker(context);
            if (_date == null) return;
            setState(() => widget.date = _date);
          },
        ),
      ],
    ); 
  }
  Future<DateTime> _datePicker(BuildContext context) async {
  return showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2018),
    lastDate: DateTime(2030),
    builder: (BuildContext context, Widget child) {
      return Theme(
        data: ThemeData.dark(),
        child: child,
      );
    },
  );
  // return picked;
}
}