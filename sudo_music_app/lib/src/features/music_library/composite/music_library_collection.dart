import 'package:flutter/material.dart';
import 'package:patternify/src/core/presentation/widgets/music_library_screen.dart';
import 'package:patternify/src/features/music_library/composite/music_library_item.dart';
import 'package:patternify/src/features/music_library/models/music_collection.dart';

class MusicLibraryCollection extends StatelessWidget
    implements MusicLibraryItem {
  MusicLibraryCollection({
    super.key,
    required this.data,
  });

  final MusicCollection data;
  final List<MusicLibraryItem> _items = [];

  void addItems(List<MusicLibraryItem> items) => _items.addAll(items);

  @override
  int getDuration() =>
      _items.fold(0, (prev, item) => prev + item.getDuration());

  @override
  int getItemsCount() => _items.fold(0, (prev, item) => item.getDuration());

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(data.title),
        leading: Icon(
          Icons.album,
          size: 40.0,
          color: Theme.of(context).primaryColor,
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Theme.of(context).primaryColor,
        ),
        onTap: () => Navigator.pushNamed(
          context,
          MusicLibraryScreen.route,
          arguments: <String, dynamic>{
            "title": data.title,
            "items": _items,
          },
        ),
      ),
    );
  }
}
