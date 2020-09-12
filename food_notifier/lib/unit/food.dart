import 'dart:convert';

class Food {
  static final Food none = new Food(null, null, null, null, null, null, null);

  final String id;
  final String barcode;
  final String foodType;
  final String makerName;
  final String productName;
  final DateTime shelfLife;
  final DateTime registerDate;

  Food(this.id, this.barcode, this.foodType, this.makerName, this.productName, this.shelfLife, this.registerDate);

  factory Food.fromJsonString(String jsonString) {
    JsonCodec codec = new JsonCodec();
    return Food.fromJson(codec.decode(jsonString));
  }

  factory Food.fromJson(dynamic json) {
    DateTime today = DateTime.now();
    DateTime registerDate = new DateTime(today.year, today.month, today.day);
    DateTime shelfLife = new DateTime(today.year, today.month, today.day);

    String strPOG = json['shelf_life'];

    int dateValue = 0;

    if(strPOG.length == 0) {
      shelfLife = shelfLife.add(Duration(days: 30));
    } else {
      if(strPOG.contains(new RegExp(r'[0-9]'))) {
        for(int i=0; i<strPOG.length; i++) {
          if(strPOG[i].contains(new RegExp(r'[0-9]'))) {
            int val = int.parse(strPOG[i]);
            dateValue += val;
            dateValue *= 10;
          } else {
            if(dateValue != 0) {
              break;
            }
          }
        }
        dateValue ~/= 10;
        if(strPOG.contains('일')) {
          shelfLife = shelfLife.add(Duration(days: dateValue));
        } else if(strPOG.contains('년')) {
          shelfLife = shelfLife.add(Duration(days: dateValue * 365));
        } else {
          shelfLife = shelfLife.add(Duration(days: dateValue * 30));
        }
      } else {
        shelfLife = shelfLife.add(Duration(days: 30));
      }
    }

    return Food(json['id'], json['barcode'], json['food_type'], json['maker_name'], json['name'], shelfLife, registerDate);
  }
}