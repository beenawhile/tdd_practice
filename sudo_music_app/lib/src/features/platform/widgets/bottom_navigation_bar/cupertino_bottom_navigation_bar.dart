import 'package:flutter/cupertino.dart';
import 'package:patternify/l10n/l10n.dart';

class CupertinoBottomNavigationBar extends StatelessWidget {
  const CupertinoBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  final int currentIndex;
  final ValueSetter<int> onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return CupertinoTabBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          label: l10n.libraryBottomNavigationLabel,
          icon: const Icon(CupertinoIcons.music_albums),
        ),
        BottomNavigationBarItem(
          label: l10n.playlistBottomNavigationLabel,
          icon: const Icon(CupertinoIcons.music_note_list),
        ),
      ],
    );
  }
}
