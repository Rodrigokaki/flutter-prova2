import 'package:flutter/material.dart';
import '../styles/styles.dart';
import '../constants/constants.dart';

class IMCPage extends StatefulWidget {
  final String name;

  const IMCPage({super.key, required this.name});

  @override
  State<IMCPage> createState() => _IMCPageState();
}

class _IMCPageState extends State<IMCPage> {
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();

  String resultado = "Informe seus dados!";

  String get saudacao {
    final hora = DateTime.now().hour;
    if (hora < 12) {
      return "Bom dia";
    } else if (hora < 18) {
      return "Boa tarde";
    } else {
      return "Boa noite";
    }
  }

  dynamic resultColor = ResultTextStyle.color;
  
  void calcularIMC() {
    final peso = double.tryParse(pesoController.text);
    final alturaCm = double.tryParse(alturaController.text);

    if (peso == null || alturaCm == null) {
      setState(() => resultado = "Preencha os campos corretamente!");
      return;
    }

    if (peso < AppValueLimits.minPeso || peso > AppValueLimits.maxPeso) {
      setState(() => resultado = "Peso inválido. Deve ser entre ${AppValueLimits.minPeso} kg e ${AppValueLimits.maxPeso} kg.");
      return;
    }

    if (alturaCm < AppValueLimits.minAltura || alturaCm > AppValueLimits.maxAltura) {
      setState(() => resultado = "Altura inválida. Deve ser entre ${AppValueLimits.minAltura} cm e ${AppValueLimits.maxAltura} cm.");
      return;
    }

    final alturaM = alturaCm / 100;
    final imc = peso / (alturaM * alturaM);

    Color newColor;
    String classificacao;
    if (imc < AppIMCValues.imcMagrezaGrave) {
      classificacao = "Magreza grave";
      newColor = AppIMCColors.magrezaGrave;
    } else if (imc < AppIMCValues.imcMagrezaModerada) {
      classificacao = "Magreza moderada";
      newColor = AppIMCColors.magrezaModerada;
    } else if (imc < AppIMCValues.imcMagrezaLeve) {
      classificacao = "Magreza leve";
      newColor = AppIMCColors.magrezaLeve;
    } else if (imc <= AppIMCValues.imcPesoIdeal) {
      classificacao = "Peso ideal";
      newColor = AppIMCColors.pesoIdeal;
    } else if (imc <= AppIMCValues.imcSobrepeso) {
      classificacao = "Sobrepeso";
      newColor = AppIMCColors.sobrepeso;
    } else if (imc <= AppIMCValues.imcObesidade1) {
      classificacao = "Obesidade grau 1";
      newColor = AppIMCColors.obesidade1;
    } else if (imc <= AppIMCValues.imcObesidade2) {
      classificacao = "Obesidade grau 2";
      newColor = AppIMCColors.obesidade2;
    } else {
      classificacao = "Obesidade grau 3";
      newColor = AppIMCColors.obesidade3;
    }

    setState(() {
      resultado = "IMC: ${imc.toStringAsFixed(2)} - $classificacao";
      resultColor = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Row(
        spacing: AppSpacing.appBarSpaceBetween,
        children: [
        Text("Calculadora IMC", style: AppTextStyles.titleTextStyle),
        Image.asset(
                'assets/images/icon.png',
                height: appSizes.appBarIconSize,
        ),
      ]),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('$saudacao, ${widget.name}!',style: AppTextStyles.subtitleTextStyle),
            Icon(Icons.person, size: 130, color: AppColors.primaryColor),
            SizedBox(height: AppSpacing.imcSpaceBetween),
            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Peso (kg)",
                labelStyle: AppTextStyles.inputLabelStyle,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: AppSpacing.imcSpaceBetween),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Altura (cm)",
                labelStyle: AppTextStyles.inputLabelStyle,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: AppSpacing.imcSpaceBetween),
            ElevatedButton(
              onPressed: calcularIMC,
              style: defaultButtonStyle(),
              child: Text("Calcular", style: AppTextStyles.buttonTextStyle),
            ),
            SizedBox(height: AppSpacing.imcSpaceBetween),
            Text(resultado, style: TextStyle(
              fontSize: ResultTextStyle.fontSize,
              color: resultColor,
              fontWeight: ResultTextStyle.fontWeight,
            ), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
