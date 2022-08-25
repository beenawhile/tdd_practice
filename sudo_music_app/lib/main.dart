import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patternify/src/core/presentation/widgets/app.dart';

void main() {
  runApp(
    const ProviderScope(child: App()),
  );
}
