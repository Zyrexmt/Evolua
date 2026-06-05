import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Session {
  static String? token;
  static String? role;
  static String? userId;
  static int desafioAtual = 1;

  static Future<void> salvar(Map<String, dynamic> resultado) async {
    token = resultado['token'];
    role = resultado['role'];
    userId = resultado['userId'];
    desafioAtual = 1;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token!);
    await prefs.setString('role', role!);
    await prefs.setString('userId', userId!);
    await prefs.setInt('desafio_atual', desafioAtual);
  }

  static Future<bool> carregar() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    role = prefs.getString('role');
    userId = prefs.getString('userId');
    desafioAtual = prefs.getInt('desafio_atual') ?? 1;

    return token != null;
  }

  static Future<void> avancarDesafio() async {
    desafioAtual++;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('desafio_atual', desafioAtual);
  }

  static Future<void> limpar() async {
    token = null;
    role = null;
    userId = null;
    desafioAtual = 1;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('role');
    await prefs.remove('userId');
    await prefs.remove('desafio_atual');
  }

  static Future<void> salvarDesafioConcluido({
    required int id,
    required String category,
    required String activity,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final chave = 'desafios_$userId';

    List<String> desafios = prefs.getStringList(chave) ?? [];

    bool jaExiste = desafios.any((item) {
      final mapa = jsonDecode(item);
      return mapa['id'] == id;
    });

    if (jaExiste) return;

    desafios.add(
      jsonEncode({
        'id': id,
        'category': category,
        'activity': activity,
      }),
    );
    await prefs.setStringList(chave, desafios);
  }

  static Future<List<Map<String, dynamic>>>
  carregarDesafiosCOncluidos() async {
    final prefs = await SharedPreferences.getInstance();

    final chave = 'desafios_$userId';

    List<String> desafios = prefs.getStringList(chave) ?? [];

    return desafios
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .toList();
  }
}
