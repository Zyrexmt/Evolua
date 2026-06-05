import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({super.key, required this.controller , required this.titulo , required this.obscuro , required this.active ,});

  final TextEditingController controller;
  final String titulo;
  final bool obscuro;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row( mainAxisAlignment: MainAxisAlignment.start,
          children: [Text(titulo, style: TextStyle(fontSize: 20),)],
          ),
          TextField(
            controller: controller,
            obscureText: obscuro,
            enabled: active,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              
            ),
          )          
        ],
      ),
    );
  }
}