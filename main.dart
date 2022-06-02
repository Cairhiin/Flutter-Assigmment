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
          child: Container(
            child: _buildButtonGrid
          ),
        )
        ],
    );
  }
}

GridView _buildButtonGrid = GridView.count(
      primary: false,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      crossAxisCount: 4,
      children: <Widget>[
        _buildButtonContainer(Colors.white, "1"),
        _buildButtonContainer(Colors.white, "2"),
        _buildButtonContainer(Colors.white, "3"),
        _buildButtonContainer(Colors.white, "Add the two previous numbers", Icons.add),
        _buildButtonContainer(Colors.white, "4"),
        _buildButtonContainer(Colors.white, "5"),
        _buildButtonContainer(Colors.white, "6"),
        _buildButtonContainer(Colors.white, "Substract the two previous numbers", Icons.remove),
        _buildButtonContainer(Colors.white, "7"),
        _buildButtonContainer(Colors.white, "8"),
        _buildButtonContainer(Colors.white, "9"),
        Container(
          padding: const EdgeInsets.all(12),
        ),
      ]
    );

Container _buildButtonContainer(Color? textColor, String label, [IconData? icon]) { 
  final ButtonStyle style =
        ElevatedButton.styleFrom(
          primary: const Color.fromARGB(255, 127, 50, 70),
          fixedSize: const Size(200, 200),
          shape: const CircleBorder(), 
        );
  
  ElevatedButton calculatorButton;   
  if (icon != null) {
    calculatorButton = ElevatedButton(
          style: style,
          onPressed: () {},
          child: Icon(icon,
            size: 18,
            color: textColor,
            semanticLabel: label,
          ),
      );   
  } else {
    calculatorButton = ElevatedButton(
          style: style,
          onPressed: () {},
          child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
      );   
  }

  return Container(
          padding: const EdgeInsets.all(6),
          child:
            calculatorButton,
  );
}