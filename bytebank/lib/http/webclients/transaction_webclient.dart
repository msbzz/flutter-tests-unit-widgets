import 'dart:convert';
import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  static const String baseUrl = 'http://192.168.0.64:8080/transactions';

  Future<List<Transaction>> findAll() async {
    final Uri uri = Uri.parse(baseUrl);
    final Response response = await client.get(uri);
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Transaction.fromJson(json)).toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    await Future.delayed(Duration(seconds: 2));

    print('>>>>>>>>>> Into transaction webclient / save <<<<<<<<<<<<<');
    print('>>>>>>> converteu para Uri <<<<<<<<<<<<');
    print('Dados enviados: $transactionJson');

    final Uri uri = Uri.parse(baseUrl);
    try {
      final Response response = await client.post(
        uri,
        headers: {
          'Content-type': 'application/json',
          'password': password,
          'Cache-Control': 'no-cache',
        },
        body: transactionJson,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('Response statusCode ===>> ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Transaction.fromJson(jsonDecode(response.body));
      } else {
        throw HttpException(_getMessage(response.statusCode));
      }
    } catch (e) {
      print('Error: $e');
      throw e;  // Certifique-se de lançar o erro novamente para o chamador tratar
    }
  }

  String _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode]!;
    }
    return 'unknown error';
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed',
    409: 'transaction already exists'
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
