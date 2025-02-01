import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0"; // Displayed output
  String _currentInput = ""; // Current calculation string
  double _result = 0; // Result of the calculation

  // Handle button presses
  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        // Clear all inputs
        _output = "0";
        _currentInput = "";
        _result = 0;
      } else if (value == "=") {
        // Calculate the result
        _result = _calculateResult(_currentInput);
        _output = _result.toString();
        _currentInput = _output;
      } else {
        // Append the button value to the current input
        _currentInput += value;
        _output = _currentInput;
      }
    });
  }

  // Perform arithmetic calculations
  double _calculateResult(String expression) {
    try {
      // Replace 'x' with '*' for multiplication
      return double.parse(expression.replaceAll('x', '*'));
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator")),
      body: Column(
        children: [
          // Display Area
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Text(
                _output,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Divider(height: 1),

          // Button Grid
          _buildButtonGrid(),
        ],
      ),
    );
  }

  // Build the grid of buttons
  Widget _buildButtonGrid() {
    final List<String> buttons = [
      "7", "8", "9", "/",
      "4", "5", "6", "x",
      "1", "2", "3", "-",
      "C", "0", "=", "+"
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // Disable scrolling
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.5,
      ),
      itemCount: buttons.length,
      itemBuilder: (context, index) {
        return ElevatedButton(
          onPressed: () => _onButtonPressed(buttons[index]),
          child: Text(
            buttons[index],
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            primary: _getButtonColor(buttons[index]), // Customize button colors
          ),
        );
      },
    );
  }

  // Get button color based on its value
  Color _getButtonColor(String value) {
    if (value == "C") {
      return Colors.red; // Red for clear button
    } else if ("+-x/=".contains(value)) {
      return Colors.orange; // Orange for operators
    } else {
      return Colors.grey; // Grey for numbers
    }
  }
}