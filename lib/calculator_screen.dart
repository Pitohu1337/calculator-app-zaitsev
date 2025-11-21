import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _expression = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operation = "";
  bool _shouldResetOutput = false;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _expression = "";
        _num1 = 0;
        _num2 = 0;
        _operation = "";
        _shouldResetOutput = false;
      } else if (buttonText == "⌫") {
        if (_output.length > 1) {
          _output = _output.substring(0, _output.length - 1);
        } else {
          _output = "0";
        }
      } else if (buttonText == "=") {
        _num2 = double.parse(_output);
        _expression = "$_num1 $_operation $_num2 = ";
        
        switch (_operation) {
          case "+":
            _output = (_num1 + _num2).toString();
            break;
          case "-":
            _output = (_num1 - _num2).toString();
            break;
          case "×":
            _output = (_num1 * _num2).toString();
            break;
          case "÷":
            _output = _num2 != 0 ? (_num1 / _num2).toString() : "Ошибка";
            break;
        }
        
        _num1 = 0;
        _num2 = 0;
        _operation = "";
        _shouldResetOutput = true;
      } else if (["+", "-", "×", "÷"].contains(buttonText)) {
        _num1 = double.parse(_output);
        _operation = buttonText;
        _expression = "$_num1 $buttonText ";
        _shouldResetOutput = true;
      } else if (buttonText == "%") {
        _output = (double.parse(_output) / 100).toString();
      } else if (buttonText == "±") {
        _output = (double.parse(_output) * -1).toString();
      } else {
        if (_output == "0" || _shouldResetOutput) {
          _output = buttonText;
          _shouldResetOutput = false;
        } else {
          _output += buttonText;
        }
      }
      
      // Убираем лишние нули после запятой
      if (_output.contains(".")) {
        _output = _output.replaceAll(RegExp(r"0*$"), "").replaceAll(RegExp(r"\.$"), "");
      }
    });
  }

  Widget _buildButton(String buttonText, {Color color = Colors.white, Color textColor = Colors.black}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(20),
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Калькулятор"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              // Переключение темы будет добавлено позже
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          // Область выражения
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              _expression,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          
          // Область вывода результата
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              _output,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          
          Expanded(child: Divider()),
          
          // Клавиатура калькулятора
          Column(
            children: [
              // Первый ряд
              Row(children: [
                _buildButton("C", color: Colors.grey),
                _buildButton("±", color: Colors.grey),
                _buildButton("%", color: Colors.grey),
                _buildButton("÷", color: Colors.orange),
              ]),
              
              // Второй ряд
              Row(children: [
                _buildButton("7"),
                _buildButton("8"),
                _buildButton("9"),
                _buildButton("×", color: Colors.orange),
              ]),
              
              // Третий ряд
              Row(children: [
                _buildButton("4"),
                _buildButton("5"),
                _buildButton("6"),
                _buildButton("-", color: Colors.orange),
              ]),
              
              // Четвертый ряд
              Row(children: [
                _buildButton("1"),
                _buildButton("2"),
                _buildButton("3"),
                _buildButton("+", color: Colors.orange),
              ]),
              
              // Пятый ряд
              Row(children: [
                _buildButton("0"),
                _buildButton("."),
                _buildButton("⌫", color: Colors.grey),
                _buildButton("=", color: Colors.orange),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
