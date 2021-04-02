import 'package:chat_app/widgets/btn_azul.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class CenterRegister extends StatefulWidget {
  @override
  _CenterRegisterState createState() => _CenterRegisterState();
}

class _CenterRegisterState extends State<CenterRegister> {

  final nameCtrl = TextEditingController();
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
            placeHolder: 'Nombre',
            keyboardType: TextInputType.text,
            // en este apartado debemos de usar unas variables de controlador que definamos en este archivo
            textController: nameCtrl,
          ),
          SizedBox(height: 20,),
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