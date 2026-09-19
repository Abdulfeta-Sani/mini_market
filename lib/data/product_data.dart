import 'package:flutter/material.dart';

import '../models/product.dart';

const products = [
  Product(
    name: 'Phone X',
    price: 549.0,
    icon: Icons.phone_android,
    color: Color(0xffe4ecff),
    description: 'Modern smartphone with a clear display.',
    category: 'smartphones',
  ),
  Product(
    name: 'Headphones',
    price: 89.0,
    icon: Icons.headphones,
    color: Color(0xffdff3ee),
    description: 'Over-ear headphones with 30 hours of battery life.',
    category: 'accessories',
  ),
  Product(
    name: 'T-shirt',
    price: 15.0,
    icon: Icons.checkroom,
    color: Color(0xffffe9df),
    description: 'Comfortable everyday cotton T-shirt.',
    category: 'clothing',
  ),
  Product(
    name: 'Laptop',
    price: 899.0,
    icon: Icons.laptop,
    color: Color(0xffeee5ff),
    description: 'Powerful laptop for work and study.',
    category: 'computers',
  ),
  Product(
    name: 'Camera',
    price: 320.0,
    icon: Icons.camera_alt,
    color: Color(0xffeaf0df),
    description: 'Compact camera for capturing memorable moments.',
    category: 'electronics',
  ),
  Product(
    name: 'Backpack',
    price: 42.0,
    icon: Icons.backpack,
    color: Color(0xffffe4ee),
    description: 'Lightweight backpack for daily use.',
    category: 'bags',
  ),
];
