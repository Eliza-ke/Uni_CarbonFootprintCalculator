import 'package:daily_carbon_footprint/Screen/calculateScreen.dart';
import 'package:daily_carbon_footprint/data/dummydata.dart';
import 'package:daily_carbon_footprint/model/history_item.dart';
import 'package:daily_carbon_footprint/widget/start_widget_item.dart';
import 'package:flutter/material.dart';

//Stateless Widget
class StartWidget extends StatelessWidget {
  const StartWidget({super.key, required this.historyItem});
  final List<HistoryItem> historyItem;

  void calculateBtn(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => CalculateScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Save Our Planet',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Color.fromARGB(255, 45, 2, 75),
                ),
          ),
          const SizedBox(height: 50),
          Text(
            'Calculate Your Daily Carbon Consumption',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Color.fromARGB(255, 45, 2, 75),
                ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (final item in dummyItem)
                Item(
                  title: item.category.name,
                  item: item,
                ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              calculateBtn(context);
            },
            child: const Text('Calculate'),
          ),
        ],
      ),
    );
  }
}
