import 'package:coffee/const.dart';
import 'package:coffee/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:flashcolor,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 50),
            FadeInRight(
              duration: const Duration(milliseconds: 1500),
              child: Image.network('https://cdn.dribbble.com/users/209133/screenshots/741414/media/2d870035551e87e14bdd22e65e3b37ec.gif'
              ,fit: BoxFit.cover,),
            ),
            FadeInUp( //slide effect
              duration: const Duration(milliseconds: 1000),
              delay: const Duration(milliseconds: 500),
              child: Container(
                padding: const EdgeInsets.only(left: 40, top: 40, right: 20, bottom: 50),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: darkbrown,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:const Color(0xffFFC3A6).withOpacity(0.5),
                      offset: const Offset(0, -5),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      delay: const Duration(milliseconds: 1000),
                      from: 50,
                      child: const Text(
                        'Discover new flavors and \naromas of coffee in town.🏘️',
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: lightbrown,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    FadeInUp(
                      duration:const Duration(milliseconds: 1000),
                      delay:const Duration(milliseconds: 1000),
                      from: 60,
                      child: Text(
                        'Brew the perfect cup of coffee every time ☕',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: white.withOpacity(0.8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInUp(
                      duration:const Duration(milliseconds: 1000),
                      delay:const Duration(milliseconds: 1000),
                      from: 70,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            // reload the page
                            // Navigator.of(context).pushReplacementNamed('/');
                             Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ));
                          },
                          child: const Text(
                            'EXPLORE NOW 🍪',
                            style: TextStyle(
                              fontSize: 16,
                              color: lightbrown,
                              fontWeight: FontWeight.w800
                            ),
                          ),
                        ),
                      ),
                    )
                  ]
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}