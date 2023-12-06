// import 'package:flutter/material.dart';

// class PollPage extends StatefulWidget {
//   const PollPage({Key? key}) : super(key: key);

//   @override
//   _PollPageState createState() => _PollPageState();
// }

// class _PollPageState extends State<PollPage> {
//   String selectedOption = '';
//   bool isCorrect = false;

//   void checkAnswer() {
//     // Replace this with your logic to check if the selected option is correct
//     // For this example, let's assume the correct option is 'Option B'
//     setState(() {
//       isCorrect = selectedOption == 'Option B';
//     });

//     // Update reward points if the answer is correct
//     if (isCorrect) {
//       updateRewardPoints();
//     }
//   }

//   void updateRewardPoints() {
//     // Replace this with your logic to update reward points
//     // For this example, let's print a message
//     print('Reward points updated!');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Poll Page'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text('Select the correct option:'),
//             SizedBox(height: 16.0),
//             RadioListTile<String>(
//               title: Text('Option A'),
//               value: 'Option A',
//               groupValue: selectedOption,
//               onChanged: (value) {
//                 setState(() {
//                   selectedOption = value!;
//                 });
//               },
//             ),
//             RadioListTile<String>(
//               title: Text('Option B'),
//               value: 'Option B',
//               groupValue: selectedOption,
//               onChanged: (value) {
//                 setState(() {
//                   selectedOption = value!;
//                 });
//               },
//             ),
//             RadioListTile<String>(
//               title: Text('Option C'),
//               value: 'Option C',
//               groupValue: selectedOption,
//               onChanged: (value) {
//                 setState(() {
//                   selectedOption = value!;
//                 });
//               },
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 checkAnswer();
//               },
//               child: Text('Submit'),
//             ),
//             SizedBox(height: 16.0),
//             if (isCorrect) Text('Congratulations! Your answer is correct.'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: PollPage(),
//   ));
// }

import 'package:flutter/material.dart';

class PollPage extends StatefulWidget {
  @override
  _PollPageState createState() => _PollPageState();
}

class _PollPageState extends State<PollPage> {
  String selectedOption =
      ''; // Holds the value associated with the chosen option

  void _handleOptionSelected(String optionValue) {
    setState(() {
      selectedOption = optionValue;
    });
    // You can add further logic here based on the selected option value
    print('Selected Option: $selectedOption');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Poll Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildOptionButton('Option A', 'ValueA'),
            _buildOptionButton('Option B', 'ValueB'),
            _buildOptionButton('Option C', 'ValueC'),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String optionText, String optionValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          _handleOptionSelected(optionValue);
        },
        child: Text(optionText),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: PollPage(),
    ),
  );
}



