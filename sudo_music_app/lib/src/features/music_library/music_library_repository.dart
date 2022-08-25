import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:patternify/src/features/music_library/models/music_collection.dart';
import 'package:patternify/src/features/music_library/models/song.dart';

class MusicLibraryRepository {
  const MusicLibraryRepository();

  Future<List<MusicCollection>> getCollections() async {
    final jsonMap = await _getJsonMap('assets/music_collections_data.json');
    final collectionsJsonList = jsonMap['collections'] as List;

    return collectionsJsonList
        .map((collectionJson) => MusicCollection.fromMap(collectionJson))
        .toList();
  }

  Future<List<Song>> getSongs() async {
    final jsonMap = await _getJsonMap('assets/songs_data.json');
    final songsJsonList = jsonMap['songs'] as List;

    return songsJsonList.map((songJson) => Song.fromMap(songJson)).toList();
  }

  Future<Map<String, dynamic>> _getJsonMap(String jsonPath) async {
    final jsonFile = await rootBundle.loadString(jsonPath);

    return json.decode(jsonFile) as Map<String, dynamic>;
  }
}
