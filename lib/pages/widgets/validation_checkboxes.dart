import 'package:flutter/material.dart';

class ValidationCheckbox extends StatelessWidget {
  final bool hasValidValue;
  final String name;

  const ValidationCheckbox(
      {Key? key, required this.hasValidValue, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 18,
          height: 18,
          decoration: BoxDecoration(
              color: hasValidValue
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.transparent,
              border: hasValidValue
                  ? Border.all(color: Colors.transparent)
                  : Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(50)),
          child: const Center(
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 13),
        ),
      ],
    );
  }
}
