// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'model/each_item.dart';

// class FoodWidget extends StatefulWidget {
//   const FoodWidget({super.key});

//   @override
//   State<StatefulWidget> createState() {
//     return _FoodWidgetState();
//   }
// }

// class _FoodWidgetState extends State<FoodWidget> {
//   var totalFoodCarbon;
//   bool _inputValue1 = true;
//   bool _inputValue2 = false;
//   bool _inputValue3 = false;
//   bool _inputValue4 = false;

//   var _beefController = TextEditingController();
//   var _porkController = TextEditingController();
//   var _poultryController = TextEditingController();
//   var _vegetableController = TextEditingController();

//   @override
//   void dispose() {
//     _beefController.dispose();
//     _porkController.dispose();
//     _poultryController.dispose();
//     _vegetableController.dispose();

//     super.dispose();
//   }

//   void _showDialog() {
//     if (Platform.isIOS) {
//       showCupertinoDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//           title: const Text('Invalid Input'),
//           content: const Text('Please make sure valid value was entered'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(ctx),
//               child: const Text('Ok'),
//             ),
//           ],
//         ),
//       );
//     } else {
//       showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//           title: const Text('Invalid Input'),
//           content: const Text('Please make sure valid value was entered'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(ctx),
//               child: const Text('Ok'),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   void _calculateFoodValue() {
//     double beefCarbon = 0;
//     double porkCarbon = 0;
//     double poultryCarbon = 0;
//     double vegetableCarbon = 0;

//     // if (enteredValue1 == 0 &&
//     //     enteredValue2 == 0 &&
//     //     enteredValue3 == 0 &&
//     //     enteredValue4 == 0) {
//     //   _showDialog();
//     //   return;
//     // }
//     if (_inputValue1) {
//       double? enteredValue1 = double.tryParse(_beefController.text);
//       final IsInvalid = enteredValue1 == null || enteredValue1 <= 0;
//       if (IsInvalid) {
//         _showDialog();
//         return;
//       }
//       beefCarbon = (FoodValue[Food.Beef]! * enteredValue1);
//     }
//     if (_inputValue2) {
//       double? enteredValue2 = double.tryParse(_porkController.text);
//       final IsInvalid = enteredValue2 == null || enteredValue2 <= 0;
//       if (IsInvalid) {
//         _showDialog();
//         return;
//       }
//       porkCarbon = (FoodValue[Food.Pork]! * enteredValue2);
//     }
//     if (_inputValue3) {
//       double? enteredValue3 = double.tryParse(_poultryController.text);
//       final IsInvalid = enteredValue3 == null || enteredValue3 <= 0;
//       if (IsInvalid) {
//         _showDialog();
//         return;
//       }
//       poultryCarbon = (FoodValue[Food.Poultry]! * enteredValue3);
//     }
//     if (_inputValue4) {
//       double? enteredValue4 = double.tryParse(_vegetableController.text);
//       final IsInvalid = enteredValue4 == null || enteredValue4 <= 0;
//       if (IsInvalid) {
//         _showDialog();
//         return;
//       }
//       vegetableCarbon = (FoodValue[Food.Vegetable]! * enteredValue4);
//     }
//     setState(() {
//       totalFoodCarbon =
//           beefCarbon + porkCarbon + poultryCarbon + vegetableCarbon;
//     });
//     FocusManager.instance.primaryFocus?.unfocus();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
        
//         const SizedBox(height: 25),
//         ElevatedButton(
//           onPressed: _calculateFoodValue,
//           child: const Text('Calculate'),
//         ),
//         if (totalFoodCarbon != null && totalFoodCarbon != 0)
//           Center(
//             child: Container(
//               margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//               padding: EdgeInsets.all(18),
//               decoration: BoxDecoration(
//                 color: (totalFoodCarbon < 100)
//                     ? Color.fromARGB(255, 76, 168, 160)
//                     : Color.fromARGB(255, 228, 82, 45),
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               child: Text(
//                 'Total carbon emitted by Food is $totalFoodCarbon kg of Carbon',
//                 style: const TextStyle(
//                   color: Color.fromARGB(255, 224, 240, 247),
//                   fontSize: 23,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
    
//   }
// }






//  Container(
//             margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
//             child: TextField(
//               controller: _porkController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 hintText: 'Enter Food Weight',
//                 suffix: Text('kg'),
//                 border: UnderlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 filled: true,
//                 fillColor: Color.fromARGB(255, 221, 221, 221),
//                 focusColor: Theme.of(context).colorScheme.onSecondaryContainer,
//               ),
//             ),
//           ),