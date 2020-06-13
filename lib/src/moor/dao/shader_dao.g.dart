// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shader_dao.dart';

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$ShaderDaoMixin on DatabaseAccessor<MoorStore> {
  $ShaderTableTable get shaderTable => db.shaderTable;
  $PlaylistTableTable get playlistTable => db.playlistTable;
  $PlaylistShaderTableTable get playlistShaderTable => db.playlistShaderTable;
  Selectable<String> shaderIdQuery() {
    return customSelectQuery('SELECT id FROM Shader',
        variables: [],
        readsFrom: {shaderTable}).map((QueryRow row) => row.readString('id'));
  }

  Future<List<String>> shaderId() {
    return shaderIdQuery().get();
  }

  Stream<List<String>> watchShaderId() {
    return shaderIdQuery().watch();
  }
}
