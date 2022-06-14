import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Assignment',
      theme: ThemeData(
          primaryColor: const Color(0xffFF9800),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: const Color(0xffFFE0B2)),
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xffFF9800))),
      home: const MyHomePage(title: 'Calculator Assignment'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Calculator {
  const Calculator();

  int addValues(int value1, int value2) {
    return value1 + value2;
  }

  int subValues(int value1, int value2) {
    return value1 - value2;
  }
}

class Display extends StatelessWidget {
  const Display(
      {super.key,
      required this.operandType,
      required this.oldValue,
      required this.result,
      required this.value});
  final String operandType;
  final String oldValue;
  final String value;
  final int result;

  final TextStyle largeDisplayText = const TextStyle(
      fontSize: 38, color: Colors.white, fontWeight: FontWeight.bold);
  final TextStyle smallDisplayText = const TextStyle(
      fontSize: 16,
      color: Color.fromARGB(255, 235, 235, 235),
      fontWeight: FontWeight.w400);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 400.0, maxWidth: 500.0),
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.only(right: 10.0, top: 10.0),
      color: const Color.fromARGB(255, 10, 9, 8),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(operandType != '' ? oldValue : '', style: smallDisplayText),
            const SizedBox(width: 20),
            Text(operandType != '' ? operandType : '', style: smallDisplayText),
          ],
        )),
        Container(
          alignment: Alignment.bottomRight,
          child: result == 0
              ? Text(
                  value == '' ? '0' : value,
                  style: largeDisplayText,
                )
              : Text(
                  '$result',
                  style: largeDisplayText,
                ),
        ),
      ]),
    );
  }
}

class NumberButton extends StatelessWidget {
  const NumberButton(
      {super.key,
      required this.active,
      required this.label,
      required this.onPressed,
      required this.style});
  final String label;
  final Function onPressed;
  final bool active;
  final ButtonStyle style;

  void _handlePress() {
    onPressed(label);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: active == true ? _handlePress : null,
      style: style,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String _value = '';
  String _oldValue = '';
  String _operandType = '';
  int _result = 0;
  bool isOperand = false;
  bool isButtonActive = true;
  Calculator calc = const Calculator();
  List<String> buttons = [
    '1',
    '2',
    '3',
    '+',
    '4',
    '5',
    '6',
    '-',
    '7',
    '8',
    '9',
    '',
    '',
    '',
    '',
    '='
  ];

  void _handlePressed(String newValue) {
    setState(() {
      _result = 0;
      _value += newValue;
    });
  }

  void _handleOperandPressed(String operand) {
    setState(() {
      if (operand == '+' || operand == '-') {
        if (_value != '' || _oldValue != '') {
          if (_operandType == '') {
            _operandType = operand;
            _oldValue = _value;
            _value = '';
          } else {
            _operandType = operand;
          }
        }
      } else if (operand != '=' && _operandType == '') {
        _result = 0;
      }
      if (operand == '=' && _value != '') {
        _operandType == '+'
            ? _result = calc.addValues(int.parse(_oldValue), int.parse(_value))
            : _result = calc.subValues(int.parse(_oldValue), int.parse(_value));

        // resetting values
        _value = _operandType = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle normalStyle = ElevatedButton.styleFrom(
      primary: Theme.of(context).primaryColor,
      elevation: 4,
      minimumSize: const Size(100, 30),
    );

    final ButtonStyle circularStyle = ElevatedButton.styleFrom(
      primary: Theme.of(context).colorScheme.secondary,
      shape: const CircleBorder(),
      minimumSize: const Size(200, 200),
      elevation: 2,
    );

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  constraints:
                      const BoxConstraints(minWidth: 450.0, maxWidth: 450.0),
                  child: Display(
                      oldValue: _oldValue,
                      operandType: _operandType,
                      value: _value,
                      result: _result),
                ),
                Column(children: [
                  Container(
                    constraints:
                        const BoxConstraints(minWidth: 150.0, maxWidth: 150.0),
                  )
                ]),
              ]),
            ),
            Expanded(
              flex: 3,
              child: Container(
                constraints:
                    const BoxConstraints(minWidth: 600.0, maxWidth: 600.0),
                child: GridView.builder(
                    primary: false,
                    itemCount: buttons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      mainAxisExtent: 125,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      isButtonActive = true;
                      isOperand = (buttons[index] == '-' ||
                          buttons[index] == '+' ||
                          buttons[index] == '=');

                      // active only when there's two values and plus or minus operand
                      if (_value == '' || _operandType == '') {
                        if (buttons[index] == '=') isButtonActive = false;
                      }

                      // return empty container for empty grid areas
                      if (buttons[index] == '') {
                        return Container();
                      }

                      // Center to stop the button from stretching to full grid height
                      return SizedBox(

                          // adjust width based on button type, so the add/sub/equals button look a bit better
                          width: isOperand ? 150.0 : 400.0,
                          child: !isOperand
                              ? NumberButton(
                                  label: buttons[index],
                                  onPressed: _handlePressed,
                                  style: circularStyle,
                                  active: true)
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 40.0, horizontal: 10.0),
                                  child: NumberButton(
                                      active: isButtonActive,
                                      label: buttons[index],
                                      onPressed: _handleOperandPressed,
                                      style: normalStyle),
                                ));
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
