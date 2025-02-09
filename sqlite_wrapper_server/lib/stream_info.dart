import 'dart:async';

class StreamInfo {
  String sql;
  List<String> tables;
  StreamController controller;
  List<Object?> params;
  bool singleResult;
  String dbName;
  StreamInfo(
      {required this.sql,
      required this.tables,
      required this.controller,
      this.params = const [],
      required this.dbName,
      this.singleResult = false});
}
