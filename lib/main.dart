import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../hompage.dart';

void main() async {
  List currencies = await getCurrencies();
  if (kDebugMode) {
    print(currencies);
  }
  runApp(MyApp(currencies));
}

class MyApp extends StatelessWidget {
  final List _currencies;
  const MyApp(this._currencies, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(_currencies),
    );
  }
}

Future<List<dynamic>> getCurrencies() async {
  final headers = {
    'Content-Type': 'application/json',
    'X-CMC_PRO_API_KEY': '192f6ffc-306a-495f-8110-ebd51b64b52d',
  };

  final response = await http.get(
      Uri.parse(
          'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest'),
      headers: headers);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data[
        'data']; // Assuming the API response contains a 'data' field with the required cryptocurrency information.
  } else {
    throw Exception('Failed to fetch data');
  }
}

