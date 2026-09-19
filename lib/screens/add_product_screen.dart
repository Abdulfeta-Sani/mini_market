import 'package:flutter/material.dart';

import '../models/product.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({this.product, super.key});

  final Product? product;

  bool get isEditing => product != null;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController titleController;
  late final TextEditingController priceController;
  late final TextEditingController descriptionController;

  late String selectedCategory;

  @override
  void initState() {
    super.initState();

    final product = widget.product;

    titleController = TextEditingController(text: product?.name ?? 'Desk lamp');
    priceController = TextEditingController(
      text: product?.price.toStringAsFixed(0) ?? '0',
    );
    descriptionController = TextEditingController(
      text: product?.description ?? 'Short description',
    );
    selectedCategory = product?.category ?? 'smartphones';
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void saveProduct() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final oldProduct = widget.product;

    final product = Product(
      name: titleController.text.trim(),
      price: double.parse(priceController.text.trim()),
      icon: oldProduct?.icon ?? Icons.lightbulb_outline,
      color: oldProduct?.color ?? const Color(0xfffff1cc),
      description: descriptionController.text.trim(),
      category: selectedCategory,
    );

    Navigator.pop(context, product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          widget.isEditing ? 'Edit product' : 'Add product',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            _FormLabel(text: 'Title'),
            _TextField(
              controller: titleController,
              validator: requiredValidator,
            ),
            const SizedBox(height: 14),
            _FormLabel(text: 'Price'),
            _TextField(
              controller: priceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: priceValidator,
            ),
            const SizedBox(height: 14),
            _FormLabel(text: 'Category'),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: _inputDecoration(),
              items: const [
                DropdownMenuItem(
                  value: 'smartphones',
                  child: Text('smartphones'),
                ),
                DropdownMenuItem(
                  value: 'accessories',
                  child: Text('accessories'),
                ),
                DropdownMenuItem(value: 'clothing', child: Text('clothing')),
                DropdownMenuItem(value: 'computers', child: Text('computers')),
                DropdownMenuItem(
                  value: 'electronics',
                  child: Text('electronics'),
                ),
                DropdownMenuItem(value: 'bags', child: Text('bags')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedCategory = value;
                  });
                }
              },
            ),
            const SizedBox(height: 14),
            _FormLabel(text: 'Description'),
            _TextField(
              controller: descriptionController,
              maxLines: 4,
              validator: requiredValidator,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        child: SizedBox(
          height: 44,
          child: FilledButton(
            onPressed: saveProduct,
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xff2864e8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Text(
              widget.isEditing ? 'Save product' : 'Save product',
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ),
      ),
    );
  }

  String? requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }

    return null;
  }

  String? priceValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }

    if (double.tryParse(value.trim()) == null) {
      return 'Enter a valid price';
    }

    return null;
  }
}

class _FormLabel extends StatelessWidget {
  const _FormLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style: const TextStyle(color: Colors.grey, fontSize: 9),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    required this.controller,
    required this.validator,
    this.keyboardType,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(fontSize: 10),
      decoration: _inputDecoration(),
    );
  }
}

InputDecoration _inputDecoration() {
  return InputDecoration(
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: Color(0xff9e9e9e)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: Color(0xff9e9e9e)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: Color(0xff2864e8)),
    ),
  );
}
