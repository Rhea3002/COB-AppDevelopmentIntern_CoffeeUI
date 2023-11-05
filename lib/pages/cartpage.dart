// Define the CartItem model
import 'package:coffee/pages/checkout.dart';
import 'package:coffee/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartItem {
  final Product product;
  final int quantity;
  final double totalPrice;

  CartItem({
    required this.product,
    required this.quantity,
    required this.totalPrice,
  });
}

// CartPage widget
class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;

  const CartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double calculateTotalCartValue(List<CartItem> cartItems) {
    double totalValue = 0.0;
    for (var cartItem in cartItems) {
      totalValue += cartItem.totalPrice * cartItem.quantity;
    }
    return totalValue;
  }

  @override
  Widget build(BuildContext context) {
    List<CartItem> cartItems = Provider.of<CartModel>(context).cartItems;
    double totalValue = calculateTotalCartValue(cartItems);
    return Scaffold(
      backgroundColor: lightbrown,
      appBar: AppBar(
        backgroundColor: darkbrown,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: lightbrown,
          ),
        ),
        title: const Text(
          'Cart Page',
          style: TextStyle(
              color: lightbrown, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Center(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  child: const Icon(
                    Icons.coffee,
                    color: lightbrown,
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 0,
                  child: Container(
                    width: 7.5,
                    height: 7.5,
                    decoration: const BoxDecoration(
                        color: white, shape: BoxShape.circle),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: Consumer<CartModel>(builder: (context, cart, child) {
        return Stack(
          children: <Widget>[
            if (cart.cartItems.isEmpty)
              Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/nocoffee.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      const Text(
                        "Empty :(",
                        style: TextStyle(
                            color: darkbrown,
                            fontSize: 36,
                            fontWeight: FontWeight.w900),
                      )
                    ],
                  ),
                ],
              ),
            if (cart.cartItems.isNotEmpty)
              Stack(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/coffee_bg.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Content with transparency
                  Container(
                    color: Colors.black.withOpacity(0.6),
                  ),
                  ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      return SingleChildScrollView(
                        child: Container(
                          child: ListTile(
                              leading: const CircleAvatar(
                                child: Icon(
                                  Icons.coffee_maker_sharp,
                                  color: darkbrown,
                                ),
                                backgroundColor: lightbrown,
                              ),
                              title: Text(
                                cartItem.product.name,
                                style: const TextStyle(
                                    color: lightbrown,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Quantity: ${cartItem.quantity}',
                                style: const TextStyle(
                                    color: lightbrown,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '\u{20B9}${cartItem.totalPrice * cartItem.quantity}',
                                      style: const TextStyle(
                                          color: lightbrown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () =>
                                          cart.removeFromCart(cartItem),
                                      child: SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: Image.asset(
                                            'assets/dustbin.png'), // Replace 'dustbin.jpg' with your image path
                                      ),
                                    ),
                                  ])),
                        ),
                      );
                    },
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Total: \u{20B9}${totalValue.toStringAsFixed(2)}', // Formatting to two decimal places
                          style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 22,
                              color: lightbrown),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          cart.clearCart();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CheckOut()),
                          );
                        },
                        child: Expanded(
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                  color: lightbrown,
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Center(
                                  child: Text(
                                'Sip It →',
                                style: TextStyle(
                                    color: darkbrown,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ],
              )
          ],
        );
      }),
    );
  }
}
