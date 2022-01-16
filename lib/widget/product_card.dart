//Makeup Products
/*
* 6 Months: eyeliner, mascara, lip gloss, liquid lipsticks
* 1 Year: foundation, primer, lipstick
* 2 Years: Powder products such as; blush, eyeshadow, setting spray, pressed powder, setting powder
*
* */


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:makeup_expires2/model/product.dart';

final _lightColors = [
  Colors.lightGreen.shade300,
  Colors.amber.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.lightBlue.shade300,
];


class ProductCardWidget extends StatelessWidget {
  ProductCardWidget({
    Key? key,
    required this.product,
    required this.index,
  }) : super(key: key);

  final Product product;
  final int index;

  @override
  Widget build(BuildContext context) {
    final color = _lightColors[getColor(product.createdTime, product.title)];
    final time = DateFormat.yMMMd().format(product.createdTime);
    final minHeight = getMinHeight(product.title);

    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon(
            //   Icons.favorite,
            // // AssetImage('assets/icons/mascara.svg'),
            //   // onPressed: () => exit(0),
            //   // color: Colors.pink,
            //   // size: 24.0,
            //   // semanticLabel: 'Text to announce in accessibility modes',
            // ),
            Text(
              getExpires(product.title, product.createdTime),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 4),
            Text(
              product.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              product.description,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                // fontWeight: FontWeight.bold,
              ),
            ),
            // Text(
            //   getExpires(product.title, product.createdTime),
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontSize: 15,
            //     // fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  /// To return different height for different widgets
  double getMinHeight(String title) {
    // if(title == "Mascara"){
    //   return 200;
    // }
    return 100;
  }
  String getInfo(String title) {
    if (title == "Mascara" || title == "mascara") {
      return "Mascara should be thrown out every 6 months...";
    } else if (title == "Eyeshadow" || title == "eyeshadow") {
      return "Eyeshadow should be thrown out every 2 years...";
    } else if (title == "Pressed Powder" || title == "pressed powder" ||
        title == "Pressed powder") {
      return "Pressed powder should be thrown out every 2 years...";
    } else if (title == "Foundation" || title == "foundation") {
      return "Foundation should be thrown out every year...";
    }else if(title == "Eyeliner" || title == "eyeliner"){
      return "Eyeliner should be thrown out every 6 months...";
    } else if(title == "Lipstick" || title == "lipstick"){
      return "Lipstick should be thrown out every year...";
    } else if(title == "Blush" || title == "blush"){
      return "Blush should be thrown out every two years...";
    } else if(title == "Lip gloss" || title == "lip gloss"){
      return "Lip gloss should be thrown out every two years...";
    }else if(title == "Liquid Lipstick" || title == "liquid lipstick"){
      return "Liquid lipstick should be thrown out every 6 months...";
    }else if(title == "Concealer" || title == "concealer"){
      return "Concealer should be thrown out every 6 months...";
    }
    return "If it starts smelling different, throw it out!";
  }
  String getExpires(String title, DateTime from) {
    DateTime expires;
    //6 Months
    if (title == "Mascara" || title == "mascara" || title == "eyeliner" || title == "Eyeliner" || title == "Liquid Lipstick" ||
        title == "liquid lipstick" || title == "Lip gloss" || title == "lip gloss" || title == "Concealer" || title == "concealer") {
      expires = from.add(const Duration(days: 180));
      //One Year
    }else if (title.contains("Foundation") == true || title.contains("foundation") == true || title == "Lipstick" || title == "lipstick") {
      expires = from.add(const Duration(days: 365));
      //Two years
    } else if (title == "Eyeshadow" || title == "eyeshadow" || title == "Pressed Powder" || title == "pressed powder" ||
        title == "Pressed powder" || title == "Blush" || title == "blush") {
      expires = from.add(const Duration(days: 730));
      //No info
    }else{
      expires = from.add(const Duration(days: 180));
    }
    String myString = DateFormat.yMMMd().format(expires);
    return "Expires $myString";
  }
  int getColor(DateTime created, String title){ //colors are decided by how close to expiration date
    DateTime today = DateTime.now();
    DateTime expires;
    int days;
    if (title == "Mascara" || title == "mascara" || title == "eyeliner" || title == "Eyeliner") {
      expires = created.add(const Duration(days: 180));
    } else if (title == "Eyeshadow" || title == "eyeshadow" || title == "Pressed Powder" || title == "pressed powder" ||
        title == "Pressed powder" || title == "blush" || title == "Blush") {
      expires = created.add(const Duration(days: 730));
    } else if (title == "Foundation" || title == "foundation") {
      expires = created.add(const Duration(days: 365));
    }else{
      expires = created.add(const Duration(days: 180));
    }
    days = daysBetween(created, expires);

    if (days > 700){
      return 0;
    }else if(days > 300){
      return 1;
    }else if(days > 180){
      return 2;
    }else if (days > 50){
      return 3;
    }
    return 4;

  }
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
    //https://stackoverflow.com/questions/52713115/flutter-find-the-number-of-days-between-two-dates
  }

}
