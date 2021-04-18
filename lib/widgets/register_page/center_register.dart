import 'package:chat_app/helpers/mostrar_alerta.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/widgets/btn_azul.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
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
            onPressed: authService.autenticando ? null : () async{
              print('Nombre ${nameCtrl.text}, Correo  ${emailCtrl.text}, password ${passCtrl.text}');
              final registerOk = await authService.register(nameCtrl.text, emailCtrl.text, passCtrl.text);
              if( registerOk == true ) {
                // TODO conectar al socket server
                socketService.connect();
                mostrarAlerta(context, 'registro exitoso', 'todo corrrecto');
                Navigator.pushReplacementNamed(context, 'usuarios');
              } else {
                mostrarAlerta(context, 'algo salió mal', registerOk.toString());
              }
            }
          )
        ],
      ),
    );
  }


}