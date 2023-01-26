import 'package:flutter/material.dart';
import 'package:pay_calculator/widgets/custom_text_field_widget.dart';
import 'package:pay_calculator/widgets/footer_widget.dart';
import 'package:pay_calculator/widgets/row_list_item.dart';

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
  double hourlyRate = 0;

  String? errorMessage;

  void resetValues(){
     regularPay = 0;
     overtimePay = 0;
     totalPay = 0;
     tax = 0;
     hourlyRate = 0;
  }

  //numeric check
  bool _isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  //validate user inputs
  bool validate() {
    if (hoursWorkedTextController.text.trim().isEmpty) {
      setState(() {
        errorMessage = 'Please enter your hours worked';
      });
      return false;
    } else {
      if (!_isNumeric(hoursWorkedTextController.text.trim())) {
        setState(() {
          errorMessage = 'Please enter only numbers for hours worked';
        });
        return false;
      }
      else if (double.parse(hoursWorkedTextController.text.trim()) < 0) {
        setState(() {
          errorMessage = 'Hours worked cannot be less than zero';
        });
        return false;
      }
    }

    if (hourlyRateTextController.text.trim().isEmpty) {
      setState(() {
        errorMessage = 'Please enter your hourly rate';
      });
      return false;
    } else {
      if (!_isNumeric(hourlyRateTextController.text.trim())) {
        setState(() {
          errorMessage = 'Please enter only numbers for hourly rate';
        });
        return false;
      }
      else if (double.parse(hourlyRateTextController.text.trim()) < 0) {
        setState(() {
          errorMessage = 'Hourly rate cannot be less than zero';
        });
        return false;
      }
    }
    setState(() {
      errorMessage = null;
    });
    return true;
  }

  void calculatePay() {
    resetValues();
    double overtimeHours = 0;
    double hours = double.parse(hoursWorkedTextController.text.toString());
    double hourlyRate = double.parse(hourlyRateTextController.text.toString());
    double regularHours = hours;

    if (hours > 40) {
      overtimeHours = hours - 40;
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Pay Calculator',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 10,
            ),
            if (errorMessage != null) ...[
              Text(
                errorMessage!,
                style: const TextStyle(fontSize: 17, color: Colors.red),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
            CustomTextFieldWidget('Enter number of hours worked',
                controller: hoursWorkedTextController),
            const SizedBox(
              height: 10,
            ),
            CustomTextFieldWidget('Enter hourly rate',
                controller: hourlyRateTextController),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (validate()) {
                    calculatePay();
                  }
                },
                child: const Text(
                  "Calculate",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            regularPay != 0?buildReportDisplay():const Spacer(),
            const FootWidget(),

          ],
        ),
      ),
    );
  }

  Expanded buildReportDisplay() {
    return Expanded(
            child: ListView(children: [
              const SizedBox(height: 10,),

              const Text('Report',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              const SizedBox(height: 30,),

              RowListItem(title: 'Regular Pay', data: '\$ $regularPay'),
              RowListItem(title: 'Overtime Pay', data: '\$ $overtimePay'),
              RowListItem(title: 'Tax Deduction', data: '-\$ $tax'),
              RowListItem(title: 'Total Pay Before Tax ', data: '\$ $totalPay'),
              RowListItem(title: 'Total Pay After Tax', data: '\$ ${totalPay-tax}'),

            ],),
          );
  }
}

