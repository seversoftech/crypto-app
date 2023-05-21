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

Future<List> getCurrencies() async {
  String cryptoUrl = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest';

    final headers = {
    'Content-Type': 'application/json', 
    'X-CMC_PRO_API_KEY': 'YOUR-API-KEY', 
  };


  http.Response response = await http.get(Uri.parse(cryptoUrl), headers: headers);
  return json.decode(response.body);
  
}

