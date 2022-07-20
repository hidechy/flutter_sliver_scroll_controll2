import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Image.asset(image),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DefaultTextStyle(
            style: const TextStyle(color: Colors.black54),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.greenAccent.withOpacity(0.3),
              ),
              child: const Text(' '),
            ),
          ),
        )
      ],
    );
  }
}
