import 'package:chat_app/widgets/loginPage/center_login.dart';
import 'package:chat_app/widgets/loginPage/labels_login.dart';
import 'package:chat_app/widgets/loginPage/upper_login.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
    );
  }
}