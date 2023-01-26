import 'package:flutter/material.dart';

class FootWidget extends StatelessWidget {
  const FootWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          Text(
            'Jovi Chen-Mcintyre',
            style: TextStyle(fontSize: 17, color: Colors.black),
          ),
          Text(
            '301125059',
            style: TextStyle(fontSize: 17, color:Colors.black),
          ),
        ],
      ),
    );
  }
}

