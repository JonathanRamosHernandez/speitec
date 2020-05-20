import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speitec/pages/powerpage.dart';
import 'package:speitec/pages/tablas.dart';
import 'package:speitec/solicitud.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'dart:async';

import 'main.dart';

void main() => runApp(Log());

class Log extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Speitec',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.

        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => MyApp(),
      },
    );
  }
}

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController password = new TextEditingController();
  TextEditingController usuario = new TextEditingController();
  String mensaje = '';
  bool _obscureText = true;

  Future<List> obtenerusuario() async {
    var url =
        "http://192.168.0.6/example/ProyectoFinal/Main_app/loginflutter.php";
    final response = await http
        .post(url, body: {"usuariolg": usuario.text, "passlg": password.text});
    if (response.body == "CORRECTO") {
      Navigator.of(context).pushNamed('/second', arguments: usuario.text);

      print("este es mi usuario$usuario");
      Toast.show("Login correcto", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white);
    } else if (response.body == "ERROR") {
      Toast.show("Login incorrecto", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    appBar:
    AppBar();

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        height: 600,
        margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
        child: Column(
          children: <Widget>[
            Container(
              child: Image(
                image: AssetImage('Assets/logo.png'),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              padding: EdgeInsets.all(40),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      controller: usuario,
                      autofocus: false,
                      obscureText: false,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_circle),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 30, 20.0, 15.0),
                          hintText: 'Usuario'),
                    ),
                    new SizedBox(height: 20.0),
                    TextField(
                      controller: password,
                      autofocus: false,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 30, 20.0, 15.0),
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Contraseña',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            semanticLabel: _obscureText
                                ? 'show password'
                                : 'hide password',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 110.0),
                      child: OutlineButton(
                        shape: StadiumBorder(),
                        child: Text('Ingresar'),
                        onPressed: () {
                          obtenerusuario();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
