import 'package:flutter/material.dart';
import 'package:modulo_a2_v1/appWidgets.dart';
import 'package:modulo_a2_v1/services/apiService.dart';
import 'package:modulo_a2_v1/services/session.dart';

class LoginPage extends StatefulWidget {
  final ApiService api;
  const LoginPage({super.key, required this.api});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController(),
      senhaController = TextEditingController();

  String email = '', senha = '';

  Future<void> login() async {
    email = emailController.text.toString().trim();
    senha = senhaController.text.toString().trim();
    try {
      final resultado = await widget.api.login(email, senha);

      await Session.salvar(resultado);

      print(resultado['token']);

      if (!mounted) return;

      Navigator.of(context).pushReplacementNamed('/home');
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário ou senha inválidos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 200),
                Image.asset(
                  'assets/images/logotipo.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 30),
                TextInputField(
                  controller: emailController,
                  titulo: 'E-mail',
                  obscuro: false,
                  active: true,
                ),
                SizedBox(height: 15),

                TextInputField(
                  controller: senhaController,
                  titulo: 'Senha',
                  obscuro: true,
                  active: true,
                ),
                SizedBox(height: 30),
                TextButton(
                  onPressed: () => login(),
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xff333333),
                    foregroundColor: Color(0xfff7f7f7),
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(8),
                    ),
                    fixedSize: Size(
                      MediaQuery.sizeOf(context).width,
                      45,
                    ),
                  ),
                  child: Text(
                    'ENTRAR',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
