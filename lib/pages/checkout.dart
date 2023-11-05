import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../const.dart';
import 'homepage.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final controller = ConfettiController();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    controller.play();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          backgroundColor: brown,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: darkbrown,
            elevation: 0,
            title: const Text(
              'Yay!',
              style: TextStyle(
                  color: lightbrown, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              ConfettiWidget(
                        confettiController: controller,
                        shouldLoop: true,
                        emissionFrequency: 0.1,
                        gravity: 0.2,
                        colors: const [brown, lightbrown, white, darkbrown],
                        blastDirectionality: BlastDirectionality.explosive,
                      ),
              Container(
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeInUp(
                        duration: const Duration(milliseconds: 1500),
                        child: Image.asset(
                          'assets/success.gif',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "You’ve made a great choice.\nYour order is complete.",
                        style: TextStyle(
                            color: lightbrown,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                       const SizedBox(
                        height: 5,
                      ),
                      //button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              darkbrown, // Set the background color
                          foregroundColor: lightbrown, // Set the text color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Set rounded border radius
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Sip Some More',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ]),
              )
            ],
          )),
    );
  }
}
