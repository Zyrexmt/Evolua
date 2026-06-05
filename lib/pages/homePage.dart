import 'package:flutter/material.dart';
import 'package:modulo_a2_v1/services/apiService.dart';
import 'package:modulo_a2_v1/services/session.dart';

class HomePage extends StatefulWidget {
  final ApiService api;
  const HomePage({super.key, required this.api});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showDailyActivity = false;
  int _desafioAtual = 1;
  int _totalDesafios = 0;
  String _textoDesafio = '';

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
  }

  Future<void> _verDesafio() async {
    final resposta = await widget.api.getDesafio(
      _desafioAtual,
      Session.token!,
    );

    setState(() {
      _textoDesafio = resposta['activity'];
      _totalDesafios = resposta['total_activities'];
      _showDailyActivity = true;
    });
  }

  Future<void> _proximoDesafio() async {
    await Session.avancarDesafio();
    setState(() {
      _desafioAtual = Session.desafioAtual;
    });
  }

  Future<void> logout() async {
    await Session.limpar();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: logout, icon: Icon(Icons.logout, size: 30, color: Color(0xff333333),)),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/logomarca.png',
                  width: 150,
                  height: 150,
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
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'RESUMO DE PROGRESSO',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Desafio $_desafioAtual de $_totalDesafios',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 25),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff333333),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffa2ded0),
                    ),
                    child: Text(
                      'VER DESAFIO DO DIA',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  onTap: () async {
                    await _verDesafio();
                  },
                ),
                SizedBox(height: 60),

                if (_showDailyActivity) _desafioView(_textoDesafio),
                Spacer(),
                _textButton('CONCLUIR DESAFIO', () async {
                  final resposta = await widget.api.getDesafio(
                    _desafioAtual,
                    Session.token!,
                  );

                  await Session.salvarDesafioConcluido(
                    id: _desafioAtual,
                    category: resposta['category'],
                    activity: resposta['activity'],
                  );

                  setState(() {
                    _showDailyActivity = false;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Desafío concluído!')),
                  );
                }, Color(0xffaed6f1)),
                SizedBox(height: 30),
                _textButton('PRÓXIMO DESAFIO', () {
                  if (_desafioAtual < _totalDesafios) {
                    _proximoDesafio();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Você chegou no fim dos desafios diários.',
                        ),
                      ),
                    );
                  }
                }, Color(0xffededed)),
                SizedBox(height: 30),
                _textButton('DESAFIOS CONCLUÍDOS', () {
                  Navigator.of(
                    context,
                  ).pushReplacementNamed('/quest');
                }, Color(0xffededed)),
                SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushReplacementNamed('/sobre');
                  },
                  style: TextButton.styleFrom(
                    shape: LinearBorder.bottom(
                      side: BorderSide(
                        color: Color(0xff333333),
                        width: 1,
                      ),
                    ),
                    foregroundColor: Color(0xff333333),
                  ),
                  child: Text(
                    'SOBRE',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
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

  Widget _desafioView(String texto) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Text(
        textAlign: TextAlign.center,
        texto,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
