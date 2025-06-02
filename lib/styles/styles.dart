import 'package:flutter/material.dart';

class AppColors{
  static const primaryColor = Colors.blue;
  static const secondaryColor = Colors.white;
}

class AppTextStyles {
  static const resultTextStyle = TextStyle(
    fontSize: 18, 
    color: AppColors.primaryColor,
    fontWeight: FontWeight.bold,
  );

  static const inputLabelStyle = TextStyle(
    color: AppColors.primaryColor,
    fontSize: 16,
  );

  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      minimumSize: Size(double.infinity, 50)
  );

  static const buttonTextStyles = TextStyle(
    fontSize: 18,
    color: AppColors.secondaryColor,
  );
}

class AppSpacing {
  static const double defaultPadding = 20.0;
  static const double spaceBetween = 20;
}

