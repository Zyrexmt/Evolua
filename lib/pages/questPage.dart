import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:modulo_a2_v1/services/apiService.dart';
import 'package:modulo_a2_v1/services/session.dart';

class QuestPage extends StatefulWidget {
  final ApiService api;
  const QuestPage({super.key, required this.api});

  @override
  State<QuestPage> createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> {
  int _desafioAtual = 1;
  int _totalDesafios = 0;
  String _textoDesafio = '';
  List<Map<String, dynamic>> _desafios = [];
  int _desafiosConcluidos = 0;

  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    setState(() {
      _desafioAtual = Session.desafioAtual;
    });

    final resposta = await widget.api.getDesafio(
      _desafioAtual,
      Session.token!,
    );
    setState(() {
      _totalDesafios = resposta['total_activities'];
    });

    _desafios = await Session.carregarDesafiosCOncluidos();

    _desafiosConcluidos = _desafios.length;

    setState(() {});
  }

  Future<void> verDesafio() async {
    final resposta = await widget.api.getDesafio(
      _desafioAtual,
      Session.token!,
    );

    setState(() {
      _textoDesafio = resposta['category'];
      _totalDesafios = resposta['total_activities'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            vertical: 40,
            horizontal: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/logomarca.png',
                width: 100,
                height: 100,
              ),
              SizedBox(height: 30),
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
                  'DESAFIOS CONCLUÍDOS',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 400,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xff333333),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'RESUMO DO PROGRESSO GERAL',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                '$_desafiosConcluidos de $_totalDesafios desafios concluídos!',
              ),
              SizedBox(height: 40),
              Expanded(
                child: ListView.builder(
                  itemCount: _desafios.length,
                  itemBuilder: (context, index) {
                    final desafio = _desafios[index];
                    int questCount = index+1;
                    return Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xff333333),
                          width: 2,
                        ),
                        borderRadius: BorderRadiusGeometry.circular(
                          8,
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        title: Text(
                          'DESAFIO $questCount - ${desafio['activity']}',
                        ),
                        subtitle: Text(desafio['category']),
                      ),
                    );
                  },
                ),
              ),
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
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}
