import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scene_chat/pages/signup/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 4;
              });
            },
            children: const [
              BuildPage(
                image: "assets/logos/SceneChat_logo.png",
                title: "",
                pageColor: Colors.white30,
                isAnimatedImage: false,
                description:
                    "Welcome to Scene Chat. A chat app that puts you into different chat scenarios. ",
              ),
              BuildPage(
                image: "assets/lottie_animations/game-asset.json",
                title: "Choices",
                pageColor: Colors.white30,
                isAnimatedImage: true,
                description:
                    "Your choices will determine the path you take and the outcome of the story. Let's get started! ",
              ),
              BuildPage(
                image: "assets/lottie_animations/winning-badge.json",
                title: "Winning is simple",
                pageColor: Colors.white30,
                isAnimatedImage: true,
                description:
                    "Get ready to immerse yourself in an interactive story like no other. Every decision you make will lead to new adventures and endings.",
              ),
              BuildPage(
                image: "assets/lottie_animations/gift-box.json",
                title: "Plot twists",
                pageColor: Colors.white30,
                isAnimatedImage: true,
                description:
                    "It's time to embark on a journey full of twists and turns, where your choices will shape the story.",
              ),
              BuildPage(
                image: "assets/lottie_animations/air-balloon.json",
                title: "Get Started",
                pageColor: Colors.white30,
                isAnimatedImage: true,
                description:
                    "Are you ready for an immersive storytelling experience? With every decision you make, the story changes. Let's begin your journey!",
              ),
            ],
          ),
        ),
        bottomSheet: isLastPage
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: Colors.black,
                      minimumSize: const Size.fromHeight(80),
                    ),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isfirstTime', true);

                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const NewSignUpPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return child;
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                  ),
                ),
              )
            : Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.5, vertical: 5),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          _pageController.jumpToPage(4);
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: 4,
                        effect: SlideEffect(
                          spacing: 8.0,
                          // radius: 4.0,
                          dotWidth: 5.0,
                          dotHeight: 16.0,
                          paintStyle: PaintingStyle.stroke,
                          strokeWidth: 1.5,
                          dotColor: Colors.grey[200]!,
                          activeDotColor:
                              Theme.of(context).colorScheme.secondary,
                        ),
                        onDotClicked: (index) {
                          _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ),
                  ],
                )),
      ),
    );
  }
}

class BuildPage extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final Color pageColor;
  final bool isAnimatedImage;

  const BuildPage({
    Key? key,
    required this.title,
    required this.image,
    required this.pageColor,
    required this.description,
    required this.isAnimatedImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: pageColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isAnimatedImage
              ? Lottie.asset(
                  image,
                  height: 220,
                )
              : Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: 250,
                  alignment: Alignment.center,
                ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  description,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // SizedBox(height: 50),
        ],
      ),
    );
  }
}
