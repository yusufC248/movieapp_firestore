import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int? id;
  final String? backdrop;
  final String? title;
  final String? overview;
  final bool isFavorite;
  final String? poster;
  final String? idFirestore;

  const Movie(
      {this.id,
      this.backdrop,
      this.title,
      this.overview,
      this.isFavorite = false,
      this.poster,
      this.idFirestore});

  Map<String, dynamic> toJson() {
    var json = {
      'id': id,
      'title': title,
      'backdrop': backdrop,
      'overview': overview,
      'is_favorite': isFavorite,
    };
    if (poster != null) {
      json.addAll({'poster': poster});
    }
    return json;
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        title: json['title'],
        backdrop: json['backdrop'],
        overview: json['overview'],
        isFavorite: json['is_favorite'] ?? false,
        poster: json['poster'],
        idFirestore: json['id_firestore']);
  }

  @override
  List<Object?> get props =>
      [id, backdrop, title, overview, isFavorite, poster, idFirestore];

  @override
  bool? get stringify => true;

  Movie copyWith(
      {int? id,
      String? backdrop,
      String? title,
      String? overview,
      bool? isFavorite,
      String? poster,
      String? idFirestore}) {
    return Movie(
        id: id ?? this.id,
        backdrop: backdrop ?? this.backdrop,
        title: title ?? this.title,
        overview: overview ?? this.overview,
        isFavorite: isFavorite ?? this.isFavorite,
        poster: poster,
        idFirestore: idFirestore ?? this.idFirestore);
  }
}
