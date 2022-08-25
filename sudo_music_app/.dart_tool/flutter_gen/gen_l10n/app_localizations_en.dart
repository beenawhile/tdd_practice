

import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Patternify';

  @override
  String get playlistTitle => 'Playlist';

  @override
  String get playlistEmpty => 'Playlist is empty.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get useCupertinoLabel => 'Use Cupertino widgets.';

  @override
  String songsLabel(num count) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      zero: 'no songs',
      one: '1 song',
      other: '$count songs',
    );
  }

  @override
  String get libraryBottomNavigationLabel => 'Library';

  @override
  String get playlistBottomNavigationLabel => 'Playlist';

  @override
  String get errorMessage => 'Oops, something went wrong...';
}
