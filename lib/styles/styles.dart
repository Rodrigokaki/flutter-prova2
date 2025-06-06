import 'package:flutter/material.dart';

class AppColors{
  static const primaryColor = Colors.blue;
  static const secondaryColor = Colors.white;
}

class AppTextStyles {
  static const titleTextStyle = TextStyle(
    fontSize: 28,
    fontFamily: 'BarberChop',
    color: AppColors.primaryColor,
    fontWeight: FontWeight.bold,
  );

  static const subtitleTextStyle = TextStyle(
    fontSize: 24,
    color: AppColors.primaryColor,
    fontWeight: FontWeight.bold,
  );

  static const smallTextStyle = TextStyle(
    fontSize: 16,
    color: AppColors.primaryColor,
  );

  static const inputLabelStyle = TextStyle(
    color: AppColors.primaryColor,
    fontSize: 18,
  );

  static const buttonTextStyle = TextStyle(
    fontSize: 18,
    color: AppColors.secondaryColor,
  );
}

class ResultTextStyle {
  static const double fontSize = 18;
  static const color = AppColors.primaryColor;
  static const fontWeight = FontWeight.bold;
}

ButtonStyle defaultButtonStyle(){
  return ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      minimumSize: Size(double.infinity, 50)
  );
} 
  

class AppSpacing {
  static const double defaultPadding = 20.0;

  static const double imcSpaceBetween = 20;

  static const double loginSpaceBetween = 20;

  static const double registerSpaceBetween = 20;

  static const double appBarSpaceBetween = 10;
}

class appSizes {
  static const double homeIconSize = 130;

  static const double appBarIconSize = 30;
}