import 'package:flutter/material.dart';
import 'package:food_tracker/main.dart';

class Questions extends StatefulWidget {

  final MyHomePageState parent;
  Questions(this.parent);
  @override
  _QuestionsState createState() => _QuestionsState();
}
class _QuestionsState extends State<Questions> {
  bool chiVal = false;
  bool canVal = false;
  bool japVal = false;
  bool freVal = false;
  bool araVal = false;
  bool indVal = false;
  bool gluVal = false;
  bool vegVal = false;
  bool halVal = false;
  bool lacVal = false;
  
  Widget getImage(String title){
    switch (title) {
                case "Chinese":
                  return Image.asset(
            'assets/images/chiPic.jpg',
            height: 100,
            width: 100,
          );
                case "Canadian":
                  return Image.asset(
            'assets/images/canPic.jpg',
            height: 100,
            width: 100,
          );
                case "Japanese":
                  return Image.asset(
            'assets/images/japPic.jpg',
            height: 100,
            width: 100,
          );
                case "French":
                  return Image.asset(
            'assets/images/frePic.jpg',
            height: 100,
            width: 100,
          );
                case "Arabic":
                  return Image.asset(
            'assets/images/araPic.jpg',
            height: 100,
            width: 100,
          );
                case "Indian":
                 return Image.asset(
            'assets/images/indPic.jpg',
            height: 100,
            width: 100,
          );
              }
  }
  

  Widget checkbox(String title, bool boolValue) {
    return Column(
    //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          
           getImage(title),
            
            Text(title),
            Checkbox(
                value: boolValue,
                onChanged: (bool value) {
                  setState(() {
              switch (title) {
                case "Chinese":
                  chiVal = value;
                  break;
                case "Canadian":
                  canVal = value;
                  break;
                case "Japanese":
                  japVal = value;
                  break;
                case "French":
                  freVal = value;
                  break;
                case "Arabic":
                  araVal = value;
                  break;
                case "Indian":
                  indVal = value;
                  break;
                
              }
            });
                },
            )
        ],
    );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Before Start"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: (){
                widget.parent.setState(
                  () {
                    widget.parent.currentIndex = 0;
                  }
                );
              },
              icon: Icon(Icons.check),)
          ],
        ),
        body: Center(
          child: Column(
           
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  Text('Food Type')

                ]

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  checkbox("Chinese", chiVal),
                  checkbox("Canadian", canVal),
                  checkbox("Japanese", japVal),
                  
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  checkbox("French", freVal),
                  checkbox("Arabic", araVal),
                  checkbox("Indian", indVal),
                  
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  Text('Dietary Restrictions')

                ]

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
        Text("Gluten-free"),
        Checkbox(
            value: gluVal,
            onChanged: (bool value) {
                setState(() {
                    gluVal = value;
                });
            },
        ),
    ],
),
      Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
        Text("Vegan"),
        Checkbox(
            value: vegVal,
            onChanged: (bool value) {
                setState(() {
                    vegVal = value;
                });
            },
        ),
    ],
),
Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
        Text("Halal"),
        Checkbox(
            value: halVal,
            onChanged: (bool value) {
                setState(() {
                    halVal = value;
                });
            },
        ),
    ],
),
Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
        Text("Lactose-free"),
        Checkbox(
            value: lacVal,
            onChanged: (bool value) {
                setState(() {
                    lacVal = value;
                });
            },
        ),
    ],
),


                ]

              ),
            ],
          ),
        )
    );
  }
} 
