import 'package:daily_carbon_footprint/model/each_item.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  const Item({
    super.key,
    required this.title,
    required this.item,
  });
  final String title;
  final EachItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(23),
      child: InkWell(
        // InkWell is that each grid widget will be tappable
        onTap: () {},
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [item.color1, item.color2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Icon(
                categoryIcons[item.category],
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Color.fromARGB(255, 45, 2, 75),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
