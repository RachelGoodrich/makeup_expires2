import 'package:flutter/material.dart';
import 'package:makeup_expires2/db/product_database.dart';
import 'package:makeup_expires2/model/product.dart';
import 'package:makeup_expires2/widget/product_form.dart';

class AddEditProductPage extends StatefulWidget {
  final Product? product;

  const AddEditProductPage({
    Key? key,
    this.product,
  }) : super(key: key);
  @override
  _AddEditProductPageState createState() => _AddEditProductPageState();
}

class _AddEditProductPageState extends State<AddEditProductPage> {
  final _formKey = GlobalKey<FormState>();
  late int number;
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    number = widget.product?.number ?? 0;
    title = widget.product?.title ?? '';
    description = widget.product?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [buildButton()],
    ),
    body: Form( 
      key: _formKey,
      child: ProductFormWidget(
        number: number,
        title: title,
        description: description,
        onChangedNumber: (number) => setState(() => this.number = number),
        onChangedTitle: (title) => setState(() => this.title = title),
        onChangedDescription: (description) =>
            setState(() => this.description = description),
      ),
    ),
  );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.pinkAccent,
        ),
        onPressed: addOrUpdateProduct,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateProduct() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.product != null;

      if (isUpdating) {
        await updateProduct();
      } else {
        await addProduct();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateProduct() async {
    final product = widget.product!.copy(
      number: number,
      title: title,
      description: description,
    );

    await ProductsDatabase.instance.update(product);
  }

  Future addProduct() async {
    final product = Product(
      title: title,
      number: number,
      description: description,
      createdTime: DateTime.now(),
    );

    await ProductsDatabase.instance.create(product);
  }
}
