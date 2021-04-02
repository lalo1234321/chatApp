import 'package:flutter/material.dart';

class LabelsRegister extends StatelessWidget {

  final String route;

  const LabelsRegister({
    Key key, 
    @required this.route
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text('¿Ya tienes una cuenta?', style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight:FontWeight.w300),),
          SizedBox( height: 10, ),
          GestureDetector(
            child: Text( 'Ingresa con ella!', style: TextStyle(color:  Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold), ),
            onTap: () {
              // cuando pasa esto destruye la página anterior y en el arbol de componentes ahora esta estará al final
              Navigator.pushReplacementNamed(context, this.route);
            },
          )
        ],
      ),
      
    );
  }
}