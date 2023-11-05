import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../const.dart';
import '../models/cart_model.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../models/size_options_model.dart';
import 'cartpage.dart';
import 'homepage.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  final Function(CartItem) onAddToCart;
  const DetailPage({Key? key, required this.product, required this.onAddToCart})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int selectedSize = 0;
  int quantity = 1;

  double getAdjustedPrice() {
    switch (selectedSize) {
      case 1: // Medium
        return widget.product.price + 30;
      case 2: // Large
        return widget.product.price + 100;
      default:
        return widget.product.price; // Small
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedProduct = widget.product;
    final adjustedPrice = getAdjustedPrice();
    final cartItem = CartItem(product: selectedProduct, quantity: quantity, totalPrice: adjustedPrice);

    bool isBakeryCategory = widget.product.category.name == categories[3].name;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkbrown,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            // controller.stop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: lightbrown,
          ),
        ),
        title: const Text(
          'Details',
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
                          builder: (context) => CartPage(
                            cartItems: [cartItem],
                          ),
                        ));
                  },
                  child: const Icon(
                    Icons.shopping_cart_outlined,
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
      body: Stack(children: [
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
        Positioned(
          left: 20,
          right: 20,
          child: Column(
            children: [
              Hero(
                tag: widget.product.name,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.50,
                  child: ProductImage(product: widget.product),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 35,
                    width: MediaQuery.of(context).size.width - 150,
                    child: Text(
                      widget.product.name,
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                      style: const TextStyle(
                          color: white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\u{20B9}${getAdjustedPrice()}',
                        style: const TextStyle(
                            color: white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
              // const SizedBox(height: 3),
              if (!isBakeryCategory) // Check if not a Bakery category
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Size Options',
                      style: TextStyle(
                          color: white.withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...List.generate(sizeOptions.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSize = index;
                              });
                            },
                            child: SizeOptionItem(
                              index: index,
                              selected: selectedSize == index ? true : false,
                              sizeOption: sizeOptions[index],
                            ),
                          );
                        })
                      ],
                    )
                  ],
                ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (quantity > 1) {
                              quantity--;
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: lightbrown,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: darkbrown,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        quantity.toString(),
                        style: const TextStyle(
                            color: white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: lightbrown,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: darkbrown,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        widget.onAddToCart(cartItem);
                        Provider.of<CartModel>(context, listen: false).addToCart(cartItem);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('${cartItem.product.name} added to cart'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              color: lightbrown,
                              borderRadius: BorderRadius.circular(30)),
                          child: const Center(
                              child: Text(
                            'Add to Order',
                            style: TextStyle(
                                color: darkbrown,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ))),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}

//------------------Size options----------------------
class SizeOptionItem extends StatelessWidget {
  final int index;
  final SizeOption sizeOption;
  final bool selected;
  const SizeOptionItem({
    Key? key,
    required this.index,
    required this.sizeOption,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 66,
          width: 66,
          decoration: BoxDecoration(
              color: selected ? lightbrown : darkbrown, shape: BoxShape.circle),
          child: Center(
            child: SvgPicture.asset(
              'assets/coffee-cup.svg',
              color: selected ? darkbrown : lightbrown,
              width: 26 + (index * 5),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(sizeOption.name,
            style: const TextStyle(
                color: white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5)),
        Text(
          '${sizeOption.quantity} ml',
          style: TextStyle(color: white.withOpacity(0.7), fontSize: 12),
        )
      ],
    );
  }
}
