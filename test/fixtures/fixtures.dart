import 'dart:convert';
import 'dart:io';

import 'package:shadertoy_api/shadertoy_api.dart';

File _fixture(String path) => File('test/fixtures/$path');

String textFixture(String path) => _fixture(path).readAsStringSync();

Map<String, dynamic> jsonFixture(String path) => json.decode(textFixture(path));

List jsonListFixture(String path) => json.decode(textFixture(path));

Shader shaderFixture(String path) => Shader.fromJson(jsonFixture(path));

List<Shader> shadersFixture(List<String> paths) =>
    paths.map((p) => shaderFixture(p)).toList();

User userFixture(String path) => User.fromJson(jsonFixture(path));

String userIdFixture(String path) => userFixture(path).id;

List<User> usersFixture(List<String> paths) =>
    paths.map((p) => userFixture(p)).toList();

FindUserIdsResponse findUserIdsResponseFixture(List<String> paths,
        {int count, ResponseError error}) =>
    FindUserIdsResponse(
        count: count,
        ids: paths.map((p) => userIdFixture(p)).toList(),
        error: error);

FindUsersResponse findUsersResponseFixture(List<String> paths,
        {int total, ResponseError error}) =>
    FindUsersResponse(
        total: total,
        users:
            paths.map((p) => FindUserResponse(user: userFixture(p))).toList(),
        error: error);

List<Comment> commentListFixture(String path) =>
    jsonListFixture(path).map((comment) => Comment.fromJson(comment)).toList();

Playlist playlistFixture(String path) => Playlist.fromJson(jsonFixture(path));

String playlistIdFixture(String path) => playlistFixture(path).id;

FindShaderResponse findShaderResponseFixture(String path,
        {ResponseError error}) =>
    FindShaderResponse(shader: shaderFixture(path), error: error);

FindShadersResponse findShadersResponseFixture(List<String> paths,
        {ResponseError error}) =>
    FindShadersResponse(
        shaders: paths.map((p) => findShaderResponseFixture(p)).toList(),
        error: error);

String shaderIdFixture(String path) => shaderFixture(path).info.id;

FindShaderIdsResponse findShaderIdsResponseFixture(List<String> paths,
        {int count, ResponseError error}) =>
    FindShaderIdsResponse(
        count: count,
        ids: paths.map((p) => shaderIdFixture(p)).toList(),
        error: error);

FindShadersRequest findShadersRequestFixture(List<String> paths,
        {ResponseError error}) =>
    FindShadersRequest(paths.map((p) => shaderIdFixture(p)).toSet());

FindCommentIdsResponse findCommentIdsResponseFixture(String path,
        {ResponseError error}) =>
    FindCommentIdsResponse(
        ids: commentListFixture(path).map((comment) => comment.id).toList(),
        error: error);

FindCommentsResponse findCommentsResponseFixture(String path,
        {ResponseError error}) =>
    FindCommentsResponse(comments: commentListFixture(path), error: error);

CommentsResponse commentsResponseFixture(String path) =>
    CommentsResponse.fromMap(jsonFixture(path));

FindPlaylistIdsResponse findPlaylistIdsResponseFixture(List<String> paths,
        {int count, ResponseError error}) =>
    FindPlaylistIdsResponse(
        count: count,
        ids: paths.map((p) => playlistIdFixture(p)).toList(),
        error: error);

FindPlaylistsResponse findPlaylistsResponseFixture(List<String> paths,
        {int total, ResponseError error}) =>
    FindPlaylistsResponse(
        total: total,
        playlists: paths.map((p) => playlistFixture(p)).toList(),
        error: error);
