import 'package:flutter/material.dart';

class AppColors {
  static const titleGreen = Color(0xff82D4B3);
  static const titleOrange = Color(0xffFB9275);
  static const titleHalfBlue = Color(0xff147587);
  static const titleHalfGrey = Color(0xff21262B);
  static const gradientStartingColor = Color(0xffE2EFF3);
  static const gradientEndColor = Color(0xff99C0C6);
  static const roundTileColor = Color(0xff212628);
  static const yellow = Color(0xffDDF247);
  static const textColor = Color(0xff212628);
  static const bodyColor = Color(0xfff9f9f9);

  static homeGradient() => const LinearGradient(
      colors: [gradientStartingColor, gradientEndColor],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
}
