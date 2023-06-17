import 'package:http/http.dart' as http;
import 'dart:convert';
import 'entidade.dart';

class BackEnd {
  Future<int> post(Exercicio exercicio) async {
    Uri request = Uri(
        scheme: "http",
        host: "localhost",
        port: 5000,
        path: "/exercicios",
        queryParameters: {
          "nme_exercicio": exercicio.nome,
          "dsc_exercicio": exercicio.descricao,
          "num_repeticao_exercicio": exercicio.repeticao.toString(),
          "num_gasto_calorico_exercicio": exercicio.caloria.toString()
        });
    print(request.queryParameters);
    http.Response response = await http.post(request);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['insert'];
    } else {
      Future.error("Exercicio não cadastrada!");
      return 0;
    }
  }
}
