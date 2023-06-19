import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../model/each_item.dart';
import '../model/history_item.dart';

var myFormat = DateFormat('d-MM-yyyy');

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({super.key});

  @override
  State<CalculateScreen> createState() {
    return _CalculateScreenState();
  }
}

class _CalculateScreenState extends State<CalculateScreen> {
  final _formKey = GlobalKey<FormState>();
  // in order to use formKey for 'validator' and 'onSaved'
  var _enteredDistance;

  var _enteredMeat;
  var _enteredDairy;
  var _enteredVegetable;
  var _enteredFruit;

  var _enteredElectricity;

  var _selectedTravel = Travel.Bus;
  var _selectedElectricity = Electricity.Natural_Gas;

  var totalDistance;
  var totalFood;
  var totalElectricity;
  var dailytotal;

  var _isSending = false;

  void _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Total Carbon Footprint'),
        content: (dailytotal != null)
            ? Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue, // Set your desired border color here
                    width: 1.0, // Set the border width
                  ),
                  borderRadius: BorderRadius.circular(9),
                ),
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Carbon emitted by Travel : $totalDistance',
                      style: TextStyle(
                          fontSize: 16,
                          color: (totalDistance > 200)
                              ? Colors.red
                              : Colors.black),
                    ),
                    Text(
                      'Carbon emitted by Food : $totalFood ',
                      style: TextStyle(
                        fontSize: 16,
                        color: (totalFood > 20000) ? Colors.red : Colors.black,
                      ),
                    ),
                    Text(
                      'Carbon emitted by Electricity : $totalElectricity',
                      style: TextStyle(
                        fontSize: 16,
                        color: (totalElectricity > 200)
                            ? Colors.red
                            : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Total Emission : $dailytotal kg of CO2e',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: (dailytotal > 1000)
                            ? Color.fromARGB(255, 252, 33, 17)
                            : Color.fromARGB(255, 44, 145, 228),
                      ),
                    ),
                  ],
                ),
              )
            : const Text('Invalid Data'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _isSending = false;
              });
              Navigator.pop(ctx);
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  void _saveItem() async {
    DateTime dateTime = DateTime.now();
    String currentTime = myFormat.format(dateTime);

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        totalDistance = double.tryParse(_enteredDistance)! *
            travelCarbonValue[_selectedTravel]!;
        totalElectricity = double.tryParse(_enteredElectricity)! *
            ElectricityValue[_selectedElectricity]!;

        var meatValue = double.tryParse(_enteredMeat)! * foodValue[Food.Meat]!;

        var dairyValue =
            double.tryParse(_enteredDairy)! * foodValue[Food.Dairy]!;
        var vegetableValue =
            double.tryParse(_enteredVegetable)! * foodValue[Food.Vegetable]!;
        var fruitValue =
            double.tryParse(_enteredFruit)! * foodValue[Food.Fruit]!;

        totalFood = meatValue + dairyValue + vegetableValue + fruitValue;
        dailytotal = totalDistance + totalElectricity + totalFood;
      });

      FocusManager.instance.primaryFocus?.unfocus();
      _showDialog();

      setState(() {
        _isSending = true;
      });
      final url = Uri.https(
          'carbon-footprint-d6ae8-default-rtdb.firebaseio.com',
          'carbonfootprint-history.json');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'dateTime': currentTime,
            'totalDistance': totalDistance,
            'totalElectricity': totalElectricity,
            'totalFood': totalFood,
            'distanceCategory': _selectedTravel.name,
            'electricityCategory': _selectedElectricity.name,
            'overallTotal': dailytotal
          },
        ),
      ); // body // post
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculate Carbon Footprint'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
        child: Form(
          key: _formKey, // very important to get value from InputForm
          child: ListView(
            children: [
              Text(
                'Traveled Distance',
                style: GoogleFonts.aBeeZee(
                    fontSize: 16, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 218, 232, 255),
                ),
                //Travel
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Distance'),
                          icon: Icon(
                            Icons.electric_car_rounded,
                            size: 25,
                          ),
                          suffixText: 'miles',
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              double.tryParse(value) == null ||
                              double.tryParse(value)! <= 0) {
                            return 'Must be a valid, positive number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _enteredDistance = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 140,
                      height: 110,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Vehicle',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 7),
                          DropdownButtonFormField(
                              borderRadius: BorderRadius.circular(25),
                              value: _selectedTravel,
                              items: [
                                for (final travel in Travel.values)
                                  DropdownMenuItem(
                                    value: travel,
                                    child: Text(travel.name),
                                  ),
                              ],
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _selectedTravel = value!;
                                });
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Food
              const SizedBox(height: 10),
              Text(
                'Food',
                style: GoogleFonts.aBeeZee(
                    fontSize: 16, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              Container(
                padding: const EdgeInsets.all(18),
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 252, 234, 208),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text(
                          'Meat',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                        icon: Icon(
                          Icons.fastfood_sharp,
                        ),
                        suffixText: 'kg',
                      ),
                      onSaved: (value) {
                        if (value == null || value.isEmpty) {
                          value = '0';
                        }
                        setState(() {
                          _enteredMeat = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text(
                          'Dairy',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                        icon: Icon(
                          Icons.fastfood_sharp,
                        ),
                        suffixText: 'kg',
                      ),
                      onSaved: (value) {
                        if (value == null || value.isEmpty) {
                          value = '0';
                        }
                        setState(() {
                          _enteredDairy = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text(
                          'Vegetable',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                        icon: Icon(
                          Icons.fastfood_sharp,
                        ),
                        suffixText: 'kg',
                      ),
                      onSaved: (value) {
                        if (value == null || value.isEmpty) {
                          value = '0';
                        }
                        setState(() {
                          _enteredVegetable = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text(
                          'Fruit',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                        icon: Icon(
                          Icons.fastfood_sharp,
                        ),
                        suffixText: 'kg',
                      ),
                      onSaved: (value) {
                        if (value == null || value.isEmpty) {
                          value = '0';
                        }
                        setState(() {
                          _enteredFruit = value;
                        });
                      },
                    ),
                  ],
                ),
              ),

              // electricity
              const SizedBox(height: 20),
              Text(
                'Electricity',
                style: GoogleFonts.aBeeZee(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),

              Container(
                padding: const EdgeInsets.all(18),
                margin: const EdgeInsets.symmetric(vertical: 25),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 214, 248, 219),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Amount of Electricity'),
                          suffixText: 'kWh',
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              double.tryParse(value) == null ||
                              double.tryParse(value)! < 0) {
                            return 'Must be a valid, positive number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _enteredElectricity = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 155,
                      height: 106,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Electricity Source',
                              style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 10),
                          DropdownButtonFormField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              value: _selectedElectricity,
                              items: [
                                for (final electricity in Electricity.values)
                                  DropdownMenuItem(
                                    value: electricity,
                                    child: Text(electricity.name),
                                  ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedElectricity = value!;
                                });
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _formKey.currentState!.reset();
                      },
                      child: const Text('Reset'),
                    ),
                    ElevatedButton(
                      onPressed: _saveItem,
                      child: _isSending
                          ? const SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(),
                            )
                          : const Text('Calculate'),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
