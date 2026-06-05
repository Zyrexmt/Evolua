import 'package:modulo_a2_v1/services/apiService.dart';

class MockApiService implements ApiService {
  @override
  Future<bool> getStatus() async {
    await Future.delayed(Duration(milliseconds: 400));
    return true;
  }

  final List<Map<String, dynamic>> _users = [
    {
      'id': '1',
      'username': 'admin',
      'password': 'admin123',
      'role': 'admin',
    },
    {
      'id': '2',
      'username': 'teste',
      'password': 'teste123',
      'role': 'user',
    },
  ];

  @override
  Future<List<Map<String, dynamic>>> getUsers() async {
    await Future.delayed(Duration(milliseconds: 400));

    return _users
        .map(
          (u) => {
            'id': u['id'],
            'username': u['username'],
            'role': u['role'],
          },
        )
        .toList();
  }

  @override
  Future<Map<String, dynamic>> createUser(
    String username,
    String password,
  ) async {
    await Future.delayed(Duration(milliseconds: 400));

    final existe = _users.any((u) => u['username'] == username);
    if (existe) throw Exception('Username já existe');

    final novoId = (_users.length + 1).toString();
    _users.add({
      'id': novoId,
      'username': username,
      'password': password,
      'role': 'user',
    });

    return {'message': 'User created', 'id': novoId};
  }

  final Map<String, String> _tokens = {};

  @override
  Future<Map<String, dynamic>> login(
    String username,
    String password,
  ) async {
    await Future.delayed(Duration(milliseconds: 400));

    final user = _users.firstWhere(
      (u) => u['username'] == username && u['password'] == password,
      orElse: () => {},
    );

    if (user.isEmpty) throw Exception('Credenciais inválidas');

    final token = 'mock_token_${user['id']}';

    _tokens[token] = user['id'];

    return {
      'token': token,
      'role': user['role'],
      'userId': user['id'],
    };
  }

  final List<Map<String, dynamic>> _desafios = [
    {
      'id': 1,
      'activity': 'Medite por 10 minutos em silêncio',
      'category': 'Foco',
      'total_activities': 5,
    },
    {
      'id': 2,
      'activity': 'Pratique respiração profunda por 5 minutos',
      'category': 'Emoções',
      'total_activities': 5,
    },
    {
      'id': 3,
      'activity': 'Escreva 3 coisas pelas quais você é grato',
      'category': 'Disciplina',
      'total_activities': 5,
    },
    {
      'id': 4,
      'activity': 'Envie uma mensagem positiva para alguém',
      'category': 'Social',
      'total_activities': 5,
    },
    {
      'id': 5,
      'activity': 'Faça uma caminhada de 20 minutos',
      'category': 'Foco',
      'total_activities': 5,
    },
  ];

  @override
  Future<Map<String, dynamic>> getDesafio(
    int id,
    String token,
  ) async {
    await Future.delayed(Duration(milliseconds: 400));

    if (!token.startsWith('mock_token_'))
      throw Exception('Token inválido');


    final desafio = _desafios.firstWhere(
      (d) => d['id'] == id,
      orElse: () => {},
    );

    if (desafio.isEmpty) throw Exception('Desafio não encontrado');

    return desafio;
  }
}
