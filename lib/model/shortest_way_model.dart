import 'package:equatable/equatable.dart';

class ShortestWayModel extends Equatable {
  const ShortestWayModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory ShortestWayModel.fromJson(Map<String, dynamic> json) {
    final List<Data> listData = [];
    if (json['data'] != null) {
      json['data'].forEach((dynamic v) {
        listData.add(Data.fromJson(v as Map<String, dynamic>));
      });
    }
    return ShortestWayModel(
      error: json['error'] as bool,
      message: json['message'] as String,
      data: listData,
    );
  }

  final bool error;
  final String message;
  final List<Data> data;

  @override
  List<Object?> get props => [error, message, data];

  @override
  bool get stringify => true;

  ShortestWayModel copyWith({
    bool? error,
    String? message,
    List<Data>? data,
  }) {
    return ShortestWayModel(
      error: error ?? this.error,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  String toString() {
    return 'YourModel{error: $error, message: $message, data: $data}';
  }
}

class Data extends Equatable {
  const Data({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    final List<String> listFields= [];
    if (json['field'] != null) {
      json['field'].forEach((dynamic v) {
        listFields.add(v as String);
      });
    }
    return Data(
      id: json['id'] as String,
      field: listFields,
      start: Point.fromJson(json['start'] as Map<String, dynamic>),
      end: Point.fromJson(json['end'] as Map<String, dynamic>),
    );
  }

  final String id;
  final List<String> field;
  final Point start;
  final Point end;

  @override
  List<Object?> get props => [id, field, start, end];

  @override
  bool get stringify => true;

  Data copyWith({
    String? id,
    List<String>? field,
    Point? start,
    Point? end,
  }) {
    return Data(
      id: id ?? this.id,
      field: field ?? this.field,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  @override
  String toString() {
    return 'Data{id: $id, field: $field, start: $start, end: $end}';
  }
}

class Point extends Equatable {
  const Point({
    required this.x,
    required this.y,
  });

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      x: json['x'] as int,
      y: json['y'] as int,
    );
  }

  final int x;
  final int y;

  @override
  List<Object?> get props => [x, y];

  @override
  bool get stringify => true;

  Point copyWith({
    int? x,
    int? y,
  }) {
    return Point(
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }

  @override
  String toString() {
    return 'Point{x: $x, y: $y}';
  }
}
