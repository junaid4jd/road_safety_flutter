import 'dart:ui';
import 'package:road_safety/res/colors.dart';

class AppText {
  static const String appName = 'Road Safety';
  static const String login = 'Log In';
  static const String register = 'Sign up';
  static const String registerLine = 'Don\'t have account?';
  static const String loginLine = 'Already have account?';
  static const String continueText = 'Continue';
  static const String orderNowText = 'Order Now';

}

class TextStylesData {
  static const extraSmallFontSize = 12.0;
  static const smallFontSize = 14.0;
  static const mediumFontSize = 17.0;
  static const titleFontSize = 20.0;
  static const largeFontSize = 25.0;
  static const headingLargeFontSize = 35.0;
  static const headingSmallFontSize = 30.0;
  static const appBarRound = 25.0;
  static final smallTextStyle = TextStyle(
    fontSize: smallFontSize,
    color: AppColors.blackColor,
  );
  final largeHeadingTextStyle = TextStyle(
      fontSize: headingLargeFontSize,
      color: AppColors.whiteColor,
      fontWeight: FontWeight.w400);
}
