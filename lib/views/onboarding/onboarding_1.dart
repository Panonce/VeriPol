import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veripol/components/themes.dart';
import 'package:veripol/views/signup_dashboard.dart';

import '../../components/dot_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int pageCount = 3;
  int pageIndex = 0;
  final pageViewController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = mockUpWidth / size.width;
    final textScale = size.width / mockUpWidth;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/bg_pattern.png'),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/tr_wave.png',
              width: 250,
              scale: scale,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/bl_wave.png',
              width: 250,
              scale: scale,
            ),
          ),
          Positioned(
            top: 80,
            left: size.width / 2 -
                (((20.0 * pageCount) / mockUpWidth * size.width) / 2),
            child: DotIndicator(
              pageCount: pageCount,
              pageIndex: pageIndex,
            ),
          ),
          SizedBox(
            height: size.height,
            width: size.width,
            child: PageView(
              controller: pageViewController,
              onPageChanged: (val) {
                setState(() {
                  pageIndex = val;
                });
              },
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/mobile_12.png',
                        scale: scale,
                      ),
                      Text(
                        'My Candidates',
                        textScaleFactor: textScale,
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                            height: 1.5,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 295 / mockUpWidth * size.width,
                        child: Text(
                          'Do your research and Fill in your ballot before entering the polling place',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 1.5,
                              letterSpacing: 0,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/mobile_34.png'),
                      Text(
                        'Candidate Profile',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                            height: 1.5,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 295 / mockUpWidth * size.width,
                        child: Text(
                          'Learn about the candidates through our candidates profile feature',
                          textScaleFactor: textScale,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 1.5,
                              letterSpacing: 0,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/mobile_56.png',
                        scale: scale,
                      ),
                      Text(
                        'Courses',
                        textScaleFactor: textScale,
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                            height: 1.5,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 295 / mockUpWidth * size.width,
                        child: Text(
                          'Learn about the positions the candidates are running for',
                          textScaleFactor: textScale,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 1.5,
                              letterSpacing: 0,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 10.0 / mockUpWidth * size.width),
              width: size.width,
              height: 50 / mockUpHeight * size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  pageIndex == 0
                      ? Container()
                      : InkWell(
                          onTap: () {
                            pageIndex--;
                            if (pageIndex < 0) pageIndex = 0;
                            pageViewController.animateToPage(pageIndex,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut);
                            setState(() {});
                          },
                          child: SizedBox(
                            width: 60 / mockUpWidth * size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Back',
                                  textScaleFactor: textScale,
                                  style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      height: 1.5,
                                      letterSpacing: 0,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                  InkWell(
                    onTap: () {
                      if (pageIndex + 1 == pageCount) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const SignupDashboard(
                              flag: 1,
                            ),
                          ),
                        );
                      } else {
                        pageIndex++;
                        if (pageIndex > pageCount) pageIndex = pageCount;
                        pageViewController.animateToPage(pageIndex,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut);
                        setState(() {});
                      }
                    },
                    child: Container(
                      width: pageIndex + 1 == pageCount
                          ? 100 / mockUpWidth * size.width
                          : 80 / mockUpWidth * size.width,
                      padding: EdgeInsets.symmetric(
                          vertical: 8.0 / mockUpHeight * size.height,
                          horizontal: 7.0 / mockUpWidth * size.width),
                      decoration: BoxDecoration(
                        color: const Color(0xFF051923),
                        borderRadius:
                            BorderRadius.circular(5 / mockUpWidth * size.width),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            pageIndex + 1 == pageCount ? "Let's Go" : 'Next',
                            textScaleFactor: textScale,
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 1.5,
                                letterSpacing: 0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
