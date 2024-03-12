
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar( title: Text('Flutter Calculator' )),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              //color:  Color.fromARGB(255, 66, 121, 152),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Color.fromARGB(255, 26, 25, 25)),
            ),
            child: CalculatorUI(),
          ),
        ),
      ),
    );
  }
}

class CalculatorUI extends StatefulWidget {
  @override
  _CalculatorUIState createState() => _CalculatorUIState();
}

class _CalculatorUIState extends State<CalculatorUI> {
  String input = '';
  bool isResult = false;

  Color _backgroundColor = Colors.white; // Default background color
  Color _buttonColor = Colors.grey[300]!; // Default button color


  void _handleButtonPress(String buttonText) {
    setState(() {
      
      if (isResult && buttonText != 'AC') {
        input = '';
        isResult = false;
      }

      if (buttonText == '=') {
        try {
          input = _evaluateExpression(input);
          isResult = true;
        } catch (e) {
          input = 'Error';
          isResult = true;
        }
      } else if (buttonText == 'AC') {
        input = '';
        isResult = false;
      } else if (buttonText == 'Clear') {
        if (input.isNotEmpty) {
          buttonText = 'CE';
          // Clear the last entry
          input = input.substring(0, input.length - 1);
        }

     } else  {
        if (buttonText == '√') {
          // Replace √ with sqrt
          buttonText = 'sqrt';
        } else if (buttonText == 'x') {
          // Replace x with *
          buttonText = '*';
        } else if (buttonText == '÷') {
          // Replace ÷ with /
          buttonText = '/';
        }
        input += buttonText;
      }
    });
  }

  String _evaluateExpression(String expression) {
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    double result = exp.evaluate(EvaluationType.REAL, cm);
    return result.toString();
  }

void _showColorPicker() async {
  Color? selectedColor = await showDialog<Color>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select Color'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: _backgroundColor,
            onColorChanged: (color) {
              setState(() {
                _backgroundColor = color;
                _buttonColor = _getButtonColorForBackground(color);
              });
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(_backgroundColor);
            },
            child: Text('Done'),
          ),
        ],
      );
    },
  );

  if (selectedColor != null) {
    setState(() {
      _backgroundColor = selectedColor;
      _buttonColor = _getButtonColorForBackground(selectedColor);
    });
  } else {
    // If the user cancels, set the background color back to white
    setState(() {
      _backgroundColor = Colors.white;
      _buttonColor = _getButtonColorForBackground(Colors.white);
    });
  }
}

Color _getButtonColorForBackground(Color backgroundColor) {
  return backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            color: _backgroundColor,
            child: Text(
              input,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: _backgroundColor,
            child: GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.8,
              children: [
                _buildButton('AC'),
                _buildButton('Clear'),
                _buildButton('%'),
                _buildButton('÷'),
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildButton('x'),
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildButton('-'),
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildButton('+'),
                _buildButton('√'),
                _buildButton('0'),
                _buildButton('.'),
                _buildButton('='),
               //_buildButton('Clear'), // Clear Entry button
              ],
            ),
          ),
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: _showColorPicker,
                child: Icon(Icons.color_lens),
              ),
            ),
          ],
        ), 
      ],
    );
  }

  Widget _buildButton(String text) {
    return ElevatedButton(
      onPressed: () => _handleButtonPress(text),
      child: Text(
        text,
        style: TextStyle(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 231, 231, 234),
        padding: EdgeInsets.all(12.0),
        minimumSize: Size(50, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }
}
