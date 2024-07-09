import 'package:basecode/components/intro_screen.dart';
import 'package:basecode/services/auth/screen/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  isLastPage = value == 2;
                });
              },
              controller: _controller,
              children: [
                IntroScreen(
                  imagePath: 'assets/illustrations/intro_1.png',
                  heading: "Be easier to manage your own money",
                  sub_heading:
                      "Just using your phone, you can manage all your cashflow more easily.",
                ),
                IntroScreen(
                  imagePath: 'assets/illustrations/intro_2.png',
                  heading: "Be more flexible and secure",
                  sub_heading:
                      "Use this platform in all your devices, don\'t worry about anything, we protect you.",
                ),
                IntroScreen(
                  imagePath: 'assets/illustrations/intro_3.png',
                  heading: "Easy way to manage your expense",
                  sub_heading:
                      "Save your future by managing your expense right now",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  alignment: Alignment(0, 0.75),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _controller.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFFDF8F8),
                            borderRadius: BorderRadius.circular(20)),
                        width: 100,
                        height: 40,
                        child: Center(
                          child: Text(
                            "Back",
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (isLastPage) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LogInScreen(),
                            ),
                          );
                          final pref = await SharedPreferences.getInstance();
                          pref.setBool('home', true);
                        } else {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color(0xFF0265FF),
                            borderRadius: BorderRadius.circular(20)),
                        height: 40,
                        child: Center(
                          child: Text(
                            isLastPage ? "Get Started" : "Next",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}