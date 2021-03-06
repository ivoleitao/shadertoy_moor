import 'package:moor/ffi.dart';
import 'package:moor/moor.dart' show QueryExecutor, moorRuntimeOptions;
import 'package:shadertoy_api/shadertoy_api.dart';
import 'package:shadertoy_moor/src/moor/store.dart';
import 'package:shadertoy_moor/src/moor_options.dart';
import 'package:shadertoy_moor/src/moor_store.dart';
import 'package:test/test.dart';

import 'fixtures/fixtures.dart';

void main() {
  ShadertoyMoorOptions newOptions() {
    return ShadertoyMoorOptions();
  }

  QueryExecutor memoryExecutor({bool logStatements = false}) {
    return VmDatabase.memory(logStatements: logStatements);
  }

  MoorStore newStore(QueryExecutor executor) {
    return MoorStore(executor ?? memoryExecutor());
  }

  ShadertoyMoorStore newMoorStore(ShadertoyMoorOptions options,
      {QueryExecutor executor}) {
    return ShadertoyMoorStore(newStore(executor), options);
  }

  moorRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  List<FindShaderResponse> _nameSort(List<String> shaderPaths) {
    final nameSort = (FindShaderResponse fsr) => fsr.shader.info.name;
    final result = List<FindShaderResponse>.from(
        findShadersResponseFixture(shaderPaths).shaders);
    result.sort((shader1, shader2) {
      final name1 = nameSort(shader1);
      final name2 = nameSort(shader2);
      return name1.compareTo(name2);
    });

    return result;
  }

  List<FindShaderResponse> _dateSort(List<String> shaderPaths) {
    final dateSort = (FindShaderResponse fsr) => fsr.shader.info.date;
    final result = List<FindShaderResponse>.from(
        findShadersResponseFixture(shaderPaths).shaders);
    result.sort((shader1, shader2) {
      final date1 = dateSort(shader1);
      final date2 = dateSort(shader2);
      return -1 * date1.compareTo(date2);
    });

    return result;
  }

  List<FindShaderResponse> _popularitySort(List<String> shaderPaths) {
    final popularitySort = (FindShaderResponse fsr) => fsr.shader.info.views;
    final result = List<FindShaderResponse>.from(
        findShadersResponseFixture(shaderPaths).shaders);
    result.sort((shader1, shader2) {
      final popularity1 = popularitySort(shader1);
      final popularity2 = popularitySort(shader2);
      if (popularity1 < popularity2) {
        return 1;
      } else if (popularity1 > popularity2) {
        return -1;
      }

      return 0;
    });

    return result;
  }

  List<FindShaderResponse> _loveSort(List<String> shaderPaths) {
    final loveSort = (FindShaderResponse fsr) => fsr.shader.info.likes;
    final result = List<FindShaderResponse>.from(
        findShadersResponseFixture(shaderPaths).shaders);
    result.sort((shader1, shader2) {
      final love1 = loveSort(shader1);
      final love2 = loveSort(shader2);
      if (love1 < love2) {
        return 1;
      } else if (love1 > love2) {
        return -1;
      }

      return 0;
    });

    return result;
  }

  List<FindShaderResponse> _hotSort(List<String> shaderPaths) {
    final hotSort = (FindShaderResponse fsr) =>
        fsr.shader.info.views /
        (DateTime.now().millisecondsSinceEpoch ~/ 1000 -
            fsr.shader.info.date.millisecondsSinceEpoch ~/ 1000);
    final result = List<FindShaderResponse>.from(
        findShadersResponseFixture(shaderPaths).shaders);
    result.sort((shader1, shader2) {
      final hot1 = hotSort(shader1);
      final hot2 = hotSort(shader2);
      if (hot1 < hot2) {
        return 1;
      } else if (hot1 > hot2) {
        return -1;
      }

      return 0;
    });

    return result;
  }

  group('Shader', () {
    test('Save shader', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shader = shaderFixture('shaders/happy_jumping.json');
      // act
      final response = await store.saveShader(shader);
      // assert
      expect(response, isNotNull);
      expect(response.error, isNull);
    });

    test('Save shaders', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shaders = shadersFixture(
          ['shaders/seascape.json', 'shaders/happy_jumping.json']);
      // act
      final response = await store.saveShaders(shaders);
      // assert
      expect(response, isNotNull);
      expect(response.error, isNull);
    });

    test('Save shader twice', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final originalShader = shaderFixture('shaders/happy_jumping.json');
      final updatedShader = originalShader.copyWith(version: 'a');
      // act
      await store.saveShader(originalShader);
      final savedShader1 = await store.findShaderById(originalShader.info.id);
      await store.saveShader(updatedShader);
      final savedShader2 = await store.findShaderById(originalShader.info.id);
      // assert
      expect(savedShader1.shader, originalShader);
      expect(savedShader2.shader, updatedShader);
    });

    test('Find shader by id', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shader = shaderFixture('shaders/happy_jumping.json');
      await store.saveShader(shader);
      // act
      final response = await store.findShaderById(shader.info.id);
      // assert
      expect(response, isNotNull);
      expect(response.error, isNull);
      expect(response.shader, shader);
    });

    test('Find shader by id with not found response', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shaderId = 'xxxx';
      // act
      final response = await store.findShaderById(shaderId);
      // assert
      expect(response, isNotNull);
      expect(response.error, isNotNull);
      expect(response.error,
          ResponseError.notFound(context: CONTEXT_SHADER, target: shaderId));
    });

    test('Find shaders by id set', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shaderPaths = [
        'shaders/seascape.json',
        'shaders/happy_jumping.json'
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      // act
      final response = await store
          .findShadersByIdSet({shaders[0].info.id, shaders[1].info.id});
      // assert
      expect(response.shaders, findShadersResponseFixture(shaderPaths).shaders);
    });

    test('Find shader ids by query', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shaderPaths = [
        'shaders/clouds.json',
        'shaders/elevated.json',
        'shaders/rainforest.json',
        'shaders/raymarching_part_1.json',
        'shaders/raymarching_part_2.json',
        'shaders/raymarching_part_3.json',
        'shaders/raymarching_part_4.json',
        'shaders/raymarching_part_6.json',
        'shaders/raymarching_primitives.json',
        'shaders/volcanic.json',
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      // act
      final response = await store
          .findShaderIds(term: 'Elevated', filters: {'procedural', '3d'});
      // assert
      final actual = response.ids;
      final expected =
          findShaderIdsResponseFixture(['shaders/elevated.json']).ids;

      expect(actual, containsAllInOrder(expected));
    });

    test('Find all shader ids', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shaderPaths = [
        'shaders/seascape.json',
        'shaders/happy_jumping.json'
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      // act
      final response = await store.findAllShaderIds();
      // assert
      expect(response, isNotNull);
      expect(response.error, isNull);
      expect(response.ids,
          containsAll(findShaderIdsResponseFixture(shaderPaths).ids));
    });

    test('Find shaders', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shaderPaths = [
        'shaders/clouds.json',
        'shaders/creation.json',
        'shaders/elevated.json',
        'shaders/rainforest.json',
        'shaders/raymarching_part_1.json',
        'shaders/raymarching_part_2.json',
        'shaders/raymarching_part_3.json',
        'shaders/raymarching_part_4.json',
        'shaders/raymarching_part_6.json',
        'shaders/raymarching_primitives.json',
        'shaders/seascape.json',
        'shaders/volcanic.json',
        'shaders/snail.json',
        'shaders/selfie_girl.json',
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      // act
      final response = await store.findShaders();
      // assert
      final actual = response.shaders;
      final expected = _hotSort(shaderPaths).take(options.shaderCount);

      expect(actual.length, options.shaderCount);
      expect(actual, containsAllInOrder(expected));
    });

    test('Find shaders, sort by name asc', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shaderPaths = [
        'shaders/clouds.json',
        'shaders/creation.json',
        'shaders/elevated.json',
        'shaders/rainforest.json',
        'shaders/raymarching_part_1.json',
        'shaders/raymarching_part_2.json',
        'shaders/raymarching_part_3.json',
        'shaders/raymarching_part_4.json',
        'shaders/raymarching_part_6.json',
        'shaders/raymarching_primitives.json',
        'shaders/seascape.json',
        'shaders/volcanic.json',
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      // act
      final response = await store.findShaders(sort: Sort.name);
      // assert
      final actual = response.shaders;
      final expected = _nameSort(shaderPaths).take(options.shaderCount);

      expect(actual, containsAllInOrder(expected));
    });

    test('Find shaders, sort by popularity (views)', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shaderPaths = [
        'shaders/clouds.json',
        'shaders/creation.json',
        'shaders/elevated.json',
        'shaders/rainforest.json',
        'shaders/raymarching_part_1.json',
        'shaders/raymarching_part_2.json',
        'shaders/raymarching_part_3.json',
        'shaders/raymarching_part_4.json',
        'shaders/raymarching_part_6.json',
        'shaders/raymarching_primitives.json',
        'shaders/seascape.json',
        'shaders/volcanic.json',
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      // act
      final response = await store.findShaders(sort: Sort.popular);
      // assert
      final actual = response.shaders;
      final expected = _popularitySort(shaderPaths).take(options.shaderCount);

      expect(actual, containsAllInOrder(expected));
    });

    test('Find shaders, sort by date desc', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shaderPaths = [
        'shaders/clouds.json',
        'shaders/creation.json',
        'shaders/elevated.json',
        'shaders/rainforest.json',
        'shaders/raymarching_part_1.json',
        'shaders/raymarching_part_2.json',
        'shaders/raymarching_part_3.json',
        'shaders/raymarching_part_4.json',
        'shaders/raymarching_part_6.json',
        'shaders/raymarching_primitives.json',
        'shaders/seascape.json',
        'shaders/volcanic.json',
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      // act
      final response = await store.findShaders(sort: Sort.newest);
      // assert
      final actual = response.shaders;
      final expected = _dateSort(shaderPaths).take(options.shaderCount);

      expect(actual, containsAllInOrder(expected));
    });

    test('Find shaders, sort by love (likes) desc', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shaderPaths = [
        'shaders/clouds.json',
        'shaders/creation.json',
        'shaders/elevated.json',
        'shaders/expansive_reaction_diffusion.json',
        'shaders/flame.json',
        'shaders/fractal_land.json',
        'shaders/protean_clouds.json',
        'shaders/rainforest.json',
        'shaders/raymarching_primitives.json',
        'shaders/seascape.json',
        'shaders/star_nest.json',
        'shaders/voxel_edges.json',
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      // act
      final response = await store.findShaders(sort: Sort.love);
      // assert
      final actual = response.shaders;
      final expected = _loveSort(shaderPaths).take(options.shaderCount);

      expect(actual, containsAllInOrder(expected));
    });

    test('Find shaders, sort by hot desc', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);

      final shaderPaths = [
        'shaders/day_at_the_lake.json',
        'shaders/ed_209.json',
        'shaders/happy_jumping.json',
        'shaders/joe_gardner_soul_pixar.json',
        'shaders/m_o_from_wall_e.json',
        'shaders/normalized_blinn_phong.json',
        'shaders/normalized_blinn_phong_test.json',
        'shaders/raymarching_primitives.json',
        'shaders/seascape.json',
        'shaders/second_order_pixel_sorter.json',
        'shaders/selfie_girl.json',
        'shaders/truchet_grid_inversion.json',
      ];
      final shaders = shadersFixture(shaderPaths);

      await store.saveShaders(shaders);
      // act
      final response = await store.findShaders(sort: Sort.hot);
      // assert
      final actual = response.shaders;
      final expected = _hotSort(shaderPaths).take(options.shaderCount);

      expect(actual, containsAllInOrder(expected));
    });

    test('Find shaders by term', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shaderPaths = [
        'shaders/clouds.json',
        'shaders/creation.json',
        'shaders/elevated.json',
        'shaders/rainforest.json',
        'shaders/raymarching_part_1.json',
        'shaders/raymarching_part_2.json',
        'shaders/raymarching_part_3.json',
        'shaders/raymarching_part_4.json',
        'shaders/raymarching_part_6.json',
        'shaders/raymarching_primitives.json',
        'shaders/seascape.json',
        'shaders/volcanic.json',
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      // act
      final response = await store.findShaders(term: 'volcanic');
      // assert
      final actual = response.shaders;
      final expected =
          findShadersResponseFixture(['shaders/volcanic.json']).shaders;

      expect(actual, containsAllInOrder(expected));
    });

    test('Find shaders by tag', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shaderPaths = [
        'shaders/clouds.json',
        'shaders/creation.json',
        'shaders/elevated.json',
        'shaders/rainforest.json',
        'shaders/raymarching_part_1.json',
        'shaders/raymarching_part_2.json',
        'shaders/raymarching_part_3.json',
        'shaders/raymarching_part_4.json',
        'shaders/raymarching_part_6.json',
        'shaders/raymarching_primitives.json',
        'shaders/seascape.json',
        'shaders/volcanic.json',
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      // act
      final response = await store.findShaders(filters: {'waves', 'sea'});
      // assert
      final actual = response.shaders;
      final expected =
          findShadersResponseFixture(['shaders/seascape.json']).shaders;

      expect(actual, containsAllInOrder(expected));
    });

    test('Find shaders by query', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shaderPaths = [
        'shaders/clouds.json',
        'shaders/creation.json',
        'shaders/elevated.json',
        'shaders/rainforest.json',
        'shaders/raymarching_part_1.json',
        'shaders/raymarching_part_2.json',
        'shaders/raymarching_part_3.json',
        'shaders/raymarching_part_4.json',
        'shaders/raymarching_part_6.json',
        'shaders/raymarching_primitives.json',
        'shaders/seascape.json',
        'shaders/volcanic.json',
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      // act
      final response = await store
          .findShaders(term: 'Elevated', filters: {'procedural', '3d'});
      // assert
      final actual = response.shaders;
      final expected =
          findShadersResponseFixture(['shaders/elevated.json']).shaders;

      expect(actual, containsAllInOrder(expected));
    });

    test('Find shaders with from and limit', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shaderPaths = [
        'shaders/clouds.json',
        'shaders/creation.json',
        'shaders/elevated.json',
        'shaders/rainforest.json',
        'shaders/raymarching_part_1.json',
        'shaders/raymarching_part_2.json',
        'shaders/raymarching_part_3.json',
        'shaders/raymarching_part_4.json',
        'shaders/raymarching_part_6.json',
        'shaders/raymarching_primitives.json',
        'shaders/seascape.json',
        'shaders/volcanic.json',
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      // act
      final response = await store.findShaders(from: 6, num: 5);
      // assert
      final actual = response.shaders;
      final expected = _hotSort(shaderPaths).sublist(6, 11);

      expect(actual, containsAllInOrder(expected));
    });

    test('Find all shaders', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shaderPaths = [
        'shaders/seascape.json',
        'shaders/happy_jumping.json'
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      // act
      final response = await store.findAllShaders();
      // assert
      expect(response, isNotNull);
      expect(response.error, isNull);
      expect(response.shaders,
          containsAll(findShadersResponseFixture(shaderPaths).shaders));
    });

    test('Delete shader by id', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shader = shaderFixture('shaders/happy_jumping.json');
      await store.saveShader(shader);
      final fsr1 = await store.findShaderById(shader.info.id);
      // act
      final dsr = await store.deleteShaderById(shader.info.id);
      final fsr2 = await store.findShaderById(shader.info.id);
      // assert
      expect(fsr1.shader, isNotNull);
      expect(dsr, isNotNull);
      expect(dsr.error, isNull);
      expect(fsr2.shader, isNull);
    });

    test('Delete shader by id with comments', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shader = shaderFixture('shaders/elevated.json');
      final shaderId = shader.info.id;
      await store.saveShader(shader);
      final comments = commentListFixture('comment/$shaderId.json');
      await store.saveShaderComments(comments);
      final fcr1 = await store.findCommentsByShaderId(shaderId);
      // act
      final dsr = await store.deleteShaderById(shader.info.id);
      final fcr2 = await store.findCommentsByShaderId(shaderId);
      // assert
      expect(fcr1.comments, isNotEmpty);
      expect(dsr, isNotNull);
      expect(dsr.error, isNull);
      expect(fcr2.comments, isEmpty);
    });

    test('Delete shader by id with playlist reference', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final playlistId = 'week';
      final shaderPaths = [
        'shaders/seascape.json',
        'shaders/happy_jumping.json'
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      final playlist = playlistFixture('playlist/$playlistId.json');
      await store.savePlaylist(playlist);
      await store.savePlaylistShaders(
          playlistId, shaders.map((shader) => shader.info.id).toList());
      final fspr1 = await store.findShadersByPlaylistId(playlistId);
      // act
      final dsr = await store.deleteShaderById(shaders[0].info.id);
      final fspr2 = await store.findShadersByPlaylistId(playlistId);
      // assert
      expect(fspr1.shaders, contains(FindShaderResponse(shader: shaders[0])));
      expect(dsr, isNotNull);
      expect(dsr.error, isNull);
      expect(fspr2.shaders,
          isNot(contains(FindShaderResponse(shader: shaders[0]))));
    });
  });

  group('User', () {
    test('Save user', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final userId = 'iq';
      final user = userFixture('users/$userId.json');
      // act
      final response = await store.saveUser(user);
      // assert
      expect(response, isNotNull);
      expect(response.error, isNull);
    });

    test('Save users', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final users = usersFixture(['users/iq.json', 'users/shaderflix.json']);
      // act
      final response = await store.saveUsers(users);
      // assert
      expect(response, isNotNull);
      expect(response.error, isNull);
    });

    test('Save user twice', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final userId = 'iq';
      final originalUser = userFixture('users/$userId.json');
      final updatedUser = originalUser.copyWith(followers: 1);
      // act
      await store.saveUser(originalUser);
      final savedUser1 = await store.findUserById(userId);
      await store.saveUser(updatedUser);
      final savedUser2 = await store.findUserById(userId);
      // assert
      expect(savedUser1.user, originalUser);
      expect(savedUser2.user, updatedUser);
    });

    test('Find user by id', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final user = userFixture('users/iq.json');
      await store.saveUser(user);
      // act
      final response = await store.findUserById(user.id);
      // assert
      expect(response, isNotNull);
      expect(response.error, isNull);
      expect(response.user, user);
    });

    test('Find user by id with not found response', () async {
      // prepare
      final options = newOptions();
      final userId = 'xxx';
      final store = newMoorStore(options);
      // act
      final response = await store.findUserById(userId);
      // assert
      expect(response, isNotNull);
      expect(response.error, isNotNull);
      expect(response.error,
          ResponseError.notFound(context: CONTEXT_USER, target: userId));
    });

    test('Find shaders by user id', () async {
      final options = newOptions();
      final store = newMoorStore(options);
      final userId = 'iq';
      final user = userFixture('users/$userId.json');
      await store.saveUser(user);
      final shaderPaths = [
        'shaders/clouds.json',
        'shaders/creation.json',
        'shaders/elevated.json',
        'shaders/rainforest.json',
        'shaders/raymarching_part_1.json',
        'shaders/raymarching_part_2.json',
        'shaders/raymarching_part_3.json',
        'shaders/raymarching_part_4.json',
        'shaders/raymarching_part_6.json',
        'shaders/raymarching_primitives.json',
        'shaders/seascape.json',
        'shaders/selfie_girl.json',
        'shaders/snail.json',
        'shaders/volcanic.json',
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      // act
      final response = await store.findShadersByUserId(userId);
      // assert
      final actual = response.shaders;
      final expected = _popularitySort(shaderPaths)
          .where((element) => element.shader.info.userId == userId)
          .take(options.userShaderCount);

      expect(actual, containsAllInOrder(expected));
    });

    test('Find shader ids by user id', () async {
      final options = newOptions();
      final store = newMoorStore(options);
      final userId = 'iq';
      final user = userFixture('users/$userId.json');
      await store.saveUser(user);
      final shaderPaths = [
        'shaders/clouds.json',
        'shaders/creation.json',
        'shaders/elevated.json',
        'shaders/rainforest.json',
        'shaders/raymarching_part_1.json',
        'shaders/raymarching_part_2.json',
        'shaders/raymarching_part_3.json',
        'shaders/raymarching_part_4.json',
        'shaders/raymarching_part_6.json',
        'shaders/raymarching_primitives.json',
        'shaders/seascape.json',
        'shaders/selfie_girl.json',
        'shaders/snail.json',
        'shaders/volcanic.json',
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      // act
      final response = await store.findShaderIdsByUserId(userId);
      // assert
      final actual = response.ids;
      final expected = _popularitySort(shaderPaths)
          .where((element) => element.shader.info.userId == userId)
          .take(options.userShaderCount)
          .map((e) => e.shader.info.id)
          .toList();

      expect(actual, containsAllInOrder(expected));
    });

    test('Find all shader ids by user id', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final user = userFixture('users/iq.json');
      await store.saveUser(user);
      final shaderPaths = [
        'shaders/seascape.json',
        'shaders/happy_jumping.json',
        'shaders/ladybug.json'
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      // act
      final response = await store.findAllShaderIdsByUserId(user.id);
      // assert
      expect(response, isNotNull);
      expect(response.error, isNull);
      expect(response.ids,
          findShaderIdsResponseFixture(shaderPaths.sublist(1)).ids);
    });

    test('Find all user ids', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final userPaths = ['users/iq.json', 'users/shaderflix.json'];
      final users = usersFixture(userPaths);
      await store.saveUsers(users);
      // act
      final response = await store.findAllUserIds();
      // assert
      expect(response, isNotNull);
      expect(response.error, isNull);
      expect(
          response.ids, containsAll(findUserIdsResponseFixture(userPaths).ids));
    });

    test('Find all users', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final userPaths = ['users/iq.json', 'users/shaderflix.json'];
      final users = usersFixture(userPaths);
      await store.saveUsers(users);
      // act
      final response = await store.findAllUsers();
      // assert
      expect(response, isNotNull);
      expect(response.error, isNull);
      expect(response.users,
          containsAll(findUsersResponseFixture(userPaths).users));
    });

    test('Delete user by id', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final userId = 'iq';
      final user = userFixture('users/$userId.json');
      await store.saveUser(user);
      final fur1 = await store.findUserById(user.id);
      // act
      final dur = await store.deleteUserById(user.id);
      final fur2 = await store.findUserById(user.id);
      // assert
      expect(fur1.user, isNotNull);
      expect(dur, isNotNull);
      expect(dur.error, isNull);
      expect(fur2.user, isNull);
    });
  });

  group('Comment', () {
    test('Save comment', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shader = shaderFixture('shaders/elevated.json');
      final shaderId = shader.info.id;
      await store.saveShader(shader);
      final comments = commentListFixture('comment/$shaderId.json');
      // act
      final response = await store.saveShaderComments(comments);
      // assert
      expect(response, isNotNull);
      expect(response.error, isNull);
    });

    test('Save comments twice', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shader = shaderFixture('shaders/elevated.json');
      final shaderId = shader.info.id;
      await store.saveShader(shader);
      final originalComments = commentListFixture('comment/$shaderId.json');
      final updatedComments = originalComments
          .map((comment) => comment.copyWith(text: 'test'))
          .toList();
      // act
      await store.saveShaderComments(originalComments);
      final savedComments1 = await store.findCommentsByShaderId(shaderId);
      await store.saveShaderComments(updatedComments);
      final savedComments2 = await store.findCommentsByShaderId(shaderId);
      // assert
      expect(savedComments1.comments, originalComments);
      expect(savedComments2.comments, updatedComments);
    });

    test('Find comment by id', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shader = shaderFixture('shaders/elevated.json');
      final shaderId = shader.info.id;
      await store.saveShader(shader);
      final comments = commentListFixture('comment/$shaderId.json');
      await store.saveShaderComments(comments);
      // act
      final response = await store.findCommentById(comments[0].id);
      // assert
      expect(response, isNotNull);
      expect(response.error, isNull);
      expect(response.comment, comments[0]);
    });

    test('Find all comment ids', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shader = shaderFixture('shaders/elevated.json');
      final shaderId = shader.info.id;
      await store.saveShader(shader);
      final commentPath = 'comment/$shaderId.json';
      final comments = commentListFixture(commentPath);
      await store.saveShaderComments(comments);
      // act
      final response = await store.findAllCommentIds();
      // assert
      expect(response, isNotNull);
      expect(response.error, isNull);
      expect(response.ids,
          containsAll(findCommentIdsResponseFixture(commentPath).ids));
    });

    test('Find all comments', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shader = shaderFixture('shaders/elevated.json');
      final shaderId = shader.info.id;
      await store.saveShader(shader);
      final commentPath = 'comment/$shaderId.json';
      final comments = commentListFixture(commentPath);
      await store.saveShaderComments(comments);
      // act
      final response = await store.findAllComments();
      // assert
      expect(response, isNotNull);
      expect(response.error, isNull);
      expect(response.comments,
          containsAll(findCommentsResponseFixture(commentPath).comments));
    });

    test('Delete comment by id', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final shader = shaderFixture('shaders/elevated.json');
      final shaderId = shader.info.id;
      await store.saveShader(shader);
      final comments = commentListFixture('comment/$shaderId.json');
      await store.saveShaderComments(comments);
      final fcr1 = await store.findCommentsByShaderId(shaderId);
      // act
      final dcr = await store.deleteCommentById(comments[0].id);
      final fcr2 = await store.findCommentsByShaderId(shaderId);
      // assert
      expect(fcr1.comments, isNotNull);
      expect(dcr, isNotNull);
      expect(dcr.error, isNull);
      expect(fcr2.comments, isNot(contains(comments[0].id)));
    });
  });

  group('Playlist', () {
    test('Save playlist', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final playlistId = 'week';
      final playlist = playlistFixture('playlist/$playlistId.json');
      // act
      final response = await store.savePlaylist(playlist);
      // assert
      expect(response, isNotNull);
      expect(response.error, isNull);
    });

    test('Save playlist twice', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final playlistId = 'week';
      final originalPlaylist = playlistFixture('playlist/$playlistId.json');
      final updatedPlaylist = originalPlaylist.copyWith(name: 'weekly');
      // act
      await store.savePlaylist(originalPlaylist);
      final savedPlaylist1 = await store.findPlaylistById(playlistId);
      await store.savePlaylist(updatedPlaylist);
      final savedPlaylist2 = await store.findPlaylistById(playlistId);
      // assert
      expect(savedPlaylist1.playlist, originalPlaylist);
      expect(savedPlaylist2.playlist, updatedPlaylist);
    });

    test('Save playlist with shader ids', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final playlistId = 'week';
      final shaderPaths = [
        'shaders/seascape.json',
        'shaders/happy_jumping.json'
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      final playlist = playlistFixture('playlist/$playlistId.json');
      // act
      final response = await store.savePlaylist(playlist,
          shaderIds: shaders.map((shader) => shader.info.id).toList());
      // assert
      expect(response, isNotNull);
      expect(response.error, isNull);
    });

    test('Find playlist by id with not found response', () async {
      // prepare
      final options = newOptions();
      final playlistId = 'xxx';
      final store = newMoorStore(options);
      // act
      final response = await store.findPlaylistById(playlistId);
      // assert
      expect(response, isNotNull);
      expect(response.error, isNotNull);
      expect(
          response.error,
          ResponseError.notFound(
              context: CONTEXT_PLAYLIST, target: playlistId));
    });

    test('Find all playlist ids', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final playlistId1 = 'week';
      final playlist1Path = 'playlist/$playlistId1.json';
      final playlist1 = playlistFixture(playlist1Path);
      await store.savePlaylist(playlist1);

      final playlistId2 = 'featured';
      final playlist2Path = 'playlist/$playlistId2.json';
      final playlist2 = playlistFixture(playlist2Path);
      await store.savePlaylist(playlist2);
      final playlistPaths = [playlist1Path, playlist2Path];
      // act
      final response = await store.findAllPlaylistIds();
      // assert
      expect(response, isNotNull);
      expect(response.error, isNull);
      expect(response.ids,
          containsAll(findPlaylistIdsResponseFixture(playlistPaths).ids));
    });

    test('Find all playlists', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final playlistId1 = 'week';
      final playlist1Path = 'playlist/$playlistId1.json';
      final playlist1 = playlistFixture(playlist1Path);
      await store.savePlaylist(playlist1);

      final playlistId2 = 'featured';
      final playlist2Path = 'playlist/$playlistId2.json';
      final playlist2 = playlistFixture(playlist2Path);
      await store.savePlaylist(playlist2);
      final playlistPaths = [playlist1Path, playlist2Path];
      // act
      final response = await store.findAllPlaylists();
      // assert
      expect(response, isNotNull);
      expect(response.error, isNull);
      expect(response.playlists,
          containsAll(findPlaylistsResponseFixture(playlistPaths).playlists));
    });

    test('Save playlist shaders', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final playlistId = 'week';
      final shaderPaths = [
        'shaders/seascape.json',
        'shaders/happy_jumping.json'
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      final playlist = playlistFixture('playlist/$playlistId.json');
      await store.savePlaylist(playlist);
      // act
      final response = await store.savePlaylistShaders(
          playlistId, shaders.map((shader) => shader.info.id).toList());
      // assert
      expect(response, isNotNull);
      expect(response.error, isNull);
    });

    test('Save playlist shader ids with FOREIGN KEY constraint', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final playlistId = 'week';
      final shaderPaths = [
        'shaders/seascape.json',
        'shaders/happy_jumping.json'
      ];
      final shaders = shadersFixture(shaderPaths);
      final playlist = playlistFixture('playlist/$playlistId.json');
      await store.savePlaylist(playlist);
      // act
      final response = await store.savePlaylistShaders(
          playlistId, shaders.map((shader) => shader.info.id).toList());
      // assert
      expect(response, isNotNull);
      expect(response.error, isNotNull);
      expect(
          response.error,
          ResponseError.unprocessableEntity(
              message: 'FOREIGN KEY constraint failed',
              context: CONTEXT_PLAYLIST,
              target: playlistId));
    });

    test('Save playlist shader ids', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final playlistId = 'week';
      final shaderPaths = [
        'shaders/seascape.json',
        'shaders/happy_jumping.json'
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      final playlist = playlistFixture('playlist/$playlistId.json');
      await store.savePlaylist(playlist);
      // act
      final response = await store.savePlaylistShaders(
          playlistId, shaders.map((shader) => shader.info.id).toList());
      // assert
      expect(response, isNotNull);
      expect(response.error, isNull);
    });

    test('Find shaders by playlist id', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final playlistId = 'week';
      final shaderPaths = [
        'shaders/clouds.json',
        'shaders/creation.json',
        'shaders/elevated.json',
        'shaders/rainforest.json',
        'shaders/raymarching_part_1.json',
        'shaders/raymarching_part_2.json',
        'shaders/raymarching_part_3.json',
        'shaders/raymarching_part_4.json',
        'shaders/raymarching_part_6.json',
        'shaders/raymarching_primitives.json',
        'shaders/seascape.json',
        'shaders/volcanic.json',
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      final playlist = playlistFixture('playlist/$playlistId.json');
      await store.savePlaylist(playlist);
      await store.savePlaylistShaders(
          playlistId, shaders.map((shader) => shader.info.id).toList());
      // act
      final response = await store.findShadersByPlaylistId(playlistId);
      // assert
      final actual = response.shaders;
      final expected = findShadersResponseFixture(shaderPaths).shaders;

      expect(actual, containsAllInOrder(expected));
    });

    test('Find shader ids by playlist id', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final playlistId = 'week';
      final shaderPaths = [
        'shaders/clouds.json',
        'shaders/creation.json',
        'shaders/elevated.json',
        'shaders/rainforest.json',
        'shaders/raymarching_part_1.json',
        'shaders/raymarching_part_2.json',
        'shaders/raymarching_part_3.json',
        'shaders/raymarching_part_4.json',
        'shaders/raymarching_part_6.json',
        'shaders/raymarching_primitives.json',
        'shaders/seascape.json',
        'shaders/volcanic.json',
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      final playlist = playlistFixture('playlist/$playlistId.json');
      await store.savePlaylist(playlist);
      await store.savePlaylistShaders(
          playlistId, shaders.map((shader) => shader.info.id).toList());
      // act
      final response = await store.findShaderIdsByPlaylistId(playlistId);
      // assert
      final actual = response.ids;
      final expected = findShaderIdsResponseFixture(shaderPaths).ids;

      expect(actual, containsAllInOrder(expected));
    });

    test('Find all shader ids by playlist id', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final playlistId = 'week';
      final shaderPaths = [
        'shaders/clouds.json',
        'shaders/creation.json',
        'shaders/elevated.json',
        'shaders/rainforest.json',
        'shaders/raymarching_part_1.json',
        'shaders/raymarching_part_2.json',
        'shaders/raymarching_part_3.json',
        'shaders/raymarching_part_4.json',
        'shaders/raymarching_part_6.json',
        'shaders/raymarching_primitives.json',
        'shaders/seascape.json',
        'shaders/volcanic.json',
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      final playlist = playlistFixture('playlist/$playlistId.json');
      await store.savePlaylist(playlist);
      await store.savePlaylistShaders(
          playlistId, shaders.map((shader) => shader.info.id).toList());
      // act
      final response = await store.findAllShaderIdsByPlaylistId(playlistId);
      // assert
      final actual = response.ids;
      final expected = findShaderIdsResponseFixture(shaderPaths).ids;

      expect(actual, containsAllInOrder(expected));
    });

    test('Delete playlist by id', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final playlistId = 'week';
      final playlist = playlistFixture('playlist/$playlistId.json');
      await store.savePlaylist(playlist);
      final fpr1 = await store.findPlaylistById(playlist.id);
      // act
      final dpr = await store.deletePlaylistById(playlist.id);
      final fpr2 = await store.findPlaylistById(playlist.id);
      // assert
      expect(fpr1.playlist, isNotNull);
      expect(dpr, isNotNull);
      expect(dpr.error, isNull);
      expect(fpr2.playlist, isNull);
    });

    test('Delete playlist by id with playlist reference', () async {
      // prepare
      final options = newOptions();
      final store = newMoorStore(options);
      final playlistId = 'week';
      final shaderPaths = [
        'shaders/seascape.json',
        'shaders/happy_jumping.json'
      ];
      final shaders = shadersFixture(shaderPaths);
      await store.saveShaders(shaders);
      final playlist = playlistFixture('playlist/$playlistId.json');
      await store.savePlaylist(playlist);
      await store.savePlaylistShaders(
          playlistId, shaders.map((shader) => shader.info.id).toList());
      final fspr1 = await store.findShadersByPlaylistId(playlistId);
      // act
      final dsr = await store.deletePlaylistById(playlistId);
      final fspr2 = await store.findShadersByPlaylistId(playlistId);
      // assert
      expect(fspr1.shaders, contains(FindShaderResponse(shader: shaders[0])));
      expect(dsr, isNotNull);
      expect(dsr.error, isNull);
      expect(fspr2.shaders, isEmpty);
    });
  });
}
