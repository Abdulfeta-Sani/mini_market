import 'package:flutter/material.dart';

import '../data/product_data.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'add_product_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final List<Product> productList;
  final List<CartItem> cartItems = [];

  @override
  void initState() {
    super.initState();
    productList = List<Product>.from(products);
  }

  Future<void> openAddProductScreen() async {
    final newProduct = await Navigator.push<Product>(
      context,
      MaterialPageRoute(builder: (context) => const AddProductScreen()),
    );

    if (!mounted || newProduct == null) {
      return;
    }

    setState(() {
      productList.add(newProduct);
    });
  }

  void addProductToCart(Product product) {
    final existingIndex = cartItems.indexWhere(
      (item) => item.product.name == product.name,
    );

    setState(() {
      if (existingIndex == -1) {
        cartItems.add(CartItem(product: product));
      } else {
        cartItems[existingIndex].quantity++;
      }
    });
  }

  void openCartScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CartScreen(
            cartItems: cartItems,
            onCartChanged: () {
              setState(() {});
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Mini Market',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: openCartScreen,
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black87,
                  size: 21,
                ),
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 3,
                  top: 5,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cartItems.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
        child: GridView.builder(
          itemCount: productList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
            childAspectRatio: 0.82,
          ),
          itemBuilder: (context, index) {
            return ProductCard(
              product: productList[index],
              onProductAdded: addProductToCart,
              onProductUpdated: (updatedProduct) {
                setState(() {
                  productList[index] = updatedProduct;
                });
              },
              onProductDeleted: () {
                setState(() {
                  productList.removeAt(index);
                });
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddProductScreen,
        backgroundColor: const Color(0xffdce4ff),
        foregroundColor: const Color(0xff4e5fd5),
        elevation: 3,
        child: const Icon(Icons.add),
      ),
    );
  }
}
