import 'package:flutter/material.dart';
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

        if (user != null && user.password == passwordController.text) {
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
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Icon(Icons.health_and_safety, size: 80, color: Colors.teal),
              const SizedBox(height: 16),
              const Text(
                'IMC Calculator',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: validadeEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: validatePassword,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: login,
                child: const Text('Entrar'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()),
                  );
                },
                child: const Text('Não tem conta? Cadastre-se aqui'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
