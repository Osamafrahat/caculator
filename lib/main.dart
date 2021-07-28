import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
void main() {
  runApp(MyCalculator());
}

class MyCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Calculator();
  }
}

class _Calculator extends State<Calculator> {
  String text = "0";
  String text2 = "";
  double numOne = 0;
  double numTwo = 0;
  String result = "0";
  String finalResult = "0";
  String opr = "";
  String preOpr = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                      text2,
                      style: TextStyle(color: Colors.white, fontSize: 40),
                      maxLines: 1,
                      textAlign: TextAlign.right,
                    ))
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                      text,
                      style: TextStyle(color: Colors.white, fontSize: 60),
                      maxLines: 1,
                      textAlign: TextAlign.right,
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("C", Color(0xffa5a5a5), 0),
                button("+/-", Color(0xffa5a5a5), 0),
                button("%", Color(0xffa5a5a5), 0),
                button("/", Color(0xffff9000), 0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("7", Color(0xff4e4d4d), 0),
                button("8", Color(0xff4e4d4d), 0),
                button("9", Color(0xff4e4d4d), 0),
                button("x", Color(0xffff9000), 0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("4", Color(0xff4e4d4d), 0),
                button("5", Color(0xff4e4d4d), 0),
                button("6", Color(0xff4e4d4d), 0),
                button("-", Color(0xffff9000), 0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("1", Color(0xff4e4d4d), 0),
                button("2", Color(0xff4e4d4d), 0),
                button("3", Color(0xff4e4d4d), 0),
                button("+", Color(0xffff9000), 0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("0", Color(0xff4e4d4d), 1),
                button(".", Color(0xff4e4d4d), 0),
                button("=", Color(0xffff0000), 0),
              ],
            )
          ],
        ),
      ),
    );
  }
// ----------------- build buttons ------------
  Widget button(String btnTxt, Color color, int num) {
    Container container;
    if (num == 0) {
      container = Container(
        padding: EdgeInsets.only(bottom: 10),
        child: RaisedButton(
          onPressed: () {
            calculate(btnTxt);
          },
          child: Text(
            btnTxt,
            style: TextStyle(fontSize: 30),
          ),
          color: color,
          padding: EdgeInsets.all(20),
          shape: CircleBorder(),
        ),
      );
    } else {
      container = Container(
        padding: EdgeInsets.only(bottom: 10),
        child: RaisedButton(
          onPressed: () {
            calculate(btnTxt);
          },
          child: Text(
            btnTxt,
            style: TextStyle(fontSize: 30),
          ),
          color: color,
          padding: EdgeInsets.only(left: 80, top: 20, right: 80, bottom: 20),
          shape: StadiumBorder(),
        ),
      );
    }
    return container;
  }
// --------------- action method --------------
  void calculate(txtBtn) {
    if (txtBtn == 'C') {
      text = "0";
      numOne = 0;
      numTwo = 0;
      opr = "";
      result = "";
      finalResult = "0";
      preOpr = "";
    } else if (opr == '=' && txtBtn == '=') {
      switch (preOpr) {
        case '+':
          finalResult = add();
          break;
        case '-':
          finalResult = sub();
          break;
        case 'x':
          finalResult = mul();
          break;
        case '/':
          finalResult = div();
          break;
      }
      rmDec(finalResult);
    } //  ----------- operations buttons ------------
    else if (txtBtn == '+' ||
        txtBtn == '-' ||
        txtBtn == 'x' ||
        txtBtn == '/' ||
        txtBtn == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(finalResult);
      }
      switch (opr) {
        case '+':
          finalResult = add();
          break;
        case '-':
          finalResult = sub();
          break;
        case 'x':
          finalResult = mul();
          break;
        case '/':
          finalResult = div();
          break;
      }
      preOpr = opr;
      opr = txtBtn;
      result = '';

    } //  -------- % button ----------
    else if (txtBtn == '%') {
      if (result == '') {
        result = '0';
      } else {
        result = (double.parse(result) / 100).toString();
      }
      finalResult = result;
    }   // ------- . button --------------
    else if (txtBtn == '.') {
      if (!result.contains('.')) {
        if (result == '') {
          result = '0';
        }
        result += '.';
        finalResult = result;
      }
    }    // ------------ +/- button ---------
    else if (txtBtn == '+/-') {
      if (result.startsWith('-')) {
        result = result.substring(1);
      } else {
        if (double.parse(result) == 0) {
        } else {
          result = "-" + result;
        }
      }
      finalResult = result;
    }    //    -------- 0 button --------
    else {
      if (result == '0') {
        result = txtBtn;
      } else // ---------   numbers -------
        result = result + txtBtn;
      finalResult = result;
    }
    setState(() {
      text = finalResult;
      text2=opr;
    });
  }
//  -------------- adding method --------------
  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return rmDec(result);
  }
//     ----------- subversion method ------------
  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return rmDec(result);
  }
//     ---------- multiplication method -----------
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return rmDec(result);
  }
//       ----------- Division method --------
  String div() {
    if(numTwo==0){
      Fluttertoast.showToast(
          msg: "Can't Divide by Zero",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

      );
      result='0';
    }else {
      result = (numOne / numTwo).toString();
      numOne = double.parse(result);
    }
    return rmDec(result);
  }
//     --------- to remove dot ----------
  String rmDec(String _result) {
    if (_result.contains('.')) {
      List<String> split = _result.split('.');
      if (!(int.parse(split[1]) > 0)) {
        return split[0];
      }
    }
    return _result;
  }
}
