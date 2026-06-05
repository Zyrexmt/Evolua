import 'package:flutter/material.dart';
import 'package:modulo_a2_v1/services/mock_api_service.dart';

abstract class ApiService {
  Future<bool> getStatus();
  Future<List<Map<String, dynamic>>> getUsers();
  Future<Map<String, dynamic>> createUser(
    String username,
    String password,
  );
  Future<Map<String, dynamic>> login(
    String username,
    String password,
  );
  Future<Map<String, dynamic>> getDesafio(int id, String token);
}

class DesafioConcluido {
  final int id;
  final String category;
  final String activity;

  DesafioConcluido({
    required this.id,
    required this.category,
    required this.activity,
  });

  Map<String, dynamic> toJson() {
    return {'id': id, 'category': category, 'activity': activity};
  }

  factory DesafioConcluido.fromJson(Map<String, dynamic> json) {
    return DesafioConcluido(
      id: json['id'],
      category: json['category'],
      activity: json['activity'],
    );
  }
}
