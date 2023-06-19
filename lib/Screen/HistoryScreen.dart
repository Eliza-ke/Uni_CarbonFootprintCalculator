import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../model/history_item.dart';
import 'package:http/http.dart' as http;

final formatterDate = DateFormat.yMd();
final formatterTime = DateFormat.Hm();

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return HistoryScreenState();
  }
}

class HistoryScreenState extends State<HistoryScreen> {
  List<HistoryItem> historyItem = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  void _loadItem() async {
    final url = Uri.https('carbon-footprint-d6ae8-default-rtdb.firebaseio.com',
        'carbonfootprint-history.json');

    try {
      final response = await http.get(url);

      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Failed to fetch data. Please try again later';
        });
      }

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      // decode the data from firebase
      print(response.body);
      final List<HistoryItem> _loadedItems = [];
      for (final item in listData.entries) {
        _loadedItems.add(
          HistoryItem(
              id: item.key,
              dateTime: item.value['dateTime'],
              totalDistance: item.value['totalDistance'],
              totalElectricity: item.value['totalElectricity'],
              totalFood: item.value['totalFood'],
              distanceCategory: item.value['distanceCategory'],
              electricityCategory: item.value['electricityCategory'],
              overallTotal: item.value['overallTotal']),
        );
      } // for loop

      setState(() {
        historyItem = _loadedItems;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = 'Something went wrong. Please try again later';
      });
    }
  }

  void _removeItem(HistoryItem item) async {
    final index = historyItem.indexOf(item);
    setState(() {
      historyItem.remove(item);
    });

    final url = Uri.https('carbon-footprint-d6ae8-default-rtdb.firebaseio.com',
        'carbonfootprint-history/${item.id}.json');

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      setState(() {
        historyItem.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('There is no history'));

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (historyItem.isNotEmpty) {
      content = ListView.builder(
        itemCount: historyItem.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            _removeItem(historyItem[index]);
          },
          key: ValueKey(historyItem[index].id),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 230, 255,
                          255), // Set your desired border color here
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          historyItem[index].dateTime,
                          style: GoogleFonts.abel(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text('Carbon emitted by '),
                      Text(historyItem[index].distanceCategory.toString()),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(historyItem[index].totalDistance.toStringAsFixed(2)),
                      const Text(' kg of CO2e'),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const Text('Carbon emitted by Food'),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(historyItem[index].totalFood.toStringAsFixed(2)),
                      const Text(' kg of CO2e'),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const Text('Carbon emitted by '),
                      Text(historyItem[index].electricityCategory.toString()),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(historyItem[index]
                          .totalElectricity
                          .toStringAsFixed(2)),
                      const Text(' kg of CO2e'),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const Text('Total Carbon Emission'),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(historyItem[index].overallTotal.toStringAsFixed(2)),
                      const Text('kg of CO2e'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (_error != null) {
      content = Center(
        child: Text(_error!),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
      ),
      body: content,
    );
  }
}
