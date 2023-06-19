import 'package:flutter/material.dart';

enum Travel { Bus, Car, Motorcycle }

const travelCarbonValue = {
  // per mile
  Travel.Bus: 0.68,
  Travel.Car: 2.7,
  Travel.Motorcycle: 0.5,
};

enum Food { Meat, Dairy, Vegetable, Fruit }

const foodValue = {
  // per kg
  Food.Meat: 30,
  Food.Dairy: 6,
  Food.Vegetable: 0.4,
  Food.Fruit: 0.7,
};

enum Electricity { Natural_Gas, Oil }

const ElectricityValue = {
  //per kWh
  Electricity.Natural_Gas: 0.5,
  Electricity.Oil: 0.6,
};

enum Category { Travel, Food, Electricity }

const categoryIcons = {
  Category.Food: Icons.fastfood,
  Category.Travel: Icons.electric_car,
  Category.Electricity: Icons.lightbulb_circle,
};

class EachItem {
  const EachItem(
      {required this.id,
      required this.category,
      required this.color1,
      required this.color2});

  final String id;
  final Category category;
  final Color color1;
  final Color color2;
}
