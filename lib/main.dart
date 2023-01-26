import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  var hoursWorkedTextController = TextEditingController();
  var hourlyRateTextController = TextEditingController();

  double regularPay = 0;
  double overtimePay = 0;
  double totalPay = 0;
  double tax = 0;
  int hours = 0;
  double hourlyRate = 0;

  String? errorMessage;

  validate(){
    if(hoursWorkedTextController.text.trim().isEmpty){
      setState(() {
        errorMessage = 'Please enter your hours worked';
      });
      return false;
    }

    if(hoursWorkedTextController.text.trim().isEmpty){
      setState(() {
        errorMessage = 'Please enter your hourly rate';
      });
      return false;

    }
    setState(() {
      errorMessage = null;
    });
    return true;
  }

  void calculatePay(){

    int overtimeHours = 0;
    int regularHours = hours;

    if(hours > 40){
      overtimeHours = hours-40;
      overtimePay = overtimeHours * hourlyRate * 1.5;
      regularHours = 40;
    }

    regularPay = regularHours * hourlyRate;
    totalPay = regularPay + overtimePay;
    tax = totalPay * 0.18;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  <Widget>[
            const Text(
              'Pay Calculator',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
            ),

            const SizedBox(height:10,),
            if(errorMessage != null)
              ...[
                Text(errorMessage!,
                  style: const TextStyle(
                      fontSize: 17, color: Colors.red),
                ),
                 const SizedBox(height:5,),
              ],
             _CustomTextFieldWidget('Enter numbers worked',
                controller: hoursWorkedTextController),
            const SizedBox(height: 10,),
             _CustomTextFieldWidget('Enter hourly rate',
                controller: hourlyRateTextController),
            const SizedBox(height: 30,),
            Center(
              child: ElevatedButton(
              onPressed: () {
                if(validate()){
                  calculatePay();
                }
              },
              child: const Text(
                "Calculate",
                style: TextStyle(color: Colors.white),
              ),
          ),
            )
          ],
        ),
      ),

    );
  }
}

class _CustomTextFieldWidget extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  const _CustomTextFieldWidget(this.hint, {
    super.key, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(keyboardType: TextInputType.number,
      controller: controller,
      decoration: InputDecoration(
          hintText: hint
      ),
    );
  }
}
