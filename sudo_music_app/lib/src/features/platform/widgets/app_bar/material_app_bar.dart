import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patternify/src/core/presentation/widgets/settings_screen.dart';
import 'package:patternify/src/features/playlist/dependency_injection.dart';

class MaterialAppBar extends ConsumerWidget with PreferredSizeWidget {
  const MaterialAppBar({
    Key? key,
    required this.title,
    required this.showSettingsButton,
  }) : super(key: key);

  final String title;
  final bool showSettingsButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCommandHistoryEmpty = ref.watch(playlistStateNotifierProvider
        .select((value) => value.isCommandHistoryEmpty));

    return AppBar(
      backgroundColor: Colors.black,
      title: Text(title),
      actions: [
        if (showSettingsButton)
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(SettingsScreen.route),
            icon: const Icon(Icons.settings),
          )
        else if (!isCommandHistoryEmpty)
          IconButton(
            onPressed: () => ref
                .read(playlistStateNotifierProvider.notifier)
                .undoLastCommand(),
            icon: const Icon(Icons.replay),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
