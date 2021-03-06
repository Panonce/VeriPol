import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'themes.dart';

class VeripolPicNavigationButton extends StatelessWidget {
  const VeripolPicNavigationButton({
    Key? key,
    required this.label,
    required this.subLabel,
    required this.imageURL,
    required this.onTap,
  }) : super(key: key);
  final String label;
  final String subLabel;
  final String imageURL;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = mockUpWidth / size.width;
    final textScale = size.width / mockUpWidth;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 350 / mockUpWidth * size.width,
        height: 161 / mockUpHeight * size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            scale: scale,
            image: AssetImage(imageURL),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(
            9.21 / mockUpWidth * size.width,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 5.53 / mockUpWidth * size.width,
              blurRadius: 11.05 / mockUpWidth * size.width,
              offset: Offset(
                0,
                7.37 / mockUpHeight * size.height,
              ),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.30),
              spreadRadius: 0,
              blurRadius: 3.68 / mockUpWidth * size.width,
              offset: Offset(
                0,
                3.68 / mockUpHeight * size.height,
              ),
            ),
          ],
        ),
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            textScaleFactor: textScale,
            text: TextSpan(
              children: [
                TextSpan(
                  text: label + "\n",
                  style: GoogleFonts.notoSans(
                    textStyle: const TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 20.26,
                      fontWeight: FontWeight.w400,
                      height: 1.27,
                      letterSpacing: 0,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextSpan(
                  text: subLabel,
                  style: GoogleFonts.notoSans(
                    textStyle: const TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 12.9,
                      fontWeight: FontWeight.w500,
                      height: 1.43,
                      letterSpacing: 0.09,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
