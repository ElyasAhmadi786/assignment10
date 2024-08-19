import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stylish Calculator',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _output = "0";
  String _input = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operator = "";

  void _buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      _input = "";
      _num1 = 0;
      _num2 = 0;
      _operator = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "*" ||
        buttonText == "/") {
      _num1 = double.parse(_input);
      _operator = buttonText;
      _input = "";
    } else if (buttonText == "=") {
      _num2 = double.parse(_input);

      if (_operator == "+") {
        _output = (_num1 + _num2).toString();
      } else if (_operator == "-") {
        _output = (_num1 - _num2).toString();
      } else if (_operator == "*") {
        _output = (_num1 * _num2).toString();
      } else if (_operator == "/") {
        _output = (_num1 / _num2).toString();
      }

      _input = _output;
      _operator = "";
    } else {
      _input += buttonText;
      _output = _input;
    }

    setState(() {
      _output = double.parse(_output)
          .toStringAsFixed(2)
          .replaceFirst(RegExp(r'\.00$'), '');
    });
  }

  Widget _buildButton(String buttonText, Color buttonColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            padding: EdgeInsets.all(20),
            backgroundColor: buttonColor,
          ),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Text(
              _output,
              style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Expanded(child: Divider()),
          Column(
            children: [
              Row(
                children: [
                  _buildButton("7", Colors.blueGrey),
                  _buildButton("8", Colors.blueGrey),
                  _buildButton("9", Colors.blueGrey),
                  _buildButton("/", Colors.deepPurple),
                ],
              ),
              Row(
                children: [
                  _buildButton("4", Colors.blueGrey),
                  _buildButton("5", Colors.blueGrey),
                  _buildButton("6", Colors.blueGrey),
                  _buildButton("*", Colors.deepPurple),
                ],
              ),
              Row(
                children: [
                  _buildButton("1", Colors.blueGrey),
                  _buildButton("2", Colors.blueGrey),
                  _buildButton("3", Colors.blueGrey),
                  _buildButton("-", Colors.deepPurple),
                ],
              ),
              Row(
                children: [
                  _buildButton("0", Colors.blueGrey),
                  _buildButton(".", Colors.blueGrey),
                  _buildButton("C", Colors.redAccent),
                  _buildButton("+", Colors.deepPurple),
                ],
              ),
              Row(
                children: [
                  _buildButton("=", Colors.greenAccent),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
