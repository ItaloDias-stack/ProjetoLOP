import 'dart:async';
import 'dart:io';
import 'package:projeto_de_lop/controller/appDB.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:projeto_de_lop/models/Aluno.dart';
import 'package:projeto_de_lop/models/Turma.dart';
import 'package:toast/toast.dart';

class CadastrarAluno extends StatefulWidget {
  final Turma turma;
  const CadastrarAluno({Key key, this.turma}) : super(key: key);

  @override
  _CadastrarAlunoState createState() => _CadastrarAlunoState(turma: this.turma);
}

class _CadastrarAlunoState extends State<CadastrarAluno> {
  final TextEditingController controllerNome = new TextEditingController();
  final TextEditingController controllerMatricula = new TextEditingController();
  Turma turma;
  _CadastrarAlunoState({this.turma});
  String _temp = " ";
  MqttClient client;

  String username = 'ofogefpy';
  String pass = 't9VT0Rz2Vdka';
  int port = 17709;

  void connect() async {
    client = MqttClient('tailor.cloudmqtt.com', '');
    client.port = port;
    client.keepAlivePeriod = 60;
    client.logging(on: false);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;

    

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .keepAliveFor(20) // Must agree with the keep alive set above or not set
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    client.connectionMessage = connMess;

    try {
      if (client.connectionStatus.state ==
          mqtt.MqttConnectionState.disconnected) {
        await client.connect(username, pass);
      }
      print('to aq');
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      //client.disconnect();
    }

    if (client.connectionStatus.state == MqttConnectionState.connected) {
      print('EXAMPLE::Mosquitto client connected');
    } else {
      print(
          'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      //client.disconnect();
      //exit(-1);
    }

    const String topic = '/aluno';
    client.subscribe(topic, MqttQos.atMostOnce);
    client.updates.listen(_onMessage);
  }

  void _onMessage(List<mqtt.MqttReceivedMessage> event) {
    final mqtt.MqttPublishMessage recMess =
        event[0].payload as mqtt.MqttPublishMessage;
    final String message =
        mqtt.MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    setState(() {
      _temp = message;
      controllerNome.text=controllerNome.text;
      controllerMatricula.text=controllerMatricula.text;
    });
      

    
  }

  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
  }

  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus.returnCode == MqttConnectReturnCode.solicited) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    }
    //exit(-1);
  }

  void onConnected() {
    print(
        'EXAMPLE::OnConnected client callback - Client connection was sucessful');
  }

  void pong() {
    print('EXAMPLE::Ping response client callback invoked');
  }

  @override
  Widget build(BuildContext context) {
    final id = Text("ID: " + _temp,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15, color: Colors.blueGrey[300]));

    

    final nomeField = TextField(
      controller: controllerNome,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_box),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Nome do Aluno',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
      ),
    );

    final getConnection = FloatingActionButton(
      backgroundColor: Colors.blueAccent[300],
      child: Icon(Icons.play_arrow),
      onPressed: () {
        connect();
      },
    );
    final salvar = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(32),
      color: Colors.green[600],
      child: MaterialButton(
          minWidth: 100,
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () async {
            if (_temp == "") {
              Toast.show("Aguarde a carteirinha para salvar os alunos", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
            } else {
              if (controllerNome.text == "" || controllerMatricula == "") {
                Toast.show("Insira os dados do aluno", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
              } else {
                Aluno aluno = new Aluno(
                    controllerNome.text, controllerMatricula.text, _temp, '');
                if (await inserirAlunos(aluno, turma)) {
                  Toast.show("Aluno inserido com sucesso", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
                  
                  setState(() {
                    controllerMatricula.text = "";
                    controllerNome.text = "";
                     _temp = "";
                  });
                  
                }else{
                  Toast.show("Esse aluno já está cadastrado na turma", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
                  setState(() {
                    controllerMatricula.text = "";
                    controllerNome.text = "";
                     _temp = "";
                  });   
                }
              }
            }
          },
          child: Text('Salvar Aluno',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white))),
    );

    final matField = TextField(
      controller: controllerMatricula,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.assignment_ind),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Matrícula do Aluno',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
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
                      'Cadastro de Alunos',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 35),
                    id,
                    SizedBox(height: 25),
                    nomeField,
                    SizedBox(height: 25),
                    matField,
                    SizedBox(height: 25),
                    new Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        child: Wrap(
                          spacing: 50,
                          children: <Widget>[salvar,getConnection],
                        ))
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
