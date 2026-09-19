import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
        side: const BorderSide(color: Color(0xffe0e0e0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: product.color,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(product.icon, size: 25, color: _iconColor(product)),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              product.name,
              style: const TextStyle(fontSize: 9, color: Colors.black87),
            ),
            const SizedBox(height: 1),
            Text(
              '\$${product.price.toStringAsFixed(1)}',
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 3),
          ],
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
