import 'package:daily_carbon_footprint/model/each_item.dart';
import 'package:flutter/material.dart';

const dummyItem = [
  EachItem(
      id: 'I1',
      category: Category.Travel,
      color1: Color.fromARGB(255, 62, 129, 243),
      color2: Color.fromARGB(255, 1, 81, 219)),
  EachItem(
      id: 'I2',
      category: Category.Food,
      color1: Color.fromRGBO(235, 142, 3, 1),
      color2: Color.fromRGBO(196, 106, 3, 1)),
  EachItem(
      id: 'I3',
      category: Category.Electricity,
      color1: Color.fromARGB(255, 8, 185, 117),
      color2: Color.fromARGB(255, 3, 158, 112)),
];
