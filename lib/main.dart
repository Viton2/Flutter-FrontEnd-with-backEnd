import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'entidade.dart';
import 'servico.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de Exercício'),
        ),
        body: const Cadastro(),
      ),
    );
  }
}

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorDescricao = TextEditingController();
  final TextEditingController _controladorRepeticao = TextEditingController();
  final TextEditingController _controladorCaloria = TextEditingController();

  void cadastrar() {
    final String nome = _controladorNome.text;
    final String descricao = _controladorDescricao.text;
    final int repeticao = int.parse(_controladorRepeticao.text);
    final int caloria = int.parse(_controladorCaloria.text);

    final Exercicio exercicio = Exercicio(nome, descricao, repeticao, caloria);
    print(exercicio);
    BackEnd backEnd = BackEnd();
    //Future<int> retorno = backEnd.post(tarefa);

    backEnd.post(exercicio).then((response) {
      _showDialog(
          "O Exercício foi cadastrado com sucesso.\n\nIdentificador: $response");
    }).catchError((onError) {
      _showDialog("Não foi possível cadastrar o exercício!");
    });

    // Limpando campos
    _controladorNome.text = "";
    _controladorDescricao.text = "";
    _controladorRepeticao.text = "";
    _controladorCaloria.text = "";
  }

  Future<void> _showDialog(String msg) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Cadastro de Exercício"),
          content: Text(msg),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _controladorNome,
            decoration: const InputDecoration(labelText: 'Nome do Exercício'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: TextField(
              minLines: 4,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: _controladorDescricao,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: TextField(
                keyboardType: TextInputType.number,
                controller: _controladorRepeticao,
                decoration:
                    const InputDecoration(labelText: 'Repetições do Exercício'),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: TextField(
                keyboardType: TextInputType.number,
                controller: _controladorCaloria,
                decoration: const InputDecoration(labelText: 'Gasto Calórico'),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ElevatedButton(
              onPressed: cadastrar,
              child: const Text('Cadastrar Exercício'),
            ),
          ),
        ],
      ),
    );
  }
}
