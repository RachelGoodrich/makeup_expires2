import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:makeup_expires2/db/product_database.dart';
import 'package:makeup_expires2/model/product.dart';
import 'package:makeup_expires2/page/edit_product.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Product product;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshProduct();
  }

  Future refreshProduct() async {
    setState(() => isLoading = true);

    this.product = await ProductsDatabase.instance.readProduct(widget.productId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [editButton(), deleteButton()],
    ),
    body: isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
      padding: EdgeInsets.all(12),
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 8),
        children: [
          Text(
            product.title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            //DateFormat.yMMMd().format(product.createdTime)
            getExpires(product.title, product.createdTime),
            style: TextStyle(color: Colors.black),
          ),
          Text(
            DateFormat.yMMMd().format(product.createdTime),
            // getExpires(product.title, product.createdTime),
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 8),
          Text(
            product.description,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          SizedBox(height: 16),
          Text(
            getInfo(product.title),
            style: TextStyle(
              color: Colors.black38,
              fontSize: 18,
              // fontWeight: FontWeight.bold,
            ),
          )

        ],
      ),
    ),
  );

  Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditProductPage(product: product),
        ));

        refreshProduct();
      });

  Widget deleteButton() => IconButton(
    icon: Icon(Icons.delete),
    onPressed: () async {
      await ProductsDatabase.instance.delete(widget.productId);

      Navigator.of(context).pop();
    },
  );
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
}

