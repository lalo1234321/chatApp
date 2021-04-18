import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
 
import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//  esta clase se encarga de notificar cuando es necesario redibujar los widgets
//  para esto debemos de hacer global  AuthService
class AuthService with ChangeNotifier{
  // para notificar que estamos autenticando
  bool _autenticando = false;
  // create storage
  // queremos exponer el token al resto de las páginas
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando( bool valor ) {
    this._autenticando = valor;
    notifyListeners();
  }

  // getters del token de forma estática
  static Future<String> getToken() async{
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  // para borrar un token
  static Future<String> deleteToken() async{
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Usuario usuario;
  Future<bool> login( String email, String password ) async{

    this.autenticando = true;
  
    final data = {
      'email': email,
      'password': password
    };
  // la dirección del server socket es sin la diagonal ejemplo: http://192.168.100.6:3002
    final resp = await http.post('http://192.168.100.6:3002/api/login', 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );
    print(resp.body);
    this.autenticando = false;
    if(resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      this._guardarToken(loginResponse.token);
      // TODO guardar token 
      

      return true;
    } else {
      return false;
    }

    
  }

  Future register( String nombre, String email, String password ) async{
    this.autenticando = true;
    final data = {
      'nombre': nombre,
      'email': email,
      'password': password
    };

    final resp = await http.post('http://192.168.100.6:3002/api/login/new', 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );
    print(resp.body);
    this.autenticando = false;
    if(resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      this._guardarToken(loginResponse.token);
      // TODO guardar token 
      

      return true;
    } else {
      // debemos de mapear el error
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }


  }

  // necesitamos verificar si el token es válido}
  Future<bool> isLoogedIn() async{
    final token = await this._storage.read(key: 'token');
    print(token); 
    final resp = await http.get('http://192.168.100.6:3002/api/login/renew', 
      headers: {
        'Content-Type': 'application/json',
        'token': token
      }
    );
    print(resp.body);
    if(resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      //  le damos más tiempo de vida al token
      this._guardarToken(loginResponse.token);
      // TODO guardar token 
      

      return true;
    } else {
      this.logout();
      return false;
      
    }


  }

  Future _guardarToken( String token ) async{
    return await _storage.write(key: 'token', value: token);
  }
  Future logout() async{
    await _storage.delete(key: 'token');
  }
}