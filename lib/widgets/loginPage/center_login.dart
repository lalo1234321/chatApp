import 'package:chat_app/widgets/btn_azul.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class CenterLogin extends StatefulWidget {
  @override
  _CenterLoginState createState() => _CenterLoginState();
}

class _CenterLoginState extends State<CenterLogin> {

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.only(top:40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.mail_outline,
            placeHolder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            // en este apartado debemos de usar unas variables de controlador que definamos en este archivo
            textController: emailCtrl,
          ),
          SizedBox(height: 20,),
          CustomInput(
            icon: Icons.lock,
            placeHolder: 'Password',
            textController: passCtrl,
            isPassword: true,
          ),
          SizedBox(height: 20,),
          BtnAzul(
            texto: 'Ingresar', 
            onPressed: (){
              print('Correo  ${emailCtrl.text}');
            }
          )
        ],
      ),
    );
  }


}