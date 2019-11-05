import 'package:flutter/material.dart';
import 'package:projeto_de_lop/controller/appDB.dart';
import 'package:projeto_de_lop/models/Aluno.dart';
import 'package:projeto_de_lop/models/Presenca.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:projeto_de_lop/models/Turma.dart';
import 'package:path_provider/path_provider.dart';
import 'package:projeto_de_lop/pages/listaPresenca.dart';
import 'dart:io';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:projeto_de_lop/pages/PdfViewerPage.dart';
import 'package:simple_permissions/simple_permissions.dart' as prefix1;
import 'package:toast/toast.dart';

class Detalhes extends StatefulWidget {
  final Presenca presenca;
  const Detalhes({Key key, this.presenca}) : super(key: key);
  @override
  _DetalhesState createState() => _DetalhesState(presenca: this.presenca);
}

class _DetalhesState extends State<Detalhes> {
  Presenca presenca;
  _DetalhesState({this.presenca});
  @override
  Widget build(BuildContext context) {
    final gerarPDF = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(32),
      color: Colors.green[600],
      child: MaterialButton(
          minWidth: 200,
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () async {
            _generatePdf(context);
          },
          child: Text('Gerar PDF',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white))),
    );

    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 35),
          Text("Chamada do dia " + presenca.dia,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Expanded(
            child: SizedBox(
              height: 50,
              child: new FutureBuilder(
                future: listarPresenca(presenca),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text("Carregando ..."),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return ListTile(
                            title: Text(snapshot.data[i].nome),
                            subtitle: Text(
                                "Matrícula: " + snapshot.data[i].matricula),
                            leading: CircleAvatar(
                              backgroundColor: Color(0xff01A0C7),
                              foregroundColor: Colors.white,
                              child: Text('${i + 1}'),
                            ));
                      },
                    );
                  }
                },
              ),
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Wrap(
              spacing: 5,
              children: <Widget>[gerarPDF],
            ),
          ),
        ],
      ),
    ));
  }
  _generatePdf(context) async{
    List<Aluno> alunos = await listarPresenca(presenca);
    final pdfLib.Document pdf = pdfLib.Document(deflate: zlib.encode);
    pdf.addPage(
      pdfLib.MultiPage(
        build: (context) => [
          pdfLib.Table.fromTextArray(context: context,data:<List<String>>[
            <String>['Nome','Matricula'],
            ...alunos.map(
              (item) => [item.nome,item.matricula]
            )
          ])
        ]
      )
    );
    //final String dir = (await getExternalStorageDirectory()).path;
     
    final String dir = await "storage/emulated/0";
    final String aux = presenca.getIdChamada;
    final String path  = '/$dir/chamada_$aux.pdf';
    final File file = File(path);
    PermissionStatus permissionResult = await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
    if(permissionResult == PermissionStatus.authorized){
      await file.writeAsBytes(pdf.save());
      Toast.show("PDF gerado", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      print("Veja se funfou");
      Turma turma = await  getTurmaById(presenca);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListaPresenca(turma:turma)));
    }
    print(dir);
    /*Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => PdfViewerPage(path: path))
    );*/
  }



}
