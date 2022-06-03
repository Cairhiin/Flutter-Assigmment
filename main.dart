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
  var value1 = '';
  var value2 = '';
  var operator = '';
  List<String> buttons = ['1', '2', '3', '+', '4', '5', '6', '-', '7', '8', '9'];
  int? displayValue;

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
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              )
                            ),
                            SizedBox(width: 20),
                            Text(
                              value2,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              )
                            ),
                            SizedBox(width: 20),
                            Text(
                              operator,
                              style: TextStyle(
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
                    child: const Text(
                      "answer",
                      style: TextStyle(
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
                return ElevatedButton(
                  style: style,
                  onPressed: () {
                    setState(() {
                      if (buttons[index] == '+' || buttons[index] == '-') {
                        operator = buttons[index];
                      } else if (value1 == '') {
                        value1 = buttons[index];
                      } else if (value2 == '') {
                        value2 = buttons[index];
                      }
                      else {
                        value1 = buttons[index];
                        value2 = '';
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
                    );
              }
            ),
          )
      ]
    );
  }

   final ButtonStyle style =
          ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 127, 50, 70),
            fixedSize: const Size(200, 200),
            shape: const CircleBorder(), 
          );

}



