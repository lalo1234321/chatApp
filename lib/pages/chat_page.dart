import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

// para mostrar animaciones debemos mezclar la clase padre con

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{
  // al mezclar con el TicketProivider ya podemos trabjar con muchas animaciones


  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _estaEscribiendo = false;
  List<ChatMessage> _messages = [
    // ChatMessage(uid: '123', texto: 'Hola mundo',),
    // ChatMessage(uid: '1234231', texto: 'Hola mundo',),
    // ChatMessage(uid: '123', texto: 'Hola mundo',),
    // ChatMessage(uid: '1233234', texto: 'Hola mundo',),
    // ChatMessage(uid: '123', texto: 'Hola mundo',),
    // ChatMessage(uid: '123', texto: 'Hola mundo',),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Column(
            children: <Widget>[
              CircleAvatar(
                child: Text('Te', style: TextStyle(fontSize: 12)),
                backgroundColor: Colors.blue[100],
                maxRadius: 15,
              ),
              Text('Test1',style: TextStyle(color: Colors.black, fontSize: 12),)
            ],
          ),
        ),
        centerTitle: true,
        elevation: 1,
      ),  //para hacer el cuerpo usaremos flexible para que se expanda según lo que tengamos
      body: Column(
        children: <Widget>[
          Flexible(
            // hay que recordar que el listView.builder se va generando con base en la demanda
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, i) {
                return _messages[i];
              },
              reverse: true,
              physics: BouncingScrollPhysics(),
              )
          ),
          Divider( height: 1,),
          //TODO  caja de texto
          Container(
            color: Colors.white,
            child: _inputChat(),
          )

        ],
      )
    );
  }

  Widget _inputChat() {
    // el cuadro de texto siempre debe de trabajarse dentro de un safe area
   return SafeArea(
     child: Container(
       margin: EdgeInsets.symmetric( horizontal: 8.0 ),
       child: Row(
         children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmit,
              onChanged: (String texto) {
                //TODO cuando hay un valor para poder postear
                // en este punto sabemos que el usuario está escribiendo, debemos de cambiar el bool con el setState
                setState(() {
                  if(texto.trim().length > 0) {
                    _estaEscribiendo = true;
                  } else {
                    _estaEscribiendo = false;
                  }
                });
                
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Enviar mensaje'
              ),
              focusNode: _focusNode,
            ) 
          ),

          Container(
            margin: EdgeInsets.symmetric( horizontal: 4.0 ),
            child: IconTheme(
              data: IconThemeData( color: Colors.blue[400] ),
              child: IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: Icon( Icons.send ),
                onPressed: (_estaEscribiendo) 
                          ?
                          () => _handleSubmit( _textController.text.trim() )
                          :
                          null
              ),
            )
          )
         ],
       ),
     ) 
    );  
  }

  // aqui haremos instancias de los mensajes, cada vez que se presione el submit
  // Para insertar 
  _handleSubmit( String texto ) {

    if(texto.length == 0) return;

    print(texto);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      uid: '123', 
      texto: texto,
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 500)),//el this está disponibler gracias a la mezcla  
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });
  }

}