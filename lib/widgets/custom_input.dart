import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  final IconData icon;
  final String placeHolder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;

  // este es un contructor, y podemos usar @required para hacer obligatorios los campos

  const CustomInput(
    {Key key,
    @required this.icon, 
    @required this.placeHolder, 
    @required this.textController, 
    this.keyboardType = TextInputType.text, 
    this.isPassword = false
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      // este padding es para poder hacer que el texto interno no se pegue tanto al borde derecho
      padding: EdgeInsets.only( top:5, left:5, bottom: 5, right: 20 ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.09),
            offset: Offset(0,5),
            // blur es para difuminar el color 
            blurRadius: 5
          )
        ]
      ),
      child: TextField(
        // autoCorrect autocompleta el texto
        autocorrect: false,
        controller: this.textController,
        keyboardType: this.keyboardType,
        obscureText: this.isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(this.icon),
          // esto quita la línea de abajo
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: this.placeHolder
        ),
      ),
    );
  }
}