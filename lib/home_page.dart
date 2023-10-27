import 'package:calculator/config/app_color/app_color.dart';
import 'package:calculator/dart/my_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed(){
    String finalUserInput=userInput;
    finalUserInput=userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalUserInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();

  }


  var userInput='';
  var answer='';

  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
        backgroundColor: AppColor.mainAppColor,
      ),
      backgroundColor: AppColor.mainAppColor,
      body: Column(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 90),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15.0),
                  alignment: Alignment.centerRight,
                  child: Text(
                    answer,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,),
                  ),
                )
              ],),
          ),
          Expanded(
              child: Container(
                child: GridView.builder(
                  itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4
                    ),
                    itemBuilder: (BuildContext context,int index){
                    if (index==0){
                      return MyButton(
                        buttontapped: (){
                          setState(() {
                            userInput='';
                            answer='0';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.white,
                        textColor: AppColor.mainButtonColor,
                      );
                    }
                    else if(index==1){
                      return MyButton(
                      buttonText: buttons[index],
                      color: Colors.white,
                      textColor: AppColor.mainButtonColor,
                      );
                    }else if(index==2){
                      return MyButton(
                        buttontapped: (){
                          setState(() {
                            userInput+= buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.white,
                        textColor: AppColor.mainButtonColor,);
                    }
                    else if(index==3){
                      return MyButton(
                          buttontapped: (){
                            setState(() {
                              userInput =
                                  userInput.substring(0,userInput.length-1);
                            });
                          },
                        buttonText: buttons[index],
                        color: Colors.white,
                        textColor: AppColor.mainButtonColor,);
                    }
                    else if(index==18){
                      return MyButton(
                        buttontapped: (){
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: AppColor.mainButtonColor,
                        textColor: Colors.black,);
                    }
                    else{
                      return MyButton(
                          buttontapped: (){
                            setState(() {
                              userInput+=buttons[index];
                            });
                          },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.white,
                        textColor: isOperator(buttons[index])
                            ? AppColor.mainButtonColor
                            : Colors.black,);
                    }
                    }),
              ))
        ],
      ),
    );
  }
}
