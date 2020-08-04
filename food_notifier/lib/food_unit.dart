import 'package:flutter/material.dart';
import 'package:food_notifier/food.dart';
import 'package:intl/intl.dart';

class FoodUnit extends StatelessWidget {
  final Food _food;
  
  FoodUnit({
    @required Food food
  })
  : _food = food;

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = new DateFormat('yyyy.MM.dd.');

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.all(20),
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5
          )
        ]
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              _food.name,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('유통기한 : ${dateFormat.format(_food.shelfLife)}'),
                SizedBox(height: 5),
                Text('등록일 : ${dateFormat.format(_food.registerDate)}')
              ],
            ),
          )
        ],
      ),
    );
  }
}