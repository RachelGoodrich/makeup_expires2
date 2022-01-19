import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:makeup_expires2/db/product_database.dart';
import 'package:makeup_expires2/model/product.dart';
import 'package:makeup_expires2/page/edit_product.dart';
import 'package:makeup_expires2/page/product_detail_page.dart';
import 'package:makeup_expires2/widget/product_card.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late List<Product> products;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshProducts();
  }

  @override
  void dispose() {
    ProductsDatabase.instance.close();

    super.dispose();
  }

  Future refreshProducts() async {
    setState(() => isLoading = true);

    this.products = await ProductsDatabase.instance.readAllProducts();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        'Makeup Expires!',
        style: TextStyle(fontSize: 24),
      ),
    ),
    body: Center(
      child: isLoading
          ? CircularProgressIndicator()
          : products.isEmpty
          ? Text(
        'No products have been added.',
        style: TextStyle(color: Colors.grey, fontSize: 24),
      )
          : buildProducts(),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.pink,
      child: Icon(Icons.add),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AddEditProductPage()),
        );

        refreshProducts();
      },
    ),
  );

  Widget buildProducts() => StaggeredGridView.countBuilder(
    padding: EdgeInsets.all(8),
    itemCount: products.length,
    staggeredTileBuilder: (index) => StaggeredTile.fit(2),
    crossAxisCount: 4,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    itemBuilder: (context, index) {
      final product = products[index];

      return GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailPage(productId: product.id!),
          ));

          refreshProducts();
        },
        child: ProductCardWidget(product: product, index: index),
      );
    },
  );
}
