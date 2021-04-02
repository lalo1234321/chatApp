import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(uid: '1',nombre: 'Lalo', email: 'test1@test', online: true),
    Usuario(uid: '2',nombre: 'Edgar', email: 'test2@test', online: true),
    Usuario(uid: '3',nombre: 'Luis', email: 'test3@test', online: true),
    Usuario(uid: '4',nombre: 'Alberto', email: 'test4@test', online: false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi nombre', style: TextStyle(color: Colors.black87),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black87),
          onPressed: () => print('hoola'),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only( right: 10 ),
            // child: Icon(Icons.check_circle, color: Colors.blue,),
            child: Icon(Icons.bolt, color: Colors.red,),
          )
        ],
      ),
      // body: _listViewUsuarios()
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400],),
          waterDropColor: Colors.blue[400],
        ),
        onRefresh: () {
          _cargarUsuarios();
        },
        child: _listViewUsuarios(),
      ),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context,i) {
        return _usuarioListTile(usuarios[i]);
      },
      separatorBuilder: (BuildContext context,i) {
        return Divider();
      },
      itemCount: usuarios.length,
      
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
          title: Text(usuario.nombre),
          subtitle: Text(usuario.email),
          leading: CircleAvatar(
            child: Text(usuario.nombre.substring(0,2)),
          ),
          trailing: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: (usuario.online) ? Colors.green : Colors.grey,
              borderRadius: BorderRadius.circular(100)
            ),
          ),
        );
  }

  _cargarUsuarios() async{
    await Future.delayed(Duration( milliseconds: 1000 ));
    _refreshController.refreshCompleted();
  }
}