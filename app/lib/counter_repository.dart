import 'dart:convert';

import 'package:counter_edge_functions/model/counter_response.dart';
import 'package:http/http.dart' as http;

class CounterRepository {
  static final _functionUrl =
      Uri.parse('http://localhost:54321/functions/v1/dart_edge');

  Future<CounterResponse> get count async {
    final response = await http.get(_functionUrl);
    final body =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    return CounterResponse.fromJson(body);
  }

  Future<CounterResponse> increment() async {
    final response = await http.post(_functionUrl);
    final body =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    return CounterResponse.fromJson(body);
  }
}
