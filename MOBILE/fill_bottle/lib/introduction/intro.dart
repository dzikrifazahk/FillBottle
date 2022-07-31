// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:fill_bottle/landing_page.dart';
import 'package:fill_bottle/home/home_page.dart';

class IntroPage extends StatelessWidget {
  final PageController _pageController = PageController();
  int halaman;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: OnBoard(
        onBoardData: onBoardData,
        pageController: _pageController,
        // Either Provide onSkip Callback or skipButton Widget to handle skip state
        onSkip: () {},
        // Either Provide onDone Callback or nextButton Widget to handle done state
        onDone: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LandingPage()),
          );
        },
        pageIndicatorStyle: const PageIndicatorStyle(
          width: 100,
          inactiveColor: Color.fromARGB(255, 162, 161, 164),
          activeColor: Color.fromARGB(255, 159, 94, 238),
          inactiveSize: Size(8, 8),
          activeSize: Size(12, 12),
        ),
        // Either Provide onSkip Callback or skipButton Widget to handle skip state
        skipButton: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LandingPage()),
            );
          },
          child: const Text(
            "Skip",
            style: TextStyle(color: Color.fromARGB(255, 159, 94, 238)),
          ),
        ),
        // Either Provide onDone Callback or nextButton Widget to handle done state
        nextButton: OnBoardConsumer(
          builder: (context, ref, child) {
            final state = ref.watch(onBoardStateProvider);
            if (halaman == 3) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color.fromARGB(255, 159, 94, 238),
                                    Color.fromARGB(255, 220, 114, 241),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                              primary: Colors.white,
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LandingPage()),
                              );
                            },
                            child: const Text('Done'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return InkWell(
                onTap: () => _onNextTap(state),
                child: Container(
                  width: 230,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 159, 94, 238),
                        Color.fromARGB(255, 220, 114, 241),
                      ],
                    ),
                  ),
                  child: Text(
                    state.isLastPage ? "Done" : "Next",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        halaman = onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
      print(halaman);
    } else {
      print('pindah halaman');
    }
  }
}

Widget AllProduct(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
      );
    },
    child: const Text(
      "Skip",
      style: TextStyle(color: Color.fromARGB(255, 159, 94, 238)),
    ),
  );
}

final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "",
    description: "",
    imgUrl: "assets/images/introduction/intro1.png",
  ),
  const OnBoardModel(
    title: "",
    description: "",
    imgUrl: 'assets/images/introduction/intro2.png',
  ),
  const OnBoardModel(
    title: "",
    description: "",
    imgUrl: 'assets/images/introduction/intro3.png',
  ),
  const OnBoardModel(
    title: "",
    description: "",
    imgUrl: 'assets/images/introduction/intro4.png',
  ),
];
