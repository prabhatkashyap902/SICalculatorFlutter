import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "SI Calculator",
    home: _SIForm(),
    theme: ThemeData(
      primaryColor: Colors.pink,
      accentColor: Colors.pink,
    ),
  ));
}

class _SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<_SIForm> {

  var _formkey=GlobalKey<FormState>();

  var _currencies = ["Rupees", "Pounds", "Dollars", "Others"];
  var _currentCurrencies = "Rupees";
  String total = "";

  TextEditingController principle = TextEditingController();
  TextEditingController roi = TextEditingController();
  TextEditingController term = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("SI Calculator"),
      ),
      body: Form(
        key: _formkey,
          child: Padding(
        padding: EdgeInsets.only(top: 20, left: 2, right: 2),
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: principle,
                validator: (String value){
                  if(value.isEmpty){
                    return "Please enter some number";
                  }
                },
                decoration: InputDecoration(
                  hintText: "write number eg. 12000",
                  labelText: "Principal",
                  labelStyle: textStyle,
                  errorStyle: TextStyle(color: Colors.amber),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                style: textStyle,
                controller: roi,
                keyboardType: TextInputType.number,
                validator: (String value){
                  if(value.isEmpty){
                    return "Please enter some number";
                  }
                },
                decoration: InputDecoration(
                    labelText: "Rate of Interest",
                    hintText: "Write any number eg. 12000",
                    labelStyle: textStyle,
                    errorStyle: TextStyle(color: Colors.amber),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: term,
                      style: textStyle,
                      validator: (String value){
                        if(value.){
                          return "Please enter some number";
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Term",
                        labelStyle: textStyle,
                        errorStyle: TextStyle(color: Colors.amber),
                        hintText: "Number of years",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Container(
                    width: 20,
                  ),
                  Expanded(
                    child: DropdownButton(
                        items: _currencies.map((String DropdownItems) {
                          return DropdownMenuItem<String>(
                            value: DropdownItems,
                            child: Text(DropdownItems),
                          );
                        }).toList(),
                        value: _currentCurrencies,
                        onChanged: (String values) {
                          _onDropItemSelected(values);
                        }),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 50),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      elevation: 10,
                      textColor: Colors.white,
                      color: Colors.pink,
                      child: Text(
                        "Calculate",
                        textScaleFactor: 1.2,
                      ),
                      onPressed: () {
                        setState(() {
                          if(_formkey.currentState.validate()){
                            total = _calculate();
                          }

                        });
                      },
                    ),
                  ),
                  Container(
                    width: 20,
                  ),
                  Expanded(
                    child: RaisedButton(
                      elevation: 10,
                      textColor: Colors.white,
                      color: Colors.amber,
                      child: Text(
                        "Reset",
                        textScaleFactor: 1.2,
                      ),
                      onPressed: () {
                        setState(() {
                          reset();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                total,
                style: textStyle,
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/bankimage.png');
    Image image = Image(
      image: assetImage,
      height: 250,
      width: 250,
    );
    return Container(
      child: image,
    );
  }

  void _onDropItemSelected(String values) {
    setState(() {
      this._currentCurrencies = values;
    });
  }

  String _calculate() {
    double principles = double.parse(principle.text);
    double rois = double.parse(roi.text);
    double terms = double.parse(term.text);
    double total = principles + (principles * rois * terms) / 100;
    principle.text = '';
    roi.text = '';
    term.text = '';
    return "The Amount will be $total $_currentCurrencies in $terms Years with the interest of $rois and principle is $principles!";
  }

  void reset() {
    principle.text = '';
    roi.text = '';
    term.text = '';
    total = '';
    _currentCurrencies = _currencies[0];
  }
}
