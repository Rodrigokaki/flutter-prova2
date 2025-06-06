import 'package:flutter/material.dart';
import 'package:flutter_prova2/styles/styles.dart';
import '../database/database.dart';
import 'imc_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final databaseHelper = DatabaseHelper();

  void login() async {
    if (formKey.currentState!.validate()) {
      try {
        final user = await databaseHelper.getUserByEmail(emailController.text);

        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email ou senha inválidos')),
          );
          return;
        }

        if (user.password == passwordController.text) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IMCPage(name: user.name),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email ou senha inválidos')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao acessar o banco de dados: $e')),
        );
      }
    }
  }

  String? validadeEmail(String? value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value == null || value.isEmpty) return 'Digite seu e-mail';
    if (!emailRegex.hasMatch(value)) return 'E-mail inválido';
    return null;
  }

  String? validatePassword(String? value) {
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    if (value == null || value.isEmpty) return 'Digite sua senha';
    if (!passwordRegex.hasMatch(value)) {
      return 'Senha deve conter no mínimo 8 caracteres, incluindo letras e números';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(
                'Calculadora IMC',
                style: AppTextStyles.titleTextStyle,
              ))),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.defaultPadding),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.loginSpaceBetween),
              Image.asset(
                'assets/images/icon.png',
                height: appSizes.iconSize,
              ),
              const SizedBox(height: AppSpacing.loginSpaceBetween),
              const Text('Login',
                style: AppTextStyles.subtitleTextStyle,
              ),
              const SizedBox(height: AppSpacing.loginSpaceBetween),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: AppTextStyles.inputLabelStyle,
                  border: OutlineInputBorder()
                ),
                validator: validadeEmail,
              ),
              const SizedBox(height: AppSpacing.loginSpaceBetween),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: AppTextStyles.inputLabelStyle,
                  border: OutlineInputBorder()
                ),
                obscureText: true,
                validator: validatePassword,
              ),
              const SizedBox(height: AppSpacing.loginSpaceBetween),
              ElevatedButton(
                onPressed: login,
                style: defaultButtonStyle(),
                child: const Text('Entrar', style: AppTextStyles.buttonTextStyle),
              ),
              const SizedBox(height: AppSpacing.loginSpaceBetween),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()),
                  );
                },
                child: const Text(
                  'Não tem conta? Cadastre-se aqui',
                  style: AppTextStyles.smallTextStyle
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
