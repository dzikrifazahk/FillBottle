import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:fill_bottle/landing_page.dart';

class IntroPage extends StatelessWidget {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoard(
        pageController: _pageController,
        // Either Provide onSkip Callback or skipButton Widget to handle skip state
        onSkip: () {},
        // Either Provide onDone Callback or nextButton Widget to handle done state
        onDone: () {
          // print('done tapped');
        },
        onBoardData: onBoardData,
        titleStyles: const TextStyle(
          color: Colors.deepOrange,
          fontSize: 18,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.15,
        ),
        descriptionStyles: TextStyle(
          fontSize: 16,
          color: Colors.brown.shade300,
        ),
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
          },
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      _pageController.animateToPage(
        onBoardState.page + 3,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    }
  }
}

final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "",
    description: "",
    imgUrl: "assets/images/introduction/pertama.png",
  ),
  const OnBoardModel(
    title: "",
    description: "",
    imgUrl: 'assets/images/introduction/kedua.png',
  ),
  const OnBoardModel(
    title: "",
    description: "",
    imgUrl: 'assets/images/introduction/ketiga.png',
  ),
  const OnBoardModel(
    title: "",
    description: "",
    imgUrl: 'assets/images/introduction/keempat.png',
  ),
];
