import 'package:flutter/material.dart';
import 'package:patternify/l10n/l10n.dart';

class MaterialBottomNavigationBar extends StatelessWidget {
  const MaterialBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  final int currentIndex;
  final ValueSetter<int> onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          label: l10n.libraryBottomNavigationLabel,
          icon: const Icon(Icons.library_music),
        ),
        BottomNavigationBarItem(
          label: l10n.playlistBottomNavigationLabel,
          icon: const Icon(Icons.queue_music),
        ),
      ],
    );
  }
}
