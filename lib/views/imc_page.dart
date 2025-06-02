import 'package:flutter/material.dart';
import '../styles/styles.dart';
import '../constants/constants.dart';

class IMCPage extends StatefulWidget {
  @override
  _IMCPageState createState() => _IMCPageState();
}

class _IMCPageState extends State<IMCPage> {
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();
  String resultado = "Informe seus dados!";

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

    String classificacao;
    if (imc < AppIMCValues.imcMagrezaGrave) {
      classificacao = "Magreza grave";
    } else if (imc < AppIMCValues.imcMagrezaModerada) {
      classificacao = "Magreza moderada";
    } else if (imc < AppIMCValues.imcMagrezaLeve) {
      classificacao = "Magreza leve";
    } else if (imc <= AppIMCValues.imcPesoIdeal) {
      classificacao = "Peso ideal";
    } else if (imc <= AppIMCValues.imcSobrepeso) {
      classificacao = "Sobrepeso";
    } else if (imc <= AppIMCValues.imcObesidade1) {
      classificacao = "Obesidade grau 1";
    } else if (imc <= AppIMCValues.imcObesidade2) {
      classificacao = "Obesidade grau 2";
    } else {
      classificacao = "Obesidade grau 3";
    }

    setState(() {
      resultado = "IMC: ${imc.toStringAsFixed(2)} - $classificacao";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Calculadora IMC"))),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.person, size: 130, color: AppColors.primaryColor),
            SizedBox(height: AppSpacing.spaceBetween),
            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Peso (kg)",
                labelStyle: AppTextStyles.inputLabelStyle,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: AppSpacing.spaceBetween),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Altura (cm)",
                labelStyle: AppTextStyles.inputLabelStyle,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: AppSpacing.spaceBetween),
            ElevatedButton(
              onPressed: calcularIMC,
              style: AppTextStyles.buttonStyle,
              child: Text("Calcular", style: AppTextStyles.buttonTextStyles),
            ),
            SizedBox(height: AppSpacing.spaceBetween),
            Text(resultado, style: AppTextStyles.resultTextStyle, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
