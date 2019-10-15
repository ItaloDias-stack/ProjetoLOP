import 'package:flutter/material.dart';
import 'package:projeto_de_lop/controller/appDB.dart';
import 'package:projeto_de_lop/main.dart';
import 'package:toast/toast.dart';
class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controllerUser = new TextEditingController();
    TextEditingController controllerPass = new TextEditingController();
    TextEditingController controllerName = new TextEditingController();

    final username = TextField(
      controller: controllerUser,
      decoration: InputDecoration(
        contentPadding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 15),
        hintText: 'Nome de Usuário',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
      ),
    );

    final passField = TextField(
      controller: controllerPass,
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 15),
          hintText: 'Senha',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32))),
    );

    final nameField = TextField(
      controller: controllerName,
      decoration: InputDecoration(
          contentPadding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 15),
          hintText: 'Nome Completo',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32))),
    );

    final createButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(32),
      color: Color(0xff01A0C7),

      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: ()async{
          
          if(await createAcc(controllerName.text, controllerUser.text, controllerPass.text)){
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
          }else{
            Toast.show("Esse usuário ja existe", context,duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
            controllerUser.text = "";
            controllerName.text = "";
            controllerPass.text = "";
          }
        },
        child: Text(
          'Criar Usuário',style: TextStyle(color: Colors.white),
        ),
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            new Container(
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 50),
                    Text(
                      'Realize o seu cadastro',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 45),
                    username,
                    SizedBox(height: 25),
                    passField,
                    SizedBox(height: 25),
                    nameField,
                    SizedBox(height: 25),
                    createButton
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
