// import 'package:flutter/material.dart';

// class FoodWidget extends StatelessWidget {
//   const FoodWidget({super.key, this.enteredFood});
//   final SenteredFood;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//                   children: [
//                     Text(
//                       'Dietary Patterns',
//                       style: GoogleFonts.aBeeZee(
//                         fontSize: 16,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 10),
//                     ListTile(
//                       title: const Text('Heavy Meat Eater'),
//                       leading: Radio(
//                           value: Dietary.Heavy_Meat,
//                           groupValue: _enteredDietary,
//                           onChanged: (inputvalue) {
//                             setState(() {
//                               _enteredDietary = inputvalue!;
//                             });
//                           }),
//                     ),
//                     ListTile(
//                       title: const Text('Low Meat Eater'),
//                       leading: Radio(
//                           value: Dietary.Low_Meat,
//                           groupValue: _enteredDietary,
//                           onChanged: (inputvalue) {
//                             setState(() {
//                               _enteredDietary = inputvalue!;
//                             });
//                           }),
//                     ),
//                     ListTile(
//                       title: const Text('Vegetarian'),
//                       leading: Radio(
//                           value: Dietary.Vegetarian,
//                           groupValue: _enteredDietary,
//                           onChanged: (inputvalue) {
//                             setState(() {
//                               _enteredDietary = inputvalue!;
//                             });
//                           }),
//                     ),
//                     ListTile(
//                       title: const Text('Vegan'),
//                       leading: Radio(
//                           value: Dietary.Vegan,
//                           groupValue: _enteredDietary,
//                           onChanged: (inputvalue) {
//                             setState(() {
//                               _enteredDietary = inputvalue!;
//                             });
//                           }),
//                     ),
//                     const SizedBox(height: 20),
//                     TextFormField(
//                       keyboardType: TextInputType.number,
//                       decoration: const InputDecoration(
//                         label: Text('Enter amount of calories'),
//                         suffixText: 'calories',
//                       ),
//                       validator: (value) {
//                         if (value == null ||
//                             value.isEmpty ||
//                             double.tryParse(value) == null ||
//                             double.tryParse(value)! <= 0) {
//                           return 'Must be a valid, positive number';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         setState(() {
//                           _enteredCalories = value!;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//   }
// }
