import 'package:moor/moor.dart';
import 'package:shadertoy_api/shadertoy_api.dart';
import 'package:shadertoy_moor/src/moor/store.dart';
import 'package:shadertoy_moor/src/moor/table/comment_table.dart';

part 'comment_dao.g.dart';

@UseDao(tables: [CommentTable])

/// Comment data access object
class CommentDao extends DatabaseAccessor<MoorStore> with _$CommentDaoMixin {
  /// Creates a [CommentDao]
  ///
  /// * [store]: A pre-initialized [MoorStore] store
  CommentDao(MoorStore store) : super(store);

  /// Checks if a shader has comments
  ///
  /// * [shaderId]: The shader id to check for comments
  ///
  /// Returns `true` if the shader has comments
  Future<bool> exists(String shaderId) {
    return (select(commentTable)
          ..where((entry) => entry.shaderId.equals(shaderId)))
        .get()
        .then((comments) => comments.isNotEmpty);
  }

  /// Converts a list of [CommentEntry] into a list of [Comment]
  ///
  /// * [entries]: The list of entries to convert
  List<Comment> _mapCommentEntity(List<CommentEntry> entries) {
    return entries
        .map((CommentEntry entry) => Comment(
            id: entry.id,
            userId: entry.userId,
            picture: entry.picture,
            date: entry.date,
            text: entry.comment,
            hidden: entry.hidden))
        .toList();
  }

  /// Get's the comments of shader by [shaderId]
  ///
  /// * [shaderId]: The id of the shader
  Future<List<Comment>> findByShaderId(String shaderId) {
    return (select(commentTable)
          ..where((entry) => entry.shaderId.equals(shaderId)))
        .get()
        .then(_mapCommentEntity);
  }

  /// Converts a list of [Comment] into a list of [CommentEntry]
  ///
  /// * [shaderId]: The shaderId
  /// * [comments]: The list of [Comment] to convert
  List<CommentEntry> _toCommentEntries(
      String shaderId, List<Comment> comments) {
    return comments
        .map((comment) => CommentEntry(
            id: comment.id,
            userId: comment.userId,
            picture: comment.picture,
            shaderId: shaderId,
            date: comment.date,
            comment: comment.text,
            hidden: comment.hidden))
        .toList();
  }

  /// Saves the comments of a shader
  ///
  /// * [shaderId]: The id of the sahder
  /// * [comments]: The list of comments to save
  Future<void> save(String shaderId, List<Comment> comments) {
    return batch((b) => b.insertAll(
        commentTable, _toCommentEntries(shaderId, comments),
        mode: InsertMode.insertOrReplace));
  }
}
