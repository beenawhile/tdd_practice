import 'dart:convert';

class MusicCollection {
  const MusicCollection({
    required this.id,
    required this.title,
    this.parentId,
  });

  final int id;
  final String title;
  final int? parentId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'parentId': parentId,
    };
  }

  factory MusicCollection.fromMap(Map<String, dynamic> map) {
    return MusicCollection(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      parentId: map['parentId']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MusicCollection.fromJson(String source) =>
      MusicCollection.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MusicCollection &&
        other.id == id &&
        other.title == title &&
        other.parentId == parentId;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ parentId.hashCode;

  MusicCollection copyWith({
    int? id,
    String? title,
    int? parentId,
  }) {
    return MusicCollection(
      id: id ?? this.id,
      title: title ?? this.title,
      parentId: parentId ?? this.parentId,
    );
  }

  @override
  String toString() =>
      'MusicCollection{ id: $id, title: $title, parentId: $parentId }';
}
