import 'dart:math';
import 'package:coffee/pages/cartpage.dart';
import 'package:coffee/pages/onboarding_srn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../const.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import 'detailpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentCategory = 0;
  int currentProduct = 0;
  PageController? controller;
  double viewPortFraction = 0.6;
  double? pageOffset = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        PageController(initialPage: 1, viewportFraction: viewPortFraction)
          ..addListener(() {
            setState(() {
              pageOffset = controller!.page;
            });
          });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.dispose();
  }

  void addToCart(CartItem cartItem){

  }

  @override
  Widget build(BuildContext context) {
    List<Product> dataProducts = products
        .where((element) => element.category == categories[currentCategory])
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkbrown,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OnBoard(),
                ));
          },
          child: Center(
            child: SvgPicture.asset(
              'assets/coffee-cup.svg',
              color: lightbrown,
              width: 24,
            ),
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Coffee UI',
              style: TextStyle(
                  color: lightbrown, fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
        actions: [
          Center(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(cartItems: [],)
                        ));
                  },
                  child: const Icon(
                    Icons.shopping_cart,
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
      //----------------------BODY----------------------------------------------------
      body: Stack(
        children: <Widget>[
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/coffee_bg.jpg'), // Replace with your JPG image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content with transparency
          Container(
            color: Colors.black.withOpacity(0.6),
          ), // Adjust the opacity (0.0 - 1.0)
          Positioned(
            top: 30.0,
            left: 40.0,
            right: 40.0,
            child: Text(
              'For Every Taste and Mood 🤍'.toUpperCase(),
              style: const TextStyle(
                  color: white,
                  fontSize: 26.0,
                  fontWeight: FontWeight.w900),
            ),
          ),
          //------------------Main Products BG-----------------
          Positioned(
            bottom: 80,
            child: ClipPath(
              clipper: Clip(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.52,
                width: MediaQuery.of(context).size.width,
                color: transparent,
              ),
            ),
          ),
          //---------------------Product Center----------------
          Positioned(
            bottom: 110,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                ClipPath(
                  clipper: Clip(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.60,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                        controller: controller,
                        onPageChanged: (value) {
                          setState(() {
                            currentProduct = value % dataProducts.length;
                          });
                        },
                        itemBuilder: (context, index) {
                          double scale = max(
                              viewPortFraction,
                              (1 -
                                  (pageOffset! - index).abs() +
                                  viewPortFraction));
                          double angle = 0.0;
                          if (controller!.position.haveDimensions) {
                            angle = index.toDouble() - (controller!.page ?? 0);
                            angle = (angle * 0.05).clamp(-1, 1);
                          } else {
                            angle = index.toDouble() - (1);
                            angle = (angle * 0.05).clamp(-1, 1);
                          }

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                        product: dataProducts[
                                            index % dataProducts.length],
                                            onAddToCart: addToCart,),
                                  ));
                            },
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: 180 - (scale / 1.6 * 180)),
                                child: Transform.rotate(
                                    angle: angle * pi,
                                    child: Stack(
                                        alignment:
                                            AlignmentDirectional.topCenter,
                                        children: [
                                          ProductImage(
                                            product: dataProducts[
                                                index % dataProducts.length],
                                          ),
                                        ]))),
                          );
                          // return Container(
                          //   width:100,
                          //   height: 100,
                          //   decoration: const BoxDecoration(
                          //     color: lightbrown, shape: BoxShape.circle
                          //   ),);
                        }),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dataProducts[currentProduct].name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: white,
                              fontSize: 27,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '\u{20B9}${dataProducts[currentProduct].price}',
                            style: const TextStyle(
                                color: white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        ...List.generate(
                            dataProducts.length, (index) => indicator(index))
                      ],
                    ),
                    // const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
          //------------------Selected Category--------------
          // Positioned(
          //   bottom: 0,
          //   child: ClipPath(
          //     clipper: Clip(),
          //     child: Container(
          //       height: 105,
          //       width: MediaQuery.of(context).size.width,
          //       color: darkbrown,
          //       child: Row(
          //         children: [
          //           ...List.generate(
          //               categories.length,
          //               (index) => Container(
          //                     height: 105,
          //                     width: MediaQuery.of(context).size.width /
          //                         categories.length,
          //                     color: currentCategory == index
          //                         ? lightbrown
          //                         : transparent,
          //                   ))
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          //-------------------------Display Category-----------------------
          Positioned(
              bottom: 0,
              child: ClipPath(
                clipper: Clip(),
                child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    color: darkbrown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...List.generate(categories.length, (index) {
                          return Container(
                            height: 102,
                            width: MediaQuery.of(context).size.width /
                                categories.length,
                            color: currentCategory == index ? brown : darkbrown,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentCategory = index;
                                  dataProducts = products
                                      .where((element) =>
                                          element.category ==
                                          categories[currentCategory])
                                      .toList();
                                  if (controller!.hasClients) {
                                    controller!.animateToPage(1,
                                        duration:
                                            const Duration(milliseconds: 250),
                                        curve: Curves.easeInOut);
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15, bottom: 3),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 55,
                                      width: 55,
                                      decoration: const BoxDecoration(
                                          color: lightbrown,
                                          shape: BoxShape.circle),
                                      child: Image.asset(
                                          'assets/${categories[index].image}'),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      categories[index].name.toUpperCase(),
                                      style: const TextStyle(
                                          color: lightbrown,
                                          fontSize: 10,
                                          letterSpacing: 1.5,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                      ],
                    )),
              )),
        ],
      ),
    );
  }

  AnimatedContainer indicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            width: 3,
            color: index == currentProduct ? lightbrown : transparent),
      ),
      child: Container(
          // margin: const EdgeInsets.only(right: 5),
          width: 5,
          height: 5,
          decoration: BoxDecoration(
              color: index == currentProduct ? white : white.withOpacity(0.6),
              shape: BoxShape.circle)),
    );
  }
}

//----------------Clipping Class------------------------------------
class Clip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 20);
    path.quadraticBezierTo(size.width / 2, -20, 0, 20);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

//-------------------------------Product Image class----------------------
class ProductImage extends StatelessWidget {
  final Product product;
  const ProductImage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrain) {
        return SizedBox(
          height: constrain.maxWidth * 1.25,
          width: constrain.maxWidth,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                width: constrain.maxWidth * 0.9,
                height: constrain.maxWidth * 0.9,
                decoration: const BoxDecoration(
                    color: lightbrown, shape: BoxShape.circle),
              ),
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(constrain.maxWidth * 0.45)),
                child: SizedBox(
                  width: constrain.maxWidth * 0.9,
                  height: constrain.maxWidth * 1.4,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Positioned(
                          bottom: -60,
                          width: constrain.maxWidth * 0.9,
                          height: constrain.maxWidth * 1.4,
                          child: Image.asset(
                            'assets/${product.image}',
                            fit: BoxFit.contain,
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
