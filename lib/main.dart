import 'package:calculator/constant.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Application());
}

class Application extends StatefulWidget {
  Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  var inputUser = '';
  var result = '';

  void buttonPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  Widget getRow(
      String Number1, String Number2, String Number3, String Number4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: getBackgroundColor(Number1),
          child: TextButton(
            onPressed: () {
              if (Number1 == 'ac') {
                setState(() {
                  inputUser = '';
                  result = '';
                });
              } else {
                buttonPressed(Number1);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                '$Number1',
                style: TextStyle(
                  fontSize: 50,
                  color: getTextColor(Number1),
                ),
              ),
            ),
          ),
        ),
        CircleAvatar(
          radius: 45,
          backgroundColor: getBackgroundColor(Number2),
          child: TextButton(
            onPressed: () {
              if (Number2 == 'ce') {
                if (inputUser.isNotEmpty)
                  setState(() {
                    //input user - 1
                    inputUser = inputUser.substring(0, inputUser.length - 1);
                  });
              } else {
                buttonPressed(Number2);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                '$Number2',
                style: TextStyle(
                    fontSize: 50,
                    color: getTextColor(
                      Number2,
                    )),
              ),
            ),
          ),
        ),
        CircleAvatar(
          radius: 45,
          backgroundColor: getBackgroundColor(Number3),
          child: TextButton(
            onPressed: () {
              buttonPressed(Number3);
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                '$Number3',
                style: TextStyle(
                  fontSize: 50,
                  color: getTextColor(Number3),
                ),
              ),
            ),
          ),
        ),
        CircleAvatar(
          radius: 45,
          backgroundColor: getBackgroundColor(Number4),
          child: TextButton(
            onPressed: () {
              if (Number4 == '=') {
                Parser parser = Parser();
                Expression expression = parser.parse(inputUser);
                ContextModel contextModel = ContextModel();
                double eval =
                    expression.evaluate(EvaluationType.REAL, contextModel);
                setState(() {
                  result = eval.toString();
                });
              } else {
                buttonPressed(Number4);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                Number4,
                style: TextStyle(
                  fontSize: 50,
                  color: getTextColor(Number4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'manrope'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    color: backgroundGrey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            inputUser,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Wrap(
                            children: [
                              Text(
                                result,
                                style: TextStyle(
                                  color: textGrey,
                                  fontSize: 95,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  flex: 3,
                ),
                Expanded(
                  child: Container(
                    color: backgroundDark,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        getRow(
                          'ac',
                          'ce',
                          '%',
                          '/',
                        ),
                        getRow(
                          '7',
                          '8',
                          '9',
                          '*',
                        ),
                        getRow(
                          '4',
                          '5',
                          '6',
                          '-',
                        ),
                        getRow(
                          '1',
                          '2',
                          '3',
                          '+',
                        ),
                        getRow(
                          '00',
                          '0',
                          '.',
                          '=',
                        ),
                      ],
                    ),
                  ),
                  flex: 7,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//if اینجام مهم نیست چی توی اپریتور میزاری ، فقط باید پاس بدی اخر به
  bool isOperator(String text) {
    var list = ['ac', 'ce', '%', '/', '*', '-', '+', '='];
    for (var item in list) {
      //
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  //این قسمت هرچی بزاری فرقی نداره
  Color getBackgroundColor(String Operator) {
    //شگزاشتی برگردونgetbackground color این قسمت باید هرچی توی
    if (isOperator(Operator)) {
      return bluebackground;
    } else {
      return backgroundGrey;
    }
  }

  Color getTextColor(String text) {
    if (isOperator(text)) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }
}
