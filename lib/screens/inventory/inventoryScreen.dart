import 'package:flutter/material.dart';
import 'package:food_tracker/screens/inventory/myFoodScreen.dart';

class InventoryScreen extends StatefulWidget{
  @override
  _InventoryState createState() {
    return _InventoryState();
  }
}
class _InventoryState extends State<InventoryScreen>{
  FoodScreens _currentScreen = FoodScreens.all;

  Widget build(BuildContext context){
    return Container(
      child:Column(
        children:<Widget> [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              _element('My Food', FoodScreens.all),
              _element('Expiring in 3 days', FoodScreens.expiring),
              _element('Expired', FoodScreens.expired),
            ],
          ),
          Expanded(
            child:MyFoodScreen(_currentScreen)
          )
        ]
      ),
    );
  }

  Widget _element(String text, FoodScreens screen){
    return Container(
      padding: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
      child: FlatButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Text(text,
        style: TextStyle(
            color: screen == _currentScreen ? Colors.black : Colors.grey,
            decoration: screen == _currentScreen ? TextDecoration.underline : TextDecoration.none,
          ),),
        onPressed: () => onTabTapped(screen),
      ),
    );
  }

  void onTabTapped(FoodScreens screen) {
    if(_currentScreen == screen) return;
    setState(() {
      _currentScreen = screen;
    });
 }
}