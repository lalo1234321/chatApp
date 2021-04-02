import 'package:chat_app/widgets/register_page/center_register.dart';
import 'package:chat_app/widgets/register_page/labels_register.dart';
import 'package:chat_app/widgets/register_page/upper_register.dart';
import 'package:flutter/material.dart';



class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
// con el SingleCHild Scroll podremos quitar el error del overflow,
// pero sale otro error, que hace que los espacios se vean afectados 
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            // con esto podemos activar la animación de que rebote, con el Mediaquery
            height: MediaQuery.of(context).size.height * .9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                UpperRegister(titulo:'Registro'),
                CenterRegister(),
                LabelsRegister(route:'login'),
                // Text('Términos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200))
              ],
            ),
          ),
        ),
      ),
    );
  }
}