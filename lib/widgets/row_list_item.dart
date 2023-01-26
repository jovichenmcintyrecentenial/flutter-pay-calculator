import 'package:flutter/material.dart';

class RowListItem extends StatelessWidget {
  const RowListItem({
    super.key,
    required this.title,
    required this.data,
  });

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Expanded(child: Text(title,style: const TextStyle(fontSize: 17, color: Colors.black45))),
          Text(data,style: const TextStyle(fontSize: 17),)
        ],),
        const SizedBox(height: 20,)
      ],
    );
  }
}
