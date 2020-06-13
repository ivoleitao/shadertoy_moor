import 'package:moor/moor.dart';
import 'package:shadertoy_api/shadertoy_api.dart';
import 'package:shadertoy_moor/src/moor/store.dart';
import 'package:shadertoy_moor/src/moor/store_options.dart';

class ShadertoyMoorStore extends ShadertoyBaseStore {
  final MoorStore mdb;

  ShadertoyMoorStore(this.mdb);

  factory ShadertoyMoorStore.build(QueryExecutor executor,
          {List<Account> accounts}) =>
      ShadertoyMoorStore(
          MoorStore(MoorStoreOptions(executor, accounts: accounts)));

  @override
  Future<FindUserResponse> findUserById(String userId) {
    return mdb.userDao.findById(userId).then((value) => value != null
        ? FindUserResponse(user: value)
        : FindUserResponse(
            error:
                ResponseError.notFound(context: CONTEXT_USER, target: userId)));
  }

  @override
  Future<SaveUserResponse> saveUser(User user) {
    return mdb.userDao.save(user).then((reponse) => SaveUserResponse());
  }

  @override
  Future<FindAccountResponse> findAccountById(String accountId) {
    return mdb.accountDao.findById(accountId).then((value) => value != null
        ? FindAccountResponse(account: value)
        : FindAccountResponse(
            error: ResponseError.notFound(
                context: CONTEXT_ACCOUNT, target: accountId)));
  }

  @override
  Future<FindAccountsResponse> findAccounts(
      {String name, AccountType type, bool system}) {
    return mdb.accountDao.find(name: name, type: type, system: system).then(
        (results) => FindAccountsResponse(
            accounts: results
                .map((account) => FindAccountResponse(account: account))
                .toList()));
  }

  @override
  Future<SaveAccountResponse> saveAccount(Account account) {
    return mdb.accountDao
        .save(account)
        .then((reponse) => SaveAccountResponse());
  }

  @override
  Future<FindShaderResponse> findShaderById(String shaderId) {
    return mdb.shaderDao.findById(shaderId).then((value) => value != null
        ? FindShaderResponse(shader: value)
        : FindShaderResponse(
            error: ResponseError.notFound(
                context: CONTEXT_SHADER, target: shaderId)));
  }

  @override
  Future<FindShadersResponse> findShadersByIdSet(Set<String> shaderIds) {
    return Future.wait(shaderIds.map((id) => findShaderById(id).then(
            (FindShaderResponse sr) => FindShaderResponse(shader: sr.shader))))
        .then((l) => FindShadersResponse(shaders: l));
  }

  @override
  Future<FindShadersResponse> findShaders(
      {String term, Set<String> filters, Sort sort, int from, int num}) {
    return mdb.shaderDao
        .findByTerm(
            term: term, filters: filters, sort: sort, from: from, num: num)
        .then((results) => FindShadersResponse(
            shaders:
                results.map((r) => FindShaderResponse(shader: r)).toList()));
  }

  @override
  Future<FindShaderIdsResponse> findAllShaderIds() {
    return mdb.shaderDao
        .findAllIds()
        .then((value) => FindShaderIdsResponse(ids: value));
  }

  @override
  Future<FindShaderIdsResponse> findShaderIds(
      {String term, Set<String> filters, Sort sort, int from, int num}) {
    return mdb.shaderDao
        .findIdsByTerm(
            term: term, filters: filters, sort: sort, from: from, num: num)
        .then((results) => FindShaderIdsResponse(ids: results));
  }

  @override
  Future<FindCommentsResponse> findCommentsByShaderId(String shaderId) {
    return mdb.commentDao.findByShaderId(shaderId).then((results) => results !=
            null
        ? FindCommentsResponse(
            comments: results
                .map((r) => Comment(
                    shaderId: r.shaderId,
                    userId: r.userId,
                    date: r.date,
                    text: r.text))
                .toList())
        : FindCommentsResponse(
            error: ResponseError.notFound(
                context: CONTEXT_COMMENT, target: shaderId)));
  }

  @override
  Future<FindShadersResponse> findShadersByUserId(String userId,
      {Set<String> filters, Sort sort, int from, int num}) {
    return mdb.shaderDao
        .findByUser(
            userId: userId, filters: filters, sort: sort, from: from, num: num)
        .then((results) => FindShadersResponse(
            shaders: results.map((r) => FindShaderResponse(shader: r))));
  }

  @override
  Future<FindShaderIdsResponse> findShaderIdsByUserId(String userId,
      {Set<String> filters, Sort sort, int from, int num}) {
    return mdb.shaderDao
        .findIdsByUser(
            userId: userId, filters: filters, sort: sort, from: from, num: num)
        .then((results) => FindShaderIdsResponse(ids: results.toList()));
  }

  @override
  Future<FindPlaylistResponse> findPlaylistById(String playlistId) {
    return mdb.playlistDao.findById(playlistId).then((playlist) =>
        playlist != null
            ? FindPlaylistResponse(playlist: playlist)
            : FindPlaylistResponse(
                error: ResponseError.notFound(
                    context: CONTEXT_COMMENT, target: playlistId)));
  }

  @override
  Future<FindShadersResponse> findShadersByPlaylistId(String playlistId,
      {int from, int num}) {
    return mdb.shaderDao.findByPlaylist(playlistId, from: from, num: num).then(
        (results) => FindShadersResponse(
            shaders:
                results.map((r) => FindShaderResponse(shader: r)).toList()));
  }

  @override
  Future<FindShaderIdsResponse> findShaderIdsByPlaylistId(String playlistId,
      {int from, int num}) {
    return mdb.shaderDao
        .findIdsByPlaylist(playlistId, from: from, num: num)
        .then((results) => FindShaderIdsResponse(ids: results));
  }

  @override
  Future<SaveShaderResponse> saveShader(Shader shader) {
    return mdb.shaderDao.save(shader).then((reponse) => SaveShaderResponse());
  }

  @override
  Future<SaveShaderCommentsResponse> saveShaderComments(
      String shaderId, List<Comment> comments) {
    return mdb.commentDao
        .save(comments)
        .then((reponse) => SaveShaderCommentsResponse());
  }

  @override
  Future<SavePlaylistResponse> savePlaylist(Playlist playlist) {
    return mdb.playlistDao
        .save(playlist)
        .then((reponse) => SavePlaylistResponse());
  }
}
