import 'package:flutter/material.dart';

import '../models/product.dart';
import 'add_product_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({required this.product, super.key});

  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

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
          product.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final updatedProduct = await Navigator.push<Product>(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddProductScreen(product: product);
                  },
                ),
              );

              if (!mounted || updatedProduct == null) {
                return;
              }

              Navigator.pop(context, updatedProduct);
            },
            icon: const Icon(Icons.edit_outlined, size: 18),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 124,
              width: double.infinity,
              decoration: BoxDecoration(
                color: product.color,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(product.icon, size: 58, color: _iconColor(product)),
            ),
            const SizedBox(height: 12),
            Text(
              product.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              '\$${product.price.toStringAsFixed(1)}',
              style: const TextStyle(
                color: Color(0xff1664e8),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              product.description,
              style: const TextStyle(color: Colors.grey, fontSize: 9),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const Text(
                  'Qty',
                  style: TextStyle(color: Colors.grey, fontSize: 9),
                ),
                const SizedBox(width: 10),
                _QuantityButton(
                  icon: Icons.remove,
                  onPressed: quantity > 1
                      ? () {
                          setState(() {
                            quantity--;
                          });
                        }
                      : null,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    '$quantity',
                    style: const TextStyle(fontSize: 11),
                  ),
                ),
                _QuantityButton(
                  icon: Icons.add,
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        child: SizedBox(
          height: 44,
          child: FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xff2864e8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Text('Add to cart', style: TextStyle(fontSize: 10)),
          ),
        ),
      ),
    );
  }

  Color _iconColor(Product product) {
    switch (product.name) {
      case 'Headphones':
        return const Color(0xff009b72);
      case 'T-shirt':
        return const Color(0xffd34300);
      case 'Laptop':
        return const Color(0xff7c3aed);
      case 'Camera':
        return const Color(0xff4d7c0f);
      case 'Backpack':
        return const Color(0xffc02667);
      default:
        return const Color(0xff2864e8);
    }
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          side: const BorderSide(color: Color(0xffe0e0e0)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Icon(icon, size: 14),
      ),
    );
  }
}
