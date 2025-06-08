import 'package:flutter/material.dart';

import '../database/database.dart';
import '../models/user.dart';
import '../styles/styles.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final databaseHelper = DatabaseHelper();


  void register() async {
    if (formKey.currentState!.validate()) {
      final user = User(
        name: nameController.text,
        surname: surnameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      // Verifica se o e-mail já está cadastrado
      await databaseHelper.getUserByEmail(user.email).then((existingUser) {
        if (existingUser != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('E-mail já cadastrado')),
          );
        } 
        else {
          DatabaseHelper.instance.insertUser(user);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuário registrado com sucesso')),
          );
          Navigator.pop(context);
        }
      });
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'Digite seu nome';
    if (value.length < 3) return 'Nome deve ter pelo menos 3 caracteres';
    return null;
  }

  String? validateSurname(String? value) {
    if (value == null || value.isEmpty) return 'Digite seu sobrenome';
    if (value.length < 3) return 'Sobrenome deve ter pelo menos 3 caracteres';
    return null;
  }

  String? validateEmail(String? value) {
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
      appBar: AppBar(title: Text('Calculadora IMC',style: AppTextStyles.titleTextStyle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.defaultPadding),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.registerSpaceBetween),
              Image.asset(
                'assets/images/icon.png',
                height: appSizes.homeIconSize,
              ),
              const SizedBox(height: AppSpacing.registerSpaceBetween),
              const Text('Registrar',
                style: AppTextStyles.subtitleTextStyle,
              ),
              const SizedBox(height: AppSpacing.registerSpaceBetween),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  labelStyle: AppTextStyles.inputLabelStyle,
                  border: OutlineInputBorder()
                ),
                validator: validateName,
              ),
              const SizedBox(height: AppSpacing.registerSpaceBetween),
              TextFormField(
                controller: surnameController,
                decoration: InputDecoration(
                  labelText: 'Sobrenome',
                  labelStyle: AppTextStyles.inputLabelStyle,
                  border: OutlineInputBorder()
                ),
                validator: validateSurname,
              ),
              const SizedBox(height: AppSpacing.loginSpaceBetween),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: AppTextStyles.inputLabelStyle,
                  border: OutlineInputBorder()
                ),
                validator: validateEmail,
              ),
              const SizedBox(height: AppSpacing.loginSpaceBetween),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: AppTextStyles.inputLabelStyle,
                  border: OutlineInputBorder(),
                  errorMaxLines: 2
                ),
                obscureText: true,
                validator: validatePassword,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: register,
                style: defaultButtonStyle(),
                child: const Text('Registrar', style: AppTextStyles.buttonTextStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}