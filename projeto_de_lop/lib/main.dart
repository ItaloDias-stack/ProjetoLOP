import 'package:flutter/material.dart';

import 'package:projeto_de_lop/controller/appDB.dart';
import 'package:projeto_de_lop/inicio.dart';
import 'package:toast/toast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Realize o seu login',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LoginPage(title: 'Login'),
        routes: <String, WidgetBuilder>{
          '/inicio': (BuildContext context) => new Inicio(),
        });
  }
}

class LoginPage extends StatefulWidget {
  final String title;
  LoginPage({Key key, this.title}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controllerUser = new TextEditingController();
    TextEditingController controllerPass = new TextEditingController();

    final userField = TextField(
      controller: controllerUser,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Usuário',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
      ),
    );
    final passField = TextField(
      controller: controllerPass,
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Senha',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32))),
    );

    /*Future<String> login() async {
      final response = await http.post("http://192.168.0.18/projeto/login.php",
          body: {"usuario": controllerUser.text, "senha": controllerPass.text});
      if (response.body.length>2) {
        var datauser = json.decode(response.body);
        print('[INFORMATION] ' + datauser.toString());
        //Navigator.pushReplacementNamed(context, '/inicio');
      }else{
        setState(() {
            print("Usuário ou senha incorretos");
          });
      }
    }*/

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(32),
      color: Color(0xff01A0C7),
      child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width / 1.75,
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () async {
            String mensagem =
                await login(controllerUser.text, controllerPass.text);
            print(mensagem);
            if (mensagem == 'true') {
              Navigator.pushReplacementNamed(context, '/inicio');
            }
            else {
              Toast.show("Usuário ou senha incorretos", context, duration: Toast.LENGTH_LONG,gravity: Toast.TOP);
            }
          },
          child: Text('Login',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white))),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            new Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.account_circle, color: Colors.blue, size: 100),
                    SizedBox(height: 45),
                    userField,
                    SizedBox(height: 25),
                    passField,
                    SizedBox(height: 35),
                    loginButton
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
