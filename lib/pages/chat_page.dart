import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

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
              itemBuilder: (BuildContext context, i) {
                return Text('${i}');
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

              },
              decoration: InputDecoration.collapsed(
                hintText: 'Enviar mensaje'
              ),
              focusNode: _focusNode,
            ) 
          ),

          Container(
            margin: EdgeInsets.symmetric( horizontal: 4.0 ),
            child: IconButton(
              icon: Icon( Icons.send, color: Colors.blue, ),
              onPressed: () {
                
              },
            )
          )
         ],
       ),
     ) 
    );  
  }

  _handleSubmit( String texto ) {
    print(texto);
    _textController.clear();
    _focusNode.requestFocus();
  }

}