import 'package:flutter/material.dart';

void  main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("SI Calculator"),),
        body: _UI(),
      ),
    )
  );
}

class _UI extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }

}