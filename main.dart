import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 37, 22, 25),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 127, 50, 70),
          title: const Center(
            child:
              Text('Calculator'),
          )
        ),
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
  String operator = '';
  String result = '';
  // array of the buttons, an empty String for areas in the grid where no button is needed
  List<String> buttons = ['1', '2', '3', '+', '4', '5', '6', '-', '7', '8', '9', '', '', '', '', '='];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                     Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                            Text(
                              value1,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              )
                            ),
                            const SizedBox(width: 20),
                            Text(
                              operator,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              )
                            ),
                            const SizedBox(width: 20),
                            Text(
                              value2,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              )
                            )
                        ],
                      ),
                  Container(
                    color: Colors.black12, 
                    padding: const EdgeInsets.all(25),
                    alignment: Alignment.centerRight,
                    child: Text(
                      result,
                      style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
          ),
        ),
        Expanded(
          flex: 3,
          child:
            Container(
              padding: const EdgeInsets.all(15),
              child:
                GridView.builder(
                  primary: false,
                  itemCount: buttons.length,
                  gridDelegate: 
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                  itemBuilder: (BuildContext context, int index) {
                    var style = circularStyle;
                    EdgeInsets extraPadding = const EdgeInsets.only(top: 0.0, bottom: 0.0);
                    if (buttons[index] == '') {
                      return Container();
                    }
                    if (buttons[index] == '-' || buttons[index] == '+' || buttons[index] == '=') {
                      style = normalStyle;
                      extraPadding = const EdgeInsets.only(top: 30.0, bottom: 30.0);
                    }
                    return Container(
                      padding: extraPadding,
                      child:
                        ElevatedButton( 
                          style: style,
                          onPressed: () {
                            setState(() {
                              if (buttons[index] == '+' || buttons[index] == '-') {
                                if (value1 != '') {
                                  operator = buttons[index];
                                }
                              } else if (buttons[index] != '=' && operator == '') {
                                result = "";
                                // appending values to allow numbers larger than 1 digit
                                value1 += buttons[index];
                              } else if (buttons[index] != '=') {
                                value2 += buttons[index];
                              }

                              if (buttons[index] == '=' && value1 != '' && value2 != '') {
                                if (operator == '+') {
                                  // parse the values to int then add or substract them and convert them back to String
                                  result = (int.parse(value1) + int.parse(value2)).toString();
                                }
                                else { 
                                  result = (int.parse(value1) - int.parse(value2)).toString();
                                }
                                // resetting values
                                value1 = value2 = '';
                                operator = '';
                              }                   
                            });
                          },
                          child: Text(
                                  buttons[index],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                        )
                      );
                    }
                )
              )
            ),
      ]
    );
  }

   final ButtonStyle circularStyle =
          ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 127, 50, 70),
            fixedSize: const Size(200, 200),
            shape: const CircleBorder(), 
          );
  
  final ButtonStyle normalStyle =
          ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 127, 50, 70),
          );
}



