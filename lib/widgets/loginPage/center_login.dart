import 'package:chat_app/helpers/mostrar_alerta.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/widgets/btn_azul.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CenterLogin extends StatefulWidget {
  @override
  _CenterLoginState createState() => _CenterLoginState();
}

class _CenterLoginState extends State<CenterLogin> {

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // le quitamos el listen porque necesitamos que se redibuje esta parte del login
    final authService = Provider.of<AuthService>(context);
    // hacemos una instancia del socketService
    final socketService = Provider.of<SocketService>(context);
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
            onPressed: authService.autenticando ? null : () async{
              print('Correo  ${emailCtrl.text}\nPassword ${passCtrl.text}');
              // final authService = Provider.of<AuthService>(context, listen: false);
              final loginOk = await authService.login(emailCtrl.text, passCtrl.text);
              if( loginOk ) {
                print('Navegando a la otra página');
                // TODO navegar a otra página
                // TODO conectarme a los sockets
                socketService.connect();
                Navigator.pushReplacementNamed(context, 'usuarios');
              } else {
                print('credenciales incorrectas');
                // MOstrar alerta
                mostrarAlerta(context, 'Login incorrecto', 'Revisar credenciales');
              }
            }
          )
        ],
      ),
    );
  }


}