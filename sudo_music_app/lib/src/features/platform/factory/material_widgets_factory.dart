import 'package:flutter/material.dart';
import 'package:patternify/src/features/platform/factory/platform_widgets_factory.dart';
import 'package:patternify/src/features/platform/widgets/material_widgets.dart';

class MaterialWidgetsFactory implements PlatformWidgetsFactory {
  const MaterialWidgetsFactory();

  @override
  PreferredSizeWidget createAppBar(
      {required String title, bool showSettingsButton = false}) {
    return MaterialAppBar(title: title, showSettingsButton: showSettingsButton);
  }

  @override
  Widget createBottomNavigationBar(
      {required int currentIndex, required ValueSetter<int> onTap}) {
    return MaterialBottomNavigationBar(
        currentIndex: currentIndex, onTap: onTap);
  }

  @override
  Widget createLoader() {
    return const MaterialLoader();
  }

  @override
  PageRoute createPageRouter({required WidgetBuilder builder}) {
    return MaterialPageRouter(builder: builder);
  }

  @override
  Widget createSwitcher(
      {required bool isActive, required ValueSetter<bool> onChanged}) {
    return MaterialSwitcher(isActive: isActive, onChanged: onChanged);
  }
}
