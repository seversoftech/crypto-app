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
  late final List currencies;
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  @override
  Future<void> initState() async {
    super.initState();
    currencies = await getCurrencies();
  }

  Future<List> getCurrencies() async {
    String cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/?limit=50";
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

  Widget _cryptoWidget() {
    return Container(
      child: Flexible(
        child: ListView.builder(
          itemCount: currencies.length,
          itemBuilder: (BuildContext context, int index) {
            final Map currency = currencies[index];
            final MaterialColor color = _colors[index % _colors.length];

            return _getListItemUI(currency, color);
          },
        ),
      ),
    );
  }

  ListTile _getListItemUI(Map currency, MaterialColor color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(
          currency['name'][0],
        ),
      ),
      title: Text(
        currency['name'],
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: _getSubtitleText(
          currency['price_usd'], currency['percentage_change_1h']),
    );
  }

  Widget _getSubtitleText(String priceUSD, String percentageChange) {
    TextSpan priceTextWidget = TextSpan(
        text: "\$$priceUSD\n", style: const TextStyle(color: Colors.black));
    String percentageChangeText = "1 hour: $percentageChange%";

    TextSpan percentageChangeTextWidget;

    if (double.parse(percentageChange) > 0) {
      percentageChangeTextWidget = TextSpan(
          text: percentageChangeText,
          style: const TextStyle(color: Colors.green));
    } else {
      percentageChangeTextWidget = TextSpan(
          text: percentageChangeText,
          style: const TextStyle(color: Colors.red));
    }

    return RichText(text: TextSpan(children: [priceTextWidget,percentageChangeTextWidget]));
  }
}
