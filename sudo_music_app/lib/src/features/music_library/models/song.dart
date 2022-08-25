import 'dart:convert';

class Song {
  const Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.duration,
    required this.collectionId,
  });

  final int id;
  final String title;
  final String artist;
  final int duration;
  final int collectionId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'duration': duration,
      'collectionId': collectionId,
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      artist: map['artist'] ?? '',
      duration: map['duration']?.toInt() ?? 0,
      collectionId: map['collectionId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Song.fromJson(String source) => Song.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Song &&
        other.id == id &&
        other.title == title &&
        other.artist == artist &&
        other.duration == duration &&
        other.collectionId == collectionId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        artist.hashCode ^
        duration.hashCode ^
        collectionId.hashCode;
  }

  Song copyWith({
    int? id,
    String? title,
    String? artist,
    int? duration,
    int? collectionId,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      duration: duration ?? this.duration,
      collectionId: collectionId ?? this.collectionId,
    );
  }

  @override
  String toString() {
    return 'Song {id: $id, title: $title, artist: $artist, duration: $duration, collectionId: $collectionId }';
  }
}
