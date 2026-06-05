import 'package:flutter/material.dart';

class SobrePage extends StatefulWidget {
  const SobrePage({super.key});

  @override
  State<SobrePage> createState() => _SobrePageState();
}

class _SobrePageState extends State<SobrePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            vertical: 30,
            horizontal: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/logomarca.png',
                width: 120,
                height: 120,
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xff333333),
                    width: 2,
                  ),
                  color: Color(0xffaed6f1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'SOBRE O APLICATIVO',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
                '''Este aplicativo foi criado para ajudar você a desenvolver hábitos mais saudáveis, melhorar seu bem-estar emocional e estimular o aprendizado diário por meio de pequenos desafios.
Cada ação proposta foi pensada para trazer mais equilíbrio, foco e leveza para a sua rotina.
Cuide de você um passo de cada vez.''',
              ),
              SizedBox(height: 30),
              Text(
                'COMO FUNCIONA',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 26,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
                '''O aplicativo possui 5 desafios rotativos que são disponibilizados progressivamente para você.''',
              ),
              SizedBox(height: 65,),
              Text('*Equílibrio e Saúde Mental ao seu alcance*', style: TextStyle(fontSize: 16),),
              SizedBox(height: 15,),
              _textButton('VOLTAR PARA HOME', () {
                Navigator.of(context).pushReplacementNamed('/home');
              }, Color(0xffaed6f1)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textButton(String texto, VoidCallback action, Color color) {
    return TextButton(
      onPressed: action,
      style: TextButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Color(0xff333333),
        fixedSize: Size(275, 50),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xff333333), width: 2),
          borderRadius: BorderRadiusGeometry.circular(8),
        ),
      ),
      child: Text(
        texto,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
    );
  }
}
