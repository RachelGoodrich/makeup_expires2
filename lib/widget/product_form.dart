import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:date_time_picker/date_time_picker.dart';

class ProductFormWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final DateTime? createdTime;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<DateTime> onChangedCreatedTime;



  const ProductFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    // DateTime? createdTime,
    this.createdTime,
    // required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedCreatedTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            tooltip: 'Tap to open date picker',
            onPressed: () {
              final createdTime = showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2015, 8),
                lastDate: DateTime(2101),
              );
              onChanged: (createdTime) => onChangedCreatedTime(createdTime);
            },
          ),
          buildTitle(),
          SizedBox(height: 8),
          buildDescription(),
          SizedBox(height: 16),
        ],
      ),
    ),
  );

  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: title,
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Product Type',
      hintStyle: TextStyle(color: Colors.black),
    ),
    validator: (title) =>
    title != null && title.isEmpty ? 'The product type cannot be empty' : null,
    onChanged: onChangedTitle,
  );

  Widget buildDescription() => TextFormField(
    maxLines: 5,
    initialValue: description,
    style: TextStyle(color: Colors.black, fontSize: 18),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Enter the brand and product specifics here!',
      hintStyle: TextStyle(color: Colors.black),
    ),
    validator: (title) => title != null && title.isEmpty
        ? 'The description cannot be empty'
        : null,
    onChanged: onChangedDescription,
  );

}
