import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MaterialSwitcher extends StatelessWidget {
  const MaterialSwitcher({
    Key? key,
    required this.isActive,
    required this.onChanged,
  }) : super(key: key);

  final bool isActive;
  final ValueSetter<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      onChanged: onChanged,
      value: isActive,
    );
  }
}
