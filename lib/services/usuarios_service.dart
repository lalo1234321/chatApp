

import 'package:chat_app/models/usuarios_response.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:http/http.dart' as http ;
import 'package:chat_app/models/usuario.dart';

class UsuarioService {

  Future<List<Usuario>> getUsuarios() async{
    try {

      final resp = await http.get('http://192.168.100.109:3002/api/usuarios', 
      
        headers: {
          'Content-Type': 'application/json',
          'token': await AuthService.getToken()
        }
      );

      final usuarioResponse = usuariosResponseFromJson( resp.body );
      return usuarioResponse.usuarios;


    } catch(e) {
      return[];
    }
  }

}