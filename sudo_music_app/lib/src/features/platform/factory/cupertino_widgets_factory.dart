import 'package:flutter/cupertino.dart';
import 'package:patternify/src/features/platform/factory/platform_widgets_factory.dart';
import 'package:patternify/src/features/platform/widgets/cupertino_widgets.dart';

class CupertinoWidgetsFactory implements PlatformWidgetsFactory {
  const CupertinoWidgetsFactory();

  @override
  PreferredSizeWidget createAppBar(
      {required String title, bool showSettingsButton = false}) {
    return CupertinoAppBar(title: title);
  }

  @override
  Widget createBottomNavigationBar(
      {required int currentIndex, required ValueSetter<int> onTap}) {
    return CupertinoBottomNavigationBar(
        currentIndex: currentIndex, onTap: onTap);
  }

  @override
  Widget createLoader() {
    return const CupertinoLoader();
  }

  @override
  PageRoute createPageRouter({required WidgetBuilder builder}) {
    return CupertinoPageRouter(builder: builder);
  }

  @override
  Widget createSwitcher(
      {required bool isActive, required ValueSetter<bool> onChanged}) {
    return CupertinoSwitcher(isActive: isActive, onChanged: onChanged);
  }
}
