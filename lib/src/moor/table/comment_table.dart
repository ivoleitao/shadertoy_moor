import 'package:moor/moor.dart';

@DataClassName('CommentEntry')
class CommentTable extends Table {
  @override
  String get tableName => 'Comment';

  TextColumn get shaderId => text().customConstraint('REFERENCES Shader(id)')();
  TextColumn get userId => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get comment => text()();

  @override
  Set<Column> get primaryKey => {shaderId, userId};
}
