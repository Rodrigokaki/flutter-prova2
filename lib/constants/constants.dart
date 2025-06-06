import 'package:flutter/material.dart';

class AppValueLimits {
  static const double maxPeso = 635;
  static const double minPeso = 2;
  static const double maxAltura = 272;
  static const double minAltura = 15;
}

class AppIMCValues {
  static const double imcMagrezaGrave = 16;
  static const double imcMagrezaModerada = 16.9;
  static const double imcMagrezaLeve = 18.5;
  static const double imcPesoIdeal = 24.9;
  static const double imcSobrepeso = 29.9;
  static const double imcObesidade1 = 34.9;
  static const double imcObesidade2 = 39.9;
}

class AppIMCColors {
  static const Color magrezaGrave = Color(0xFFB71C1C); 
  static const Color magrezaModerada = Color(0xFFF44336); 
  static const Color magrezaLeve = Color(0xFFFF7043); 
  static const Color pesoIdeal = Color(0xFF4CAF50); 
  static const Color sobrepeso = Color(0xFFFFC107); 
  static const Color obesidade1 = Color(0xFFFF9800); 
  static const Color obesidade2 = Color(0xFFFF5722); 
  static const Color obesidade3 = Color(0xFFD32F2F); 
}
