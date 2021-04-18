import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting
}
// debemos de hacer el socket service global, para que todas las pantallas sepan que pasa aquí

class SocketService with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;


  
  void connect() async{
    final token = await AuthService.getToken(); 
    
    // forceNew cada vez que se conecta o se desconecta se crea una nueva instancia en el backend
    // Dart client
    this._socket = IO.io('http://192.168.100.6:3002', {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {
        'token': token
      }
    });

    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

  }
  void disconnect() {
    this._socket.disconnect();
  }

}