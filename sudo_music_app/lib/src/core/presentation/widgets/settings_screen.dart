import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patternify/l10n/l10n.dart';
import 'package:patternify/src/core/presentation/widgets/dependency_injection.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const route = "/settings";

  void _onUseCupertinoWidgetsChanged(bool useCupertino) {
    debugDefaultTargetPlatformOverride =
        useCupertino ? TargetPlatform.iOS : TargetPlatform.android;
    WidgetsBinding.instance.reassembleApplication();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: ref.read(widgetsFactoryProvider).createAppBar(
            title: l10n.settingsTitle,
            showSettingsButton: false,
          ),
      body: Column(
        children: [
          ListTile(
            title: Text(l10n.useCupertinoLabel),
            trailing: ref.read(widgetsFactoryProvider).createSwitcher(
                  isActive: defaultTargetPlatform == TargetPlatform.iOS,
                  onChanged: _onUseCupertinoWidgetsChanged,
                ),
          ),
        ],
      ),
    );
  }
}
