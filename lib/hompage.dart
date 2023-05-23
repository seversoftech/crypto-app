import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  final List currencies;
  const HomePage(this.currencies, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List currencies;
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

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
    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            itemCount: widget.currencies.length,
            itemBuilder: (BuildContext context, int index) {
              final Map currency = widget.currencies[index];
              final MaterialColor color = _colors[index % _colors.length];

              return _getListItemUI(currency, color);
            },
          ),
        ),
      ],
    );
  }

  ListTile _getListItemUI(Map currency, MaterialColor color) {
    return ListTile(
      isThreeLine: true,
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
      subtitle: _getSubtitleText(currency['quote']['USD']['price'],
          currency['quote']['USD']['percent_change_1h']),
    );
  }

  Widget _getSubtitleText(double priceUSD, double percentageChange) {
    TextSpan priceTextWidget = TextSpan(
      text: "\$$priceUSD\n",
      style: const TextStyle(color: Colors.black),
    );
    String percentageChangeText = "1 hour: $percentageChange%";

    TextSpan percentageChangeTextWidget;

    if (double.parse(percentageChange.toString()) > 0) {
      percentageChangeTextWidget = TextSpan(
        text: percentageChangeText,
        style: const TextStyle(color: Colors.green),
      );
    } else {
      percentageChangeTextWidget = TextSpan(
        text: percentageChangeText,
        style: const TextStyle(color: Colors.red),
      );
    }

    return RichText(
      text: TextSpan(children: [priceTextWidget, percentageChangeTextWidget]),
    );
  }
}
