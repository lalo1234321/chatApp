import 'package:chat_app/routes/routes.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat app',
      //esta página se encargará de saber si está autenticado o no, dependiendo de esto se enviará a una página o a otra
      initialRoute: 'chat', 
      routes: appRoutes,

    );
  }
}