import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../hompage.dart';

void main() async {
  List currencies = await getCurrencies();

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
    'X-CMC_PRO_API_KEY': 'YOUR-API-KEY',
  };

  final response = await http.get(
      Uri.parse(
          'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=5000&convert=USD'),
      headers: headers);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['data'];
  } else {
    throw Exception('Failed to fetch data');
  }
}
