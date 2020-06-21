// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class UserEntry extends DataClass implements Insertable<UserEntry> {
  final String id;
  final String picture;
  final DateTime memberSince;
  final int shaders;
  final int comments;
  final String about;
  UserEntry(
      {@required this.id,
      this.picture,
      this.memberSince,
      this.shaders,
      this.comments,
      this.about});
  factory UserEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final intType = db.typeSystem.forDartType<int>();
    return UserEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      picture:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}picture']),
      memberSince: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}member_since']),
      shaders:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}shaders']),
      comments:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}comments']),
      about:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}about']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || picture != null) {
      map['picture'] = Variable<String>(picture);
    }
    if (!nullToAbsent || memberSince != null) {
      map['member_since'] = Variable<DateTime>(memberSince);
    }
    if (!nullToAbsent || shaders != null) {
      map['shaders'] = Variable<int>(shaders);
    }
    if (!nullToAbsent || comments != null) {
      map['comments'] = Variable<int>(comments);
    }
    if (!nullToAbsent || about != null) {
      map['about'] = Variable<String>(about);
    }
    return map;
  }

  UserTableCompanion toCompanion(bool nullToAbsent) {
    return UserTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      picture: picture == null && nullToAbsent
          ? const Value.absent()
          : Value(picture),
      memberSince: memberSince == null && nullToAbsent
          ? const Value.absent()
          : Value(memberSince),
      shaders: shaders == null && nullToAbsent
          ? const Value.absent()
          : Value(shaders),
      comments: comments == null && nullToAbsent
          ? const Value.absent()
          : Value(comments),
      about:
          about == null && nullToAbsent ? const Value.absent() : Value(about),
    );
  }

  factory UserEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return UserEntry(
      id: serializer.fromJson<String>(json['id']),
      picture: serializer.fromJson<String>(json['picture']),
      memberSince: serializer.fromJson<DateTime>(json['memberSince']),
      shaders: serializer.fromJson<int>(json['shaders']),
      comments: serializer.fromJson<int>(json['comments']),
      about: serializer.fromJson<String>(json['about']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'picture': serializer.toJson<String>(picture),
      'memberSince': serializer.toJson<DateTime>(memberSince),
      'shaders': serializer.toJson<int>(shaders),
      'comments': serializer.toJson<int>(comments),
      'about': serializer.toJson<String>(about),
    };
  }

  UserEntry copyWith(
          {String id,
          String picture,
          DateTime memberSince,
          int shaders,
          int comments,
          String about}) =>
      UserEntry(
        id: id ?? this.id,
        picture: picture ?? this.picture,
        memberSince: memberSince ?? this.memberSince,
        shaders: shaders ?? this.shaders,
        comments: comments ?? this.comments,
        about: about ?? this.about,
      );
  @override
  String toString() {
    return (StringBuffer('UserEntry(')
          ..write('id: $id, ')
          ..write('picture: $picture, ')
          ..write('memberSince: $memberSince, ')
          ..write('shaders: $shaders, ')
          ..write('comments: $comments, ')
          ..write('about: $about')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          picture.hashCode,
          $mrjc(
              memberSince.hashCode,
              $mrjc(shaders.hashCode,
                  $mrjc(comments.hashCode, about.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is UserEntry &&
          other.id == this.id &&
          other.picture == this.picture &&
          other.memberSince == this.memberSince &&
          other.shaders == this.shaders &&
          other.comments == this.comments &&
          other.about == this.about);
}

class UserTableCompanion extends UpdateCompanion<UserEntry> {
  final Value<String> id;
  final Value<String> picture;
  final Value<DateTime> memberSince;
  final Value<int> shaders;
  final Value<int> comments;
  final Value<String> about;
  const UserTableCompanion({
    this.id = const Value.absent(),
    this.picture = const Value.absent(),
    this.memberSince = const Value.absent(),
    this.shaders = const Value.absent(),
    this.comments = const Value.absent(),
    this.about = const Value.absent(),
  });
  UserTableCompanion.insert({
    @required String id,
    this.picture = const Value.absent(),
    this.memberSince = const Value.absent(),
    this.shaders = const Value.absent(),
    this.comments = const Value.absent(),
    this.about = const Value.absent(),
  }) : id = Value(id);
  static Insertable<UserEntry> custom({
    Expression<String> id,
    Expression<String> picture,
    Expression<DateTime> memberSince,
    Expression<int> shaders,
    Expression<int> comments,
    Expression<String> about,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (picture != null) 'picture': picture,
      if (memberSince != null) 'member_since': memberSince,
      if (shaders != null) 'shaders': shaders,
      if (comments != null) 'comments': comments,
      if (about != null) 'about': about,
    });
  }

  UserTableCompanion copyWith(
      {Value<String> id,
      Value<String> picture,
      Value<DateTime> memberSince,
      Value<int> shaders,
      Value<int> comments,
      Value<String> about}) {
    return UserTableCompanion(
      id: id ?? this.id,
      picture: picture ?? this.picture,
      memberSince: memberSince ?? this.memberSince,
      shaders: shaders ?? this.shaders,
      comments: comments ?? this.comments,
      about: about ?? this.about,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (picture.present) {
      map['picture'] = Variable<String>(picture.value);
    }
    if (memberSince.present) {
      map['member_since'] = Variable<DateTime>(memberSince.value);
    }
    if (shaders.present) {
      map['shaders'] = Variable<int>(shaders.value);
    }
    if (comments.present) {
      map['comments'] = Variable<int>(comments.value);
    }
    if (about.present) {
      map['about'] = Variable<String>(about.value);
    }
    return map;
  }
}

class $UserTableTable extends UserTable
    with TableInfo<$UserTableTable, UserEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $UserTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _pictureMeta = const VerificationMeta('picture');
  GeneratedTextColumn _picture;
  @override
  GeneratedTextColumn get picture => _picture ??= _constructPicture();
  GeneratedTextColumn _constructPicture() {
    return GeneratedTextColumn(
      'picture',
      $tableName,
      true,
    );
  }

  final VerificationMeta _memberSinceMeta =
      const VerificationMeta('memberSince');
  GeneratedDateTimeColumn _memberSince;
  @override
  GeneratedDateTimeColumn get memberSince =>
      _memberSince ??= _constructMemberSince();
  GeneratedDateTimeColumn _constructMemberSince() {
    return GeneratedDateTimeColumn(
      'member_since',
      $tableName,
      true,
    );
  }

  final VerificationMeta _shadersMeta = const VerificationMeta('shaders');
  GeneratedIntColumn _shaders;
  @override
  GeneratedIntColumn get shaders => _shaders ??= _constructShaders();
  GeneratedIntColumn _constructShaders() {
    return GeneratedIntColumn(
      'shaders',
      $tableName,
      true,
    );
  }

  final VerificationMeta _commentsMeta = const VerificationMeta('comments');
  GeneratedIntColumn _comments;
  @override
  GeneratedIntColumn get comments => _comments ??= _constructComments();
  GeneratedIntColumn _constructComments() {
    return GeneratedIntColumn(
      'comments',
      $tableName,
      true,
    );
  }

  final VerificationMeta _aboutMeta = const VerificationMeta('about');
  GeneratedTextColumn _about;
  @override
  GeneratedTextColumn get about => _about ??= _constructAbout();
  GeneratedTextColumn _constructAbout() {
    return GeneratedTextColumn(
      'about',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, picture, memberSince, shaders, comments, about];
  @override
  $UserTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'User';
  @override
  final String actualTableName = 'User';
  @override
  VerificationContext validateIntegrity(Insertable<UserEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('picture')) {
      context.handle(_pictureMeta,
          picture.isAcceptableOrUnknown(data['picture'], _pictureMeta));
    }
    if (data.containsKey('member_since')) {
      context.handle(
          _memberSinceMeta,
          memberSince.isAcceptableOrUnknown(
              data['member_since'], _memberSinceMeta));
    }
    if (data.containsKey('shaders')) {
      context.handle(_shadersMeta,
          shaders.isAcceptableOrUnknown(data['shaders'], _shadersMeta));
    }
    if (data.containsKey('comments')) {
      context.handle(_commentsMeta,
          comments.isAcceptableOrUnknown(data['comments'], _commentsMeta));
    }
    if (data.containsKey('about')) {
      context.handle(
          _aboutMeta, about.isAcceptableOrUnknown(data['about'], _aboutMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return UserEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $UserTableTable createAlias(String alias) {
    return $UserTableTable(_db, alias);
  }
}

class AccountEntry extends DataClass implements Insertable<AccountEntry> {
  final String name;
  final String type;
  final bool system;
  final String password;
  final String displayName;
  final String picture;
  AccountEntry(
      {@required this.name,
      @required this.type,
      @required this.system,
      this.password,
      this.displayName,
      this.picture});
  factory AccountEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return AccountEntry(
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      type: stringType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
      system:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}system']),
      password: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}password']),
      displayName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}display_name']),
      picture:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}picture']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || system != null) {
      map['system'] = Variable<bool>(system);
    }
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String>(password);
    }
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || picture != null) {
      map['picture'] = Variable<String>(picture);
    }
    return map;
  }

  AccountTableCompanion toCompanion(bool nullToAbsent) {
    return AccountTableCompanion(
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      system:
          system == null && nullToAbsent ? const Value.absent() : Value(system),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      picture: picture == null && nullToAbsent
          ? const Value.absent()
          : Value(picture),
    );
  }

  factory AccountEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return AccountEntry(
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      system: serializer.fromJson<bool>(json['system']),
      password: serializer.fromJson<String>(json['password']),
      displayName: serializer.fromJson<String>(json['displayName']),
      picture: serializer.fromJson<String>(json['picture']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'system': serializer.toJson<bool>(system),
      'password': serializer.toJson<String>(password),
      'displayName': serializer.toJson<String>(displayName),
      'picture': serializer.toJson<String>(picture),
    };
  }

  AccountEntry copyWith(
          {String name,
          String type,
          bool system,
          String password,
          String displayName,
          String picture}) =>
      AccountEntry(
        name: name ?? this.name,
        type: type ?? this.type,
        system: system ?? this.system,
        password: password ?? this.password,
        displayName: displayName ?? this.displayName,
        picture: picture ?? this.picture,
      );
  @override
  String toString() {
    return (StringBuffer('AccountEntry(')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('system: $system, ')
          ..write('password: $password, ')
          ..write('displayName: $displayName, ')
          ..write('picture: $picture')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      name.hashCode,
      $mrjc(
          type.hashCode,
          $mrjc(
              system.hashCode,
              $mrjc(password.hashCode,
                  $mrjc(displayName.hashCode, picture.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is AccountEntry &&
          other.name == this.name &&
          other.type == this.type &&
          other.system == this.system &&
          other.password == this.password &&
          other.displayName == this.displayName &&
          other.picture == this.picture);
}

class AccountTableCompanion extends UpdateCompanion<AccountEntry> {
  final Value<String> name;
  final Value<String> type;
  final Value<bool> system;
  final Value<String> password;
  final Value<String> displayName;
  final Value<String> picture;
  const AccountTableCompanion({
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.system = const Value.absent(),
    this.password = const Value.absent(),
    this.displayName = const Value.absent(),
    this.picture = const Value.absent(),
  });
  AccountTableCompanion.insert({
    @required String name,
    @required String type,
    @required bool system,
    this.password = const Value.absent(),
    this.displayName = const Value.absent(),
    this.picture = const Value.absent(),
  })  : name = Value(name),
        type = Value(type),
        system = Value(system);
  static Insertable<AccountEntry> custom({
    Expression<String> name,
    Expression<String> type,
    Expression<bool> system,
    Expression<String> password,
    Expression<String> displayName,
    Expression<String> picture,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (system != null) 'system': system,
      if (password != null) 'password': password,
      if (displayName != null) 'display_name': displayName,
      if (picture != null) 'picture': picture,
    });
  }

  AccountTableCompanion copyWith(
      {Value<String> name,
      Value<String> type,
      Value<bool> system,
      Value<String> password,
      Value<String> displayName,
      Value<String> picture}) {
    return AccountTableCompanion(
      name: name ?? this.name,
      type: type ?? this.type,
      system: system ?? this.system,
      password: password ?? this.password,
      displayName: displayName ?? this.displayName,
      picture: picture ?? this.picture,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (system.present) {
      map['system'] = Variable<bool>(system.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (picture.present) {
      map['picture'] = Variable<String>(picture.value);
    }
    return map;
  }
}

class $AccountTableTable extends AccountTable
    with TableInfo<$AccountTableTable, AccountEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $AccountTableTable(this._db, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedTextColumn _type;
  @override
  GeneratedTextColumn get type => _type ??= _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn(
      'type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _systemMeta = const VerificationMeta('system');
  GeneratedBoolColumn _system;
  @override
  GeneratedBoolColumn get system => _system ??= _constructSystem();
  GeneratedBoolColumn _constructSystem() {
    return GeneratedBoolColumn(
      'system',
      $tableName,
      false,
    );
  }

  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  GeneratedTextColumn _password;
  @override
  GeneratedTextColumn get password => _password ??= _constructPassword();
  GeneratedTextColumn _constructPassword() {
    return GeneratedTextColumn(
      'password',
      $tableName,
      true,
    );
  }

  final VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  GeneratedTextColumn _displayName;
  @override
  GeneratedTextColumn get displayName =>
      _displayName ??= _constructDisplayName();
  GeneratedTextColumn _constructDisplayName() {
    return GeneratedTextColumn(
      'display_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _pictureMeta = const VerificationMeta('picture');
  GeneratedTextColumn _picture;
  @override
  GeneratedTextColumn get picture => _picture ??= _constructPicture();
  GeneratedTextColumn _constructPicture() {
    return GeneratedTextColumn(
      'picture',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [name, type, system, password, displayName, picture];
  @override
  $AccountTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'Account';
  @override
  final String actualTableName = 'Account';
  @override
  VerificationContext validateIntegrity(Insertable<AccountEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type'], _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('system')) {
      context.handle(_systemMeta,
          system.isAcceptableOrUnknown(data['system'], _systemMeta));
    } else if (isInserting) {
      context.missing(_systemMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password'], _passwordMeta));
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name'], _displayNameMeta));
    }
    if (data.containsKey('picture')) {
      context.handle(_pictureMeta,
          picture.isAcceptableOrUnknown(data['picture'], _pictureMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  AccountEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return AccountEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $AccountTableTable createAlias(String alias) {
    return $AccountTableTable(_db, alias);
  }
}

class ShaderEntry extends DataClass implements Insertable<ShaderEntry> {
  final String id;
  final String userId;
  final String version;
  final String name;
  final DateTime date;
  final String description;
  final int views;
  final int likes;
  final String publishStatus;
  final int flags;
  final String tagsJson;
  final bool liked;
  final String renderPassesJson;
  ShaderEntry(
      {@required this.id,
      @required this.userId,
      @required this.version,
      @required this.name,
      @required this.date,
      this.description,
      @required this.views,
      @required this.likes,
      this.publishStatus,
      @required this.flags,
      @required this.tagsJson,
      @required this.liked,
      @required this.renderPassesJson});
  factory ShaderEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final intType = db.typeSystem.forDartType<int>();
    final boolType = db.typeSystem.forDartType<bool>();
    return ShaderEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      userId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
      version:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}version']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      views: intType.mapFromDatabaseResponse(data['${effectivePrefix}views']),
      likes: intType.mapFromDatabaseResponse(data['${effectivePrefix}likes']),
      publishStatus: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}publish_status']),
      flags: intType.mapFromDatabaseResponse(data['${effectivePrefix}flags']),
      tagsJson: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}tags_json']),
      liked: boolType.mapFromDatabaseResponse(data['${effectivePrefix}liked']),
      renderPassesJson: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}render_passes_json']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || version != null) {
      map['version'] = Variable<String>(version);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || views != null) {
      map['views'] = Variable<int>(views);
    }
    if (!nullToAbsent || likes != null) {
      map['likes'] = Variable<int>(likes);
    }
    if (!nullToAbsent || publishStatus != null) {
      map['publish_status'] = Variable<String>(publishStatus);
    }
    if (!nullToAbsent || flags != null) {
      map['flags'] = Variable<int>(flags);
    }
    if (!nullToAbsent || tagsJson != null) {
      map['tags_json'] = Variable<String>(tagsJson);
    }
    if (!nullToAbsent || liked != null) {
      map['liked'] = Variable<bool>(liked);
    }
    if (!nullToAbsent || renderPassesJson != null) {
      map['render_passes_json'] = Variable<String>(renderPassesJson);
    }
    return map;
  }

  ShaderTableCompanion toCompanion(bool nullToAbsent) {
    return ShaderTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      version: version == null && nullToAbsent
          ? const Value.absent()
          : Value(version),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      views:
          views == null && nullToAbsent ? const Value.absent() : Value(views),
      likes:
          likes == null && nullToAbsent ? const Value.absent() : Value(likes),
      publishStatus: publishStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(publishStatus),
      flags:
          flags == null && nullToAbsent ? const Value.absent() : Value(flags),
      tagsJson: tagsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(tagsJson),
      liked:
          liked == null && nullToAbsent ? const Value.absent() : Value(liked),
      renderPassesJson: renderPassesJson == null && nullToAbsent
          ? const Value.absent()
          : Value(renderPassesJson),
    );
  }

  factory ShaderEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ShaderEntry(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      version: serializer.fromJson<String>(json['version']),
      name: serializer.fromJson<String>(json['name']),
      date: serializer.fromJson<DateTime>(json['date']),
      description: serializer.fromJson<String>(json['description']),
      views: serializer.fromJson<int>(json['views']),
      likes: serializer.fromJson<int>(json['likes']),
      publishStatus: serializer.fromJson<String>(json['publishStatus']),
      flags: serializer.fromJson<int>(json['flags']),
      tagsJson: serializer.fromJson<String>(json['tagsJson']),
      liked: serializer.fromJson<bool>(json['liked']),
      renderPassesJson: serializer.fromJson<String>(json['renderPassesJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'version': serializer.toJson<String>(version),
      'name': serializer.toJson<String>(name),
      'date': serializer.toJson<DateTime>(date),
      'description': serializer.toJson<String>(description),
      'views': serializer.toJson<int>(views),
      'likes': serializer.toJson<int>(likes),
      'publishStatus': serializer.toJson<String>(publishStatus),
      'flags': serializer.toJson<int>(flags),
      'tagsJson': serializer.toJson<String>(tagsJson),
      'liked': serializer.toJson<bool>(liked),
      'renderPassesJson': serializer.toJson<String>(renderPassesJson),
    };
  }

  ShaderEntry copyWith(
          {String id,
          String userId,
          String version,
          String name,
          DateTime date,
          String description,
          int views,
          int likes,
          String publishStatus,
          int flags,
          String tagsJson,
          bool liked,
          String renderPassesJson}) =>
      ShaderEntry(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        version: version ?? this.version,
        name: name ?? this.name,
        date: date ?? this.date,
        description: description ?? this.description,
        views: views ?? this.views,
        likes: likes ?? this.likes,
        publishStatus: publishStatus ?? this.publishStatus,
        flags: flags ?? this.flags,
        tagsJson: tagsJson ?? this.tagsJson,
        liked: liked ?? this.liked,
        renderPassesJson: renderPassesJson ?? this.renderPassesJson,
      );
  @override
  String toString() {
    return (StringBuffer('ShaderEntry(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('version: $version, ')
          ..write('name: $name, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('views: $views, ')
          ..write('likes: $likes, ')
          ..write('publishStatus: $publishStatus, ')
          ..write('flags: $flags, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('liked: $liked, ')
          ..write('renderPassesJson: $renderPassesJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          userId.hashCode,
          $mrjc(
              version.hashCode,
              $mrjc(
                  name.hashCode,
                  $mrjc(
                      date.hashCode,
                      $mrjc(
                          description.hashCode,
                          $mrjc(
                              views.hashCode,
                              $mrjc(
                                  likes.hashCode,
                                  $mrjc(
                                      publishStatus.hashCode,
                                      $mrjc(
                                          flags.hashCode,
                                          $mrjc(
                                              tagsJson.hashCode,
                                              $mrjc(
                                                  liked.hashCode,
                                                  renderPassesJson
                                                      .hashCode)))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ShaderEntry &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.version == this.version &&
          other.name == this.name &&
          other.date == this.date &&
          other.description == this.description &&
          other.views == this.views &&
          other.likes == this.likes &&
          other.publishStatus == this.publishStatus &&
          other.flags == this.flags &&
          other.tagsJson == this.tagsJson &&
          other.liked == this.liked &&
          other.renderPassesJson == this.renderPassesJson);
}

class ShaderTableCompanion extends UpdateCompanion<ShaderEntry> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> version;
  final Value<String> name;
  final Value<DateTime> date;
  final Value<String> description;
  final Value<int> views;
  final Value<int> likes;
  final Value<String> publishStatus;
  final Value<int> flags;
  final Value<String> tagsJson;
  final Value<bool> liked;
  final Value<String> renderPassesJson;
  const ShaderTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.version = const Value.absent(),
    this.name = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
    this.views = const Value.absent(),
    this.likes = const Value.absent(),
    this.publishStatus = const Value.absent(),
    this.flags = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.liked = const Value.absent(),
    this.renderPassesJson = const Value.absent(),
  });
  ShaderTableCompanion.insert({
    @required String id,
    @required String userId,
    @required String version,
    @required String name,
    @required DateTime date,
    this.description = const Value.absent(),
    this.views = const Value.absent(),
    this.likes = const Value.absent(),
    this.publishStatus = const Value.absent(),
    this.flags = const Value.absent(),
    @required String tagsJson,
    this.liked = const Value.absent(),
    @required String renderPassesJson,
  })  : id = Value(id),
        userId = Value(userId),
        version = Value(version),
        name = Value(name),
        date = Value(date),
        tagsJson = Value(tagsJson),
        renderPassesJson = Value(renderPassesJson);
  static Insertable<ShaderEntry> custom({
    Expression<String> id,
    Expression<String> userId,
    Expression<String> version,
    Expression<String> name,
    Expression<DateTime> date,
    Expression<String> description,
    Expression<int> views,
    Expression<int> likes,
    Expression<String> publishStatus,
    Expression<int> flags,
    Expression<String> tagsJson,
    Expression<bool> liked,
    Expression<String> renderPassesJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (version != null) 'version': version,
      if (name != null) 'name': name,
      if (date != null) 'date': date,
      if (description != null) 'description': description,
      if (views != null) 'views': views,
      if (likes != null) 'likes': likes,
      if (publishStatus != null) 'publish_status': publishStatus,
      if (flags != null) 'flags': flags,
      if (tagsJson != null) 'tags_json': tagsJson,
      if (liked != null) 'liked': liked,
      if (renderPassesJson != null) 'render_passes_json': renderPassesJson,
    });
  }

  ShaderTableCompanion copyWith(
      {Value<String> id,
      Value<String> userId,
      Value<String> version,
      Value<String> name,
      Value<DateTime> date,
      Value<String> description,
      Value<int> views,
      Value<int> likes,
      Value<String> publishStatus,
      Value<int> flags,
      Value<String> tagsJson,
      Value<bool> liked,
      Value<String> renderPassesJson}) {
    return ShaderTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      version: version ?? this.version,
      name: name ?? this.name,
      date: date ?? this.date,
      description: description ?? this.description,
      views: views ?? this.views,
      likes: likes ?? this.likes,
      publishStatus: publishStatus ?? this.publishStatus,
      flags: flags ?? this.flags,
      tagsJson: tagsJson ?? this.tagsJson,
      liked: liked ?? this.liked,
      renderPassesJson: renderPassesJson ?? this.renderPassesJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (views.present) {
      map['views'] = Variable<int>(views.value);
    }
    if (likes.present) {
      map['likes'] = Variable<int>(likes.value);
    }
    if (publishStatus.present) {
      map['publish_status'] = Variable<String>(publishStatus.value);
    }
    if (flags.present) {
      map['flags'] = Variable<int>(flags.value);
    }
    if (tagsJson.present) {
      map['tags_json'] = Variable<String>(tagsJson.value);
    }
    if (liked.present) {
      map['liked'] = Variable<bool>(liked.value);
    }
    if (renderPassesJson.present) {
      map['render_passes_json'] = Variable<String>(renderPassesJson.value);
    }
    return map;
  }
}

class $ShaderTableTable extends ShaderTable
    with TableInfo<$ShaderTableTable, ShaderEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $ShaderTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  GeneratedTextColumn _userId;
  @override
  GeneratedTextColumn get userId => _userId ??= _constructUserId();
  GeneratedTextColumn _constructUserId() {
    return GeneratedTextColumn(
      'user_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _versionMeta = const VerificationMeta('version');
  GeneratedTextColumn _version;
  @override
  GeneratedTextColumn get version => _version ??= _constructVersion();
  GeneratedTextColumn _constructVersion() {
    return GeneratedTextColumn(
      'version',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      true,
    );
  }

  final VerificationMeta _viewsMeta = const VerificationMeta('views');
  GeneratedIntColumn _views;
  @override
  GeneratedIntColumn get views => _views ??= _constructViews();
  GeneratedIntColumn _constructViews() {
    return GeneratedIntColumn('views', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _likesMeta = const VerificationMeta('likes');
  GeneratedIntColumn _likes;
  @override
  GeneratedIntColumn get likes => _likes ??= _constructLikes();
  GeneratedIntColumn _constructLikes() {
    return GeneratedIntColumn('likes', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _publishStatusMeta =
      const VerificationMeta('publishStatus');
  GeneratedTextColumn _publishStatus;
  @override
  GeneratedTextColumn get publishStatus =>
      _publishStatus ??= _constructPublishStatus();
  GeneratedTextColumn _constructPublishStatus() {
    return GeneratedTextColumn(
      'publish_status',
      $tableName,
      true,
    );
  }

  final VerificationMeta _flagsMeta = const VerificationMeta('flags');
  GeneratedIntColumn _flags;
  @override
  GeneratedIntColumn get flags => _flags ??= _constructFlags();
  GeneratedIntColumn _constructFlags() {
    return GeneratedIntColumn('flags', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _tagsJsonMeta = const VerificationMeta('tagsJson');
  GeneratedTextColumn _tagsJson;
  @override
  GeneratedTextColumn get tagsJson => _tagsJson ??= _constructTagsJson();
  GeneratedTextColumn _constructTagsJson() {
    return GeneratedTextColumn(
      'tags_json',
      $tableName,
      false,
    );
  }

  final VerificationMeta _likedMeta = const VerificationMeta('liked');
  GeneratedBoolColumn _liked;
  @override
  GeneratedBoolColumn get liked => _liked ??= _constructLiked();
  GeneratedBoolColumn _constructLiked() {
    return GeneratedBoolColumn('liked', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _renderPassesJsonMeta =
      const VerificationMeta('renderPassesJson');
  GeneratedTextColumn _renderPassesJson;
  @override
  GeneratedTextColumn get renderPassesJson =>
      _renderPassesJson ??= _constructRenderPassesJson();
  GeneratedTextColumn _constructRenderPassesJson() {
    return GeneratedTextColumn(
      'render_passes_json',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        version,
        name,
        date,
        description,
        views,
        likes,
        publishStatus,
        flags,
        tagsJson,
        liked,
        renderPassesJson
      ];
  @override
  $ShaderTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'Shader';
  @override
  final String actualTableName = 'Shader';
  @override
  VerificationContext validateIntegrity(Insertable<ShaderEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id'], _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version'], _versionMeta));
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    }
    if (data.containsKey('views')) {
      context.handle(
          _viewsMeta, views.isAcceptableOrUnknown(data['views'], _viewsMeta));
    }
    if (data.containsKey('likes')) {
      context.handle(
          _likesMeta, likes.isAcceptableOrUnknown(data['likes'], _likesMeta));
    }
    if (data.containsKey('publish_status')) {
      context.handle(
          _publishStatusMeta,
          publishStatus.isAcceptableOrUnknown(
              data['publish_status'], _publishStatusMeta));
    }
    if (data.containsKey('flags')) {
      context.handle(
          _flagsMeta, flags.isAcceptableOrUnknown(data['flags'], _flagsMeta));
    }
    if (data.containsKey('tags_json')) {
      context.handle(_tagsJsonMeta,
          tagsJson.isAcceptableOrUnknown(data['tags_json'], _tagsJsonMeta));
    } else if (isInserting) {
      context.missing(_tagsJsonMeta);
    }
    if (data.containsKey('liked')) {
      context.handle(
          _likedMeta, liked.isAcceptableOrUnknown(data['liked'], _likedMeta));
    }
    if (data.containsKey('render_passes_json')) {
      context.handle(
          _renderPassesJsonMeta,
          renderPassesJson.isAcceptableOrUnknown(
              data['render_passes_json'], _renderPassesJsonMeta));
    } else if (isInserting) {
      context.missing(_renderPassesJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShaderEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ShaderEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ShaderTableTable createAlias(String alias) {
    return $ShaderTableTable(_db, alias);
  }
}

class CommentEntry extends DataClass implements Insertable<CommentEntry> {
  final String shaderId;
  final String userId;
  final DateTime date;
  final String comment;
  CommentEntry(
      {@required this.shaderId,
      @required this.userId,
      @required this.date,
      @required this.comment});
  factory CommentEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return CommentEntry(
      shaderId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}shader_id']),
      userId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      comment:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}comment']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || shaderId != null) {
      map['shader_id'] = Variable<String>(shaderId);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    return map;
  }

  CommentTableCompanion toCompanion(bool nullToAbsent) {
    return CommentTableCompanion(
      shaderId: shaderId == null && nullToAbsent
          ? const Value.absent()
          : Value(shaderId),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
    );
  }

  factory CommentEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CommentEntry(
      shaderId: serializer.fromJson<String>(json['shaderId']),
      userId: serializer.fromJson<String>(json['userId']),
      date: serializer.fromJson<DateTime>(json['date']),
      comment: serializer.fromJson<String>(json['comment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'shaderId': serializer.toJson<String>(shaderId),
      'userId': serializer.toJson<String>(userId),
      'date': serializer.toJson<DateTime>(date),
      'comment': serializer.toJson<String>(comment),
    };
  }

  CommentEntry copyWith(
          {String shaderId, String userId, DateTime date, String comment}) =>
      CommentEntry(
        shaderId: shaderId ?? this.shaderId,
        userId: userId ?? this.userId,
        date: date ?? this.date,
        comment: comment ?? this.comment,
      );
  @override
  String toString() {
    return (StringBuffer('CommentEntry(')
          ..write('shaderId: $shaderId, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('comment: $comment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(shaderId.hashCode,
      $mrjc(userId.hashCode, $mrjc(date.hashCode, comment.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is CommentEntry &&
          other.shaderId == this.shaderId &&
          other.userId == this.userId &&
          other.date == this.date &&
          other.comment == this.comment);
}

class CommentTableCompanion extends UpdateCompanion<CommentEntry> {
  final Value<String> shaderId;
  final Value<String> userId;
  final Value<DateTime> date;
  final Value<String> comment;
  const CommentTableCompanion({
    this.shaderId = const Value.absent(),
    this.userId = const Value.absent(),
    this.date = const Value.absent(),
    this.comment = const Value.absent(),
  });
  CommentTableCompanion.insert({
    @required String shaderId,
    @required String userId,
    @required DateTime date,
    @required String comment,
  })  : shaderId = Value(shaderId),
        userId = Value(userId),
        date = Value(date),
        comment = Value(comment);
  static Insertable<CommentEntry> custom({
    Expression<String> shaderId,
    Expression<String> userId,
    Expression<DateTime> date,
    Expression<String> comment,
  }) {
    return RawValuesInsertable({
      if (shaderId != null) 'shader_id': shaderId,
      if (userId != null) 'user_id': userId,
      if (date != null) 'date': date,
      if (comment != null) 'comment': comment,
    });
  }

  CommentTableCompanion copyWith(
      {Value<String> shaderId,
      Value<String> userId,
      Value<DateTime> date,
      Value<String> comment}) {
    return CommentTableCompanion(
      shaderId: shaderId ?? this.shaderId,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      comment: comment ?? this.comment,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (shaderId.present) {
      map['shader_id'] = Variable<String>(shaderId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    return map;
  }
}

class $CommentTableTable extends CommentTable
    with TableInfo<$CommentTableTable, CommentEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $CommentTableTable(this._db, [this._alias]);
  final VerificationMeta _shaderIdMeta = const VerificationMeta('shaderId');
  GeneratedTextColumn _shaderId;
  @override
  GeneratedTextColumn get shaderId => _shaderId ??= _constructShaderId();
  GeneratedTextColumn _constructShaderId() {
    return GeneratedTextColumn('shader_id', $tableName, false,
        $customConstraints: 'REFERENCES Shader(id)');
  }

  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  GeneratedTextColumn _userId;
  @override
  GeneratedTextColumn get userId => _userId ??= _constructUserId();
  GeneratedTextColumn _constructUserId() {
    return GeneratedTextColumn(
      'user_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _commentMeta = const VerificationMeta('comment');
  GeneratedTextColumn _comment;
  @override
  GeneratedTextColumn get comment => _comment ??= _constructComment();
  GeneratedTextColumn _constructComment() {
    return GeneratedTextColumn(
      'comment',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [shaderId, userId, date, comment];
  @override
  $CommentTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'Comment';
  @override
  final String actualTableName = 'Comment';
  @override
  VerificationContext validateIntegrity(Insertable<CommentEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('shader_id')) {
      context.handle(_shaderIdMeta,
          shaderId.isAcceptableOrUnknown(data['shader_id'], _shaderIdMeta));
    } else if (isInserting) {
      context.missing(_shaderIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id'], _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('comment')) {
      context.handle(_commentMeta,
          comment.isAcceptableOrUnknown(data['comment'], _commentMeta));
    } else if (isInserting) {
      context.missing(_commentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {shaderId, userId};
  @override
  CommentEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CommentEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CommentTableTable createAlias(String alias) {
    return $CommentTableTable(_db, alias);
  }
}

class PlaylistEntry extends DataClass implements Insertable<PlaylistEntry> {
  final String id;
  final String name;
  PlaylistEntry({@required this.id, @required this.name});
  factory PlaylistEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return PlaylistEntry(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  PlaylistTableCompanion toCompanion(bool nullToAbsent) {
    return PlaylistTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  factory PlaylistEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PlaylistEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  PlaylistEntry copyWith({String id, String name}) => PlaylistEntry(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('PlaylistEntry(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, name.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is PlaylistEntry &&
          other.id == this.id &&
          other.name == this.name);
}

class PlaylistTableCompanion extends UpdateCompanion<PlaylistEntry> {
  final Value<String> id;
  final Value<String> name;
  const PlaylistTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  PlaylistTableCompanion.insert({
    @required String id,
    @required String name,
  })  : id = Value(id),
        name = Value(name);
  static Insertable<PlaylistEntry> custom({
    Expression<String> id,
    Expression<String> name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  PlaylistTableCompanion copyWith({Value<String> id, Value<String> name}) {
    return PlaylistTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }
}

class $PlaylistTableTable extends PlaylistTable
    with TableInfo<$PlaylistTableTable, PlaylistEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $PlaylistTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  $PlaylistTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'Playlist';
  @override
  final String actualTableName = 'Playlist';
  @override
  VerificationContext validateIntegrity(Insertable<PlaylistEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaylistEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return PlaylistEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PlaylistTableTable createAlias(String alias) {
    return $PlaylistTableTable(_db, alias);
  }
}

class PlaylistShaderEntry extends DataClass
    implements Insertable<PlaylistShaderEntry> {
  final String playlistId;
  final String shaderId;
  PlaylistShaderEntry({@required this.playlistId, @required this.shaderId});
  factory PlaylistShaderEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return PlaylistShaderEntry(
      playlistId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}playlist_id']),
      shaderId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}shader_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || playlistId != null) {
      map['playlist_id'] = Variable<String>(playlistId);
    }
    if (!nullToAbsent || shaderId != null) {
      map['shader_id'] = Variable<String>(shaderId);
    }
    return map;
  }

  PlaylistShaderTableCompanion toCompanion(bool nullToAbsent) {
    return PlaylistShaderTableCompanion(
      playlistId: playlistId == null && nullToAbsent
          ? const Value.absent()
          : Value(playlistId),
      shaderId: shaderId == null && nullToAbsent
          ? const Value.absent()
          : Value(shaderId),
    );
  }

  factory PlaylistShaderEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PlaylistShaderEntry(
      playlistId: serializer.fromJson<String>(json['playlistId']),
      shaderId: serializer.fromJson<String>(json['shaderId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'playlistId': serializer.toJson<String>(playlistId),
      'shaderId': serializer.toJson<String>(shaderId),
    };
  }

  PlaylistShaderEntry copyWith({String playlistId, String shaderId}) =>
      PlaylistShaderEntry(
        playlistId: playlistId ?? this.playlistId,
        shaderId: shaderId ?? this.shaderId,
      );
  @override
  String toString() {
    return (StringBuffer('PlaylistShaderEntry(')
          ..write('playlistId: $playlistId, ')
          ..write('shaderId: $shaderId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(playlistId.hashCode, shaderId.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is PlaylistShaderEntry &&
          other.playlistId == this.playlistId &&
          other.shaderId == this.shaderId);
}

class PlaylistShaderTableCompanion
    extends UpdateCompanion<PlaylistShaderEntry> {
  final Value<String> playlistId;
  final Value<String> shaderId;
  const PlaylistShaderTableCompanion({
    this.playlistId = const Value.absent(),
    this.shaderId = const Value.absent(),
  });
  PlaylistShaderTableCompanion.insert({
    @required String playlistId,
    @required String shaderId,
  })  : playlistId = Value(playlistId),
        shaderId = Value(shaderId);
  static Insertable<PlaylistShaderEntry> custom({
    Expression<String> playlistId,
    Expression<String> shaderId,
  }) {
    return RawValuesInsertable({
      if (playlistId != null) 'playlist_id': playlistId,
      if (shaderId != null) 'shader_id': shaderId,
    });
  }

  PlaylistShaderTableCompanion copyWith(
      {Value<String> playlistId, Value<String> shaderId}) {
    return PlaylistShaderTableCompanion(
      playlistId: playlistId ?? this.playlistId,
      shaderId: shaderId ?? this.shaderId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (playlistId.present) {
      map['playlist_id'] = Variable<String>(playlistId.value);
    }
    if (shaderId.present) {
      map['shader_id'] = Variable<String>(shaderId.value);
    }
    return map;
  }
}

class $PlaylistShaderTableTable extends PlaylistShaderTable
    with TableInfo<$PlaylistShaderTableTable, PlaylistShaderEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $PlaylistShaderTableTable(this._db, [this._alias]);
  final VerificationMeta _playlistIdMeta = const VerificationMeta('playlistId');
  GeneratedTextColumn _playlistId;
  @override
  GeneratedTextColumn get playlistId => _playlistId ??= _constructPlaylistId();
  GeneratedTextColumn _constructPlaylistId() {
    return GeneratedTextColumn('playlist_id', $tableName, false,
        $customConstraints: 'REFERENCES Playlist(id)');
  }

  final VerificationMeta _shaderIdMeta = const VerificationMeta('shaderId');
  GeneratedTextColumn _shaderId;
  @override
  GeneratedTextColumn get shaderId => _shaderId ??= _constructShaderId();
  GeneratedTextColumn _constructShaderId() {
    return GeneratedTextColumn('shader_id', $tableName, false,
        $customConstraints: 'REFERENCES Shader(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [playlistId, shaderId];
  @override
  $PlaylistShaderTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'PlaylistShader';
  @override
  final String actualTableName = 'PlaylistShader';
  @override
  VerificationContext validateIntegrity(
      Insertable<PlaylistShaderEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('playlist_id')) {
      context.handle(
          _playlistIdMeta,
          playlistId.isAcceptableOrUnknown(
              data['playlist_id'], _playlistIdMeta));
    } else if (isInserting) {
      context.missing(_playlistIdMeta);
    }
    if (data.containsKey('shader_id')) {
      context.handle(_shaderIdMeta,
          shaderId.isAcceptableOrUnknown(data['shader_id'], _shaderIdMeta));
    } else if (isInserting) {
      context.missing(_shaderIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {playlistId, shaderId};
  @override
  PlaylistShaderEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return PlaylistShaderEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PlaylistShaderTableTable createAlias(String alias) {
    return $PlaylistShaderTableTable(_db, alias);
  }
}

abstract class _$MoorStore extends GeneratedDatabase {
  _$MoorStore(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $UserTableTable _userTable;
  $UserTableTable get userTable => _userTable ??= $UserTableTable(this);
  $AccountTableTable _accountTable;
  $AccountTableTable get accountTable =>
      _accountTable ??= $AccountTableTable(this);
  $ShaderTableTable _shaderTable;
  $ShaderTableTable get shaderTable => _shaderTable ??= $ShaderTableTable(this);
  $CommentTableTable _commentTable;
  $CommentTableTable get commentTable =>
      _commentTable ??= $CommentTableTable(this);
  $PlaylistTableTable _playlistTable;
  $PlaylistTableTable get playlistTable =>
      _playlistTable ??= $PlaylistTableTable(this);
  $PlaylistShaderTableTable _playlistShaderTable;
  $PlaylistShaderTableTable get playlistShaderTable =>
      _playlistShaderTable ??= $PlaylistShaderTableTable(this);
  UserDao _userDao;
  UserDao get userDao => _userDao ??= UserDao(this as MoorStore);
  AccountDao _accountDao;
  AccountDao get accountDao => _accountDao ??= AccountDao(this as MoorStore);
  ShaderDao _shaderDao;
  ShaderDao get shaderDao => _shaderDao ??= ShaderDao(this as MoorStore);
  CommentDao _commentDao;
  CommentDao get commentDao => _commentDao ??= CommentDao(this as MoorStore);
  PlaylistDao _playlistDao;
  PlaylistDao get playlistDao =>
      _playlistDao ??= PlaylistDao(this as MoorStore);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        userTable,
        accountTable,
        shaderTable,
        commentTable,
        playlistTable,
        playlistShaderTable
      ];
}
