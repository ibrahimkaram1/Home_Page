import 'package:flutter/material.dart';

class PredictResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prediction Result"),
        backgroundColor: Colors.green,
        leading: BackButton(color: Colors.white),
      ),
      body: Center(
        child: Text("No prediction available.", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
