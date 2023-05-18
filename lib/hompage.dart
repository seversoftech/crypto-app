import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   late List currencies;

  @override
  Future<void> initState() async {
    super.initState();
    currencies = await getCurrencies();
  }

  Future <List> getCurrencies() async{
    String cryptoUrl="https://api.coinmarketcap.com/v1/ticker/?limit=50";
    http.Response response = await http.get(cryptoUrl as Uri);
    return json.decode(response.body);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto App'),
      ),
      body: _cryptoWidget(),
    );
  }
}

Widget _cryptoWidget() {
  return Container(
    child: Flexible(
      child: ListView.builder(
          itemCount: 0, itemBuilder: (BuildContext context, int index) {}),
    ),
  );
}
