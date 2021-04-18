import 'package:chat_app/routes/routes.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: ( BuildContext context ) => AuthService()),
          ChangeNotifierProvider(create: ( BuildContext context ) => SocketService())
        ],
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat app',
        //esta página se encargará de saber si está autenticado o no, dependiendo de esto se enviará a una página o a otra
        initialRoute: 'loading', 
        routes: appRoutes,

      ),
    );
  }
}