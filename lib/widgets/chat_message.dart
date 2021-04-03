import 'package:flutter/material.dart';

// este widget servirá para dibujar las burbujas del chat
// debo de identificar cuando es un mensaje mio o de otra persona
class ChatMessage extends StatelessWidget {
  // si el uid es igual al mio, quiere decir que es mensaje mio, caso contrario es otra persona
  final String texto;
  final String uid;

  const ChatMessage({
    Key key, 
    this.texto, 
    this.uid
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: (this.uid == '123')
      ? _myMessage()
      : _notMyMessage(),
    );
  }

  Widget _myMessage() {
    // hay que alinear los mensajes del lado derecho
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 5, left: 50, right: 5),
        padding: EdgeInsets.all(8.0),
        child: Text( this.texto, style: TextStyle( color: Colors.white ), ),
        decoration: BoxDecoration(
          color: Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(20),
        ),
      )
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 5, left: 5, right: 50),
        padding: EdgeInsets.all(8.0),
        child: Text( this.texto, style: TextStyle( color: Colors.black87 ), ),
        decoration: BoxDecoration(
          color: Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20),
        ),
      )
    );
  }
}