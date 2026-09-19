import 'package:flutter/material.dart';

class Product {
  const Product({
    required this.name,
    required this.price,
    required this.icon,
    required this.color,
    required this.description,
    this.category = 'smartphones',
  });

  final String name;
  final double price;
  final IconData icon;
  final Color color;
  final String description;
  final String category;
}
