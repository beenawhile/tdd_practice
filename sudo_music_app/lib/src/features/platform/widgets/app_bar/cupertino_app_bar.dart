import 'package:flutter/cupertino.dart';
import 'package:patternify/src/core/presentation/widgets/settings_screen.dart';

class CupertinoAppBar extends StatelessWidget with PreferredSizeWidget {
  const CupertinoAppBar({
    Key? key,
    required this.title,
    this.showSettingsButton = true,
  }) : super(key: key);

  final String title;
  final bool showSettingsButton;

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      middle: Text(title),
      trailing: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showSettingsButton)
            GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(SettingsScreen.route),
              child: const Icon(
                CupertinoIcons.gear_alt,
                size: 24,
              ),
            ),
          // todo: implement command list
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kMinInteractiveDimensionCupertino);
}
