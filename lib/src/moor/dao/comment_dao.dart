import 'package:moor/moor.dart';
import 'package:shadertoy_api/shadertoy_api.dart';
import 'package:shadertoy_moor/src/moor/store.dart';
import 'package:shadertoy_moor/src/moor/table/comment_table.dart';

part 'comment_dao.g.dart';

@UseDao(tables: [CommentTable])
class CommentDao extends DatabaseAccessor<MoorStore> with _$CommentDaoMixin {
  CommentDao(MoorStore store) : super(store);

  Future<bool> exists(String shaderId) async {
    return (select(commentTable)
          ..where((entry) => entry.shaderId.equals(shaderId)))
        .get()
        .then((comments) => comments.isNotEmpty);
  }

  List<Comment> _mapCommentEntity(List<CommentEntry> entries) {
    return entries
        .map((CommentEntry entry) => Comment(
            shaderId: entry.shaderId,
            userId: entry.userId,
            date: entry.date,
            text: entry.comment))
        .toList();
  }

  Future<List<Comment>> findByShaderId(String shaderId) async {
    return (select(commentTable)
          ..where((entry) => entry.shaderId.equals(shaderId)))
        .get()
        .then(_mapCommentEntity);
  }

  List<CommentEntry> _toCommentEntries(List<Comment> comments) {
    return comments.map((comment) => CommentEntry(
        shaderId: comment.shaderId,
        userId: comment.userId,
        date: comment.date,
        comment: comment.text));
  }

  Future<void> save(List<Comment> comments) {
    return batch((b) => b.insertAll(commentTable, _toCommentEntries(comments),
        mode: InsertMode.insertOrReplace));
  }
}
