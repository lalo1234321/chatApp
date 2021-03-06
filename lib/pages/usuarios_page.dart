import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  final  usuarioService = new UsuarioService();  
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  List<Usuario> usuarios = [];
  // cuando entremos a la página debemos de cargar los ususarios
  @override
  void initState() { 
    this._cargarUsuarios();
    super.initState();
    
  }

  // final usuarios = [
  //   // Usuario(uid: '1',nombre: 'Lalo', email: 'test1@test', online: true),
  //   // Usuario(uid: '2',nombre: 'Edgar', email: 'test2@test', online: true),
  //   // Usuario(uid: '3',nombre: 'Luis', email: 'test3@test', online: true),
  //   // Usuario(uid: '4',nombre: 'Alberto', email: 'test4@test', online: false)
  // ];

  @override
  Widget build(BuildContext context) {
    // para extraer la información del usuario registrado
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuario = authService.usuario;
    print(socketService.serverStatus);
    return Scaffold(
      appBar: AppBar(
        title: Text(usuario.nombre, style: TextStyle(color: Colors.black87),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black87),
          onPressed: () {
            //TODO desconectar de nuestro socket server
            // como yo no quiero instanciar todo el authservice podemos entrar a los métodos estáticos
            // por eso es imporetante trabajar con métodos estáticos según nos convenga
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
            //  en este punto ya se borró el token y cuand0 reiniciemos la app la loading page nos
            // redirigirá al login page
          },
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only( right: 10 ),
            // child: Icon(Icons.check_circle, color: Colors.blue,),
            child: ( socketService.serverStatus == ServerStatus.Online) 
                          ? 
                    Icon(Icons.check_circle, color: Colors.blue,)
                            :
                    Icon(Icons.bolt, color: Colors.red,),
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
          // agregar onTap para saber a qué usuario apuntar
          onTap: () {
            // listen en false porque no quiero que este escuchando los cambios
            // Debo de invesigar cuando ponerle true y cuando false
            final chatService = Provider.of<ChatService>(context, listen: false);
            chatService.usuarioPara = usuario;
            print(usuario.nombre);

            Navigator.pushNamed(context, 'chat');
          },
        );
  }

  _cargarUsuarios() async{
    
    this.usuarios = await usuarioService.getUsuarios();
    setState(() {
      
    });
    // await Future.delayed(Duration( milliseconds: 1000 ));
    _refreshController.refreshCompleted();
  }
}