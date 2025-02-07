
import 'package:flutter/material.dart';

import '../models/category.dart';

class DropdownButtonCategories extends StatefulWidget {
  final List<Category> categories;
  final String? defaultValue;
  final ValueChanged<String?>? onChanged;
  const DropdownButtonCategories(
      {super.key,
      this.categories = const [],
      this.defaultValue,
      this.onChanged});

  @override
  State<DropdownButtonCategories> createState() =>  DropdownButtonCategoriesState();
}

class DropdownButtonCategoriesState extends State<DropdownButtonCategories> {
  String? selectedValue;
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {

    if (!isLoaded) {
      selectedValue = widget.defaultValue ??
        (widget.categories.isNotEmpty ? widget.categories.first.id : null);
      isLoaded = true;    
    }

    return DropdownButton<String>(
      value: selectedValue,
      onChanged: (String? value) {
        setState(() {
          selectedValue = value;
        });
        widget.onChanged?.call(value);
      },
      items: widget.categories.map((Category category) {
        return DropdownMenuItem<String>(
          value: category.id,
          child: Text(category.name),
        );
      }).toList(),
    );
  }
}
