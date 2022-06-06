import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorAssignment());
}

class CalculatorAssignment extends StatelessWidget {
  const CalculatorAssignment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 198, 172, 143),
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 127, 50, 70),
            title: const Center(
              child: Text('Calculator'),
            )),
        body: const Center(
          child: Calculator(),
        ),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String value1 = '';
  String value2 = '';
  String operandType = '';
  String result = '';
  dynamic style;
  bool isButtonActive = true;
  bool isOperand = false;

  // array of the buttons, an empty String for areas in the grid where no button is needed
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

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Container(
          constraints: const BoxConstraints(minWidth: 400, maxWidth: 500),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          color: const Color.fromARGB(255, 10, 9, 8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(value1,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 234, 224, 213),
                        )),
                    const SizedBox(width: 20),
                    Text(operandType,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 234, 224, 213),
                        )),
                    const SizedBox(width: 20),
                    Text(value2,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 234, 224, 213),
                        ))
                  ],
                )),
                Container(
                  padding: const EdgeInsets.all(25),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: const TextStyle(
                        fontSize: 38,
                        color: Color.fromARGB(255, 234, 224, 213),
                        fontWeight: FontWeight.bold),
                  ),
                )
              ]),
        ),
      ),
      Expanded(
          flex: 3,
          child: Container(
              padding: const EdgeInsets.all(15),
              child: GridView.builder(
                  primary: false,
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    isOperand = (buttons[index] == '-' ||
                        buttons[index] == '+' ||
                        buttons[index] == '=');
                    isOperand == true
                        ? style = normalStyle
                        : style = circularStyle;
                    isButtonActive =

                        // active only when there's two values and plus or minus operand
                        (value1 == '' || value2 == '' || operandType == '') &&
                            buttons[index] == '=';

                    // return empty container for empty grid areas
                    if (buttons[index] == '') {
                      return Container();
                    }

                    // Center to stop the button from stretching to full grid height
                    return Center(
                        child: SizedBox(

                            // adjust width based on button type, so the add/sub/equals button look a bit better
                            width: isOperand ? 150.0 : 400.0,
                            child: ElevatedButton(
                              style: style,
                              onPressed: isButtonActive

                                  // set calc button to inactive unless both values are set and adding or substracting is chosen
                                  ? null
                                  : () {
                                      setState(() {
                                        if (buttons[index] == '+' ||
                                            buttons[index] == '-') {
                                          if (value1 != '') {
                                            operandType = buttons[index];
                                          }
                                        } else if (buttons[index] != '=' &&
                                            operandType == '') {
                                          result = "";

                                          // appending values to allow numbers larger than 1 digit
                                          value1 += buttons[index];
                                        } else if (buttons[index] != '=') {
                                          value2 += buttons[index];
                                        }

                                        if (buttons[index] == '=' &&
                                            value1 != '' &&
                                            value2 != '') {
                                          if (operandType == '+') {
                                            // parse the values to int then add or substract them and convert them back to String
                                            result = (int.parse(value1) +
                                                    int.parse(value2))
                                                .toString();
                                          } else {
                                            result = (int.parse(value1) -
                                                    int.parse(value2))
                                                .toString();
                                          }

                                          // resetting values
                                          value1 = value2 = operandType = '';
                                        }
                                      });
                                    },
                              child: Text(
                                buttons[index],
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 234, 224, 213),
                                ),
                              ),
                            )));
                  }))),
    ]);
  }

  final ButtonStyle circularStyle = ElevatedButton.styleFrom(
    primary: const Color.fromARGB(255, 94, 80, 63),
    shape: const CircleBorder(),
    minimumSize: const Size(200, 200),
    elevation: 8,
  );

  final ButtonStyle normalStyle = ElevatedButton.styleFrom(
    primary: const Color.fromARGB(255, 34, 51, 59),
    elevation: 4,
    minimumSize: const Size(100, 30),
  );
}
