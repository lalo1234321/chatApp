import 'package:chat_app/widgets/loginPage/center_login.dart';
import 'package:chat_app/widgets/loginPage/labels_login.dart';
import 'package:chat_app/widgets/loginPage/upper_login.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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
                      UpperLogin(),
                      CenterLogin(),
                      LabelsLogin(),
                      Text('Términos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200))
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}