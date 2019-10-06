import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> login(String usuario, String senha) async {
  final response = await http.post("http://192.168.0.18/projeto/login.php",
      body: {"usuario": usuario, "senha": senha});
  print(response.body);
  if (response.body.length > 2) {
    //Aq ele realizou o loggin cm sucesso
    return 'true';
  }
  return 'Usuário ou senha incorretas';
}
