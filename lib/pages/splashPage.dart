import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modulo_a2_v1/services/apiService.dart';
import 'package:modulo_a2_v1/services/session.dart';

class SplashScreen extends StatefulWidget {
  final ApiService api;
  const SplashScreen({super.key, required this.api});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    inicializar();
  }

  Future<void> inicializar() async {
    try {
      final ok = await widget.api.getStatus();

      if (!ok) throw Exception('Servidor indisponível');

      await Future.delayed(const Duration(seconds: 3));

      if (!mounted) return;

      final temSessao = await Session.carregar();

      if (!mounted) return;

      print('TEM SESSAO: $temSessao'); // ← adiciona isso
      print('USERID: ${Session.userId}');
      print('TOKEN: ${Session.token}');

      if (temSessao) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } catch (e) {
      print('ERRO: $e');
      if (!mounted) return;
      mostrarErro();
    }
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void mostrarErro() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text('Sem conexão'),
        content: Text(
          'Não foi possível estabelecer conexão com o servidor.',
        ),
        actions: [
          TextButton(
            onPressed: () => SystemNavigator.pop(),
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.6,
              height: MediaQuery.sizeOf(context).width * 0.6,
              child: Image.asset('assets/images/logomarca.png'),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.5,
              child: AnimatedBuilder(
                animation: _animation,

                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: _animation.value,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xffaed6f1),
                    ),
                    backgroundColor: Color(0xffededed),
                    minHeight: 20,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
