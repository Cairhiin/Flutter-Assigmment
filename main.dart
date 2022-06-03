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
  String operatorType = '';
  String result = '';
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
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(15),
          color: const Color.fromARGB(255, 10, 9, 8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(value1,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 234, 224, 213),
                        )),
                    const SizedBox(width: 20),
                    Text(operatorType,
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
                ),
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
                    var style = circularStyle;
                    EdgeInsets extraPadding =
                        const EdgeInsets.only(top: 0.0, bottom: 0.0);
                    if (buttons[index] == '') {
                      return Container();
                    }
                    if (buttons[index] == '-' ||
                        buttons[index] == '+' ||
                        buttons[index] == '=') {
                      style = normalStyle;
                      extraPadding =
                          const EdgeInsets.only(top: 25.0, bottom: 25.0);
                    }
                    return Container(
                        padding: extraPadding,
                        child: ElevatedButton(
                          style: style,
                          onPressed: () {
                            setState(() {
                              if (buttons[index] == '+' ||
                                  buttons[index] == '-') {
                                if (value1 != '') {
                                  operatorType = buttons[index];
                                }
                              } else if (buttons[index] != '=' &&
                                  operatorType == '') {
                                result = "";
                                // appending values to allow numbers larger than 1 digit
                                value1 += buttons[index];
                              } else if (buttons[index] != '=') {
                                value2 += buttons[index];
                              }

                              if (buttons[index] == '=' &&
                                  value1 != '' &&
                                  value2 != '') {
                                if (operatorType == '+') {
                                  // parse the values to int then add or substract them and convert them back to String
                                  result =
                                      (int.parse(value1) + int.parse(value2))
                                          .toString();
                                } else {
                                  result =
                                      (int.parse(value1) - int.parse(value2))
                                          .toString();
                                }
                                // resetting values
                                value1 = value2 = operatorType = '';
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
                        ));
                  }))),
    ]);
  }

  final ButtonStyle circularStyle = ElevatedButton.styleFrom(
    primary: const Color.fromARGB(255, 94, 80, 63),
    fixedSize: const Size(200, 200),
    shape: const CircleBorder(),
    elevation: 8,
  );

  final ButtonStyle normalStyle = ElevatedButton.styleFrom(
    primary: const Color.fromARGB(255, 34, 51, 59),
    elevation: 4,
  );
}
