// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocalUsersTable extends LocalUsers
    with TableInfo<$LocalUsersTable, LocalUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalUsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<int> serverId = GeneratedColumn<int>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceUuidMeta = const VerificationMeta(
    'deviceUuid',
  );
  @override
  late final GeneratedColumn<String> deviceUuid = GeneratedColumn<String>(
    'device_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isTrustedMeta = const VerificationMeta(
    'isTrusted',
  );
  @override
  late final GeneratedColumn<bool> isTrusted = GeneratedColumn<bool>(
    'is_trusted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_trusted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastOnlineLoginAtMeta = const VerificationMeta(
    'lastOnlineLoginAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastOnlineLoginAt =
      GeneratedColumn<DateTime>(
        'last_online_login_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    serverId,
    name,
    email,
    role,
    status,
    deviceUuid,
    isTrusted,
    lastOnlineLoginAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_users';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalUser> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('device_uuid')) {
      context.handle(
        _deviceUuidMeta,
        deviceUuid.isAcceptableOrUnknown(data['device_uuid']!, _deviceUuidMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceUuidMeta);
    }
    if (data.containsKey('is_trusted')) {
      context.handle(
        _isTrustedMeta,
        isTrusted.isAcceptableOrUnknown(data['is_trusted']!, _isTrustedMeta),
      );
    }
    if (data.containsKey('last_online_login_at')) {
      context.handle(
        _lastOnlineLoginAtMeta,
        lastOnlineLoginAt.isAcceptableOrUnknown(
          data['last_online_login_at']!,
          _lastOnlineLoginAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastOnlineLoginAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {serverId};
  @override
  LocalUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalUser(
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      deviceUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_uuid'],
      )!,
      isTrusted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_trusted'],
      )!,
      lastOnlineLoginAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_online_login_at'],
      )!,
    );
  }

  @override
  $LocalUsersTable createAlias(String alias) {
    return $LocalUsersTable(attachedDatabase, alias);
  }
}

class LocalUser extends DataClass implements Insertable<LocalUser> {
  final int serverId;
  final String name;
  final String email;
  final String role;
  final String status;
  final String deviceUuid;
  final bool isTrusted;
  final DateTime lastOnlineLoginAt;
  const LocalUser({
    required this.serverId,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    required this.deviceUuid,
    required this.isTrusted,
    required this.lastOnlineLoginAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['server_id'] = Variable<int>(serverId);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['role'] = Variable<String>(role);
    map['status'] = Variable<String>(status);
    map['device_uuid'] = Variable<String>(deviceUuid);
    map['is_trusted'] = Variable<bool>(isTrusted);
    map['last_online_login_at'] = Variable<DateTime>(lastOnlineLoginAt);
    return map;
  }

  LocalUsersCompanion toCompanion(bool nullToAbsent) {
    return LocalUsersCompanion(
      serverId: Value(serverId),
      name: Value(name),
      email: Value(email),
      role: Value(role),
      status: Value(status),
      deviceUuid: Value(deviceUuid),
      isTrusted: Value(isTrusted),
      lastOnlineLoginAt: Value(lastOnlineLoginAt),
    );
  }

  factory LocalUser.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalUser(
      serverId: serializer.fromJson<int>(json['serverId']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      role: serializer.fromJson<String>(json['role']),
      status: serializer.fromJson<String>(json['status']),
      deviceUuid: serializer.fromJson<String>(json['deviceUuid']),
      isTrusted: serializer.fromJson<bool>(json['isTrusted']),
      lastOnlineLoginAt: serializer.fromJson<DateTime>(
        json['lastOnlineLoginAt'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'serverId': serializer.toJson<int>(serverId),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'role': serializer.toJson<String>(role),
      'status': serializer.toJson<String>(status),
      'deviceUuid': serializer.toJson<String>(deviceUuid),
      'isTrusted': serializer.toJson<bool>(isTrusted),
      'lastOnlineLoginAt': serializer.toJson<DateTime>(lastOnlineLoginAt),
    };
  }

  LocalUser copyWith({
    int? serverId,
    String? name,
    String? email,
    String? role,
    String? status,
    String? deviceUuid,
    bool? isTrusted,
    DateTime? lastOnlineLoginAt,
  }) => LocalUser(
    serverId: serverId ?? this.serverId,
    name: name ?? this.name,
    email: email ?? this.email,
    role: role ?? this.role,
    status: status ?? this.status,
    deviceUuid: deviceUuid ?? this.deviceUuid,
    isTrusted: isTrusted ?? this.isTrusted,
    lastOnlineLoginAt: lastOnlineLoginAt ?? this.lastOnlineLoginAt,
  );
  LocalUser copyWithCompanion(LocalUsersCompanion data) {
    return LocalUser(
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      role: data.role.present ? data.role.value : this.role,
      status: data.status.present ? data.status.value : this.status,
      deviceUuid: data.deviceUuid.present
          ? data.deviceUuid.value
          : this.deviceUuid,
      isTrusted: data.isTrusted.present ? data.isTrusted.value : this.isTrusted,
      lastOnlineLoginAt: data.lastOnlineLoginAt.present
          ? data.lastOnlineLoginAt.value
          : this.lastOnlineLoginAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalUser(')
          ..write('serverId: $serverId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('status: $status, ')
          ..write('deviceUuid: $deviceUuid, ')
          ..write('isTrusted: $isTrusted, ')
          ..write('lastOnlineLoginAt: $lastOnlineLoginAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    serverId,
    name,
    email,
    role,
    status,
    deviceUuid,
    isTrusted,
    lastOnlineLoginAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalUser &&
          other.serverId == this.serverId &&
          other.name == this.name &&
          other.email == this.email &&
          other.role == this.role &&
          other.status == this.status &&
          other.deviceUuid == this.deviceUuid &&
          other.isTrusted == this.isTrusted &&
          other.lastOnlineLoginAt == this.lastOnlineLoginAt);
}

class LocalUsersCompanion extends UpdateCompanion<LocalUser> {
  final Value<int> serverId;
  final Value<String> name;
  final Value<String> email;
  final Value<String> role;
  final Value<String> status;
  final Value<String> deviceUuid;
  final Value<bool> isTrusted;
  final Value<DateTime> lastOnlineLoginAt;
  const LocalUsersCompanion({
    this.serverId = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.role = const Value.absent(),
    this.status = const Value.absent(),
    this.deviceUuid = const Value.absent(),
    this.isTrusted = const Value.absent(),
    this.lastOnlineLoginAt = const Value.absent(),
  });
  LocalUsersCompanion.insert({
    this.serverId = const Value.absent(),
    required String name,
    required String email,
    required String role,
    required String status,
    required String deviceUuid,
    this.isTrusted = const Value.absent(),
    required DateTime lastOnlineLoginAt,
  }) : name = Value(name),
       email = Value(email),
       role = Value(role),
       status = Value(status),
       deviceUuid = Value(deviceUuid),
       lastOnlineLoginAt = Value(lastOnlineLoginAt);
  static Insertable<LocalUser> custom({
    Expression<int>? serverId,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? role,
    Expression<String>? status,
    Expression<String>? deviceUuid,
    Expression<bool>? isTrusted,
    Expression<DateTime>? lastOnlineLoginAt,
  }) {
    return RawValuesInsertable({
      if (serverId != null) 'server_id': serverId,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (role != null) 'role': role,
      if (status != null) 'status': status,
      if (deviceUuid != null) 'device_uuid': deviceUuid,
      if (isTrusted != null) 'is_trusted': isTrusted,
      if (lastOnlineLoginAt != null) 'last_online_login_at': lastOnlineLoginAt,
    });
  }

  LocalUsersCompanion copyWith({
    Value<int>? serverId,
    Value<String>? name,
    Value<String>? email,
    Value<String>? role,
    Value<String>? status,
    Value<String>? deviceUuid,
    Value<bool>? isTrusted,
    Value<DateTime>? lastOnlineLoginAt,
  }) {
    return LocalUsersCompanion(
      serverId: serverId ?? this.serverId,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      status: status ?? this.status,
      deviceUuid: deviceUuid ?? this.deviceUuid,
      isTrusted: isTrusted ?? this.isTrusted,
      lastOnlineLoginAt: lastOnlineLoginAt ?? this.lastOnlineLoginAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (deviceUuid.present) {
      map['device_uuid'] = Variable<String>(deviceUuid.value);
    }
    if (isTrusted.present) {
      map['is_trusted'] = Variable<bool>(isTrusted.value);
    }
    if (lastOnlineLoginAt.present) {
      map['last_online_login_at'] = Variable<DateTime>(lastOnlineLoginAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalUsersCompanion(')
          ..write('serverId: $serverId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('status: $status, ')
          ..write('deviceUuid: $deviceUuid, ')
          ..write('isTrusted: $isTrusted, ')
          ..write('lastOnlineLoginAt: $lastOnlineLoginAt')
          ..write(')'))
        .toString();
  }
}

class $LocalCurrenciesTable extends LocalCurrencies
    with TableInfo<$LocalCurrenciesTable, LocalCurrency> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalCurrenciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<int> serverId = GeneratedColumn<int>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
    'name_ar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
    'symbol',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _decimalPlacesMeta = const VerificationMeta(
    'decimalPlaces',
  );
  @override
  late final GeneratedColumn<int> decimalPlaces = GeneratedColumn<int>(
    'decimal_places',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    serverId,
    uuid,
    code,
    nameAr,
    symbol,
    decimalPlaces,
    isActive,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_currencies';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalCurrency> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name_ar')) {
      context.handle(
        _nameArMeta,
        nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta),
      );
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('symbol')) {
      context.handle(
        _symbolMeta,
        symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta),
      );
    } else if (isInserting) {
      context.missing(_symbolMeta);
    }
    if (data.containsKey('decimal_places')) {
      context.handle(
        _decimalPlacesMeta,
        decimalPlaces.isAcceptableOrUnknown(
          data['decimal_places']!,
          _decimalPlacesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_decimalPlacesMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {serverId};
  @override
  LocalCurrency map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalCurrency(
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      nameAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ar'],
      )!,
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
      )!,
      decimalPlaces: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}decimal_places'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $LocalCurrenciesTable createAlias(String alias) {
    return $LocalCurrenciesTable(attachedDatabase, alias);
  }
}

class LocalCurrency extends DataClass implements Insertable<LocalCurrency> {
  final int serverId;
  final String uuid;
  final String code;
  final String nameAr;
  final String symbol;
  final int decimalPlaces;
  final bool isActive;
  final DateTime? updatedAt;
  const LocalCurrency({
    required this.serverId,
    required this.uuid,
    required this.code,
    required this.nameAr,
    required this.symbol,
    required this.decimalPlaces,
    required this.isActive,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['server_id'] = Variable<int>(serverId);
    map['uuid'] = Variable<String>(uuid);
    map['code'] = Variable<String>(code);
    map['name_ar'] = Variable<String>(nameAr);
    map['symbol'] = Variable<String>(symbol);
    map['decimal_places'] = Variable<int>(decimalPlaces);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  LocalCurrenciesCompanion toCompanion(bool nullToAbsent) {
    return LocalCurrenciesCompanion(
      serverId: Value(serverId),
      uuid: Value(uuid),
      code: Value(code),
      nameAr: Value(nameAr),
      symbol: Value(symbol),
      decimalPlaces: Value(decimalPlaces),
      isActive: Value(isActive),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory LocalCurrency.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalCurrency(
      serverId: serializer.fromJson<int>(json['serverId']),
      uuid: serializer.fromJson<String>(json['uuid']),
      code: serializer.fromJson<String>(json['code']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      symbol: serializer.fromJson<String>(json['symbol']),
      decimalPlaces: serializer.fromJson<int>(json['decimalPlaces']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'serverId': serializer.toJson<int>(serverId),
      'uuid': serializer.toJson<String>(uuid),
      'code': serializer.toJson<String>(code),
      'nameAr': serializer.toJson<String>(nameAr),
      'symbol': serializer.toJson<String>(symbol),
      'decimalPlaces': serializer.toJson<int>(decimalPlaces),
      'isActive': serializer.toJson<bool>(isActive),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  LocalCurrency copyWith({
    int? serverId,
    String? uuid,
    String? code,
    String? nameAr,
    String? symbol,
    int? decimalPlaces,
    bool? isActive,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => LocalCurrency(
    serverId: serverId ?? this.serverId,
    uuid: uuid ?? this.uuid,
    code: code ?? this.code,
    nameAr: nameAr ?? this.nameAr,
    symbol: symbol ?? this.symbol,
    decimalPlaces: decimalPlaces ?? this.decimalPlaces,
    isActive: isActive ?? this.isActive,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  LocalCurrency copyWithCompanion(LocalCurrenciesCompanion data) {
    return LocalCurrency(
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      code: data.code.present ? data.code.value : this.code,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      decimalPlaces: data.decimalPlaces.present
          ? data.decimalPlaces.value
          : this.decimalPlaces,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalCurrency(')
          ..write('serverId: $serverId, ')
          ..write('uuid: $uuid, ')
          ..write('code: $code, ')
          ..write('nameAr: $nameAr, ')
          ..write('symbol: $symbol, ')
          ..write('decimalPlaces: $decimalPlaces, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    serverId,
    uuid,
    code,
    nameAr,
    symbol,
    decimalPlaces,
    isActive,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalCurrency &&
          other.serverId == this.serverId &&
          other.uuid == this.uuid &&
          other.code == this.code &&
          other.nameAr == this.nameAr &&
          other.symbol == this.symbol &&
          other.decimalPlaces == this.decimalPlaces &&
          other.isActive == this.isActive &&
          other.updatedAt == this.updatedAt);
}

class LocalCurrenciesCompanion extends UpdateCompanion<LocalCurrency> {
  final Value<int> serverId;
  final Value<String> uuid;
  final Value<String> code;
  final Value<String> nameAr;
  final Value<String> symbol;
  final Value<int> decimalPlaces;
  final Value<bool> isActive;
  final Value<DateTime?> updatedAt;
  const LocalCurrenciesCompanion({
    this.serverId = const Value.absent(),
    this.uuid = const Value.absent(),
    this.code = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.symbol = const Value.absent(),
    this.decimalPlaces = const Value.absent(),
    this.isActive = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LocalCurrenciesCompanion.insert({
    this.serverId = const Value.absent(),
    required String uuid,
    required String code,
    required String nameAr,
    required String symbol,
    required int decimalPlaces,
    required bool isActive,
    this.updatedAt = const Value.absent(),
  }) : uuid = Value(uuid),
       code = Value(code),
       nameAr = Value(nameAr),
       symbol = Value(symbol),
       decimalPlaces = Value(decimalPlaces),
       isActive = Value(isActive);
  static Insertable<LocalCurrency> custom({
    Expression<int>? serverId,
    Expression<String>? uuid,
    Expression<String>? code,
    Expression<String>? nameAr,
    Expression<String>? symbol,
    Expression<int>? decimalPlaces,
    Expression<bool>? isActive,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (serverId != null) 'server_id': serverId,
      if (uuid != null) 'uuid': uuid,
      if (code != null) 'code': code,
      if (nameAr != null) 'name_ar': nameAr,
      if (symbol != null) 'symbol': symbol,
      if (decimalPlaces != null) 'decimal_places': decimalPlaces,
      if (isActive != null) 'is_active': isActive,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LocalCurrenciesCompanion copyWith({
    Value<int>? serverId,
    Value<String>? uuid,
    Value<String>? code,
    Value<String>? nameAr,
    Value<String>? symbol,
    Value<int>? decimalPlaces,
    Value<bool>? isActive,
    Value<DateTime?>? updatedAt,
  }) {
    return LocalCurrenciesCompanion(
      serverId: serverId ?? this.serverId,
      uuid: uuid ?? this.uuid,
      code: code ?? this.code,
      nameAr: nameAr ?? this.nameAr,
      symbol: symbol ?? this.symbol,
      decimalPlaces: decimalPlaces ?? this.decimalPlaces,
      isActive: isActive ?? this.isActive,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (decimalPlaces.present) {
      map['decimal_places'] = Variable<int>(decimalPlaces.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalCurrenciesCompanion(')
          ..write('serverId: $serverId, ')
          ..write('uuid: $uuid, ')
          ..write('code: $code, ')
          ..write('nameAr: $nameAr, ')
          ..write('symbol: $symbol, ')
          ..write('decimalPlaces: $decimalPlaces, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LocalFinancialAccountsTable extends LocalFinancialAccounts
    with TableInfo<$LocalFinancialAccountsTable, LocalFinancialAccount> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalFinancialAccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<int> serverId = GeneratedColumn<int>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyServerIdMeta = const VerificationMeta(
    'currencyServerId',
  );
  @override
  late final GeneratedColumn<int> currencyServerId = GeneratedColumn<int>(
    'currency_server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencySymbolMeta = const VerificationMeta(
    'currencySymbol',
  );
  @override
  late final GeneratedColumn<String> currencySymbol = GeneratedColumn<String>(
    'currency_symbol',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyDecimalPlacesMeta =
      const VerificationMeta('currencyDecimalPlaces');
  @override
  late final GeneratedColumn<int> currencyDecimalPlaces = GeneratedColumn<int>(
    'currency_decimal_places',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _openingBalanceMinorMeta =
      const VerificationMeta('openingBalanceMinor');
  @override
  late final GeneratedColumn<int> openingBalanceMinor = GeneratedColumn<int>(
    'opening_balance_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    serverId,
    uuid,
    name,
    type,
    currencyServerId,
    currencyCode,
    currencySymbol,
    currencyDecimalPlaces,
    openingBalanceMinor,
    notes,
    isActive,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_financial_accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalFinancialAccount> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('currency_server_id')) {
      context.handle(
        _currencyServerIdMeta,
        currencyServerId.isAcceptableOrUnknown(
          data['currency_server_id']!,
          _currencyServerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyServerIdMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('currency_symbol')) {
      context.handle(
        _currencySymbolMeta,
        currencySymbol.isAcceptableOrUnknown(
          data['currency_symbol']!,
          _currencySymbolMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencySymbolMeta);
    }
    if (data.containsKey('currency_decimal_places')) {
      context.handle(
        _currencyDecimalPlacesMeta,
        currencyDecimalPlaces.isAcceptableOrUnknown(
          data['currency_decimal_places']!,
          _currencyDecimalPlacesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyDecimalPlacesMeta);
    }
    if (data.containsKey('opening_balance_minor')) {
      context.handle(
        _openingBalanceMinorMeta,
        openingBalanceMinor.isAcceptableOrUnknown(
          data['opening_balance_minor']!,
          _openingBalanceMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_openingBalanceMinorMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {serverId};
  @override
  LocalFinancialAccount map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalFinancialAccount(
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      currencyServerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}currency_server_id'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      currencySymbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_symbol'],
      )!,
      currencyDecimalPlaces: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}currency_decimal_places'],
      )!,
      openingBalanceMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}opening_balance_minor'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $LocalFinancialAccountsTable createAlias(String alias) {
    return $LocalFinancialAccountsTable(attachedDatabase, alias);
  }
}

class LocalFinancialAccount extends DataClass
    implements Insertable<LocalFinancialAccount> {
  final int serverId;
  final String uuid;
  final String name;
  final String type;
  final int currencyServerId;
  final String currencyCode;
  final String currencySymbol;
  final int currencyDecimalPlaces;
  final int openingBalanceMinor;
  final String? notes;
  final bool isActive;
  final DateTime? updatedAt;
  const LocalFinancialAccount({
    required this.serverId,
    required this.uuid,
    required this.name,
    required this.type,
    required this.currencyServerId,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
    required this.openingBalanceMinor,
    this.notes,
    required this.isActive,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['server_id'] = Variable<int>(serverId);
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['currency_server_id'] = Variable<int>(currencyServerId);
    map['currency_code'] = Variable<String>(currencyCode);
    map['currency_symbol'] = Variable<String>(currencySymbol);
    map['currency_decimal_places'] = Variable<int>(currencyDecimalPlaces);
    map['opening_balance_minor'] = Variable<int>(openingBalanceMinor);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  LocalFinancialAccountsCompanion toCompanion(bool nullToAbsent) {
    return LocalFinancialAccountsCompanion(
      serverId: Value(serverId),
      uuid: Value(uuid),
      name: Value(name),
      type: Value(type),
      currencyServerId: Value(currencyServerId),
      currencyCode: Value(currencyCode),
      currencySymbol: Value(currencySymbol),
      currencyDecimalPlaces: Value(currencyDecimalPlaces),
      openingBalanceMinor: Value(openingBalanceMinor),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isActive: Value(isActive),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory LocalFinancialAccount.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalFinancialAccount(
      serverId: serializer.fromJson<int>(json['serverId']),
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      currencyServerId: serializer.fromJson<int>(json['currencyServerId']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      currencySymbol: serializer.fromJson<String>(json['currencySymbol']),
      currencyDecimalPlaces: serializer.fromJson<int>(
        json['currencyDecimalPlaces'],
      ),
      openingBalanceMinor: serializer.fromJson<int>(
        json['openingBalanceMinor'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'serverId': serializer.toJson<int>(serverId),
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'currencyServerId': serializer.toJson<int>(currencyServerId),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'currencySymbol': serializer.toJson<String>(currencySymbol),
      'currencyDecimalPlaces': serializer.toJson<int>(currencyDecimalPlaces),
      'openingBalanceMinor': serializer.toJson<int>(openingBalanceMinor),
      'notes': serializer.toJson<String?>(notes),
      'isActive': serializer.toJson<bool>(isActive),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  LocalFinancialAccount copyWith({
    int? serverId,
    String? uuid,
    String? name,
    String? type,
    int? currencyServerId,
    String? currencyCode,
    String? currencySymbol,
    int? currencyDecimalPlaces,
    int? openingBalanceMinor,
    Value<String?> notes = const Value.absent(),
    bool? isActive,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => LocalFinancialAccount(
    serverId: serverId ?? this.serverId,
    uuid: uuid ?? this.uuid,
    name: name ?? this.name,
    type: type ?? this.type,
    currencyServerId: currencyServerId ?? this.currencyServerId,
    currencyCode: currencyCode ?? this.currencyCode,
    currencySymbol: currencySymbol ?? this.currencySymbol,
    currencyDecimalPlaces: currencyDecimalPlaces ?? this.currencyDecimalPlaces,
    openingBalanceMinor: openingBalanceMinor ?? this.openingBalanceMinor,
    notes: notes.present ? notes.value : this.notes,
    isActive: isActive ?? this.isActive,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  LocalFinancialAccount copyWithCompanion(
    LocalFinancialAccountsCompanion data,
  ) {
    return LocalFinancialAccount(
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      currencyServerId: data.currencyServerId.present
          ? data.currencyServerId.value
          : this.currencyServerId,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      currencySymbol: data.currencySymbol.present
          ? data.currencySymbol.value
          : this.currencySymbol,
      currencyDecimalPlaces: data.currencyDecimalPlaces.present
          ? data.currencyDecimalPlaces.value
          : this.currencyDecimalPlaces,
      openingBalanceMinor: data.openingBalanceMinor.present
          ? data.openingBalanceMinor.value
          : this.openingBalanceMinor,
      notes: data.notes.present ? data.notes.value : this.notes,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalFinancialAccount(')
          ..write('serverId: $serverId, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('currencyServerId: $currencyServerId, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('currencySymbol: $currencySymbol, ')
          ..write('currencyDecimalPlaces: $currencyDecimalPlaces, ')
          ..write('openingBalanceMinor: $openingBalanceMinor, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    serverId,
    uuid,
    name,
    type,
    currencyServerId,
    currencyCode,
    currencySymbol,
    currencyDecimalPlaces,
    openingBalanceMinor,
    notes,
    isActive,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalFinancialAccount &&
          other.serverId == this.serverId &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.type == this.type &&
          other.currencyServerId == this.currencyServerId &&
          other.currencyCode == this.currencyCode &&
          other.currencySymbol == this.currencySymbol &&
          other.currencyDecimalPlaces == this.currencyDecimalPlaces &&
          other.openingBalanceMinor == this.openingBalanceMinor &&
          other.notes == this.notes &&
          other.isActive == this.isActive &&
          other.updatedAt == this.updatedAt);
}

class LocalFinancialAccountsCompanion
    extends UpdateCompanion<LocalFinancialAccount> {
  final Value<int> serverId;
  final Value<String> uuid;
  final Value<String> name;
  final Value<String> type;
  final Value<int> currencyServerId;
  final Value<String> currencyCode;
  final Value<String> currencySymbol;
  final Value<int> currencyDecimalPlaces;
  final Value<int> openingBalanceMinor;
  final Value<String?> notes;
  final Value<bool> isActive;
  final Value<DateTime?> updatedAt;
  const LocalFinancialAccountsCompanion({
    this.serverId = const Value.absent(),
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.currencyServerId = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.currencySymbol = const Value.absent(),
    this.currencyDecimalPlaces = const Value.absent(),
    this.openingBalanceMinor = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LocalFinancialAccountsCompanion.insert({
    this.serverId = const Value.absent(),
    required String uuid,
    required String name,
    required String type,
    required int currencyServerId,
    required String currencyCode,
    required String currencySymbol,
    required int currencyDecimalPlaces,
    required int openingBalanceMinor,
    this.notes = const Value.absent(),
    required bool isActive,
    this.updatedAt = const Value.absent(),
  }) : uuid = Value(uuid),
       name = Value(name),
       type = Value(type),
       currencyServerId = Value(currencyServerId),
       currencyCode = Value(currencyCode),
       currencySymbol = Value(currencySymbol),
       currencyDecimalPlaces = Value(currencyDecimalPlaces),
       openingBalanceMinor = Value(openingBalanceMinor),
       isActive = Value(isActive);
  static Insertable<LocalFinancialAccount> custom({
    Expression<int>? serverId,
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<String>? type,
    Expression<int>? currencyServerId,
    Expression<String>? currencyCode,
    Expression<String>? currencySymbol,
    Expression<int>? currencyDecimalPlaces,
    Expression<int>? openingBalanceMinor,
    Expression<String>? notes,
    Expression<bool>? isActive,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (serverId != null) 'server_id': serverId,
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (currencyServerId != null) 'currency_server_id': currencyServerId,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (currencySymbol != null) 'currency_symbol': currencySymbol,
      if (currencyDecimalPlaces != null)
        'currency_decimal_places': currencyDecimalPlaces,
      if (openingBalanceMinor != null)
        'opening_balance_minor': openingBalanceMinor,
      if (notes != null) 'notes': notes,
      if (isActive != null) 'is_active': isActive,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LocalFinancialAccountsCompanion copyWith({
    Value<int>? serverId,
    Value<String>? uuid,
    Value<String>? name,
    Value<String>? type,
    Value<int>? currencyServerId,
    Value<String>? currencyCode,
    Value<String>? currencySymbol,
    Value<int>? currencyDecimalPlaces,
    Value<int>? openingBalanceMinor,
    Value<String?>? notes,
    Value<bool>? isActive,
    Value<DateTime?>? updatedAt,
  }) {
    return LocalFinancialAccountsCompanion(
      serverId: serverId ?? this.serverId,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      type: type ?? this.type,
      currencyServerId: currencyServerId ?? this.currencyServerId,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      openingBalanceMinor: openingBalanceMinor ?? this.openingBalanceMinor,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (currencyServerId.present) {
      map['currency_server_id'] = Variable<int>(currencyServerId.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (currencySymbol.present) {
      map['currency_symbol'] = Variable<String>(currencySymbol.value);
    }
    if (currencyDecimalPlaces.present) {
      map['currency_decimal_places'] = Variable<int>(
        currencyDecimalPlaces.value,
      );
    }
    if (openingBalanceMinor.present) {
      map['opening_balance_minor'] = Variable<int>(openingBalanceMinor.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalFinancialAccountsCompanion(')
          ..write('serverId: $serverId, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('currencyServerId: $currencyServerId, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('currencySymbol: $currencySymbol, ')
          ..write('currencyDecimalPlaces: $currencyDecimalPlaces, ')
          ..write('openingBalanceMinor: $openingBalanceMinor, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LocalCategoriesTable extends LocalCategories
    with TableInfo<$LocalCategoriesTable, LocalCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<int> serverId = GeneratedColumn<int>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    serverId,
    uuid,
    name,
    type,
    notes,
    isActive,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalCategory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {serverId};
  @override
  LocalCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalCategory(
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $LocalCategoriesTable createAlias(String alias) {
    return $LocalCategoriesTable(attachedDatabase, alias);
  }
}

class LocalCategory extends DataClass implements Insertable<LocalCategory> {
  final int serverId;
  final String uuid;
  final String name;
  final String type;
  final String? notes;
  final bool isActive;
  final DateTime? updatedAt;
  const LocalCategory({
    required this.serverId,
    required this.uuid,
    required this.name,
    required this.type,
    this.notes,
    required this.isActive,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['server_id'] = Variable<int>(serverId);
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  LocalCategoriesCompanion toCompanion(bool nullToAbsent) {
    return LocalCategoriesCompanion(
      serverId: Value(serverId),
      uuid: Value(uuid),
      name: Value(name),
      type: Value(type),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isActive: Value(isActive),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory LocalCategory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalCategory(
      serverId: serializer.fromJson<int>(json['serverId']),
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      notes: serializer.fromJson<String?>(json['notes']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'serverId': serializer.toJson<int>(serverId),
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'notes': serializer.toJson<String?>(notes),
      'isActive': serializer.toJson<bool>(isActive),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  LocalCategory copyWith({
    int? serverId,
    String? uuid,
    String? name,
    String? type,
    Value<String?> notes = const Value.absent(),
    bool? isActive,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => LocalCategory(
    serverId: serverId ?? this.serverId,
    uuid: uuid ?? this.uuid,
    name: name ?? this.name,
    type: type ?? this.type,
    notes: notes.present ? notes.value : this.notes,
    isActive: isActive ?? this.isActive,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  LocalCategory copyWithCompanion(LocalCategoriesCompanion data) {
    return LocalCategory(
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      notes: data.notes.present ? data.notes.value : this.notes,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalCategory(')
          ..write('serverId: $serverId, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(serverId, uuid, name, type, notes, isActive, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalCategory &&
          other.serverId == this.serverId &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.type == this.type &&
          other.notes == this.notes &&
          other.isActive == this.isActive &&
          other.updatedAt == this.updatedAt);
}

class LocalCategoriesCompanion extends UpdateCompanion<LocalCategory> {
  final Value<int> serverId;
  final Value<String> uuid;
  final Value<String> name;
  final Value<String> type;
  final Value<String?> notes;
  final Value<bool> isActive;
  final Value<DateTime?> updatedAt;
  const LocalCategoriesCompanion({
    this.serverId = const Value.absent(),
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LocalCategoriesCompanion.insert({
    this.serverId = const Value.absent(),
    required String uuid,
    required String name,
    required String type,
    this.notes = const Value.absent(),
    required bool isActive,
    this.updatedAt = const Value.absent(),
  }) : uuid = Value(uuid),
       name = Value(name),
       type = Value(type),
       isActive = Value(isActive);
  static Insertable<LocalCategory> custom({
    Expression<int>? serverId,
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? notes,
    Expression<bool>? isActive,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (serverId != null) 'server_id': serverId,
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (notes != null) 'notes': notes,
      if (isActive != null) 'is_active': isActive,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LocalCategoriesCompanion copyWith({
    Value<int>? serverId,
    Value<String>? uuid,
    Value<String>? name,
    Value<String>? type,
    Value<String?>? notes,
    Value<bool>? isActive,
    Value<DateTime?>? updatedAt,
  }) {
    return LocalCategoriesCompanion(
      serverId: serverId ?? this.serverId,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      type: type ?? this.type,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalCategoriesCompanion(')
          ..write('serverId: $serverId, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LocalPartiesTable extends LocalParties
    with TableInfo<$LocalPartiesTable, LocalParty> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalPartiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<int> serverId = GeneratedColumn<int>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastMovementAtMeta = const VerificationMeta(
    'lastMovementAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastMovementAt =
      GeneratedColumn<DateTime>(
        'last_movement_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    serverId,
    uuid,
    type,
    name,
    phone,
    address,
    notes,
    isActive,
    version,
    lastMovementAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_parties';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalParty> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('last_movement_at')) {
      context.handle(
        _lastMovementAtMeta,
        lastMovementAt.isAcceptableOrUnknown(
          data['last_movement_at']!,
          _lastMovementAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {serverId};
  @override
  LocalParty map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalParty(
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      lastMovementAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_movement_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $LocalPartiesTable createAlias(String alias) {
    return $LocalPartiesTable(attachedDatabase, alias);
  }
}

class LocalParty extends DataClass implements Insertable<LocalParty> {
  final int serverId;
  final String uuid;
  final String type;
  final String name;
  final String? phone;
  final String? address;
  final String? notes;
  final bool isActive;
  final int version;
  final DateTime? lastMovementAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const LocalParty({
    required this.serverId,
    required this.uuid,
    required this.type,
    required this.name,
    this.phone,
    this.address,
    this.notes,
    required this.isActive,
    required this.version,
    this.lastMovementAt,
    this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['server_id'] = Variable<int>(serverId);
    map['uuid'] = Variable<String>(uuid);
    map['type'] = Variable<String>(type);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['version'] = Variable<int>(version);
    if (!nullToAbsent || lastMovementAt != null) {
      map['last_movement_at'] = Variable<DateTime>(lastMovementAt);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  LocalPartiesCompanion toCompanion(bool nullToAbsent) {
    return LocalPartiesCompanion(
      serverId: Value(serverId),
      uuid: Value(uuid),
      type: Value(type),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isActive: Value(isActive),
      version: Value(version),
      lastMovementAt: lastMovementAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMovementAt),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory LocalParty.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalParty(
      serverId: serializer.fromJson<int>(json['serverId']),
      uuid: serializer.fromJson<String>(json['uuid']),
      type: serializer.fromJson<String>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      notes: serializer.fromJson<String?>(json['notes']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      version: serializer.fromJson<int>(json['version']),
      lastMovementAt: serializer.fromJson<DateTime?>(json['lastMovementAt']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'serverId': serializer.toJson<int>(serverId),
      'uuid': serializer.toJson<String>(uuid),
      'type': serializer.toJson<String>(type),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'notes': serializer.toJson<String?>(notes),
      'isActive': serializer.toJson<bool>(isActive),
      'version': serializer.toJson<int>(version),
      'lastMovementAt': serializer.toJson<DateTime?>(lastMovementAt),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  LocalParty copyWith({
    int? serverId,
    String? uuid,
    String? type,
    String? name,
    Value<String?> phone = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? isActive,
    int? version,
    Value<DateTime?> lastMovementAt = const Value.absent(),
    Value<DateTime?> createdAt = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => LocalParty(
    serverId: serverId ?? this.serverId,
    uuid: uuid ?? this.uuid,
    type: type ?? this.type,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    address: address.present ? address.value : this.address,
    notes: notes.present ? notes.value : this.notes,
    isActive: isActive ?? this.isActive,
    version: version ?? this.version,
    lastMovementAt: lastMovementAt.present
        ? lastMovementAt.value
        : this.lastMovementAt,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  LocalParty copyWithCompanion(LocalPartiesCompanion data) {
    return LocalParty(
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      type: data.type.present ? data.type.value : this.type,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      notes: data.notes.present ? data.notes.value : this.notes,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      version: data.version.present ? data.version.value : this.version,
      lastMovementAt: data.lastMovementAt.present
          ? data.lastMovementAt.value
          : this.lastMovementAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalParty(')
          ..write('serverId: $serverId, ')
          ..write('uuid: $uuid, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('version: $version, ')
          ..write('lastMovementAt: $lastMovementAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    serverId,
    uuid,
    type,
    name,
    phone,
    address,
    notes,
    isActive,
    version,
    lastMovementAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalParty &&
          other.serverId == this.serverId &&
          other.uuid == this.uuid &&
          other.type == this.type &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.notes == this.notes &&
          other.isActive == this.isActive &&
          other.version == this.version &&
          other.lastMovementAt == this.lastMovementAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalPartiesCompanion extends UpdateCompanion<LocalParty> {
  final Value<int> serverId;
  final Value<String> uuid;
  final Value<String> type;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<String?> notes;
  final Value<bool> isActive;
  final Value<int> version;
  final Value<DateTime?> lastMovementAt;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  const LocalPartiesCompanion({
    this.serverId = const Value.absent(),
    this.uuid = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.version = const Value.absent(),
    this.lastMovementAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LocalPartiesCompanion.insert({
    this.serverId = const Value.absent(),
    required String uuid,
    required String type,
    required String name,
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    required bool isActive,
    required int version,
    this.lastMovementAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : uuid = Value(uuid),
       type = Value(type),
       name = Value(name),
       isActive = Value(isActive),
       version = Value(version);
  static Insertable<LocalParty> custom({
    Expression<int>? serverId,
    Expression<String>? uuid,
    Expression<String>? type,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<String>? notes,
    Expression<bool>? isActive,
    Expression<int>? version,
    Expression<DateTime>? lastMovementAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (serverId != null) 'server_id': serverId,
      if (uuid != null) 'uuid': uuid,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (notes != null) 'notes': notes,
      if (isActive != null) 'is_active': isActive,
      if (version != null) 'version': version,
      if (lastMovementAt != null) 'last_movement_at': lastMovementAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LocalPartiesCompanion copyWith({
    Value<int>? serverId,
    Value<String>? uuid,
    Value<String>? type,
    Value<String>? name,
    Value<String?>? phone,
    Value<String?>? address,
    Value<String?>? notes,
    Value<bool>? isActive,
    Value<int>? version,
    Value<DateTime?>? lastMovementAt,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return LocalPartiesCompanion(
      serverId: serverId ?? this.serverId,
      uuid: uuid ?? this.uuid,
      type: type ?? this.type,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      version: version ?? this.version,
      lastMovementAt: lastMovementAt ?? this.lastMovementAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (lastMovementAt.present) {
      map['last_movement_at'] = Variable<DateTime>(lastMovementAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalPartiesCompanion(')
          ..write('serverId: $serverId, ')
          ..write('uuid: $uuid, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('version: $version, ')
          ..write('lastMovementAt: $lastMovementAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LocalPartyOpeningBalancesTable extends LocalPartyOpeningBalances
    with TableInfo<$LocalPartyOpeningBalancesTable, LocalPartyOpeningBalance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalPartyOpeningBalancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<int> serverId = GeneratedColumn<int>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _partyServerIdMeta = const VerificationMeta(
    'partyServerId',
  );
  @override
  late final GeneratedColumn<int> partyServerId = GeneratedColumn<int>(
    'party_server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyServerIdMeta = const VerificationMeta(
    'currencyServerId',
  );
  @override
  late final GeneratedColumn<int> currencyServerId = GeneratedColumn<int>(
    'currency_server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyNameArMeta = const VerificationMeta(
    'currencyNameAr',
  );
  @override
  late final GeneratedColumn<String> currencyNameAr = GeneratedColumn<String>(
    'currency_name_ar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencySymbolMeta = const VerificationMeta(
    'currencySymbol',
  );
  @override
  late final GeneratedColumn<String> currencySymbol = GeneratedColumn<String>(
    'currency_symbol',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyDecimalPlacesMeta =
      const VerificationMeta('currencyDecimalPlaces');
  @override
  late final GeneratedColumn<int> currencyDecimalPlaces = GeneratedColumn<int>(
    'currency_decimal_places',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _balanceSideMeta = const VerificationMeta(
    'balanceSide',
  );
  @override
  late final GeneratedColumn<String> balanceSide = GeneratedColumn<String>(
    'balance_side',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    serverId,
    partyServerId,
    currencyServerId,
    currencyCode,
    currencyNameAr,
    currencySymbol,
    currencyDecimalPlaces,
    balanceSide,
    amountMinor,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_party_opening_balances';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalPartyOpeningBalance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('party_server_id')) {
      context.handle(
        _partyServerIdMeta,
        partyServerId.isAcceptableOrUnknown(
          data['party_server_id']!,
          _partyServerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_partyServerIdMeta);
    }
    if (data.containsKey('currency_server_id')) {
      context.handle(
        _currencyServerIdMeta,
        currencyServerId.isAcceptableOrUnknown(
          data['currency_server_id']!,
          _currencyServerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyServerIdMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('currency_name_ar')) {
      context.handle(
        _currencyNameArMeta,
        currencyNameAr.isAcceptableOrUnknown(
          data['currency_name_ar']!,
          _currencyNameArMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyNameArMeta);
    }
    if (data.containsKey('currency_symbol')) {
      context.handle(
        _currencySymbolMeta,
        currencySymbol.isAcceptableOrUnknown(
          data['currency_symbol']!,
          _currencySymbolMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencySymbolMeta);
    }
    if (data.containsKey('currency_decimal_places')) {
      context.handle(
        _currencyDecimalPlacesMeta,
        currencyDecimalPlaces.isAcceptableOrUnknown(
          data['currency_decimal_places']!,
          _currencyDecimalPlacesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyDecimalPlacesMeta);
    }
    if (data.containsKey('balance_side')) {
      context.handle(
        _balanceSideMeta,
        balanceSide.isAcceptableOrUnknown(
          data['balance_side']!,
          _balanceSideMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_balanceSideMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {
    partyServerId,
    currencyServerId,
    balanceSide,
  };
  @override
  LocalPartyOpeningBalance map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalPartyOpeningBalance(
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_id'],
      ),
      partyServerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}party_server_id'],
      )!,
      currencyServerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}currency_server_id'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      currencyNameAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_name_ar'],
      )!,
      currencySymbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_symbol'],
      )!,
      currencyDecimalPlaces: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}currency_decimal_places'],
      )!,
      balanceSide: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}balance_side'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
    );
  }

  @override
  $LocalPartyOpeningBalancesTable createAlias(String alias) {
    return $LocalPartyOpeningBalancesTable(attachedDatabase, alias);
  }
}

class LocalPartyOpeningBalance extends DataClass
    implements Insertable<LocalPartyOpeningBalance> {
  final int? serverId;
  final int partyServerId;
  final int currencyServerId;
  final String currencyCode;
  final String currencyNameAr;
  final String currencySymbol;
  final int currencyDecimalPlaces;
  final String balanceSide;
  final int amountMinor;
  const LocalPartyOpeningBalance({
    this.serverId,
    required this.partyServerId,
    required this.currencyServerId,
    required this.currencyCode,
    required this.currencyNameAr,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
    required this.balanceSide,
    required this.amountMinor,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<int>(serverId);
    }
    map['party_server_id'] = Variable<int>(partyServerId);
    map['currency_server_id'] = Variable<int>(currencyServerId);
    map['currency_code'] = Variable<String>(currencyCode);
    map['currency_name_ar'] = Variable<String>(currencyNameAr);
    map['currency_symbol'] = Variable<String>(currencySymbol);
    map['currency_decimal_places'] = Variable<int>(currencyDecimalPlaces);
    map['balance_side'] = Variable<String>(balanceSide);
    map['amount_minor'] = Variable<int>(amountMinor);
    return map;
  }

  LocalPartyOpeningBalancesCompanion toCompanion(bool nullToAbsent) {
    return LocalPartyOpeningBalancesCompanion(
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      partyServerId: Value(partyServerId),
      currencyServerId: Value(currencyServerId),
      currencyCode: Value(currencyCode),
      currencyNameAr: Value(currencyNameAr),
      currencySymbol: Value(currencySymbol),
      currencyDecimalPlaces: Value(currencyDecimalPlaces),
      balanceSide: Value(balanceSide),
      amountMinor: Value(amountMinor),
    );
  }

  factory LocalPartyOpeningBalance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalPartyOpeningBalance(
      serverId: serializer.fromJson<int?>(json['serverId']),
      partyServerId: serializer.fromJson<int>(json['partyServerId']),
      currencyServerId: serializer.fromJson<int>(json['currencyServerId']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      currencyNameAr: serializer.fromJson<String>(json['currencyNameAr']),
      currencySymbol: serializer.fromJson<String>(json['currencySymbol']),
      currencyDecimalPlaces: serializer.fromJson<int>(
        json['currencyDecimalPlaces'],
      ),
      balanceSide: serializer.fromJson<String>(json['balanceSide']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'serverId': serializer.toJson<int?>(serverId),
      'partyServerId': serializer.toJson<int>(partyServerId),
      'currencyServerId': serializer.toJson<int>(currencyServerId),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'currencyNameAr': serializer.toJson<String>(currencyNameAr),
      'currencySymbol': serializer.toJson<String>(currencySymbol),
      'currencyDecimalPlaces': serializer.toJson<int>(currencyDecimalPlaces),
      'balanceSide': serializer.toJson<String>(balanceSide),
      'amountMinor': serializer.toJson<int>(amountMinor),
    };
  }

  LocalPartyOpeningBalance copyWith({
    Value<int?> serverId = const Value.absent(),
    int? partyServerId,
    int? currencyServerId,
    String? currencyCode,
    String? currencyNameAr,
    String? currencySymbol,
    int? currencyDecimalPlaces,
    String? balanceSide,
    int? amountMinor,
  }) => LocalPartyOpeningBalance(
    serverId: serverId.present ? serverId.value : this.serverId,
    partyServerId: partyServerId ?? this.partyServerId,
    currencyServerId: currencyServerId ?? this.currencyServerId,
    currencyCode: currencyCode ?? this.currencyCode,
    currencyNameAr: currencyNameAr ?? this.currencyNameAr,
    currencySymbol: currencySymbol ?? this.currencySymbol,
    currencyDecimalPlaces: currencyDecimalPlaces ?? this.currencyDecimalPlaces,
    balanceSide: balanceSide ?? this.balanceSide,
    amountMinor: amountMinor ?? this.amountMinor,
  );
  LocalPartyOpeningBalance copyWithCompanion(
    LocalPartyOpeningBalancesCompanion data,
  ) {
    return LocalPartyOpeningBalance(
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      partyServerId: data.partyServerId.present
          ? data.partyServerId.value
          : this.partyServerId,
      currencyServerId: data.currencyServerId.present
          ? data.currencyServerId.value
          : this.currencyServerId,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      currencyNameAr: data.currencyNameAr.present
          ? data.currencyNameAr.value
          : this.currencyNameAr,
      currencySymbol: data.currencySymbol.present
          ? data.currencySymbol.value
          : this.currencySymbol,
      currencyDecimalPlaces: data.currencyDecimalPlaces.present
          ? data.currencyDecimalPlaces.value
          : this.currencyDecimalPlaces,
      balanceSide: data.balanceSide.present
          ? data.balanceSide.value
          : this.balanceSide,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalPartyOpeningBalance(')
          ..write('serverId: $serverId, ')
          ..write('partyServerId: $partyServerId, ')
          ..write('currencyServerId: $currencyServerId, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('currencyNameAr: $currencyNameAr, ')
          ..write('currencySymbol: $currencySymbol, ')
          ..write('currencyDecimalPlaces: $currencyDecimalPlaces, ')
          ..write('balanceSide: $balanceSide, ')
          ..write('amountMinor: $amountMinor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    serverId,
    partyServerId,
    currencyServerId,
    currencyCode,
    currencyNameAr,
    currencySymbol,
    currencyDecimalPlaces,
    balanceSide,
    amountMinor,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalPartyOpeningBalance &&
          other.serverId == this.serverId &&
          other.partyServerId == this.partyServerId &&
          other.currencyServerId == this.currencyServerId &&
          other.currencyCode == this.currencyCode &&
          other.currencyNameAr == this.currencyNameAr &&
          other.currencySymbol == this.currencySymbol &&
          other.currencyDecimalPlaces == this.currencyDecimalPlaces &&
          other.balanceSide == this.balanceSide &&
          other.amountMinor == this.amountMinor);
}

class LocalPartyOpeningBalancesCompanion
    extends UpdateCompanion<LocalPartyOpeningBalance> {
  final Value<int?> serverId;
  final Value<int> partyServerId;
  final Value<int> currencyServerId;
  final Value<String> currencyCode;
  final Value<String> currencyNameAr;
  final Value<String> currencySymbol;
  final Value<int> currencyDecimalPlaces;
  final Value<String> balanceSide;
  final Value<int> amountMinor;
  final Value<int> rowid;
  const LocalPartyOpeningBalancesCompanion({
    this.serverId = const Value.absent(),
    this.partyServerId = const Value.absent(),
    this.currencyServerId = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.currencyNameAr = const Value.absent(),
    this.currencySymbol = const Value.absent(),
    this.currencyDecimalPlaces = const Value.absent(),
    this.balanceSide = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalPartyOpeningBalancesCompanion.insert({
    this.serverId = const Value.absent(),
    required int partyServerId,
    required int currencyServerId,
    required String currencyCode,
    required String currencyNameAr,
    required String currencySymbol,
    required int currencyDecimalPlaces,
    required String balanceSide,
    required int amountMinor,
    this.rowid = const Value.absent(),
  }) : partyServerId = Value(partyServerId),
       currencyServerId = Value(currencyServerId),
       currencyCode = Value(currencyCode),
       currencyNameAr = Value(currencyNameAr),
       currencySymbol = Value(currencySymbol),
       currencyDecimalPlaces = Value(currencyDecimalPlaces),
       balanceSide = Value(balanceSide),
       amountMinor = Value(amountMinor);
  static Insertable<LocalPartyOpeningBalance> custom({
    Expression<int>? serverId,
    Expression<int>? partyServerId,
    Expression<int>? currencyServerId,
    Expression<String>? currencyCode,
    Expression<String>? currencyNameAr,
    Expression<String>? currencySymbol,
    Expression<int>? currencyDecimalPlaces,
    Expression<String>? balanceSide,
    Expression<int>? amountMinor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (serverId != null) 'server_id': serverId,
      if (partyServerId != null) 'party_server_id': partyServerId,
      if (currencyServerId != null) 'currency_server_id': currencyServerId,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (currencyNameAr != null) 'currency_name_ar': currencyNameAr,
      if (currencySymbol != null) 'currency_symbol': currencySymbol,
      if (currencyDecimalPlaces != null)
        'currency_decimal_places': currencyDecimalPlaces,
      if (balanceSide != null) 'balance_side': balanceSide,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalPartyOpeningBalancesCompanion copyWith({
    Value<int?>? serverId,
    Value<int>? partyServerId,
    Value<int>? currencyServerId,
    Value<String>? currencyCode,
    Value<String>? currencyNameAr,
    Value<String>? currencySymbol,
    Value<int>? currencyDecimalPlaces,
    Value<String>? balanceSide,
    Value<int>? amountMinor,
    Value<int>? rowid,
  }) {
    return LocalPartyOpeningBalancesCompanion(
      serverId: serverId ?? this.serverId,
      partyServerId: partyServerId ?? this.partyServerId,
      currencyServerId: currencyServerId ?? this.currencyServerId,
      currencyCode: currencyCode ?? this.currencyCode,
      currencyNameAr: currencyNameAr ?? this.currencyNameAr,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      balanceSide: balanceSide ?? this.balanceSide,
      amountMinor: amountMinor ?? this.amountMinor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    if (partyServerId.present) {
      map['party_server_id'] = Variable<int>(partyServerId.value);
    }
    if (currencyServerId.present) {
      map['currency_server_id'] = Variable<int>(currencyServerId.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (currencyNameAr.present) {
      map['currency_name_ar'] = Variable<String>(currencyNameAr.value);
    }
    if (currencySymbol.present) {
      map['currency_symbol'] = Variable<String>(currencySymbol.value);
    }
    if (currencyDecimalPlaces.present) {
      map['currency_decimal_places'] = Variable<int>(
        currencyDecimalPlaces.value,
      );
    }
    if (balanceSide.present) {
      map['balance_side'] = Variable<String>(balanceSide.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalPartyOpeningBalancesCompanion(')
          ..write('serverId: $serverId, ')
          ..write('partyServerId: $partyServerId, ')
          ..write('currencyServerId: $currencyServerId, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('currencyNameAr: $currencyNameAr, ')
          ..write('currencySymbol: $currencySymbol, ')
          ..write('currencyDecimalPlaces: $currencyDecimalPlaces, ')
          ..write('balanceSide: $balanceSide, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalWorkersTable extends LocalWorkers
    with TableInfo<$LocalWorkersTable, LocalWorker> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalWorkersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<int> serverId = GeneratedColumn<int>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _jobTitleMeta = const VerificationMeta(
    'jobTitle',
  );
  @override
  late final GeneratedColumn<String> jobTitle = GeneratedColumn<String>(
    'job_title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wageTypeMeta = const VerificationMeta(
    'wageType',
  );
  @override
  late final GeneratedColumn<String> wageType = GeneratedColumn<String>(
    'wage_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wageCurrencyServerIdMeta =
      const VerificationMeta('wageCurrencyServerId');
  @override
  late final GeneratedColumn<int> wageCurrencyServerId = GeneratedColumn<int>(
    'wage_currency_server_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wageCurrencyCodeMeta = const VerificationMeta(
    'wageCurrencyCode',
  );
  @override
  late final GeneratedColumn<String> wageCurrencyCode = GeneratedColumn<String>(
    'wage_currency_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wageCurrencySymbolMeta =
      const VerificationMeta('wageCurrencySymbol');
  @override
  late final GeneratedColumn<String> wageCurrencySymbol =
      GeneratedColumn<String>(
        'wage_currency_symbol',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _wageCurrencyDecimalPlacesMeta =
      const VerificationMeta('wageCurrencyDecimalPlaces');
  @override
  late final GeneratedColumn<int> wageCurrencyDecimalPlaces =
      GeneratedColumn<int>(
        'wage_currency_decimal_places',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _wageAmountMinorMeta = const VerificationMeta(
    'wageAmountMinor',
  );
  @override
  late final GeneratedColumn<int> wageAmountMinor = GeneratedColumn<int>(
    'wage_amount_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hireDateMeta = const VerificationMeta(
    'hireDate',
  );
  @override
  late final GeneratedColumn<DateTime> hireDate = GeneratedColumn<DateTime>(
    'hire_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    serverId,
    uuid,
    name,
    phone,
    jobTitle,
    wageType,
    wageCurrencyServerId,
    wageCurrencyCode,
    wageCurrencySymbol,
    wageCurrencyDecimalPlaces,
    wageAmountMinor,
    hireDate,
    notes,
    isActive,
    version,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_workers';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalWorker> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('job_title')) {
      context.handle(
        _jobTitleMeta,
        jobTitle.isAcceptableOrUnknown(data['job_title']!, _jobTitleMeta),
      );
    }
    if (data.containsKey('wage_type')) {
      context.handle(
        _wageTypeMeta,
        wageType.isAcceptableOrUnknown(data['wage_type']!, _wageTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_wageTypeMeta);
    }
    if (data.containsKey('wage_currency_server_id')) {
      context.handle(
        _wageCurrencyServerIdMeta,
        wageCurrencyServerId.isAcceptableOrUnknown(
          data['wage_currency_server_id']!,
          _wageCurrencyServerIdMeta,
        ),
      );
    }
    if (data.containsKey('wage_currency_code')) {
      context.handle(
        _wageCurrencyCodeMeta,
        wageCurrencyCode.isAcceptableOrUnknown(
          data['wage_currency_code']!,
          _wageCurrencyCodeMeta,
        ),
      );
    }
    if (data.containsKey('wage_currency_symbol')) {
      context.handle(
        _wageCurrencySymbolMeta,
        wageCurrencySymbol.isAcceptableOrUnknown(
          data['wage_currency_symbol']!,
          _wageCurrencySymbolMeta,
        ),
      );
    }
    if (data.containsKey('wage_currency_decimal_places')) {
      context.handle(
        _wageCurrencyDecimalPlacesMeta,
        wageCurrencyDecimalPlaces.isAcceptableOrUnknown(
          data['wage_currency_decimal_places']!,
          _wageCurrencyDecimalPlacesMeta,
        ),
      );
    }
    if (data.containsKey('wage_amount_minor')) {
      context.handle(
        _wageAmountMinorMeta,
        wageAmountMinor.isAcceptableOrUnknown(
          data['wage_amount_minor']!,
          _wageAmountMinorMeta,
        ),
      );
    }
    if (data.containsKey('hire_date')) {
      context.handle(
        _hireDateMeta,
        hireDate.isAcceptableOrUnknown(data['hire_date']!, _hireDateMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {serverId};
  @override
  LocalWorker map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalWorker(
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      jobTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_title'],
      ),
      wageType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wage_type'],
      )!,
      wageCurrencyServerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wage_currency_server_id'],
      ),
      wageCurrencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wage_currency_code'],
      ),
      wageCurrencySymbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wage_currency_symbol'],
      ),
      wageCurrencyDecimalPlaces: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wage_currency_decimal_places'],
      ),
      wageAmountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wage_amount_minor'],
      ),
      hireDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}hire_date'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $LocalWorkersTable createAlias(String alias) {
    return $LocalWorkersTable(attachedDatabase, alias);
  }
}

class LocalWorker extends DataClass implements Insertable<LocalWorker> {
  final int serverId;
  final String uuid;
  final String name;
  final String? phone;
  final String? jobTitle;
  final String wageType;
  final int? wageCurrencyServerId;
  final String? wageCurrencyCode;
  final String? wageCurrencySymbol;
  final int? wageCurrencyDecimalPlaces;
  final int? wageAmountMinor;
  final DateTime? hireDate;
  final String? notes;
  final bool isActive;
  final int version;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const LocalWorker({
    required this.serverId,
    required this.uuid,
    required this.name,
    this.phone,
    this.jobTitle,
    required this.wageType,
    this.wageCurrencyServerId,
    this.wageCurrencyCode,
    this.wageCurrencySymbol,
    this.wageCurrencyDecimalPlaces,
    this.wageAmountMinor,
    this.hireDate,
    this.notes,
    required this.isActive,
    required this.version,
    this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['server_id'] = Variable<int>(serverId);
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || jobTitle != null) {
      map['job_title'] = Variable<String>(jobTitle);
    }
    map['wage_type'] = Variable<String>(wageType);
    if (!nullToAbsent || wageCurrencyServerId != null) {
      map['wage_currency_server_id'] = Variable<int>(wageCurrencyServerId);
    }
    if (!nullToAbsent || wageCurrencyCode != null) {
      map['wage_currency_code'] = Variable<String>(wageCurrencyCode);
    }
    if (!nullToAbsent || wageCurrencySymbol != null) {
      map['wage_currency_symbol'] = Variable<String>(wageCurrencySymbol);
    }
    if (!nullToAbsent || wageCurrencyDecimalPlaces != null) {
      map['wage_currency_decimal_places'] = Variable<int>(
        wageCurrencyDecimalPlaces,
      );
    }
    if (!nullToAbsent || wageAmountMinor != null) {
      map['wage_amount_minor'] = Variable<int>(wageAmountMinor);
    }
    if (!nullToAbsent || hireDate != null) {
      map['hire_date'] = Variable<DateTime>(hireDate);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['version'] = Variable<int>(version);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  LocalWorkersCompanion toCompanion(bool nullToAbsent) {
    return LocalWorkersCompanion(
      serverId: Value(serverId),
      uuid: Value(uuid),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      jobTitle: jobTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(jobTitle),
      wageType: Value(wageType),
      wageCurrencyServerId: wageCurrencyServerId == null && nullToAbsent
          ? const Value.absent()
          : Value(wageCurrencyServerId),
      wageCurrencyCode: wageCurrencyCode == null && nullToAbsent
          ? const Value.absent()
          : Value(wageCurrencyCode),
      wageCurrencySymbol: wageCurrencySymbol == null && nullToAbsent
          ? const Value.absent()
          : Value(wageCurrencySymbol),
      wageCurrencyDecimalPlaces:
          wageCurrencyDecimalPlaces == null && nullToAbsent
          ? const Value.absent()
          : Value(wageCurrencyDecimalPlaces),
      wageAmountMinor: wageAmountMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(wageAmountMinor),
      hireDate: hireDate == null && nullToAbsent
          ? const Value.absent()
          : Value(hireDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isActive: Value(isActive),
      version: Value(version),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory LocalWorker.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalWorker(
      serverId: serializer.fromJson<int>(json['serverId']),
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      jobTitle: serializer.fromJson<String?>(json['jobTitle']),
      wageType: serializer.fromJson<String>(json['wageType']),
      wageCurrencyServerId: serializer.fromJson<int?>(
        json['wageCurrencyServerId'],
      ),
      wageCurrencyCode: serializer.fromJson<String?>(json['wageCurrencyCode']),
      wageCurrencySymbol: serializer.fromJson<String?>(
        json['wageCurrencySymbol'],
      ),
      wageCurrencyDecimalPlaces: serializer.fromJson<int?>(
        json['wageCurrencyDecimalPlaces'],
      ),
      wageAmountMinor: serializer.fromJson<int?>(json['wageAmountMinor']),
      hireDate: serializer.fromJson<DateTime?>(json['hireDate']),
      notes: serializer.fromJson<String?>(json['notes']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      version: serializer.fromJson<int>(json['version']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'serverId': serializer.toJson<int>(serverId),
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'jobTitle': serializer.toJson<String?>(jobTitle),
      'wageType': serializer.toJson<String>(wageType),
      'wageCurrencyServerId': serializer.toJson<int?>(wageCurrencyServerId),
      'wageCurrencyCode': serializer.toJson<String?>(wageCurrencyCode),
      'wageCurrencySymbol': serializer.toJson<String?>(wageCurrencySymbol),
      'wageCurrencyDecimalPlaces': serializer.toJson<int?>(
        wageCurrencyDecimalPlaces,
      ),
      'wageAmountMinor': serializer.toJson<int?>(wageAmountMinor),
      'hireDate': serializer.toJson<DateTime?>(hireDate),
      'notes': serializer.toJson<String?>(notes),
      'isActive': serializer.toJson<bool>(isActive),
      'version': serializer.toJson<int>(version),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  LocalWorker copyWith({
    int? serverId,
    String? uuid,
    String? name,
    Value<String?> phone = const Value.absent(),
    Value<String?> jobTitle = const Value.absent(),
    String? wageType,
    Value<int?> wageCurrencyServerId = const Value.absent(),
    Value<String?> wageCurrencyCode = const Value.absent(),
    Value<String?> wageCurrencySymbol = const Value.absent(),
    Value<int?> wageCurrencyDecimalPlaces = const Value.absent(),
    Value<int?> wageAmountMinor = const Value.absent(),
    Value<DateTime?> hireDate = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? isActive,
    int? version,
    Value<DateTime?> createdAt = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => LocalWorker(
    serverId: serverId ?? this.serverId,
    uuid: uuid ?? this.uuid,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    jobTitle: jobTitle.present ? jobTitle.value : this.jobTitle,
    wageType: wageType ?? this.wageType,
    wageCurrencyServerId: wageCurrencyServerId.present
        ? wageCurrencyServerId.value
        : this.wageCurrencyServerId,
    wageCurrencyCode: wageCurrencyCode.present
        ? wageCurrencyCode.value
        : this.wageCurrencyCode,
    wageCurrencySymbol: wageCurrencySymbol.present
        ? wageCurrencySymbol.value
        : this.wageCurrencySymbol,
    wageCurrencyDecimalPlaces: wageCurrencyDecimalPlaces.present
        ? wageCurrencyDecimalPlaces.value
        : this.wageCurrencyDecimalPlaces,
    wageAmountMinor: wageAmountMinor.present
        ? wageAmountMinor.value
        : this.wageAmountMinor,
    hireDate: hireDate.present ? hireDate.value : this.hireDate,
    notes: notes.present ? notes.value : this.notes,
    isActive: isActive ?? this.isActive,
    version: version ?? this.version,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  LocalWorker copyWithCompanion(LocalWorkersCompanion data) {
    return LocalWorker(
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      jobTitle: data.jobTitle.present ? data.jobTitle.value : this.jobTitle,
      wageType: data.wageType.present ? data.wageType.value : this.wageType,
      wageCurrencyServerId: data.wageCurrencyServerId.present
          ? data.wageCurrencyServerId.value
          : this.wageCurrencyServerId,
      wageCurrencyCode: data.wageCurrencyCode.present
          ? data.wageCurrencyCode.value
          : this.wageCurrencyCode,
      wageCurrencySymbol: data.wageCurrencySymbol.present
          ? data.wageCurrencySymbol.value
          : this.wageCurrencySymbol,
      wageCurrencyDecimalPlaces: data.wageCurrencyDecimalPlaces.present
          ? data.wageCurrencyDecimalPlaces.value
          : this.wageCurrencyDecimalPlaces,
      wageAmountMinor: data.wageAmountMinor.present
          ? data.wageAmountMinor.value
          : this.wageAmountMinor,
      hireDate: data.hireDate.present ? data.hireDate.value : this.hireDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      version: data.version.present ? data.version.value : this.version,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalWorker(')
          ..write('serverId: $serverId, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('jobTitle: $jobTitle, ')
          ..write('wageType: $wageType, ')
          ..write('wageCurrencyServerId: $wageCurrencyServerId, ')
          ..write('wageCurrencyCode: $wageCurrencyCode, ')
          ..write('wageCurrencySymbol: $wageCurrencySymbol, ')
          ..write('wageCurrencyDecimalPlaces: $wageCurrencyDecimalPlaces, ')
          ..write('wageAmountMinor: $wageAmountMinor, ')
          ..write('hireDate: $hireDate, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('version: $version, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    serverId,
    uuid,
    name,
    phone,
    jobTitle,
    wageType,
    wageCurrencyServerId,
    wageCurrencyCode,
    wageCurrencySymbol,
    wageCurrencyDecimalPlaces,
    wageAmountMinor,
    hireDate,
    notes,
    isActive,
    version,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalWorker &&
          other.serverId == this.serverId &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.jobTitle == this.jobTitle &&
          other.wageType == this.wageType &&
          other.wageCurrencyServerId == this.wageCurrencyServerId &&
          other.wageCurrencyCode == this.wageCurrencyCode &&
          other.wageCurrencySymbol == this.wageCurrencySymbol &&
          other.wageCurrencyDecimalPlaces == this.wageCurrencyDecimalPlaces &&
          other.wageAmountMinor == this.wageAmountMinor &&
          other.hireDate == this.hireDate &&
          other.notes == this.notes &&
          other.isActive == this.isActive &&
          other.version == this.version &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalWorkersCompanion extends UpdateCompanion<LocalWorker> {
  final Value<int> serverId;
  final Value<String> uuid;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> jobTitle;
  final Value<String> wageType;
  final Value<int?> wageCurrencyServerId;
  final Value<String?> wageCurrencyCode;
  final Value<String?> wageCurrencySymbol;
  final Value<int?> wageCurrencyDecimalPlaces;
  final Value<int?> wageAmountMinor;
  final Value<DateTime?> hireDate;
  final Value<String?> notes;
  final Value<bool> isActive;
  final Value<int> version;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  const LocalWorkersCompanion({
    this.serverId = const Value.absent(),
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.jobTitle = const Value.absent(),
    this.wageType = const Value.absent(),
    this.wageCurrencyServerId = const Value.absent(),
    this.wageCurrencyCode = const Value.absent(),
    this.wageCurrencySymbol = const Value.absent(),
    this.wageCurrencyDecimalPlaces = const Value.absent(),
    this.wageAmountMinor = const Value.absent(),
    this.hireDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.version = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LocalWorkersCompanion.insert({
    this.serverId = const Value.absent(),
    required String uuid,
    required String name,
    this.phone = const Value.absent(),
    this.jobTitle = const Value.absent(),
    required String wageType,
    this.wageCurrencyServerId = const Value.absent(),
    this.wageCurrencyCode = const Value.absent(),
    this.wageCurrencySymbol = const Value.absent(),
    this.wageCurrencyDecimalPlaces = const Value.absent(),
    this.wageAmountMinor = const Value.absent(),
    this.hireDate = const Value.absent(),
    this.notes = const Value.absent(),
    required bool isActive,
    required int version,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : uuid = Value(uuid),
       name = Value(name),
       wageType = Value(wageType),
       isActive = Value(isActive),
       version = Value(version);
  static Insertable<LocalWorker> custom({
    Expression<int>? serverId,
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? jobTitle,
    Expression<String>? wageType,
    Expression<int>? wageCurrencyServerId,
    Expression<String>? wageCurrencyCode,
    Expression<String>? wageCurrencySymbol,
    Expression<int>? wageCurrencyDecimalPlaces,
    Expression<int>? wageAmountMinor,
    Expression<DateTime>? hireDate,
    Expression<String>? notes,
    Expression<bool>? isActive,
    Expression<int>? version,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (serverId != null) 'server_id': serverId,
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (jobTitle != null) 'job_title': jobTitle,
      if (wageType != null) 'wage_type': wageType,
      if (wageCurrencyServerId != null)
        'wage_currency_server_id': wageCurrencyServerId,
      if (wageCurrencyCode != null) 'wage_currency_code': wageCurrencyCode,
      if (wageCurrencySymbol != null)
        'wage_currency_symbol': wageCurrencySymbol,
      if (wageCurrencyDecimalPlaces != null)
        'wage_currency_decimal_places': wageCurrencyDecimalPlaces,
      if (wageAmountMinor != null) 'wage_amount_minor': wageAmountMinor,
      if (hireDate != null) 'hire_date': hireDate,
      if (notes != null) 'notes': notes,
      if (isActive != null) 'is_active': isActive,
      if (version != null) 'version': version,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LocalWorkersCompanion copyWith({
    Value<int>? serverId,
    Value<String>? uuid,
    Value<String>? name,
    Value<String?>? phone,
    Value<String?>? jobTitle,
    Value<String>? wageType,
    Value<int?>? wageCurrencyServerId,
    Value<String?>? wageCurrencyCode,
    Value<String?>? wageCurrencySymbol,
    Value<int?>? wageCurrencyDecimalPlaces,
    Value<int?>? wageAmountMinor,
    Value<DateTime?>? hireDate,
    Value<String?>? notes,
    Value<bool>? isActive,
    Value<int>? version,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return LocalWorkersCompanion(
      serverId: serverId ?? this.serverId,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      jobTitle: jobTitle ?? this.jobTitle,
      wageType: wageType ?? this.wageType,
      wageCurrencyServerId: wageCurrencyServerId ?? this.wageCurrencyServerId,
      wageCurrencyCode: wageCurrencyCode ?? this.wageCurrencyCode,
      wageCurrencySymbol: wageCurrencySymbol ?? this.wageCurrencySymbol,
      wageCurrencyDecimalPlaces:
          wageCurrencyDecimalPlaces ?? this.wageCurrencyDecimalPlaces,
      wageAmountMinor: wageAmountMinor ?? this.wageAmountMinor,
      hireDate: hireDate ?? this.hireDate,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (jobTitle.present) {
      map['job_title'] = Variable<String>(jobTitle.value);
    }
    if (wageType.present) {
      map['wage_type'] = Variable<String>(wageType.value);
    }
    if (wageCurrencyServerId.present) {
      map['wage_currency_server_id'] = Variable<int>(
        wageCurrencyServerId.value,
      );
    }
    if (wageCurrencyCode.present) {
      map['wage_currency_code'] = Variable<String>(wageCurrencyCode.value);
    }
    if (wageCurrencySymbol.present) {
      map['wage_currency_symbol'] = Variable<String>(wageCurrencySymbol.value);
    }
    if (wageCurrencyDecimalPlaces.present) {
      map['wage_currency_decimal_places'] = Variable<int>(
        wageCurrencyDecimalPlaces.value,
      );
    }
    if (wageAmountMinor.present) {
      map['wage_amount_minor'] = Variable<int>(wageAmountMinor.value);
    }
    if (hireDate.present) {
      map['hire_date'] = Variable<DateTime>(hireDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalWorkersCompanion(')
          ..write('serverId: $serverId, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('jobTitle: $jobTitle, ')
          ..write('wageType: $wageType, ')
          ..write('wageCurrencyServerId: $wageCurrencyServerId, ')
          ..write('wageCurrencyCode: $wageCurrencyCode, ')
          ..write('wageCurrencySymbol: $wageCurrencySymbol, ')
          ..write('wageCurrencyDecimalPlaces: $wageCurrencyDecimalPlaces, ')
          ..write('wageAmountMinor: $wageAmountMinor, ')
          ..write('hireDate: $hireDate, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('version: $version, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LocalWorkerOpeningBalancesTable extends LocalWorkerOpeningBalances
    with
        TableInfo<$LocalWorkerOpeningBalancesTable, LocalWorkerOpeningBalance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalWorkerOpeningBalancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<int> serverId = GeneratedColumn<int>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workerServerIdMeta = const VerificationMeta(
    'workerServerId',
  );
  @override
  late final GeneratedColumn<int> workerServerId = GeneratedColumn<int>(
    'worker_server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyServerIdMeta = const VerificationMeta(
    'currencyServerId',
  );
  @override
  late final GeneratedColumn<int> currencyServerId = GeneratedColumn<int>(
    'currency_server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyNameArMeta = const VerificationMeta(
    'currencyNameAr',
  );
  @override
  late final GeneratedColumn<String> currencyNameAr = GeneratedColumn<String>(
    'currency_name_ar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencySymbolMeta = const VerificationMeta(
    'currencySymbol',
  );
  @override
  late final GeneratedColumn<String> currencySymbol = GeneratedColumn<String>(
    'currency_symbol',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyDecimalPlacesMeta =
      const VerificationMeta('currencyDecimalPlaces');
  @override
  late final GeneratedColumn<int> currencyDecimalPlaces = GeneratedColumn<int>(
    'currency_decimal_places',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _balanceSideMeta = const VerificationMeta(
    'balanceSide',
  );
  @override
  late final GeneratedColumn<String> balanceSide = GeneratedColumn<String>(
    'balance_side',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    serverId,
    workerServerId,
    currencyServerId,
    currencyCode,
    currencyNameAr,
    currencySymbol,
    currencyDecimalPlaces,
    balanceSide,
    amountMinor,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_worker_opening_balances';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalWorkerOpeningBalance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('worker_server_id')) {
      context.handle(
        _workerServerIdMeta,
        workerServerId.isAcceptableOrUnknown(
          data['worker_server_id']!,
          _workerServerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workerServerIdMeta);
    }
    if (data.containsKey('currency_server_id')) {
      context.handle(
        _currencyServerIdMeta,
        currencyServerId.isAcceptableOrUnknown(
          data['currency_server_id']!,
          _currencyServerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyServerIdMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('currency_name_ar')) {
      context.handle(
        _currencyNameArMeta,
        currencyNameAr.isAcceptableOrUnknown(
          data['currency_name_ar']!,
          _currencyNameArMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyNameArMeta);
    }
    if (data.containsKey('currency_symbol')) {
      context.handle(
        _currencySymbolMeta,
        currencySymbol.isAcceptableOrUnknown(
          data['currency_symbol']!,
          _currencySymbolMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencySymbolMeta);
    }
    if (data.containsKey('currency_decimal_places')) {
      context.handle(
        _currencyDecimalPlacesMeta,
        currencyDecimalPlaces.isAcceptableOrUnknown(
          data['currency_decimal_places']!,
          _currencyDecimalPlacesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyDecimalPlacesMeta);
    }
    if (data.containsKey('balance_side')) {
      context.handle(
        _balanceSideMeta,
        balanceSide.isAcceptableOrUnknown(
          data['balance_side']!,
          _balanceSideMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_balanceSideMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {
    workerServerId,
    currencyServerId,
    balanceSide,
  };
  @override
  LocalWorkerOpeningBalance map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalWorkerOpeningBalance(
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_id'],
      ),
      workerServerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}worker_server_id'],
      )!,
      currencyServerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}currency_server_id'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      currencyNameAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_name_ar'],
      )!,
      currencySymbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_symbol'],
      )!,
      currencyDecimalPlaces: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}currency_decimal_places'],
      )!,
      balanceSide: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}balance_side'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
    );
  }

  @override
  $LocalWorkerOpeningBalancesTable createAlias(String alias) {
    return $LocalWorkerOpeningBalancesTable(attachedDatabase, alias);
  }
}

class LocalWorkerOpeningBalance extends DataClass
    implements Insertable<LocalWorkerOpeningBalance> {
  final int? serverId;
  final int workerServerId;
  final int currencyServerId;
  final String currencyCode;
  final String currencyNameAr;
  final String currencySymbol;
  final int currencyDecimalPlaces;
  final String balanceSide;
  final int amountMinor;
  const LocalWorkerOpeningBalance({
    this.serverId,
    required this.workerServerId,
    required this.currencyServerId,
    required this.currencyCode,
    required this.currencyNameAr,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
    required this.balanceSide,
    required this.amountMinor,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<int>(serverId);
    }
    map['worker_server_id'] = Variable<int>(workerServerId);
    map['currency_server_id'] = Variable<int>(currencyServerId);
    map['currency_code'] = Variable<String>(currencyCode);
    map['currency_name_ar'] = Variable<String>(currencyNameAr);
    map['currency_symbol'] = Variable<String>(currencySymbol);
    map['currency_decimal_places'] = Variable<int>(currencyDecimalPlaces);
    map['balance_side'] = Variable<String>(balanceSide);
    map['amount_minor'] = Variable<int>(amountMinor);
    return map;
  }

  LocalWorkerOpeningBalancesCompanion toCompanion(bool nullToAbsent) {
    return LocalWorkerOpeningBalancesCompanion(
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      workerServerId: Value(workerServerId),
      currencyServerId: Value(currencyServerId),
      currencyCode: Value(currencyCode),
      currencyNameAr: Value(currencyNameAr),
      currencySymbol: Value(currencySymbol),
      currencyDecimalPlaces: Value(currencyDecimalPlaces),
      balanceSide: Value(balanceSide),
      amountMinor: Value(amountMinor),
    );
  }

  factory LocalWorkerOpeningBalance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalWorkerOpeningBalance(
      serverId: serializer.fromJson<int?>(json['serverId']),
      workerServerId: serializer.fromJson<int>(json['workerServerId']),
      currencyServerId: serializer.fromJson<int>(json['currencyServerId']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      currencyNameAr: serializer.fromJson<String>(json['currencyNameAr']),
      currencySymbol: serializer.fromJson<String>(json['currencySymbol']),
      currencyDecimalPlaces: serializer.fromJson<int>(
        json['currencyDecimalPlaces'],
      ),
      balanceSide: serializer.fromJson<String>(json['balanceSide']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'serverId': serializer.toJson<int?>(serverId),
      'workerServerId': serializer.toJson<int>(workerServerId),
      'currencyServerId': serializer.toJson<int>(currencyServerId),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'currencyNameAr': serializer.toJson<String>(currencyNameAr),
      'currencySymbol': serializer.toJson<String>(currencySymbol),
      'currencyDecimalPlaces': serializer.toJson<int>(currencyDecimalPlaces),
      'balanceSide': serializer.toJson<String>(balanceSide),
      'amountMinor': serializer.toJson<int>(amountMinor),
    };
  }

  LocalWorkerOpeningBalance copyWith({
    Value<int?> serverId = const Value.absent(),
    int? workerServerId,
    int? currencyServerId,
    String? currencyCode,
    String? currencyNameAr,
    String? currencySymbol,
    int? currencyDecimalPlaces,
    String? balanceSide,
    int? amountMinor,
  }) => LocalWorkerOpeningBalance(
    serverId: serverId.present ? serverId.value : this.serverId,
    workerServerId: workerServerId ?? this.workerServerId,
    currencyServerId: currencyServerId ?? this.currencyServerId,
    currencyCode: currencyCode ?? this.currencyCode,
    currencyNameAr: currencyNameAr ?? this.currencyNameAr,
    currencySymbol: currencySymbol ?? this.currencySymbol,
    currencyDecimalPlaces: currencyDecimalPlaces ?? this.currencyDecimalPlaces,
    balanceSide: balanceSide ?? this.balanceSide,
    amountMinor: amountMinor ?? this.amountMinor,
  );
  LocalWorkerOpeningBalance copyWithCompanion(
    LocalWorkerOpeningBalancesCompanion data,
  ) {
    return LocalWorkerOpeningBalance(
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      workerServerId: data.workerServerId.present
          ? data.workerServerId.value
          : this.workerServerId,
      currencyServerId: data.currencyServerId.present
          ? data.currencyServerId.value
          : this.currencyServerId,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      currencyNameAr: data.currencyNameAr.present
          ? data.currencyNameAr.value
          : this.currencyNameAr,
      currencySymbol: data.currencySymbol.present
          ? data.currencySymbol.value
          : this.currencySymbol,
      currencyDecimalPlaces: data.currencyDecimalPlaces.present
          ? data.currencyDecimalPlaces.value
          : this.currencyDecimalPlaces,
      balanceSide: data.balanceSide.present
          ? data.balanceSide.value
          : this.balanceSide,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalWorkerOpeningBalance(')
          ..write('serverId: $serverId, ')
          ..write('workerServerId: $workerServerId, ')
          ..write('currencyServerId: $currencyServerId, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('currencyNameAr: $currencyNameAr, ')
          ..write('currencySymbol: $currencySymbol, ')
          ..write('currencyDecimalPlaces: $currencyDecimalPlaces, ')
          ..write('balanceSide: $balanceSide, ')
          ..write('amountMinor: $amountMinor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    serverId,
    workerServerId,
    currencyServerId,
    currencyCode,
    currencyNameAr,
    currencySymbol,
    currencyDecimalPlaces,
    balanceSide,
    amountMinor,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalWorkerOpeningBalance &&
          other.serverId == this.serverId &&
          other.workerServerId == this.workerServerId &&
          other.currencyServerId == this.currencyServerId &&
          other.currencyCode == this.currencyCode &&
          other.currencyNameAr == this.currencyNameAr &&
          other.currencySymbol == this.currencySymbol &&
          other.currencyDecimalPlaces == this.currencyDecimalPlaces &&
          other.balanceSide == this.balanceSide &&
          other.amountMinor == this.amountMinor);
}

class LocalWorkerOpeningBalancesCompanion
    extends UpdateCompanion<LocalWorkerOpeningBalance> {
  final Value<int?> serverId;
  final Value<int> workerServerId;
  final Value<int> currencyServerId;
  final Value<String> currencyCode;
  final Value<String> currencyNameAr;
  final Value<String> currencySymbol;
  final Value<int> currencyDecimalPlaces;
  final Value<String> balanceSide;
  final Value<int> amountMinor;
  final Value<int> rowid;
  const LocalWorkerOpeningBalancesCompanion({
    this.serverId = const Value.absent(),
    this.workerServerId = const Value.absent(),
    this.currencyServerId = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.currencyNameAr = const Value.absent(),
    this.currencySymbol = const Value.absent(),
    this.currencyDecimalPlaces = const Value.absent(),
    this.balanceSide = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalWorkerOpeningBalancesCompanion.insert({
    this.serverId = const Value.absent(),
    required int workerServerId,
    required int currencyServerId,
    required String currencyCode,
    required String currencyNameAr,
    required String currencySymbol,
    required int currencyDecimalPlaces,
    required String balanceSide,
    required int amountMinor,
    this.rowid = const Value.absent(),
  }) : workerServerId = Value(workerServerId),
       currencyServerId = Value(currencyServerId),
       currencyCode = Value(currencyCode),
       currencyNameAr = Value(currencyNameAr),
       currencySymbol = Value(currencySymbol),
       currencyDecimalPlaces = Value(currencyDecimalPlaces),
       balanceSide = Value(balanceSide),
       amountMinor = Value(amountMinor);
  static Insertable<LocalWorkerOpeningBalance> custom({
    Expression<int>? serverId,
    Expression<int>? workerServerId,
    Expression<int>? currencyServerId,
    Expression<String>? currencyCode,
    Expression<String>? currencyNameAr,
    Expression<String>? currencySymbol,
    Expression<int>? currencyDecimalPlaces,
    Expression<String>? balanceSide,
    Expression<int>? amountMinor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (serverId != null) 'server_id': serverId,
      if (workerServerId != null) 'worker_server_id': workerServerId,
      if (currencyServerId != null) 'currency_server_id': currencyServerId,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (currencyNameAr != null) 'currency_name_ar': currencyNameAr,
      if (currencySymbol != null) 'currency_symbol': currencySymbol,
      if (currencyDecimalPlaces != null)
        'currency_decimal_places': currencyDecimalPlaces,
      if (balanceSide != null) 'balance_side': balanceSide,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalWorkerOpeningBalancesCompanion copyWith({
    Value<int?>? serverId,
    Value<int>? workerServerId,
    Value<int>? currencyServerId,
    Value<String>? currencyCode,
    Value<String>? currencyNameAr,
    Value<String>? currencySymbol,
    Value<int>? currencyDecimalPlaces,
    Value<String>? balanceSide,
    Value<int>? amountMinor,
    Value<int>? rowid,
  }) {
    return LocalWorkerOpeningBalancesCompanion(
      serverId: serverId ?? this.serverId,
      workerServerId: workerServerId ?? this.workerServerId,
      currencyServerId: currencyServerId ?? this.currencyServerId,
      currencyCode: currencyCode ?? this.currencyCode,
      currencyNameAr: currencyNameAr ?? this.currencyNameAr,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      balanceSide: balanceSide ?? this.balanceSide,
      amountMinor: amountMinor ?? this.amountMinor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    if (workerServerId.present) {
      map['worker_server_id'] = Variable<int>(workerServerId.value);
    }
    if (currencyServerId.present) {
      map['currency_server_id'] = Variable<int>(currencyServerId.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (currencyNameAr.present) {
      map['currency_name_ar'] = Variable<String>(currencyNameAr.value);
    }
    if (currencySymbol.present) {
      map['currency_symbol'] = Variable<String>(currencySymbol.value);
    }
    if (currencyDecimalPlaces.present) {
      map['currency_decimal_places'] = Variable<int>(
        currencyDecimalPlaces.value,
      );
    }
    if (balanceSide.present) {
      map['balance_side'] = Variable<String>(balanceSide.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalWorkerOpeningBalancesCompanion(')
          ..write('serverId: $serverId, ')
          ..write('workerServerId: $workerServerId, ')
          ..write('currencyServerId: $currencyServerId, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('currencyNameAr: $currencyNameAr, ')
          ..write('currencySymbol: $currencySymbol, ')
          ..write('currencyDecimalPlaces: $currencyDecimalPlaces, ')
          ..write('balanceSide: $balanceSide, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalAccountingTransactionsTable extends LocalAccountingTransactions
    with
        TableInfo<
          $LocalAccountingTransactionsTable,
          LocalAccountingTransaction
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalAccountingTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<int> serverId = GeneratedColumn<int>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionNoMeta = const VerificationMeta(
    'transactionNo',
  );
  @override
  late final GeneratedColumn<String> transactionNo = GeneratedColumn<String>(
    'transaction_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _settlementModeMeta = const VerificationMeta(
    'settlementMode',
  );
  @override
  late final GeneratedColumn<String> settlementMode = GeneratedColumn<String>(
    'settlement_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyServerIdMeta = const VerificationMeta(
    'currencyServerId',
  );
  @override
  late final GeneratedColumn<int> currencyServerId = GeneratedColumn<int>(
    'currency_server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencySymbolMeta = const VerificationMeta(
    'currencySymbol',
  );
  @override
  late final GeneratedColumn<String> currencySymbol = GeneratedColumn<String>(
    'currency_symbol',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyDecimalPlacesMeta =
      const VerificationMeta('currencyDecimalPlaces');
  @override
  late final GeneratedColumn<int> currencyDecimalPlaces = GeneratedColumn<int>(
    'currency_decimal_places',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paidNowMinorMeta = const VerificationMeta(
    'paidNowMinor',
  );
  @override
  late final GeneratedColumn<int> paidNowMinor = GeneratedColumn<int>(
    'paid_now_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costStatusMeta = const VerificationMeta(
    'costStatus',
  );
  @override
  late final GeneratedColumn<String> costStatus = GeneratedColumn<String>(
    'cost_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('not_applicable'),
  );
  static const VerificationMeta _costTotalMinorMeta = const VerificationMeta(
    'costTotalMinor',
  );
  @override
  late final GeneratedColumn<int> costTotalMinor = GeneratedColumn<int>(
    'cost_total_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _grossProfitMinorMeta = const VerificationMeta(
    'grossProfitMinor',
  );
  @override
  late final GeneratedColumn<int> grossProfitMinor = GeneratedColumn<int>(
    'gross_profit_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _partyServerIdMeta = const VerificationMeta(
    'partyServerId',
  );
  @override
  late final GeneratedColumn<int> partyServerId = GeneratedColumn<int>(
    'party_server_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _partyNameMeta = const VerificationMeta(
    'partyName',
  );
  @override
  late final GeneratedColumn<String> partyName = GeneratedColumn<String>(
    'party_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workerServerIdMeta = const VerificationMeta(
    'workerServerId',
  );
  @override
  late final GeneratedColumn<int> workerServerId = GeneratedColumn<int>(
    'worker_server_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workerNameMeta = const VerificationMeta(
    'workerName',
  );
  @override
  late final GeneratedColumn<String> workerName = GeneratedColumn<String>(
    'worker_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryServerIdMeta = const VerificationMeta(
    'categoryServerId',
  );
  @override
  late final GeneratedColumn<int> categoryServerId = GeneratedColumn<int>(
    'category_server_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryNameMeta = const VerificationMeta(
    'categoryName',
  );
  @override
  late final GeneratedColumn<String> categoryName = GeneratedColumn<String>(
    'category_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _financialAccountServerIdMeta =
      const VerificationMeta('financialAccountServerId');
  @override
  late final GeneratedColumn<int> financialAccountServerId =
      GeneratedColumn<int>(
        'financial_account_server_id',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _financialAccountNameMeta =
      const VerificationMeta('financialAccountName');
  @override
  late final GeneratedColumn<String> financialAccountName =
      GeneratedColumn<String>(
        'financial_account_name',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _targetFinancialAccountServerIdMeta =
      const VerificationMeta('targetFinancialAccountServerId');
  @override
  late final GeneratedColumn<int> targetFinancialAccountServerId =
      GeneratedColumn<int>(
        'target_financial_account_server_id',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _targetFinancialAccountNameMeta =
      const VerificationMeta('targetFinancialAccountName');
  @override
  late final GeneratedColumn<String> targetFinancialAccountName =
      GeneratedColumn<String>(
        'target_financial_account_name',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reversalOfServerIdMeta =
      const VerificationMeta('reversalOfServerId');
  @override
  late final GeneratedColumn<int> reversalOfServerId = GeneratedColumn<int>(
    'reversal_of_server_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdByNameMeta = const VerificationMeta(
    'createdByName',
  );
  @override
  late final GeneratedColumn<String> createdByName = GeneratedColumn<String>(
    'created_by_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    serverId,
    uuid,
    transactionNo,
    type,
    settlementMode,
    currencyServerId,
    currencyCode,
    currencySymbol,
    currencyDecimalPlaces,
    amountMinor,
    paidNowMinor,
    costStatus,
    costTotalMinor,
    grossProfitMinor,
    partyServerId,
    partyName,
    workerServerId,
    workerName,
    categoryServerId,
    categoryName,
    financialAccountServerId,
    financialAccountName,
    targetFinancialAccountServerId,
    targetFinancialAccountName,
    occurredAt,
    description,
    notes,
    status,
    reversalOfServerId,
    createdByName,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_accounting_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalAccountingTransaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('transaction_no')) {
      context.handle(
        _transactionNoMeta,
        transactionNo.isAcceptableOrUnknown(
          data['transaction_no']!,
          _transactionNoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionNoMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('settlement_mode')) {
      context.handle(
        _settlementModeMeta,
        settlementMode.isAcceptableOrUnknown(
          data['settlement_mode']!,
          _settlementModeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_settlementModeMeta);
    }
    if (data.containsKey('currency_server_id')) {
      context.handle(
        _currencyServerIdMeta,
        currencyServerId.isAcceptableOrUnknown(
          data['currency_server_id']!,
          _currencyServerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyServerIdMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('currency_symbol')) {
      context.handle(
        _currencySymbolMeta,
        currencySymbol.isAcceptableOrUnknown(
          data['currency_symbol']!,
          _currencySymbolMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencySymbolMeta);
    }
    if (data.containsKey('currency_decimal_places')) {
      context.handle(
        _currencyDecimalPlacesMeta,
        currencyDecimalPlaces.isAcceptableOrUnknown(
          data['currency_decimal_places']!,
          _currencyDecimalPlacesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyDecimalPlacesMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('paid_now_minor')) {
      context.handle(
        _paidNowMinorMeta,
        paidNowMinor.isAcceptableOrUnknown(
          data['paid_now_minor']!,
          _paidNowMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paidNowMinorMeta);
    }
    if (data.containsKey('cost_status')) {
      context.handle(
        _costStatusMeta,
        costStatus.isAcceptableOrUnknown(data['cost_status']!, _costStatusMeta),
      );
    }
    if (data.containsKey('cost_total_minor')) {
      context.handle(
        _costTotalMinorMeta,
        costTotalMinor.isAcceptableOrUnknown(
          data['cost_total_minor']!,
          _costTotalMinorMeta,
        ),
      );
    }
    if (data.containsKey('gross_profit_minor')) {
      context.handle(
        _grossProfitMinorMeta,
        grossProfitMinor.isAcceptableOrUnknown(
          data['gross_profit_minor']!,
          _grossProfitMinorMeta,
        ),
      );
    }
    if (data.containsKey('party_server_id')) {
      context.handle(
        _partyServerIdMeta,
        partyServerId.isAcceptableOrUnknown(
          data['party_server_id']!,
          _partyServerIdMeta,
        ),
      );
    }
    if (data.containsKey('party_name')) {
      context.handle(
        _partyNameMeta,
        partyName.isAcceptableOrUnknown(data['party_name']!, _partyNameMeta),
      );
    }
    if (data.containsKey('worker_server_id')) {
      context.handle(
        _workerServerIdMeta,
        workerServerId.isAcceptableOrUnknown(
          data['worker_server_id']!,
          _workerServerIdMeta,
        ),
      );
    }
    if (data.containsKey('worker_name')) {
      context.handle(
        _workerNameMeta,
        workerName.isAcceptableOrUnknown(data['worker_name']!, _workerNameMeta),
      );
    }
    if (data.containsKey('category_server_id')) {
      context.handle(
        _categoryServerIdMeta,
        categoryServerId.isAcceptableOrUnknown(
          data['category_server_id']!,
          _categoryServerIdMeta,
        ),
      );
    }
    if (data.containsKey('category_name')) {
      context.handle(
        _categoryNameMeta,
        categoryName.isAcceptableOrUnknown(
          data['category_name']!,
          _categoryNameMeta,
        ),
      );
    }
    if (data.containsKey('financial_account_server_id')) {
      context.handle(
        _financialAccountServerIdMeta,
        financialAccountServerId.isAcceptableOrUnknown(
          data['financial_account_server_id']!,
          _financialAccountServerIdMeta,
        ),
      );
    }
    if (data.containsKey('financial_account_name')) {
      context.handle(
        _financialAccountNameMeta,
        financialAccountName.isAcceptableOrUnknown(
          data['financial_account_name']!,
          _financialAccountNameMeta,
        ),
      );
    }
    if (data.containsKey('target_financial_account_server_id')) {
      context.handle(
        _targetFinancialAccountServerIdMeta,
        targetFinancialAccountServerId.isAcceptableOrUnknown(
          data['target_financial_account_server_id']!,
          _targetFinancialAccountServerIdMeta,
        ),
      );
    }
    if (data.containsKey('target_financial_account_name')) {
      context.handle(
        _targetFinancialAccountNameMeta,
        targetFinancialAccountName.isAcceptableOrUnknown(
          data['target_financial_account_name']!,
          _targetFinancialAccountNameMeta,
        ),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('reversal_of_server_id')) {
      context.handle(
        _reversalOfServerIdMeta,
        reversalOfServerId.isAcceptableOrUnknown(
          data['reversal_of_server_id']!,
          _reversalOfServerIdMeta,
        ),
      );
    }
    if (data.containsKey('created_by_name')) {
      context.handle(
        _createdByNameMeta,
        createdByName.isAcceptableOrUnknown(
          data['created_by_name']!,
          _createdByNameMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {serverId};
  @override
  LocalAccountingTransaction map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalAccountingTransaction(
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      transactionNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_no'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      settlementMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}settlement_mode'],
      )!,
      currencyServerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}currency_server_id'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      currencySymbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_symbol'],
      )!,
      currencyDecimalPlaces: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}currency_decimal_places'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      paidNowMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}paid_now_minor'],
      )!,
      costStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cost_status'],
      )!,
      costTotalMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost_total_minor'],
      ),
      grossProfitMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gross_profit_minor'],
      ),
      partyServerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}party_server_id'],
      ),
      partyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}party_name'],
      ),
      workerServerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}worker_server_id'],
      ),
      workerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}worker_name'],
      ),
      categoryServerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_server_id'],
      ),
      categoryName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_name'],
      ),
      financialAccountServerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}financial_account_server_id'],
      ),
      financialAccountName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}financial_account_name'],
      ),
      targetFinancialAccountServerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_financial_account_server_id'],
      ),
      targetFinancialAccountName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_financial_account_name'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      reversalOfServerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reversal_of_server_id'],
      ),
      createdByName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by_name'],
      ),
    );
  }

  @override
  $LocalAccountingTransactionsTable createAlias(String alias) {
    return $LocalAccountingTransactionsTable(attachedDatabase, alias);
  }
}

class LocalAccountingTransaction extends DataClass
    implements Insertable<LocalAccountingTransaction> {
  final int serverId;
  final String uuid;
  final String transactionNo;
  final String type;
  final String settlementMode;
  final int currencyServerId;
  final String currencyCode;
  final String currencySymbol;
  final int currencyDecimalPlaces;
  final int amountMinor;
  final int paidNowMinor;
  final String costStatus;
  final int? costTotalMinor;
  final int? grossProfitMinor;
  final int? partyServerId;
  final String? partyName;
  final int? workerServerId;
  final String? workerName;
  final int? categoryServerId;
  final String? categoryName;
  final int? financialAccountServerId;
  final String? financialAccountName;
  final int? targetFinancialAccountServerId;
  final String? targetFinancialAccountName;
  final DateTime occurredAt;
  final String? description;
  final String? notes;
  final String status;
  final int? reversalOfServerId;
  final String? createdByName;
  const LocalAccountingTransaction({
    required this.serverId,
    required this.uuid,
    required this.transactionNo,
    required this.type,
    required this.settlementMode,
    required this.currencyServerId,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
    required this.amountMinor,
    required this.paidNowMinor,
    required this.costStatus,
    this.costTotalMinor,
    this.grossProfitMinor,
    this.partyServerId,
    this.partyName,
    this.workerServerId,
    this.workerName,
    this.categoryServerId,
    this.categoryName,
    this.financialAccountServerId,
    this.financialAccountName,
    this.targetFinancialAccountServerId,
    this.targetFinancialAccountName,
    required this.occurredAt,
    this.description,
    this.notes,
    required this.status,
    this.reversalOfServerId,
    this.createdByName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['server_id'] = Variable<int>(serverId);
    map['uuid'] = Variable<String>(uuid);
    map['transaction_no'] = Variable<String>(transactionNo);
    map['type'] = Variable<String>(type);
    map['settlement_mode'] = Variable<String>(settlementMode);
    map['currency_server_id'] = Variable<int>(currencyServerId);
    map['currency_code'] = Variable<String>(currencyCode);
    map['currency_symbol'] = Variable<String>(currencySymbol);
    map['currency_decimal_places'] = Variable<int>(currencyDecimalPlaces);
    map['amount_minor'] = Variable<int>(amountMinor);
    map['paid_now_minor'] = Variable<int>(paidNowMinor);
    map['cost_status'] = Variable<String>(costStatus);
    if (!nullToAbsent || costTotalMinor != null) {
      map['cost_total_minor'] = Variable<int>(costTotalMinor);
    }
    if (!nullToAbsent || grossProfitMinor != null) {
      map['gross_profit_minor'] = Variable<int>(grossProfitMinor);
    }
    if (!nullToAbsent || partyServerId != null) {
      map['party_server_id'] = Variable<int>(partyServerId);
    }
    if (!nullToAbsent || partyName != null) {
      map['party_name'] = Variable<String>(partyName);
    }
    if (!nullToAbsent || workerServerId != null) {
      map['worker_server_id'] = Variable<int>(workerServerId);
    }
    if (!nullToAbsent || workerName != null) {
      map['worker_name'] = Variable<String>(workerName);
    }
    if (!nullToAbsent || categoryServerId != null) {
      map['category_server_id'] = Variable<int>(categoryServerId);
    }
    if (!nullToAbsent || categoryName != null) {
      map['category_name'] = Variable<String>(categoryName);
    }
    if (!nullToAbsent || financialAccountServerId != null) {
      map['financial_account_server_id'] = Variable<int>(
        financialAccountServerId,
      );
    }
    if (!nullToAbsent || financialAccountName != null) {
      map['financial_account_name'] = Variable<String>(financialAccountName);
    }
    if (!nullToAbsent || targetFinancialAccountServerId != null) {
      map['target_financial_account_server_id'] = Variable<int>(
        targetFinancialAccountServerId,
      );
    }
    if (!nullToAbsent || targetFinancialAccountName != null) {
      map['target_financial_account_name'] = Variable<String>(
        targetFinancialAccountName,
      );
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || reversalOfServerId != null) {
      map['reversal_of_server_id'] = Variable<int>(reversalOfServerId);
    }
    if (!nullToAbsent || createdByName != null) {
      map['created_by_name'] = Variable<String>(createdByName);
    }
    return map;
  }

  LocalAccountingTransactionsCompanion toCompanion(bool nullToAbsent) {
    return LocalAccountingTransactionsCompanion(
      serverId: Value(serverId),
      uuid: Value(uuid),
      transactionNo: Value(transactionNo),
      type: Value(type),
      settlementMode: Value(settlementMode),
      currencyServerId: Value(currencyServerId),
      currencyCode: Value(currencyCode),
      currencySymbol: Value(currencySymbol),
      currencyDecimalPlaces: Value(currencyDecimalPlaces),
      amountMinor: Value(amountMinor),
      paidNowMinor: Value(paidNowMinor),
      costStatus: Value(costStatus),
      costTotalMinor: costTotalMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(costTotalMinor),
      grossProfitMinor: grossProfitMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(grossProfitMinor),
      partyServerId: partyServerId == null && nullToAbsent
          ? const Value.absent()
          : Value(partyServerId),
      partyName: partyName == null && nullToAbsent
          ? const Value.absent()
          : Value(partyName),
      workerServerId: workerServerId == null && nullToAbsent
          ? const Value.absent()
          : Value(workerServerId),
      workerName: workerName == null && nullToAbsent
          ? const Value.absent()
          : Value(workerName),
      categoryServerId: categoryServerId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryServerId),
      categoryName: categoryName == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryName),
      financialAccountServerId: financialAccountServerId == null && nullToAbsent
          ? const Value.absent()
          : Value(financialAccountServerId),
      financialAccountName: financialAccountName == null && nullToAbsent
          ? const Value.absent()
          : Value(financialAccountName),
      targetFinancialAccountServerId:
          targetFinancialAccountServerId == null && nullToAbsent
          ? const Value.absent()
          : Value(targetFinancialAccountServerId),
      targetFinancialAccountName:
          targetFinancialAccountName == null && nullToAbsent
          ? const Value.absent()
          : Value(targetFinancialAccountName),
      occurredAt: Value(occurredAt),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      status: Value(status),
      reversalOfServerId: reversalOfServerId == null && nullToAbsent
          ? const Value.absent()
          : Value(reversalOfServerId),
      createdByName: createdByName == null && nullToAbsent
          ? const Value.absent()
          : Value(createdByName),
    );
  }

  factory LocalAccountingTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalAccountingTransaction(
      serverId: serializer.fromJson<int>(json['serverId']),
      uuid: serializer.fromJson<String>(json['uuid']),
      transactionNo: serializer.fromJson<String>(json['transactionNo']),
      type: serializer.fromJson<String>(json['type']),
      settlementMode: serializer.fromJson<String>(json['settlementMode']),
      currencyServerId: serializer.fromJson<int>(json['currencyServerId']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      currencySymbol: serializer.fromJson<String>(json['currencySymbol']),
      currencyDecimalPlaces: serializer.fromJson<int>(
        json['currencyDecimalPlaces'],
      ),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      paidNowMinor: serializer.fromJson<int>(json['paidNowMinor']),
      costStatus: serializer.fromJson<String>(json['costStatus']),
      costTotalMinor: serializer.fromJson<int?>(json['costTotalMinor']),
      grossProfitMinor: serializer.fromJson<int?>(json['grossProfitMinor']),
      partyServerId: serializer.fromJson<int?>(json['partyServerId']),
      partyName: serializer.fromJson<String?>(json['partyName']),
      workerServerId: serializer.fromJson<int?>(json['workerServerId']),
      workerName: serializer.fromJson<String?>(json['workerName']),
      categoryServerId: serializer.fromJson<int?>(json['categoryServerId']),
      categoryName: serializer.fromJson<String?>(json['categoryName']),
      financialAccountServerId: serializer.fromJson<int?>(
        json['financialAccountServerId'],
      ),
      financialAccountName: serializer.fromJson<String?>(
        json['financialAccountName'],
      ),
      targetFinancialAccountServerId: serializer.fromJson<int?>(
        json['targetFinancialAccountServerId'],
      ),
      targetFinancialAccountName: serializer.fromJson<String?>(
        json['targetFinancialAccountName'],
      ),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      description: serializer.fromJson<String?>(json['description']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
      reversalOfServerId: serializer.fromJson<int?>(json['reversalOfServerId']),
      createdByName: serializer.fromJson<String?>(json['createdByName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'serverId': serializer.toJson<int>(serverId),
      'uuid': serializer.toJson<String>(uuid),
      'transactionNo': serializer.toJson<String>(transactionNo),
      'type': serializer.toJson<String>(type),
      'settlementMode': serializer.toJson<String>(settlementMode),
      'currencyServerId': serializer.toJson<int>(currencyServerId),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'currencySymbol': serializer.toJson<String>(currencySymbol),
      'currencyDecimalPlaces': serializer.toJson<int>(currencyDecimalPlaces),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'paidNowMinor': serializer.toJson<int>(paidNowMinor),
      'costStatus': serializer.toJson<String>(costStatus),
      'costTotalMinor': serializer.toJson<int?>(costTotalMinor),
      'grossProfitMinor': serializer.toJson<int?>(grossProfitMinor),
      'partyServerId': serializer.toJson<int?>(partyServerId),
      'partyName': serializer.toJson<String?>(partyName),
      'workerServerId': serializer.toJson<int?>(workerServerId),
      'workerName': serializer.toJson<String?>(workerName),
      'categoryServerId': serializer.toJson<int?>(categoryServerId),
      'categoryName': serializer.toJson<String?>(categoryName),
      'financialAccountServerId': serializer.toJson<int?>(
        financialAccountServerId,
      ),
      'financialAccountName': serializer.toJson<String?>(financialAccountName),
      'targetFinancialAccountServerId': serializer.toJson<int?>(
        targetFinancialAccountServerId,
      ),
      'targetFinancialAccountName': serializer.toJson<String?>(
        targetFinancialAccountName,
      ),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'description': serializer.toJson<String?>(description),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
      'reversalOfServerId': serializer.toJson<int?>(reversalOfServerId),
      'createdByName': serializer.toJson<String?>(createdByName),
    };
  }

  LocalAccountingTransaction copyWith({
    int? serverId,
    String? uuid,
    String? transactionNo,
    String? type,
    String? settlementMode,
    int? currencyServerId,
    String? currencyCode,
    String? currencySymbol,
    int? currencyDecimalPlaces,
    int? amountMinor,
    int? paidNowMinor,
    String? costStatus,
    Value<int?> costTotalMinor = const Value.absent(),
    Value<int?> grossProfitMinor = const Value.absent(),
    Value<int?> partyServerId = const Value.absent(),
    Value<String?> partyName = const Value.absent(),
    Value<int?> workerServerId = const Value.absent(),
    Value<String?> workerName = const Value.absent(),
    Value<int?> categoryServerId = const Value.absent(),
    Value<String?> categoryName = const Value.absent(),
    Value<int?> financialAccountServerId = const Value.absent(),
    Value<String?> financialAccountName = const Value.absent(),
    Value<int?> targetFinancialAccountServerId = const Value.absent(),
    Value<String?> targetFinancialAccountName = const Value.absent(),
    DateTime? occurredAt,
    Value<String?> description = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    String? status,
    Value<int?> reversalOfServerId = const Value.absent(),
    Value<String?> createdByName = const Value.absent(),
  }) => LocalAccountingTransaction(
    serverId: serverId ?? this.serverId,
    uuid: uuid ?? this.uuid,
    transactionNo: transactionNo ?? this.transactionNo,
    type: type ?? this.type,
    settlementMode: settlementMode ?? this.settlementMode,
    currencyServerId: currencyServerId ?? this.currencyServerId,
    currencyCode: currencyCode ?? this.currencyCode,
    currencySymbol: currencySymbol ?? this.currencySymbol,
    currencyDecimalPlaces: currencyDecimalPlaces ?? this.currencyDecimalPlaces,
    amountMinor: amountMinor ?? this.amountMinor,
    paidNowMinor: paidNowMinor ?? this.paidNowMinor,
    costStatus: costStatus ?? this.costStatus,
    costTotalMinor: costTotalMinor.present
        ? costTotalMinor.value
        : this.costTotalMinor,
    grossProfitMinor: grossProfitMinor.present
        ? grossProfitMinor.value
        : this.grossProfitMinor,
    partyServerId: partyServerId.present
        ? partyServerId.value
        : this.partyServerId,
    partyName: partyName.present ? partyName.value : this.partyName,
    workerServerId: workerServerId.present
        ? workerServerId.value
        : this.workerServerId,
    workerName: workerName.present ? workerName.value : this.workerName,
    categoryServerId: categoryServerId.present
        ? categoryServerId.value
        : this.categoryServerId,
    categoryName: categoryName.present ? categoryName.value : this.categoryName,
    financialAccountServerId: financialAccountServerId.present
        ? financialAccountServerId.value
        : this.financialAccountServerId,
    financialAccountName: financialAccountName.present
        ? financialAccountName.value
        : this.financialAccountName,
    targetFinancialAccountServerId: targetFinancialAccountServerId.present
        ? targetFinancialAccountServerId.value
        : this.targetFinancialAccountServerId,
    targetFinancialAccountName: targetFinancialAccountName.present
        ? targetFinancialAccountName.value
        : this.targetFinancialAccountName,
    occurredAt: occurredAt ?? this.occurredAt,
    description: description.present ? description.value : this.description,
    notes: notes.present ? notes.value : this.notes,
    status: status ?? this.status,
    reversalOfServerId: reversalOfServerId.present
        ? reversalOfServerId.value
        : this.reversalOfServerId,
    createdByName: createdByName.present
        ? createdByName.value
        : this.createdByName,
  );
  LocalAccountingTransaction copyWithCompanion(
    LocalAccountingTransactionsCompanion data,
  ) {
    return LocalAccountingTransaction(
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      transactionNo: data.transactionNo.present
          ? data.transactionNo.value
          : this.transactionNo,
      type: data.type.present ? data.type.value : this.type,
      settlementMode: data.settlementMode.present
          ? data.settlementMode.value
          : this.settlementMode,
      currencyServerId: data.currencyServerId.present
          ? data.currencyServerId.value
          : this.currencyServerId,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      currencySymbol: data.currencySymbol.present
          ? data.currencySymbol.value
          : this.currencySymbol,
      currencyDecimalPlaces: data.currencyDecimalPlaces.present
          ? data.currencyDecimalPlaces.value
          : this.currencyDecimalPlaces,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      paidNowMinor: data.paidNowMinor.present
          ? data.paidNowMinor.value
          : this.paidNowMinor,
      costStatus: data.costStatus.present
          ? data.costStatus.value
          : this.costStatus,
      costTotalMinor: data.costTotalMinor.present
          ? data.costTotalMinor.value
          : this.costTotalMinor,
      grossProfitMinor: data.grossProfitMinor.present
          ? data.grossProfitMinor.value
          : this.grossProfitMinor,
      partyServerId: data.partyServerId.present
          ? data.partyServerId.value
          : this.partyServerId,
      partyName: data.partyName.present ? data.partyName.value : this.partyName,
      workerServerId: data.workerServerId.present
          ? data.workerServerId.value
          : this.workerServerId,
      workerName: data.workerName.present
          ? data.workerName.value
          : this.workerName,
      categoryServerId: data.categoryServerId.present
          ? data.categoryServerId.value
          : this.categoryServerId,
      categoryName: data.categoryName.present
          ? data.categoryName.value
          : this.categoryName,
      financialAccountServerId: data.financialAccountServerId.present
          ? data.financialAccountServerId.value
          : this.financialAccountServerId,
      financialAccountName: data.financialAccountName.present
          ? data.financialAccountName.value
          : this.financialAccountName,
      targetFinancialAccountServerId:
          data.targetFinancialAccountServerId.present
          ? data.targetFinancialAccountServerId.value
          : this.targetFinancialAccountServerId,
      targetFinancialAccountName: data.targetFinancialAccountName.present
          ? data.targetFinancialAccountName.value
          : this.targetFinancialAccountName,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      description: data.description.present
          ? data.description.value
          : this.description,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      reversalOfServerId: data.reversalOfServerId.present
          ? data.reversalOfServerId.value
          : this.reversalOfServerId,
      createdByName: data.createdByName.present
          ? data.createdByName.value
          : this.createdByName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalAccountingTransaction(')
          ..write('serverId: $serverId, ')
          ..write('uuid: $uuid, ')
          ..write('transactionNo: $transactionNo, ')
          ..write('type: $type, ')
          ..write('settlementMode: $settlementMode, ')
          ..write('currencyServerId: $currencyServerId, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('currencySymbol: $currencySymbol, ')
          ..write('currencyDecimalPlaces: $currencyDecimalPlaces, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('paidNowMinor: $paidNowMinor, ')
          ..write('costStatus: $costStatus, ')
          ..write('costTotalMinor: $costTotalMinor, ')
          ..write('grossProfitMinor: $grossProfitMinor, ')
          ..write('partyServerId: $partyServerId, ')
          ..write('partyName: $partyName, ')
          ..write('workerServerId: $workerServerId, ')
          ..write('workerName: $workerName, ')
          ..write('categoryServerId: $categoryServerId, ')
          ..write('categoryName: $categoryName, ')
          ..write('financialAccountServerId: $financialAccountServerId, ')
          ..write('financialAccountName: $financialAccountName, ')
          ..write(
            'targetFinancialAccountServerId: $targetFinancialAccountServerId, ',
          )
          ..write('targetFinancialAccountName: $targetFinancialAccountName, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('description: $description, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('reversalOfServerId: $reversalOfServerId, ')
          ..write('createdByName: $createdByName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    serverId,
    uuid,
    transactionNo,
    type,
    settlementMode,
    currencyServerId,
    currencyCode,
    currencySymbol,
    currencyDecimalPlaces,
    amountMinor,
    paidNowMinor,
    costStatus,
    costTotalMinor,
    grossProfitMinor,
    partyServerId,
    partyName,
    workerServerId,
    workerName,
    categoryServerId,
    categoryName,
    financialAccountServerId,
    financialAccountName,
    targetFinancialAccountServerId,
    targetFinancialAccountName,
    occurredAt,
    description,
    notes,
    status,
    reversalOfServerId,
    createdByName,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalAccountingTransaction &&
          other.serverId == this.serverId &&
          other.uuid == this.uuid &&
          other.transactionNo == this.transactionNo &&
          other.type == this.type &&
          other.settlementMode == this.settlementMode &&
          other.currencyServerId == this.currencyServerId &&
          other.currencyCode == this.currencyCode &&
          other.currencySymbol == this.currencySymbol &&
          other.currencyDecimalPlaces == this.currencyDecimalPlaces &&
          other.amountMinor == this.amountMinor &&
          other.paidNowMinor == this.paidNowMinor &&
          other.costStatus == this.costStatus &&
          other.costTotalMinor == this.costTotalMinor &&
          other.grossProfitMinor == this.grossProfitMinor &&
          other.partyServerId == this.partyServerId &&
          other.partyName == this.partyName &&
          other.workerServerId == this.workerServerId &&
          other.workerName == this.workerName &&
          other.categoryServerId == this.categoryServerId &&
          other.categoryName == this.categoryName &&
          other.financialAccountServerId == this.financialAccountServerId &&
          other.financialAccountName == this.financialAccountName &&
          other.targetFinancialAccountServerId ==
              this.targetFinancialAccountServerId &&
          other.targetFinancialAccountName == this.targetFinancialAccountName &&
          other.occurredAt == this.occurredAt &&
          other.description == this.description &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.reversalOfServerId == this.reversalOfServerId &&
          other.createdByName == this.createdByName);
}

class LocalAccountingTransactionsCompanion
    extends UpdateCompanion<LocalAccountingTransaction> {
  final Value<int> serverId;
  final Value<String> uuid;
  final Value<String> transactionNo;
  final Value<String> type;
  final Value<String> settlementMode;
  final Value<int> currencyServerId;
  final Value<String> currencyCode;
  final Value<String> currencySymbol;
  final Value<int> currencyDecimalPlaces;
  final Value<int> amountMinor;
  final Value<int> paidNowMinor;
  final Value<String> costStatus;
  final Value<int?> costTotalMinor;
  final Value<int?> grossProfitMinor;
  final Value<int?> partyServerId;
  final Value<String?> partyName;
  final Value<int?> workerServerId;
  final Value<String?> workerName;
  final Value<int?> categoryServerId;
  final Value<String?> categoryName;
  final Value<int?> financialAccountServerId;
  final Value<String?> financialAccountName;
  final Value<int?> targetFinancialAccountServerId;
  final Value<String?> targetFinancialAccountName;
  final Value<DateTime> occurredAt;
  final Value<String?> description;
  final Value<String?> notes;
  final Value<String> status;
  final Value<int?> reversalOfServerId;
  final Value<String?> createdByName;
  const LocalAccountingTransactionsCompanion({
    this.serverId = const Value.absent(),
    this.uuid = const Value.absent(),
    this.transactionNo = const Value.absent(),
    this.type = const Value.absent(),
    this.settlementMode = const Value.absent(),
    this.currencyServerId = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.currencySymbol = const Value.absent(),
    this.currencyDecimalPlaces = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.paidNowMinor = const Value.absent(),
    this.costStatus = const Value.absent(),
    this.costTotalMinor = const Value.absent(),
    this.grossProfitMinor = const Value.absent(),
    this.partyServerId = const Value.absent(),
    this.partyName = const Value.absent(),
    this.workerServerId = const Value.absent(),
    this.workerName = const Value.absent(),
    this.categoryServerId = const Value.absent(),
    this.categoryName = const Value.absent(),
    this.financialAccountServerId = const Value.absent(),
    this.financialAccountName = const Value.absent(),
    this.targetFinancialAccountServerId = const Value.absent(),
    this.targetFinancialAccountName = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.description = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.reversalOfServerId = const Value.absent(),
    this.createdByName = const Value.absent(),
  });
  LocalAccountingTransactionsCompanion.insert({
    this.serverId = const Value.absent(),
    required String uuid,
    required String transactionNo,
    required String type,
    required String settlementMode,
    required int currencyServerId,
    required String currencyCode,
    required String currencySymbol,
    required int currencyDecimalPlaces,
    required int amountMinor,
    required int paidNowMinor,
    this.costStatus = const Value.absent(),
    this.costTotalMinor = const Value.absent(),
    this.grossProfitMinor = const Value.absent(),
    this.partyServerId = const Value.absent(),
    this.partyName = const Value.absent(),
    this.workerServerId = const Value.absent(),
    this.workerName = const Value.absent(),
    this.categoryServerId = const Value.absent(),
    this.categoryName = const Value.absent(),
    this.financialAccountServerId = const Value.absent(),
    this.financialAccountName = const Value.absent(),
    this.targetFinancialAccountServerId = const Value.absent(),
    this.targetFinancialAccountName = const Value.absent(),
    required DateTime occurredAt,
    this.description = const Value.absent(),
    this.notes = const Value.absent(),
    required String status,
    this.reversalOfServerId = const Value.absent(),
    this.createdByName = const Value.absent(),
  }) : uuid = Value(uuid),
       transactionNo = Value(transactionNo),
       type = Value(type),
       settlementMode = Value(settlementMode),
       currencyServerId = Value(currencyServerId),
       currencyCode = Value(currencyCode),
       currencySymbol = Value(currencySymbol),
       currencyDecimalPlaces = Value(currencyDecimalPlaces),
       amountMinor = Value(amountMinor),
       paidNowMinor = Value(paidNowMinor),
       occurredAt = Value(occurredAt),
       status = Value(status);
  static Insertable<LocalAccountingTransaction> custom({
    Expression<int>? serverId,
    Expression<String>? uuid,
    Expression<String>? transactionNo,
    Expression<String>? type,
    Expression<String>? settlementMode,
    Expression<int>? currencyServerId,
    Expression<String>? currencyCode,
    Expression<String>? currencySymbol,
    Expression<int>? currencyDecimalPlaces,
    Expression<int>? amountMinor,
    Expression<int>? paidNowMinor,
    Expression<String>? costStatus,
    Expression<int>? costTotalMinor,
    Expression<int>? grossProfitMinor,
    Expression<int>? partyServerId,
    Expression<String>? partyName,
    Expression<int>? workerServerId,
    Expression<String>? workerName,
    Expression<int>? categoryServerId,
    Expression<String>? categoryName,
    Expression<int>? financialAccountServerId,
    Expression<String>? financialAccountName,
    Expression<int>? targetFinancialAccountServerId,
    Expression<String>? targetFinancialAccountName,
    Expression<DateTime>? occurredAt,
    Expression<String>? description,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<int>? reversalOfServerId,
    Expression<String>? createdByName,
  }) {
    return RawValuesInsertable({
      if (serverId != null) 'server_id': serverId,
      if (uuid != null) 'uuid': uuid,
      if (transactionNo != null) 'transaction_no': transactionNo,
      if (type != null) 'type': type,
      if (settlementMode != null) 'settlement_mode': settlementMode,
      if (currencyServerId != null) 'currency_server_id': currencyServerId,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (currencySymbol != null) 'currency_symbol': currencySymbol,
      if (currencyDecimalPlaces != null)
        'currency_decimal_places': currencyDecimalPlaces,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (paidNowMinor != null) 'paid_now_minor': paidNowMinor,
      if (costStatus != null) 'cost_status': costStatus,
      if (costTotalMinor != null) 'cost_total_minor': costTotalMinor,
      if (grossProfitMinor != null) 'gross_profit_minor': grossProfitMinor,
      if (partyServerId != null) 'party_server_id': partyServerId,
      if (partyName != null) 'party_name': partyName,
      if (workerServerId != null) 'worker_server_id': workerServerId,
      if (workerName != null) 'worker_name': workerName,
      if (categoryServerId != null) 'category_server_id': categoryServerId,
      if (categoryName != null) 'category_name': categoryName,
      if (financialAccountServerId != null)
        'financial_account_server_id': financialAccountServerId,
      if (financialAccountName != null)
        'financial_account_name': financialAccountName,
      if (targetFinancialAccountServerId != null)
        'target_financial_account_server_id': targetFinancialAccountServerId,
      if (targetFinancialAccountName != null)
        'target_financial_account_name': targetFinancialAccountName,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (description != null) 'description': description,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (reversalOfServerId != null)
        'reversal_of_server_id': reversalOfServerId,
      if (createdByName != null) 'created_by_name': createdByName,
    });
  }

  LocalAccountingTransactionsCompanion copyWith({
    Value<int>? serverId,
    Value<String>? uuid,
    Value<String>? transactionNo,
    Value<String>? type,
    Value<String>? settlementMode,
    Value<int>? currencyServerId,
    Value<String>? currencyCode,
    Value<String>? currencySymbol,
    Value<int>? currencyDecimalPlaces,
    Value<int>? amountMinor,
    Value<int>? paidNowMinor,
    Value<String>? costStatus,
    Value<int?>? costTotalMinor,
    Value<int?>? grossProfitMinor,
    Value<int?>? partyServerId,
    Value<String?>? partyName,
    Value<int?>? workerServerId,
    Value<String?>? workerName,
    Value<int?>? categoryServerId,
    Value<String?>? categoryName,
    Value<int?>? financialAccountServerId,
    Value<String?>? financialAccountName,
    Value<int?>? targetFinancialAccountServerId,
    Value<String?>? targetFinancialAccountName,
    Value<DateTime>? occurredAt,
    Value<String?>? description,
    Value<String?>? notes,
    Value<String>? status,
    Value<int?>? reversalOfServerId,
    Value<String?>? createdByName,
  }) {
    return LocalAccountingTransactionsCompanion(
      serverId: serverId ?? this.serverId,
      uuid: uuid ?? this.uuid,
      transactionNo: transactionNo ?? this.transactionNo,
      type: type ?? this.type,
      settlementMode: settlementMode ?? this.settlementMode,
      currencyServerId: currencyServerId ?? this.currencyServerId,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      amountMinor: amountMinor ?? this.amountMinor,
      paidNowMinor: paidNowMinor ?? this.paidNowMinor,
      costStatus: costStatus ?? this.costStatus,
      costTotalMinor: costTotalMinor ?? this.costTotalMinor,
      grossProfitMinor: grossProfitMinor ?? this.grossProfitMinor,
      partyServerId: partyServerId ?? this.partyServerId,
      partyName: partyName ?? this.partyName,
      workerServerId: workerServerId ?? this.workerServerId,
      workerName: workerName ?? this.workerName,
      categoryServerId: categoryServerId ?? this.categoryServerId,
      categoryName: categoryName ?? this.categoryName,
      financialAccountServerId:
          financialAccountServerId ?? this.financialAccountServerId,
      financialAccountName: financialAccountName ?? this.financialAccountName,
      targetFinancialAccountServerId:
          targetFinancialAccountServerId ?? this.targetFinancialAccountServerId,
      targetFinancialAccountName:
          targetFinancialAccountName ?? this.targetFinancialAccountName,
      occurredAt: occurredAt ?? this.occurredAt,
      description: description ?? this.description,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      reversalOfServerId: reversalOfServerId ?? this.reversalOfServerId,
      createdByName: createdByName ?? this.createdByName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (transactionNo.present) {
      map['transaction_no'] = Variable<String>(transactionNo.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (settlementMode.present) {
      map['settlement_mode'] = Variable<String>(settlementMode.value);
    }
    if (currencyServerId.present) {
      map['currency_server_id'] = Variable<int>(currencyServerId.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (currencySymbol.present) {
      map['currency_symbol'] = Variable<String>(currencySymbol.value);
    }
    if (currencyDecimalPlaces.present) {
      map['currency_decimal_places'] = Variable<int>(
        currencyDecimalPlaces.value,
      );
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (paidNowMinor.present) {
      map['paid_now_minor'] = Variable<int>(paidNowMinor.value);
    }
    if (costStatus.present) {
      map['cost_status'] = Variable<String>(costStatus.value);
    }
    if (costTotalMinor.present) {
      map['cost_total_minor'] = Variable<int>(costTotalMinor.value);
    }
    if (grossProfitMinor.present) {
      map['gross_profit_minor'] = Variable<int>(grossProfitMinor.value);
    }
    if (partyServerId.present) {
      map['party_server_id'] = Variable<int>(partyServerId.value);
    }
    if (partyName.present) {
      map['party_name'] = Variable<String>(partyName.value);
    }
    if (workerServerId.present) {
      map['worker_server_id'] = Variable<int>(workerServerId.value);
    }
    if (workerName.present) {
      map['worker_name'] = Variable<String>(workerName.value);
    }
    if (categoryServerId.present) {
      map['category_server_id'] = Variable<int>(categoryServerId.value);
    }
    if (categoryName.present) {
      map['category_name'] = Variable<String>(categoryName.value);
    }
    if (financialAccountServerId.present) {
      map['financial_account_server_id'] = Variable<int>(
        financialAccountServerId.value,
      );
    }
    if (financialAccountName.present) {
      map['financial_account_name'] = Variable<String>(
        financialAccountName.value,
      );
    }
    if (targetFinancialAccountServerId.present) {
      map['target_financial_account_server_id'] = Variable<int>(
        targetFinancialAccountServerId.value,
      );
    }
    if (targetFinancialAccountName.present) {
      map['target_financial_account_name'] = Variable<String>(
        targetFinancialAccountName.value,
      );
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (reversalOfServerId.present) {
      map['reversal_of_server_id'] = Variable<int>(reversalOfServerId.value);
    }
    if (createdByName.present) {
      map['created_by_name'] = Variable<String>(createdByName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalAccountingTransactionsCompanion(')
          ..write('serverId: $serverId, ')
          ..write('uuid: $uuid, ')
          ..write('transactionNo: $transactionNo, ')
          ..write('type: $type, ')
          ..write('settlementMode: $settlementMode, ')
          ..write('currencyServerId: $currencyServerId, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('currencySymbol: $currencySymbol, ')
          ..write('currencyDecimalPlaces: $currencyDecimalPlaces, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('paidNowMinor: $paidNowMinor, ')
          ..write('costStatus: $costStatus, ')
          ..write('costTotalMinor: $costTotalMinor, ')
          ..write('grossProfitMinor: $grossProfitMinor, ')
          ..write('partyServerId: $partyServerId, ')
          ..write('partyName: $partyName, ')
          ..write('workerServerId: $workerServerId, ')
          ..write('workerName: $workerName, ')
          ..write('categoryServerId: $categoryServerId, ')
          ..write('categoryName: $categoryName, ')
          ..write('financialAccountServerId: $financialAccountServerId, ')
          ..write('financialAccountName: $financialAccountName, ')
          ..write(
            'targetFinancialAccountServerId: $targetFinancialAccountServerId, ',
          )
          ..write('targetFinancialAccountName: $targetFinancialAccountName, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('description: $description, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('reversalOfServerId: $reversalOfServerId, ')
          ..write('createdByName: $createdByName')
          ..write(')'))
        .toString();
  }
}

class $LocalProductsTable extends LocalProducts
    with TableInfo<$LocalProductsTable, LocalProduct> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<int> serverId = GeneratedColumn<int>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
    'sku',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productTypeMeta = const VerificationMeta(
    'productType',
  );
  @override
  late final GeneratedColumn<String> productType = GeneratedColumn<String>(
    'product_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyServerIdMeta = const VerificationMeta(
    'currencyServerId',
  );
  @override
  late final GeneratedColumn<int> currencyServerId = GeneratedColumn<int>(
    'currency_server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyNameArMeta = const VerificationMeta(
    'currencyNameAr',
  );
  @override
  late final GeneratedColumn<String> currencyNameAr = GeneratedColumn<String>(
    'currency_name_ar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencySymbolMeta = const VerificationMeta(
    'currencySymbol',
  );
  @override
  late final GeneratedColumn<String> currencySymbol = GeneratedColumn<String>(
    'currency_symbol',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyDecimalPlacesMeta =
      const VerificationMeta('currencyDecimalPlaces');
  @override
  late final GeneratedColumn<int> currencyDecimalPlaces = GeneratedColumn<int>(
    'currency_decimal_places',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defaultSalePriceMinorMeta =
      const VerificationMeta('defaultSalePriceMinor');
  @override
  late final GeneratedColumn<int> defaultSalePriceMinor = GeneratedColumn<int>(
    'default_sale_price_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stockQuantityMilliMeta =
      const VerificationMeta('stockQuantityMilli');
  @override
  late final GeneratedColumn<int> stockQuantityMilli = GeneratedColumn<int>(
    'stock_quantity_milli',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _averageCostMinorMeta = const VerificationMeta(
    'averageCostMinor',
  );
  @override
  late final GeneratedColumn<int> averageCostMinor = GeneratedColumn<int>(
    'average_cost_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    serverId,
    uuid,
    sku,
    name,
    productType,
    unit,
    currencyServerId,
    currencyCode,
    currencyNameAr,
    currencySymbol,
    currencyDecimalPlaces,
    defaultSalePriceMinor,
    stockQuantityMilli,
    averageCostMinor,
    isActive,
    version,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_products';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalProduct> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('sku')) {
      context.handle(
        _skuMeta,
        sku.isAcceptableOrUnknown(data['sku']!, _skuMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('product_type')) {
      context.handle(
        _productTypeMeta,
        productType.isAcceptableOrUnknown(
          data['product_type']!,
          _productTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productTypeMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('currency_server_id')) {
      context.handle(
        _currencyServerIdMeta,
        currencyServerId.isAcceptableOrUnknown(
          data['currency_server_id']!,
          _currencyServerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyServerIdMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('currency_name_ar')) {
      context.handle(
        _currencyNameArMeta,
        currencyNameAr.isAcceptableOrUnknown(
          data['currency_name_ar']!,
          _currencyNameArMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyNameArMeta);
    }
    if (data.containsKey('currency_symbol')) {
      context.handle(
        _currencySymbolMeta,
        currencySymbol.isAcceptableOrUnknown(
          data['currency_symbol']!,
          _currencySymbolMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencySymbolMeta);
    }
    if (data.containsKey('currency_decimal_places')) {
      context.handle(
        _currencyDecimalPlacesMeta,
        currencyDecimalPlaces.isAcceptableOrUnknown(
          data['currency_decimal_places']!,
          _currencyDecimalPlacesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyDecimalPlacesMeta);
    }
    if (data.containsKey('default_sale_price_minor')) {
      context.handle(
        _defaultSalePriceMinorMeta,
        defaultSalePriceMinor.isAcceptableOrUnknown(
          data['default_sale_price_minor']!,
          _defaultSalePriceMinorMeta,
        ),
      );
    }
    if (data.containsKey('stock_quantity_milli')) {
      context.handle(
        _stockQuantityMilliMeta,
        stockQuantityMilli.isAcceptableOrUnknown(
          data['stock_quantity_milli']!,
          _stockQuantityMilliMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stockQuantityMilliMeta);
    }
    if (data.containsKey('average_cost_minor')) {
      context.handle(
        _averageCostMinorMeta,
        averageCostMinor.isAcceptableOrUnknown(
          data['average_cost_minor']!,
          _averageCostMinorMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {serverId};
  @override
  LocalProduct map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalProduct(
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      sku: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sku'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      productType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_type'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      currencyServerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}currency_server_id'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      currencyNameAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_name_ar'],
      )!,
      currencySymbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_symbol'],
      )!,
      currencyDecimalPlaces: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}currency_decimal_places'],
      )!,
      defaultSalePriceMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_sale_price_minor'],
      ),
      stockQuantityMilli: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stock_quantity_milli'],
      )!,
      averageCostMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}average_cost_minor'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
    );
  }

  @override
  $LocalProductsTable createAlias(String alias) {
    return $LocalProductsTable(attachedDatabase, alias);
  }
}

class LocalProduct extends DataClass implements Insertable<LocalProduct> {
  final int serverId;
  final String uuid;
  final String? sku;
  final String name;
  final String productType;
  final String unit;
  final int currencyServerId;
  final String currencyCode;
  final String currencyNameAr;
  final String currencySymbol;
  final int currencyDecimalPlaces;
  final int? defaultSalePriceMinor;
  final int stockQuantityMilli;
  final int? averageCostMinor;
  final bool isActive;
  final int version;
  const LocalProduct({
    required this.serverId,
    required this.uuid,
    this.sku,
    required this.name,
    required this.productType,
    required this.unit,
    required this.currencyServerId,
    required this.currencyCode,
    required this.currencyNameAr,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
    this.defaultSalePriceMinor,
    required this.stockQuantityMilli,
    this.averageCostMinor,
    required this.isActive,
    required this.version,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['server_id'] = Variable<int>(serverId);
    map['uuid'] = Variable<String>(uuid);
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    map['name'] = Variable<String>(name);
    map['product_type'] = Variable<String>(productType);
    map['unit'] = Variable<String>(unit);
    map['currency_server_id'] = Variable<int>(currencyServerId);
    map['currency_code'] = Variable<String>(currencyCode);
    map['currency_name_ar'] = Variable<String>(currencyNameAr);
    map['currency_symbol'] = Variable<String>(currencySymbol);
    map['currency_decimal_places'] = Variable<int>(currencyDecimalPlaces);
    if (!nullToAbsent || defaultSalePriceMinor != null) {
      map['default_sale_price_minor'] = Variable<int>(defaultSalePriceMinor);
    }
    map['stock_quantity_milli'] = Variable<int>(stockQuantityMilli);
    if (!nullToAbsent || averageCostMinor != null) {
      map['average_cost_minor'] = Variable<int>(averageCostMinor);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['version'] = Variable<int>(version);
    return map;
  }

  LocalProductsCompanion toCompanion(bool nullToAbsent) {
    return LocalProductsCompanion(
      serverId: Value(serverId),
      uuid: Value(uuid),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      name: Value(name),
      productType: Value(productType),
      unit: Value(unit),
      currencyServerId: Value(currencyServerId),
      currencyCode: Value(currencyCode),
      currencyNameAr: Value(currencyNameAr),
      currencySymbol: Value(currencySymbol),
      currencyDecimalPlaces: Value(currencyDecimalPlaces),
      defaultSalePriceMinor: defaultSalePriceMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultSalePriceMinor),
      stockQuantityMilli: Value(stockQuantityMilli),
      averageCostMinor: averageCostMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(averageCostMinor),
      isActive: Value(isActive),
      version: Value(version),
    );
  }

  factory LocalProduct.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalProduct(
      serverId: serializer.fromJson<int>(json['serverId']),
      uuid: serializer.fromJson<String>(json['uuid']),
      sku: serializer.fromJson<String?>(json['sku']),
      name: serializer.fromJson<String>(json['name']),
      productType: serializer.fromJson<String>(json['productType']),
      unit: serializer.fromJson<String>(json['unit']),
      currencyServerId: serializer.fromJson<int>(json['currencyServerId']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      currencyNameAr: serializer.fromJson<String>(json['currencyNameAr']),
      currencySymbol: serializer.fromJson<String>(json['currencySymbol']),
      currencyDecimalPlaces: serializer.fromJson<int>(
        json['currencyDecimalPlaces'],
      ),
      defaultSalePriceMinor: serializer.fromJson<int?>(
        json['defaultSalePriceMinor'],
      ),
      stockQuantityMilli: serializer.fromJson<int>(json['stockQuantityMilli']),
      averageCostMinor: serializer.fromJson<int?>(json['averageCostMinor']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      version: serializer.fromJson<int>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'serverId': serializer.toJson<int>(serverId),
      'uuid': serializer.toJson<String>(uuid),
      'sku': serializer.toJson<String?>(sku),
      'name': serializer.toJson<String>(name),
      'productType': serializer.toJson<String>(productType),
      'unit': serializer.toJson<String>(unit),
      'currencyServerId': serializer.toJson<int>(currencyServerId),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'currencyNameAr': serializer.toJson<String>(currencyNameAr),
      'currencySymbol': serializer.toJson<String>(currencySymbol),
      'currencyDecimalPlaces': serializer.toJson<int>(currencyDecimalPlaces),
      'defaultSalePriceMinor': serializer.toJson<int?>(defaultSalePriceMinor),
      'stockQuantityMilli': serializer.toJson<int>(stockQuantityMilli),
      'averageCostMinor': serializer.toJson<int?>(averageCostMinor),
      'isActive': serializer.toJson<bool>(isActive),
      'version': serializer.toJson<int>(version),
    };
  }

  LocalProduct copyWith({
    int? serverId,
    String? uuid,
    Value<String?> sku = const Value.absent(),
    String? name,
    String? productType,
    String? unit,
    int? currencyServerId,
    String? currencyCode,
    String? currencyNameAr,
    String? currencySymbol,
    int? currencyDecimalPlaces,
    Value<int?> defaultSalePriceMinor = const Value.absent(),
    int? stockQuantityMilli,
    Value<int?> averageCostMinor = const Value.absent(),
    bool? isActive,
    int? version,
  }) => LocalProduct(
    serverId: serverId ?? this.serverId,
    uuid: uuid ?? this.uuid,
    sku: sku.present ? sku.value : this.sku,
    name: name ?? this.name,
    productType: productType ?? this.productType,
    unit: unit ?? this.unit,
    currencyServerId: currencyServerId ?? this.currencyServerId,
    currencyCode: currencyCode ?? this.currencyCode,
    currencyNameAr: currencyNameAr ?? this.currencyNameAr,
    currencySymbol: currencySymbol ?? this.currencySymbol,
    currencyDecimalPlaces: currencyDecimalPlaces ?? this.currencyDecimalPlaces,
    defaultSalePriceMinor: defaultSalePriceMinor.present
        ? defaultSalePriceMinor.value
        : this.defaultSalePriceMinor,
    stockQuantityMilli: stockQuantityMilli ?? this.stockQuantityMilli,
    averageCostMinor: averageCostMinor.present
        ? averageCostMinor.value
        : this.averageCostMinor,
    isActive: isActive ?? this.isActive,
    version: version ?? this.version,
  );
  LocalProduct copyWithCompanion(LocalProductsCompanion data) {
    return LocalProduct(
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      sku: data.sku.present ? data.sku.value : this.sku,
      name: data.name.present ? data.name.value : this.name,
      productType: data.productType.present
          ? data.productType.value
          : this.productType,
      unit: data.unit.present ? data.unit.value : this.unit,
      currencyServerId: data.currencyServerId.present
          ? data.currencyServerId.value
          : this.currencyServerId,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      currencyNameAr: data.currencyNameAr.present
          ? data.currencyNameAr.value
          : this.currencyNameAr,
      currencySymbol: data.currencySymbol.present
          ? data.currencySymbol.value
          : this.currencySymbol,
      currencyDecimalPlaces: data.currencyDecimalPlaces.present
          ? data.currencyDecimalPlaces.value
          : this.currencyDecimalPlaces,
      defaultSalePriceMinor: data.defaultSalePriceMinor.present
          ? data.defaultSalePriceMinor.value
          : this.defaultSalePriceMinor,
      stockQuantityMilli: data.stockQuantityMilli.present
          ? data.stockQuantityMilli.value
          : this.stockQuantityMilli,
      averageCostMinor: data.averageCostMinor.present
          ? data.averageCostMinor.value
          : this.averageCostMinor,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      version: data.version.present ? data.version.value : this.version,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalProduct(')
          ..write('serverId: $serverId, ')
          ..write('uuid: $uuid, ')
          ..write('sku: $sku, ')
          ..write('name: $name, ')
          ..write('productType: $productType, ')
          ..write('unit: $unit, ')
          ..write('currencyServerId: $currencyServerId, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('currencyNameAr: $currencyNameAr, ')
          ..write('currencySymbol: $currencySymbol, ')
          ..write('currencyDecimalPlaces: $currencyDecimalPlaces, ')
          ..write('defaultSalePriceMinor: $defaultSalePriceMinor, ')
          ..write('stockQuantityMilli: $stockQuantityMilli, ')
          ..write('averageCostMinor: $averageCostMinor, ')
          ..write('isActive: $isActive, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    serverId,
    uuid,
    sku,
    name,
    productType,
    unit,
    currencyServerId,
    currencyCode,
    currencyNameAr,
    currencySymbol,
    currencyDecimalPlaces,
    defaultSalePriceMinor,
    stockQuantityMilli,
    averageCostMinor,
    isActive,
    version,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalProduct &&
          other.serverId == this.serverId &&
          other.uuid == this.uuid &&
          other.sku == this.sku &&
          other.name == this.name &&
          other.productType == this.productType &&
          other.unit == this.unit &&
          other.currencyServerId == this.currencyServerId &&
          other.currencyCode == this.currencyCode &&
          other.currencyNameAr == this.currencyNameAr &&
          other.currencySymbol == this.currencySymbol &&
          other.currencyDecimalPlaces == this.currencyDecimalPlaces &&
          other.defaultSalePriceMinor == this.defaultSalePriceMinor &&
          other.stockQuantityMilli == this.stockQuantityMilli &&
          other.averageCostMinor == this.averageCostMinor &&
          other.isActive == this.isActive &&
          other.version == this.version);
}

class LocalProductsCompanion extends UpdateCompanion<LocalProduct> {
  final Value<int> serverId;
  final Value<String> uuid;
  final Value<String?> sku;
  final Value<String> name;
  final Value<String> productType;
  final Value<String> unit;
  final Value<int> currencyServerId;
  final Value<String> currencyCode;
  final Value<String> currencyNameAr;
  final Value<String> currencySymbol;
  final Value<int> currencyDecimalPlaces;
  final Value<int?> defaultSalePriceMinor;
  final Value<int> stockQuantityMilli;
  final Value<int?> averageCostMinor;
  final Value<bool> isActive;
  final Value<int> version;
  const LocalProductsCompanion({
    this.serverId = const Value.absent(),
    this.uuid = const Value.absent(),
    this.sku = const Value.absent(),
    this.name = const Value.absent(),
    this.productType = const Value.absent(),
    this.unit = const Value.absent(),
    this.currencyServerId = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.currencyNameAr = const Value.absent(),
    this.currencySymbol = const Value.absent(),
    this.currencyDecimalPlaces = const Value.absent(),
    this.defaultSalePriceMinor = const Value.absent(),
    this.stockQuantityMilli = const Value.absent(),
    this.averageCostMinor = const Value.absent(),
    this.isActive = const Value.absent(),
    this.version = const Value.absent(),
  });
  LocalProductsCompanion.insert({
    this.serverId = const Value.absent(),
    required String uuid,
    this.sku = const Value.absent(),
    required String name,
    required String productType,
    required String unit,
    required int currencyServerId,
    required String currencyCode,
    required String currencyNameAr,
    required String currencySymbol,
    required int currencyDecimalPlaces,
    this.defaultSalePriceMinor = const Value.absent(),
    required int stockQuantityMilli,
    this.averageCostMinor = const Value.absent(),
    required bool isActive,
    required int version,
  }) : uuid = Value(uuid),
       name = Value(name),
       productType = Value(productType),
       unit = Value(unit),
       currencyServerId = Value(currencyServerId),
       currencyCode = Value(currencyCode),
       currencyNameAr = Value(currencyNameAr),
       currencySymbol = Value(currencySymbol),
       currencyDecimalPlaces = Value(currencyDecimalPlaces),
       stockQuantityMilli = Value(stockQuantityMilli),
       isActive = Value(isActive),
       version = Value(version);
  static Insertable<LocalProduct> custom({
    Expression<int>? serverId,
    Expression<String>? uuid,
    Expression<String>? sku,
    Expression<String>? name,
    Expression<String>? productType,
    Expression<String>? unit,
    Expression<int>? currencyServerId,
    Expression<String>? currencyCode,
    Expression<String>? currencyNameAr,
    Expression<String>? currencySymbol,
    Expression<int>? currencyDecimalPlaces,
    Expression<int>? defaultSalePriceMinor,
    Expression<int>? stockQuantityMilli,
    Expression<int>? averageCostMinor,
    Expression<bool>? isActive,
    Expression<int>? version,
  }) {
    return RawValuesInsertable({
      if (serverId != null) 'server_id': serverId,
      if (uuid != null) 'uuid': uuid,
      if (sku != null) 'sku': sku,
      if (name != null) 'name': name,
      if (productType != null) 'product_type': productType,
      if (unit != null) 'unit': unit,
      if (currencyServerId != null) 'currency_server_id': currencyServerId,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (currencyNameAr != null) 'currency_name_ar': currencyNameAr,
      if (currencySymbol != null) 'currency_symbol': currencySymbol,
      if (currencyDecimalPlaces != null)
        'currency_decimal_places': currencyDecimalPlaces,
      if (defaultSalePriceMinor != null)
        'default_sale_price_minor': defaultSalePriceMinor,
      if (stockQuantityMilli != null)
        'stock_quantity_milli': stockQuantityMilli,
      if (averageCostMinor != null) 'average_cost_minor': averageCostMinor,
      if (isActive != null) 'is_active': isActive,
      if (version != null) 'version': version,
    });
  }

  LocalProductsCompanion copyWith({
    Value<int>? serverId,
    Value<String>? uuid,
    Value<String?>? sku,
    Value<String>? name,
    Value<String>? productType,
    Value<String>? unit,
    Value<int>? currencyServerId,
    Value<String>? currencyCode,
    Value<String>? currencyNameAr,
    Value<String>? currencySymbol,
    Value<int>? currencyDecimalPlaces,
    Value<int?>? defaultSalePriceMinor,
    Value<int>? stockQuantityMilli,
    Value<int?>? averageCostMinor,
    Value<bool>? isActive,
    Value<int>? version,
  }) {
    return LocalProductsCompanion(
      serverId: serverId ?? this.serverId,
      uuid: uuid ?? this.uuid,
      sku: sku ?? this.sku,
      name: name ?? this.name,
      productType: productType ?? this.productType,
      unit: unit ?? this.unit,
      currencyServerId: currencyServerId ?? this.currencyServerId,
      currencyCode: currencyCode ?? this.currencyCode,
      currencyNameAr: currencyNameAr ?? this.currencyNameAr,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyDecimalPlaces:
          currencyDecimalPlaces ?? this.currencyDecimalPlaces,
      defaultSalePriceMinor:
          defaultSalePriceMinor ?? this.defaultSalePriceMinor,
      stockQuantityMilli: stockQuantityMilli ?? this.stockQuantityMilli,
      averageCostMinor: averageCostMinor ?? this.averageCostMinor,
      isActive: isActive ?? this.isActive,
      version: version ?? this.version,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (productType.present) {
      map['product_type'] = Variable<String>(productType.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (currencyServerId.present) {
      map['currency_server_id'] = Variable<int>(currencyServerId.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (currencyNameAr.present) {
      map['currency_name_ar'] = Variable<String>(currencyNameAr.value);
    }
    if (currencySymbol.present) {
      map['currency_symbol'] = Variable<String>(currencySymbol.value);
    }
    if (currencyDecimalPlaces.present) {
      map['currency_decimal_places'] = Variable<int>(
        currencyDecimalPlaces.value,
      );
    }
    if (defaultSalePriceMinor.present) {
      map['default_sale_price_minor'] = Variable<int>(
        defaultSalePriceMinor.value,
      );
    }
    if (stockQuantityMilli.present) {
      map['stock_quantity_milli'] = Variable<int>(stockQuantityMilli.value);
    }
    if (averageCostMinor.present) {
      map['average_cost_minor'] = Variable<int>(averageCostMinor.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalProductsCompanion(')
          ..write('serverId: $serverId, ')
          ..write('uuid: $uuid, ')
          ..write('sku: $sku, ')
          ..write('name: $name, ')
          ..write('productType: $productType, ')
          ..write('unit: $unit, ')
          ..write('currencyServerId: $currencyServerId, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('currencyNameAr: $currencyNameAr, ')
          ..write('currencySymbol: $currencySymbol, ')
          ..write('currencyDecimalPlaces: $currencyDecimalPlaces, ')
          ..write('defaultSalePriceMinor: $defaultSalePriceMinor, ')
          ..write('stockQuantityMilli: $stockQuantityMilli, ')
          ..write('averageCostMinor: $averageCostMinor, ')
          ..write('isActive: $isActive, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }
}

class $LocalTransactionItemsTable extends LocalTransactionItems
    with TableInfo<$LocalTransactionItemsTable, LocalTransactionItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalTransactionItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<int> serverId = GeneratedColumn<int>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _transactionServerIdMeta =
      const VerificationMeta('transactionServerId');
  @override
  late final GeneratedColumn<int> transactionServerId = GeneratedColumn<int>(
    'transaction_server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productServerIdMeta = const VerificationMeta(
    'productServerId',
  );
  @override
  late final GeneratedColumn<int> productServerId = GeneratedColumn<int>(
    'product_server_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _productSkuMeta = const VerificationMeta(
    'productSku',
  );
  @override
  late final GeneratedColumn<String> productSku = GeneratedColumn<String>(
    'product_sku',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMilliMeta = const VerificationMeta(
    'quantityMilli',
  );
  @override
  late final GeneratedColumn<int> quantityMilli = GeneratedColumn<int>(
    'quantity_milli',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMinorMeta = const VerificationMeta(
    'unitPriceMinor',
  );
  @override
  late final GeneratedColumn<int> unitPriceMinor = GeneratedColumn<int>(
    'unit_price_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitCostMinorMeta = const VerificationMeta(
    'unitCostMinor',
  );
  @override
  late final GeneratedColumn<int> unitCostMinor = GeneratedColumn<int>(
    'unit_cost_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lineTotalMinorMeta = const VerificationMeta(
    'lineTotalMinor',
  );
  @override
  late final GeneratedColumn<int> lineTotalMinor = GeneratedColumn<int>(
    'line_total_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineCostMinorMeta = const VerificationMeta(
    'lineCostMinor',
  );
  @override
  late final GeneratedColumn<int> lineCostMinor = GeneratedColumn<int>(
    'line_cost_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _costSourceMeta = const VerificationMeta(
    'costSource',
  );
  @override
  late final GeneratedColumn<String> costSource = GeneratedColumn<String>(
    'cost_source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    serverId,
    transactionServerId,
    productServerId,
    productName,
    productSku,
    description,
    quantityMilli,
    unit,
    unitPriceMinor,
    unitCostMinor,
    lineTotalMinor,
    lineCostMinor,
    costSource,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_transaction_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalTransactionItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('transaction_server_id')) {
      context.handle(
        _transactionServerIdMeta,
        transactionServerId.isAcceptableOrUnknown(
          data['transaction_server_id']!,
          _transactionServerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionServerIdMeta);
    }
    if (data.containsKey('product_server_id')) {
      context.handle(
        _productServerIdMeta,
        productServerId.isAcceptableOrUnknown(
          data['product_server_id']!,
          _productServerIdMeta,
        ),
      );
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    }
    if (data.containsKey('product_sku')) {
      context.handle(
        _productSkuMeta,
        productSku.isAcceptableOrUnknown(data['product_sku']!, _productSkuMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('quantity_milli')) {
      context.handle(
        _quantityMilliMeta,
        quantityMilli.isAcceptableOrUnknown(
          data['quantity_milli']!,
          _quantityMilliMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_quantityMilliMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('unit_price_minor')) {
      context.handle(
        _unitPriceMinorMeta,
        unitPriceMinor.isAcceptableOrUnknown(
          data['unit_price_minor']!,
          _unitPriceMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMinorMeta);
    }
    if (data.containsKey('unit_cost_minor')) {
      context.handle(
        _unitCostMinorMeta,
        unitCostMinor.isAcceptableOrUnknown(
          data['unit_cost_minor']!,
          _unitCostMinorMeta,
        ),
      );
    }
    if (data.containsKey('line_total_minor')) {
      context.handle(
        _lineTotalMinorMeta,
        lineTotalMinor.isAcceptableOrUnknown(
          data['line_total_minor']!,
          _lineTotalMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lineTotalMinorMeta);
    }
    if (data.containsKey('line_cost_minor')) {
      context.handle(
        _lineCostMinorMeta,
        lineCostMinor.isAcceptableOrUnknown(
          data['line_cost_minor']!,
          _lineCostMinorMeta,
        ),
      );
    }
    if (data.containsKey('cost_source')) {
      context.handle(
        _costSourceMeta,
        costSource.isAcceptableOrUnknown(data['cost_source']!, _costSourceMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {serverId};
  @override
  LocalTransactionItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalTransactionItem(
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_id'],
      )!,
      transactionServerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}transaction_server_id'],
      )!,
      productServerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_server_id'],
      ),
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      ),
      productSku: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_sku'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      quantityMilli: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity_milli'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      unitPriceMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_price_minor'],
      )!,
      unitCostMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_cost_minor'],
      ),
      lineTotalMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}line_total_minor'],
      )!,
      lineCostMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}line_cost_minor'],
      ),
      costSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cost_source'],
      ),
    );
  }

  @override
  $LocalTransactionItemsTable createAlias(String alias) {
    return $LocalTransactionItemsTable(attachedDatabase, alias);
  }
}

class LocalTransactionItem extends DataClass
    implements Insertable<LocalTransactionItem> {
  final int serverId;
  final int transactionServerId;
  final int? productServerId;
  final String? productName;
  final String? productSku;
  final String description;
  final int quantityMilli;
  final String unit;
  final int unitPriceMinor;
  final int? unitCostMinor;
  final int lineTotalMinor;
  final int? lineCostMinor;
  final String? costSource;
  const LocalTransactionItem({
    required this.serverId,
    required this.transactionServerId,
    this.productServerId,
    this.productName,
    this.productSku,
    required this.description,
    required this.quantityMilli,
    required this.unit,
    required this.unitPriceMinor,
    this.unitCostMinor,
    required this.lineTotalMinor,
    this.lineCostMinor,
    this.costSource,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['server_id'] = Variable<int>(serverId);
    map['transaction_server_id'] = Variable<int>(transactionServerId);
    if (!nullToAbsent || productServerId != null) {
      map['product_server_id'] = Variable<int>(productServerId);
    }
    if (!nullToAbsent || productName != null) {
      map['product_name'] = Variable<String>(productName);
    }
    if (!nullToAbsent || productSku != null) {
      map['product_sku'] = Variable<String>(productSku);
    }
    map['description'] = Variable<String>(description);
    map['quantity_milli'] = Variable<int>(quantityMilli);
    map['unit'] = Variable<String>(unit);
    map['unit_price_minor'] = Variable<int>(unitPriceMinor);
    if (!nullToAbsent || unitCostMinor != null) {
      map['unit_cost_minor'] = Variable<int>(unitCostMinor);
    }
    map['line_total_minor'] = Variable<int>(lineTotalMinor);
    if (!nullToAbsent || lineCostMinor != null) {
      map['line_cost_minor'] = Variable<int>(lineCostMinor);
    }
    if (!nullToAbsent || costSource != null) {
      map['cost_source'] = Variable<String>(costSource);
    }
    return map;
  }

  LocalTransactionItemsCompanion toCompanion(bool nullToAbsent) {
    return LocalTransactionItemsCompanion(
      serverId: Value(serverId),
      transactionServerId: Value(transactionServerId),
      productServerId: productServerId == null && nullToAbsent
          ? const Value.absent()
          : Value(productServerId),
      productName: productName == null && nullToAbsent
          ? const Value.absent()
          : Value(productName),
      productSku: productSku == null && nullToAbsent
          ? const Value.absent()
          : Value(productSku),
      description: Value(description),
      quantityMilli: Value(quantityMilli),
      unit: Value(unit),
      unitPriceMinor: Value(unitPriceMinor),
      unitCostMinor: unitCostMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(unitCostMinor),
      lineTotalMinor: Value(lineTotalMinor),
      lineCostMinor: lineCostMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(lineCostMinor),
      costSource: costSource == null && nullToAbsent
          ? const Value.absent()
          : Value(costSource),
    );
  }

  factory LocalTransactionItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalTransactionItem(
      serverId: serializer.fromJson<int>(json['serverId']),
      transactionServerId: serializer.fromJson<int>(
        json['transactionServerId'],
      ),
      productServerId: serializer.fromJson<int?>(json['productServerId']),
      productName: serializer.fromJson<String?>(json['productName']),
      productSku: serializer.fromJson<String?>(json['productSku']),
      description: serializer.fromJson<String>(json['description']),
      quantityMilli: serializer.fromJson<int>(json['quantityMilli']),
      unit: serializer.fromJson<String>(json['unit']),
      unitPriceMinor: serializer.fromJson<int>(json['unitPriceMinor']),
      unitCostMinor: serializer.fromJson<int?>(json['unitCostMinor']),
      lineTotalMinor: serializer.fromJson<int>(json['lineTotalMinor']),
      lineCostMinor: serializer.fromJson<int?>(json['lineCostMinor']),
      costSource: serializer.fromJson<String?>(json['costSource']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'serverId': serializer.toJson<int>(serverId),
      'transactionServerId': serializer.toJson<int>(transactionServerId),
      'productServerId': serializer.toJson<int?>(productServerId),
      'productName': serializer.toJson<String?>(productName),
      'productSku': serializer.toJson<String?>(productSku),
      'description': serializer.toJson<String>(description),
      'quantityMilli': serializer.toJson<int>(quantityMilli),
      'unit': serializer.toJson<String>(unit),
      'unitPriceMinor': serializer.toJson<int>(unitPriceMinor),
      'unitCostMinor': serializer.toJson<int?>(unitCostMinor),
      'lineTotalMinor': serializer.toJson<int>(lineTotalMinor),
      'lineCostMinor': serializer.toJson<int?>(lineCostMinor),
      'costSource': serializer.toJson<String?>(costSource),
    };
  }

  LocalTransactionItem copyWith({
    int? serverId,
    int? transactionServerId,
    Value<int?> productServerId = const Value.absent(),
    Value<String?> productName = const Value.absent(),
    Value<String?> productSku = const Value.absent(),
    String? description,
    int? quantityMilli,
    String? unit,
    int? unitPriceMinor,
    Value<int?> unitCostMinor = const Value.absent(),
    int? lineTotalMinor,
    Value<int?> lineCostMinor = const Value.absent(),
    Value<String?> costSource = const Value.absent(),
  }) => LocalTransactionItem(
    serverId: serverId ?? this.serverId,
    transactionServerId: transactionServerId ?? this.transactionServerId,
    productServerId: productServerId.present
        ? productServerId.value
        : this.productServerId,
    productName: productName.present ? productName.value : this.productName,
    productSku: productSku.present ? productSku.value : this.productSku,
    description: description ?? this.description,
    quantityMilli: quantityMilli ?? this.quantityMilli,
    unit: unit ?? this.unit,
    unitPriceMinor: unitPriceMinor ?? this.unitPriceMinor,
    unitCostMinor: unitCostMinor.present
        ? unitCostMinor.value
        : this.unitCostMinor,
    lineTotalMinor: lineTotalMinor ?? this.lineTotalMinor,
    lineCostMinor: lineCostMinor.present
        ? lineCostMinor.value
        : this.lineCostMinor,
    costSource: costSource.present ? costSource.value : this.costSource,
  );
  LocalTransactionItem copyWithCompanion(LocalTransactionItemsCompanion data) {
    return LocalTransactionItem(
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      transactionServerId: data.transactionServerId.present
          ? data.transactionServerId.value
          : this.transactionServerId,
      productServerId: data.productServerId.present
          ? data.productServerId.value
          : this.productServerId,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      productSku: data.productSku.present
          ? data.productSku.value
          : this.productSku,
      description: data.description.present
          ? data.description.value
          : this.description,
      quantityMilli: data.quantityMilli.present
          ? data.quantityMilli.value
          : this.quantityMilli,
      unit: data.unit.present ? data.unit.value : this.unit,
      unitPriceMinor: data.unitPriceMinor.present
          ? data.unitPriceMinor.value
          : this.unitPriceMinor,
      unitCostMinor: data.unitCostMinor.present
          ? data.unitCostMinor.value
          : this.unitCostMinor,
      lineTotalMinor: data.lineTotalMinor.present
          ? data.lineTotalMinor.value
          : this.lineTotalMinor,
      lineCostMinor: data.lineCostMinor.present
          ? data.lineCostMinor.value
          : this.lineCostMinor,
      costSource: data.costSource.present
          ? data.costSource.value
          : this.costSource,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalTransactionItem(')
          ..write('serverId: $serverId, ')
          ..write('transactionServerId: $transactionServerId, ')
          ..write('productServerId: $productServerId, ')
          ..write('productName: $productName, ')
          ..write('productSku: $productSku, ')
          ..write('description: $description, ')
          ..write('quantityMilli: $quantityMilli, ')
          ..write('unit: $unit, ')
          ..write('unitPriceMinor: $unitPriceMinor, ')
          ..write('unitCostMinor: $unitCostMinor, ')
          ..write('lineTotalMinor: $lineTotalMinor, ')
          ..write('lineCostMinor: $lineCostMinor, ')
          ..write('costSource: $costSource')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    serverId,
    transactionServerId,
    productServerId,
    productName,
    productSku,
    description,
    quantityMilli,
    unit,
    unitPriceMinor,
    unitCostMinor,
    lineTotalMinor,
    lineCostMinor,
    costSource,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalTransactionItem &&
          other.serverId == this.serverId &&
          other.transactionServerId == this.transactionServerId &&
          other.productServerId == this.productServerId &&
          other.productName == this.productName &&
          other.productSku == this.productSku &&
          other.description == this.description &&
          other.quantityMilli == this.quantityMilli &&
          other.unit == this.unit &&
          other.unitPriceMinor == this.unitPriceMinor &&
          other.unitCostMinor == this.unitCostMinor &&
          other.lineTotalMinor == this.lineTotalMinor &&
          other.lineCostMinor == this.lineCostMinor &&
          other.costSource == this.costSource);
}

class LocalTransactionItemsCompanion
    extends UpdateCompanion<LocalTransactionItem> {
  final Value<int> serverId;
  final Value<int> transactionServerId;
  final Value<int?> productServerId;
  final Value<String?> productName;
  final Value<String?> productSku;
  final Value<String> description;
  final Value<int> quantityMilli;
  final Value<String> unit;
  final Value<int> unitPriceMinor;
  final Value<int?> unitCostMinor;
  final Value<int> lineTotalMinor;
  final Value<int?> lineCostMinor;
  final Value<String?> costSource;
  const LocalTransactionItemsCompanion({
    this.serverId = const Value.absent(),
    this.transactionServerId = const Value.absent(),
    this.productServerId = const Value.absent(),
    this.productName = const Value.absent(),
    this.productSku = const Value.absent(),
    this.description = const Value.absent(),
    this.quantityMilli = const Value.absent(),
    this.unit = const Value.absent(),
    this.unitPriceMinor = const Value.absent(),
    this.unitCostMinor = const Value.absent(),
    this.lineTotalMinor = const Value.absent(),
    this.lineCostMinor = const Value.absent(),
    this.costSource = const Value.absent(),
  });
  LocalTransactionItemsCompanion.insert({
    this.serverId = const Value.absent(),
    required int transactionServerId,
    this.productServerId = const Value.absent(),
    this.productName = const Value.absent(),
    this.productSku = const Value.absent(),
    required String description,
    required int quantityMilli,
    required String unit,
    required int unitPriceMinor,
    this.unitCostMinor = const Value.absent(),
    required int lineTotalMinor,
    this.lineCostMinor = const Value.absent(),
    this.costSource = const Value.absent(),
  }) : transactionServerId = Value(transactionServerId),
       description = Value(description),
       quantityMilli = Value(quantityMilli),
       unit = Value(unit),
       unitPriceMinor = Value(unitPriceMinor),
       lineTotalMinor = Value(lineTotalMinor);
  static Insertable<LocalTransactionItem> custom({
    Expression<int>? serverId,
    Expression<int>? transactionServerId,
    Expression<int>? productServerId,
    Expression<String>? productName,
    Expression<String>? productSku,
    Expression<String>? description,
    Expression<int>? quantityMilli,
    Expression<String>? unit,
    Expression<int>? unitPriceMinor,
    Expression<int>? unitCostMinor,
    Expression<int>? lineTotalMinor,
    Expression<int>? lineCostMinor,
    Expression<String>? costSource,
  }) {
    return RawValuesInsertable({
      if (serverId != null) 'server_id': serverId,
      if (transactionServerId != null)
        'transaction_server_id': transactionServerId,
      if (productServerId != null) 'product_server_id': productServerId,
      if (productName != null) 'product_name': productName,
      if (productSku != null) 'product_sku': productSku,
      if (description != null) 'description': description,
      if (quantityMilli != null) 'quantity_milli': quantityMilli,
      if (unit != null) 'unit': unit,
      if (unitPriceMinor != null) 'unit_price_minor': unitPriceMinor,
      if (unitCostMinor != null) 'unit_cost_minor': unitCostMinor,
      if (lineTotalMinor != null) 'line_total_minor': lineTotalMinor,
      if (lineCostMinor != null) 'line_cost_minor': lineCostMinor,
      if (costSource != null) 'cost_source': costSource,
    });
  }

  LocalTransactionItemsCompanion copyWith({
    Value<int>? serverId,
    Value<int>? transactionServerId,
    Value<int?>? productServerId,
    Value<String?>? productName,
    Value<String?>? productSku,
    Value<String>? description,
    Value<int>? quantityMilli,
    Value<String>? unit,
    Value<int>? unitPriceMinor,
    Value<int?>? unitCostMinor,
    Value<int>? lineTotalMinor,
    Value<int?>? lineCostMinor,
    Value<String?>? costSource,
  }) {
    return LocalTransactionItemsCompanion(
      serverId: serverId ?? this.serverId,
      transactionServerId: transactionServerId ?? this.transactionServerId,
      productServerId: productServerId ?? this.productServerId,
      productName: productName ?? this.productName,
      productSku: productSku ?? this.productSku,
      description: description ?? this.description,
      quantityMilli: quantityMilli ?? this.quantityMilli,
      unit: unit ?? this.unit,
      unitPriceMinor: unitPriceMinor ?? this.unitPriceMinor,
      unitCostMinor: unitCostMinor ?? this.unitCostMinor,
      lineTotalMinor: lineTotalMinor ?? this.lineTotalMinor,
      lineCostMinor: lineCostMinor ?? this.lineCostMinor,
      costSource: costSource ?? this.costSource,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    if (transactionServerId.present) {
      map['transaction_server_id'] = Variable<int>(transactionServerId.value);
    }
    if (productServerId.present) {
      map['product_server_id'] = Variable<int>(productServerId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (productSku.present) {
      map['product_sku'] = Variable<String>(productSku.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (quantityMilli.present) {
      map['quantity_milli'] = Variable<int>(quantityMilli.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (unitPriceMinor.present) {
      map['unit_price_minor'] = Variable<int>(unitPriceMinor.value);
    }
    if (unitCostMinor.present) {
      map['unit_cost_minor'] = Variable<int>(unitCostMinor.value);
    }
    if (lineTotalMinor.present) {
      map['line_total_minor'] = Variable<int>(lineTotalMinor.value);
    }
    if (lineCostMinor.present) {
      map['line_cost_minor'] = Variable<int>(lineCostMinor.value);
    }
    if (costSource.present) {
      map['cost_source'] = Variable<String>(costSource.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalTransactionItemsCompanion(')
          ..write('serverId: $serverId, ')
          ..write('transactionServerId: $transactionServerId, ')
          ..write('productServerId: $productServerId, ')
          ..write('productName: $productName, ')
          ..write('productSku: $productSku, ')
          ..write('description: $description, ')
          ..write('quantityMilli: $quantityMilli, ')
          ..write('unit: $unit, ')
          ..write('unitPriceMinor: $unitPriceMinor, ')
          ..write('unitCostMinor: $unitCostMinor, ')
          ..write('lineTotalMinor: $lineTotalMinor, ')
          ..write('lineCostMinor: $lineCostMinor, ')
          ..write('costSource: $costSource')
          ..write(')'))
        .toString();
  }
}

class $LocalSyncOperationsTable extends LocalSyncOperations
    with TableInfo<$LocalSyncOperationsTable, LocalSyncOperation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalSyncOperationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _operationUuidMeta = const VerificationMeta(
    'operationUuid',
  );
  @override
  late final GeneratedColumn<String> operationUuid = GeneratedColumn<String>(
    'operation_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _operationTypeMeta = const VerificationMeta(
    'operationType',
  );
  @override
  late final GeneratedColumn<String> operationType = GeneratedColumn<String>(
    'operation_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending_sync'),
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    operationUuid,
    operationType,
    payloadJson,
    status,
    attempts,
    lastError,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_sync_operations';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalSyncOperation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('operation_uuid')) {
      context.handle(
        _operationUuidMeta,
        operationUuid.isAcceptableOrUnknown(
          data['operation_uuid']!,
          _operationUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_operationUuidMeta);
    }
    if (data.containsKey('operation_type')) {
      context.handle(
        _operationTypeMeta,
        operationType.isAcceptableOrUnknown(
          data['operation_type']!,
          _operationTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_operationTypeMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalSyncOperation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalSyncOperation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      operationUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation_uuid'],
      )!,
      operationType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation_type'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LocalSyncOperationsTable createAlias(String alias) {
    return $LocalSyncOperationsTable(attachedDatabase, alias);
  }
}

class LocalSyncOperation extends DataClass
    implements Insertable<LocalSyncOperation> {
  final int id;
  final String operationUuid;
  final String operationType;
  final String payloadJson;
  final String status;
  final int attempts;
  final String? lastError;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LocalSyncOperation({
    required this.id,
    required this.operationUuid,
    required this.operationType,
    required this.payloadJson,
    required this.status,
    required this.attempts,
    this.lastError,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['operation_uuid'] = Variable<String>(operationUuid);
    map['operation_type'] = Variable<String>(operationType);
    map['payload_json'] = Variable<String>(payloadJson);
    map['status'] = Variable<String>(status);
    map['attempts'] = Variable<int>(attempts);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocalSyncOperationsCompanion toCompanion(bool nullToAbsent) {
    return LocalSyncOperationsCompanion(
      id: Value(id),
      operationUuid: Value(operationUuid),
      operationType: Value(operationType),
      payloadJson: Value(payloadJson),
      status: Value(status),
      attempts: Value(attempts),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalSyncOperation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalSyncOperation(
      id: serializer.fromJson<int>(json['id']),
      operationUuid: serializer.fromJson<String>(json['operationUuid']),
      operationType: serializer.fromJson<String>(json['operationType']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      status: serializer.fromJson<String>(json['status']),
      attempts: serializer.fromJson<int>(json['attempts']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'operationUuid': serializer.toJson<String>(operationUuid),
      'operationType': serializer.toJson<String>(operationType),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'status': serializer.toJson<String>(status),
      'attempts': serializer.toJson<int>(attempts),
      'lastError': serializer.toJson<String?>(lastError),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalSyncOperation copyWith({
    int? id,
    String? operationUuid,
    String? operationType,
    String? payloadJson,
    String? status,
    int? attempts,
    Value<String?> lastError = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => LocalSyncOperation(
    id: id ?? this.id,
    operationUuid: operationUuid ?? this.operationUuid,
    operationType: operationType ?? this.operationType,
    payloadJson: payloadJson ?? this.payloadJson,
    status: status ?? this.status,
    attempts: attempts ?? this.attempts,
    lastError: lastError.present ? lastError.value : this.lastError,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LocalSyncOperation copyWithCompanion(LocalSyncOperationsCompanion data) {
    return LocalSyncOperation(
      id: data.id.present ? data.id.value : this.id,
      operationUuid: data.operationUuid.present
          ? data.operationUuid.value
          : this.operationUuid,
      operationType: data.operationType.present
          ? data.operationType.value
          : this.operationType,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      status: data.status.present ? data.status.value : this.status,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalSyncOperation(')
          ..write('id: $id, ')
          ..write('operationUuid: $operationUuid, ')
          ..write('operationType: $operationType, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('status: $status, ')
          ..write('attempts: $attempts, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    operationUuid,
    operationType,
    payloadJson,
    status,
    attempts,
    lastError,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSyncOperation &&
          other.id == this.id &&
          other.operationUuid == this.operationUuid &&
          other.operationType == this.operationType &&
          other.payloadJson == this.payloadJson &&
          other.status == this.status &&
          other.attempts == this.attempts &&
          other.lastError == this.lastError &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalSyncOperationsCompanion extends UpdateCompanion<LocalSyncOperation> {
  final Value<int> id;
  final Value<String> operationUuid;
  final Value<String> operationType;
  final Value<String> payloadJson;
  final Value<String> status;
  final Value<int> attempts;
  final Value<String?> lastError;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const LocalSyncOperationsCompanion({
    this.id = const Value.absent(),
    this.operationUuid = const Value.absent(),
    this.operationType = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.status = const Value.absent(),
    this.attempts = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LocalSyncOperationsCompanion.insert({
    this.id = const Value.absent(),
    required String operationUuid,
    required String operationType,
    required String payloadJson,
    this.status = const Value.absent(),
    this.attempts = const Value.absent(),
    this.lastError = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : operationUuid = Value(operationUuid),
       operationType = Value(operationType),
       payloadJson = Value(payloadJson),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalSyncOperation> custom({
    Expression<int>? id,
    Expression<String>? operationUuid,
    Expression<String>? operationType,
    Expression<String>? payloadJson,
    Expression<String>? status,
    Expression<int>? attempts,
    Expression<String>? lastError,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (operationUuid != null) 'operation_uuid': operationUuid,
      if (operationType != null) 'operation_type': operationType,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (status != null) 'status': status,
      if (attempts != null) 'attempts': attempts,
      if (lastError != null) 'last_error': lastError,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LocalSyncOperationsCompanion copyWith({
    Value<int>? id,
    Value<String>? operationUuid,
    Value<String>? operationType,
    Value<String>? payloadJson,
    Value<String>? status,
    Value<int>? attempts,
    Value<String?>? lastError,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return LocalSyncOperationsCompanion(
      id: id ?? this.id,
      operationUuid: operationUuid ?? this.operationUuid,
      operationType: operationType ?? this.operationType,
      payloadJson: payloadJson ?? this.payloadJson,
      status: status ?? this.status,
      attempts: attempts ?? this.attempts,
      lastError: lastError ?? this.lastError,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (operationUuid.present) {
      map['operation_uuid'] = Variable<String>(operationUuid.value);
    }
    if (operationType.present) {
      map['operation_type'] = Variable<String>(operationType.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalSyncOperationsCompanion(')
          ..write('id: $id, ')
          ..write('operationUuid: $operationUuid, ')
          ..write('operationType: $operationType, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('status: $status, ')
          ..write('attempts: $attempts, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LocalAttachmentQueueTable extends LocalAttachmentQueue
    with TableInfo<$LocalAttachmentQueueTable, LocalAttachmentQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalAttachmentQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _transactionUuidMeta = const VerificationMeta(
    'transactionUuid',
  );
  @override
  late final GeneratedColumn<String> transactionUuid = GeneratedColumn<String>(
    'transaction_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionServerIdMeta =
      const VerificationMeta('transactionServerId');
  @override
  late final GeneratedColumn<int> transactionServerId = GeneratedColumn<int>(
    'transaction_server_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originalNameMeta = const VerificationMeta(
    'originalName',
  );
  @override
  late final GeneratedColumn<String> originalName = GeneratedColumn<String>(
    'original_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeBytesMeta = const VerificationMeta(
    'sizeBytes',
  );
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
    'size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bytesBase64Meta = const VerificationMeta(
    'bytesBase64',
  );
  @override
  late final GeneratedColumn<String> bytesBase64 = GeneratedColumn<String>(
    'bytes_base64',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending_sync'),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    transactionUuid,
    transactionServerId,
    originalName,
    mimeType,
    sizeBytes,
    bytesBase64,
    syncStatus,
    lastError,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_attachment_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalAttachmentQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('transaction_uuid')) {
      context.handle(
        _transactionUuidMeta,
        transactionUuid.isAcceptableOrUnknown(
          data['transaction_uuid']!,
          _transactionUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionUuidMeta);
    }
    if (data.containsKey('transaction_server_id')) {
      context.handle(
        _transactionServerIdMeta,
        transactionServerId.isAcceptableOrUnknown(
          data['transaction_server_id']!,
          _transactionServerIdMeta,
        ),
      );
    }
    if (data.containsKey('original_name')) {
      context.handle(
        _originalNameMeta,
        originalName.isAcceptableOrUnknown(
          data['original_name']!,
          _originalNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalNameMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mimeTypeMeta);
    }
    if (data.containsKey('size_bytes')) {
      context.handle(
        _sizeBytesMeta,
        sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeBytesMeta);
    }
    if (data.containsKey('bytes_base64')) {
      context.handle(
        _bytesBase64Meta,
        bytesBase64.isAcceptableOrUnknown(
          data['bytes_base64']!,
          _bytesBase64Meta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bytesBase64Meta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalAttachmentQueueData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalAttachmentQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      transactionUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_uuid'],
      )!,
      transactionServerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}transaction_server_id'],
      ),
      originalName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_name'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      )!,
      sizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_bytes'],
      )!,
      bytesBase64: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bytes_base64'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LocalAttachmentQueueTable createAlias(String alias) {
    return $LocalAttachmentQueueTable(attachedDatabase, alias);
  }
}

class LocalAttachmentQueueData extends DataClass
    implements Insertable<LocalAttachmentQueueData> {
  final int id;
  final String uuid;
  final String transactionUuid;
  final int? transactionServerId;
  final String originalName;
  final String mimeType;
  final int sizeBytes;
  final String bytesBase64;
  final String syncStatus;
  final String? lastError;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LocalAttachmentQueueData({
    required this.id,
    required this.uuid,
    required this.transactionUuid,
    this.transactionServerId,
    required this.originalName,
    required this.mimeType,
    required this.sizeBytes,
    required this.bytesBase64,
    required this.syncStatus,
    this.lastError,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['transaction_uuid'] = Variable<String>(transactionUuid);
    if (!nullToAbsent || transactionServerId != null) {
      map['transaction_server_id'] = Variable<int>(transactionServerId);
    }
    map['original_name'] = Variable<String>(originalName);
    map['mime_type'] = Variable<String>(mimeType);
    map['size_bytes'] = Variable<int>(sizeBytes);
    map['bytes_base64'] = Variable<String>(bytesBase64);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocalAttachmentQueueCompanion toCompanion(bool nullToAbsent) {
    return LocalAttachmentQueueCompanion(
      id: Value(id),
      uuid: Value(uuid),
      transactionUuid: Value(transactionUuid),
      transactionServerId: transactionServerId == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionServerId),
      originalName: Value(originalName),
      mimeType: Value(mimeType),
      sizeBytes: Value(sizeBytes),
      bytesBase64: Value(bytesBase64),
      syncStatus: Value(syncStatus),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalAttachmentQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalAttachmentQueueData(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      transactionUuid: serializer.fromJson<String>(json['transactionUuid']),
      transactionServerId: serializer.fromJson<int?>(
        json['transactionServerId'],
      ),
      originalName: serializer.fromJson<String>(json['originalName']),
      mimeType: serializer.fromJson<String>(json['mimeType']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      bytesBase64: serializer.fromJson<String>(json['bytesBase64']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'transactionUuid': serializer.toJson<String>(transactionUuid),
      'transactionServerId': serializer.toJson<int?>(transactionServerId),
      'originalName': serializer.toJson<String>(originalName),
      'mimeType': serializer.toJson<String>(mimeType),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'bytesBase64': serializer.toJson<String>(bytesBase64),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastError': serializer.toJson<String?>(lastError),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalAttachmentQueueData copyWith({
    int? id,
    String? uuid,
    String? transactionUuid,
    Value<int?> transactionServerId = const Value.absent(),
    String? originalName,
    String? mimeType,
    int? sizeBytes,
    String? bytesBase64,
    String? syncStatus,
    Value<String?> lastError = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => LocalAttachmentQueueData(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    transactionUuid: transactionUuid ?? this.transactionUuid,
    transactionServerId: transactionServerId.present
        ? transactionServerId.value
        : this.transactionServerId,
    originalName: originalName ?? this.originalName,
    mimeType: mimeType ?? this.mimeType,
    sizeBytes: sizeBytes ?? this.sizeBytes,
    bytesBase64: bytesBase64 ?? this.bytesBase64,
    syncStatus: syncStatus ?? this.syncStatus,
    lastError: lastError.present ? lastError.value : this.lastError,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LocalAttachmentQueueData copyWithCompanion(
    LocalAttachmentQueueCompanion data,
  ) {
    return LocalAttachmentQueueData(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      transactionUuid: data.transactionUuid.present
          ? data.transactionUuid.value
          : this.transactionUuid,
      transactionServerId: data.transactionServerId.present
          ? data.transactionServerId.value
          : this.transactionServerId,
      originalName: data.originalName.present
          ? data.originalName.value
          : this.originalName,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      bytesBase64: data.bytesBase64.present
          ? data.bytesBase64.value
          : this.bytesBase64,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalAttachmentQueueData(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('transactionUuid: $transactionUuid, ')
          ..write('transactionServerId: $transactionServerId, ')
          ..write('originalName: $originalName, ')
          ..write('mimeType: $mimeType, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('bytesBase64: $bytesBase64, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    transactionUuid,
    transactionServerId,
    originalName,
    mimeType,
    sizeBytes,
    bytesBase64,
    syncStatus,
    lastError,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalAttachmentQueueData &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.transactionUuid == this.transactionUuid &&
          other.transactionServerId == this.transactionServerId &&
          other.originalName == this.originalName &&
          other.mimeType == this.mimeType &&
          other.sizeBytes == this.sizeBytes &&
          other.bytesBase64 == this.bytesBase64 &&
          other.syncStatus == this.syncStatus &&
          other.lastError == this.lastError &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalAttachmentQueueCompanion
    extends UpdateCompanion<LocalAttachmentQueueData> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> transactionUuid;
  final Value<int?> transactionServerId;
  final Value<String> originalName;
  final Value<String> mimeType;
  final Value<int> sizeBytes;
  final Value<String> bytesBase64;
  final Value<String> syncStatus;
  final Value<String?> lastError;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const LocalAttachmentQueueCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.transactionUuid = const Value.absent(),
    this.transactionServerId = const Value.absent(),
    this.originalName = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.bytesBase64 = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LocalAttachmentQueueCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String transactionUuid,
    this.transactionServerId = const Value.absent(),
    required String originalName,
    required String mimeType,
    required int sizeBytes,
    required String bytesBase64,
    this.syncStatus = const Value.absent(),
    this.lastError = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : uuid = Value(uuid),
       transactionUuid = Value(transactionUuid),
       originalName = Value(originalName),
       mimeType = Value(mimeType),
       sizeBytes = Value(sizeBytes),
       bytesBase64 = Value(bytesBase64),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalAttachmentQueueData> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? transactionUuid,
    Expression<int>? transactionServerId,
    Expression<String>? originalName,
    Expression<String>? mimeType,
    Expression<int>? sizeBytes,
    Expression<String>? bytesBase64,
    Expression<String>? syncStatus,
    Expression<String>? lastError,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (transactionUuid != null) 'transaction_uuid': transactionUuid,
      if (transactionServerId != null)
        'transaction_server_id': transactionServerId,
      if (originalName != null) 'original_name': originalName,
      if (mimeType != null) 'mime_type': mimeType,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (bytesBase64 != null) 'bytes_base64': bytesBase64,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastError != null) 'last_error': lastError,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LocalAttachmentQueueCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<String>? transactionUuid,
    Value<int?>? transactionServerId,
    Value<String>? originalName,
    Value<String>? mimeType,
    Value<int>? sizeBytes,
    Value<String>? bytesBase64,
    Value<String>? syncStatus,
    Value<String?>? lastError,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return LocalAttachmentQueueCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      transactionUuid: transactionUuid ?? this.transactionUuid,
      transactionServerId: transactionServerId ?? this.transactionServerId,
      originalName: originalName ?? this.originalName,
      mimeType: mimeType ?? this.mimeType,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      bytesBase64: bytesBase64 ?? this.bytesBase64,
      syncStatus: syncStatus ?? this.syncStatus,
      lastError: lastError ?? this.lastError,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (transactionUuid.present) {
      map['transaction_uuid'] = Variable<String>(transactionUuid.value);
    }
    if (transactionServerId.present) {
      map['transaction_server_id'] = Variable<int>(transactionServerId.value);
    }
    if (originalName.present) {
      map['original_name'] = Variable<String>(originalName.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (bytesBase64.present) {
      map['bytes_base64'] = Variable<String>(bytesBase64.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalAttachmentQueueCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('transactionUuid: $transactionUuid, ')
          ..write('transactionServerId: $transactionServerId, ')
          ..write('originalName: $originalName, ')
          ..write('mimeType: $mimeType, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('bytesBase64: $bytesBase64, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalUsersTable localUsers = $LocalUsersTable(this);
  late final $LocalCurrenciesTable localCurrencies = $LocalCurrenciesTable(
    this,
  );
  late final $LocalFinancialAccountsTable localFinancialAccounts =
      $LocalFinancialAccountsTable(this);
  late final $LocalCategoriesTable localCategories = $LocalCategoriesTable(
    this,
  );
  late final $LocalPartiesTable localParties = $LocalPartiesTable(this);
  late final $LocalPartyOpeningBalancesTable localPartyOpeningBalances =
      $LocalPartyOpeningBalancesTable(this);
  late final $LocalWorkersTable localWorkers = $LocalWorkersTable(this);
  late final $LocalWorkerOpeningBalancesTable localWorkerOpeningBalances =
      $LocalWorkerOpeningBalancesTable(this);
  late final $LocalAccountingTransactionsTable localAccountingTransactions =
      $LocalAccountingTransactionsTable(this);
  late final $LocalProductsTable localProducts = $LocalProductsTable(this);
  late final $LocalTransactionItemsTable localTransactionItems =
      $LocalTransactionItemsTable(this);
  late final $LocalSyncOperationsTable localSyncOperations =
      $LocalSyncOperationsTable(this);
  late final $LocalAttachmentQueueTable localAttachmentQueue =
      $LocalAttachmentQueueTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    localUsers,
    localCurrencies,
    localFinancialAccounts,
    localCategories,
    localParties,
    localPartyOpeningBalances,
    localWorkers,
    localWorkerOpeningBalances,
    localAccountingTransactions,
    localProducts,
    localTransactionItems,
    localSyncOperations,
    localAttachmentQueue,
  ];
}

typedef $$LocalUsersTableCreateCompanionBuilder = LocalUsersCompanion Function({
  Value<int> serverId,
  required String name,
  required String email,
  required String role,
  required String status,
  required String deviceUuid,
  Value<bool> isTrusted,
  required DateTime lastOnlineLoginAt,
});
typedef $$LocalUsersTableUpdateCompanionBuilder = LocalUsersCompanion Function({
  Value<int> serverId,
  Value<String> name,
  Value<String> email,
  Value<String> role,
  Value<String> status,
  Value<String> deviceUuid,
  Value<bool> isTrusted,
  Value<DateTime> lastOnlineLoginAt,
});

class $$LocalUsersTableFilterComposer
    extends Composer<_$AppDatabase, $LocalUsersTable> {
  $$LocalUsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceUuid => $composableBuilder(
    column: $table.deviceUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isTrusted => $composableBuilder(
    column: $table.isTrusted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastOnlineLoginAt => $composableBuilder(
    column: $table.lastOnlineLoginAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalUsersTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalUsersTable> {
  $$LocalUsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceUuid => $composableBuilder(
    column: $table.deviceUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isTrusted => $composableBuilder(
    column: $table.isTrusted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastOnlineLoginAt => $composableBuilder(
    column: $table.lastOnlineLoginAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalUsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalUsersTable> {
  $$LocalUsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get deviceUuid => $composableBuilder(
    column: $table.deviceUuid,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isTrusted =>
      $composableBuilder(column: $table.isTrusted, builder: (column) => column);

  GeneratedColumn<DateTime> get lastOnlineLoginAt => $composableBuilder(
    column: $table.lastOnlineLoginAt,
    builder: (column) => column,
  );
}

class $$LocalUsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalUsersTable,
          LocalUser,
          $$LocalUsersTableFilterComposer,
          $$LocalUsersTableOrderingComposer,
          $$LocalUsersTableAnnotationComposer,
          $$LocalUsersTableCreateCompanionBuilder,
          $$LocalUsersTableUpdateCompanionBuilder,
          (
            LocalUser,
            BaseReferences<_$AppDatabase, $LocalUsersTable, LocalUser>,
          ),
          LocalUser,
          PrefetchHooks Function()
        > {
  $$LocalUsersTableTableManager(_$AppDatabase db, $LocalUsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalUsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalUsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalUsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> serverId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> deviceUuid = const Value.absent(),
                Value<bool> isTrusted = const Value.absent(),
                Value<DateTime> lastOnlineLoginAt = const Value.absent(),
              }) => LocalUsersCompanion(
                serverId: serverId,
                name: name,
                email: email,
                role: role,
                status: status,
                deviceUuid: deviceUuid,
                isTrusted: isTrusted,
                lastOnlineLoginAt: lastOnlineLoginAt,
              ),
          createCompanionCallback:
              ({
                Value<int> serverId = const Value.absent(),
                required String name,
                required String email,
                required String role,
                required String status,
                required String deviceUuid,
                Value<bool> isTrusted = const Value.absent(),
                required DateTime lastOnlineLoginAt,
              }) => LocalUsersCompanion.insert(
                serverId: serverId,
                name: name,
                email: email,
                role: role,
                status: status,
                deviceUuid: deviceUuid,
                isTrusted: isTrusted,
                lastOnlineLoginAt: lastOnlineLoginAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalUsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalUsersTable,
      LocalUser,
      $$LocalUsersTableFilterComposer,
      $$LocalUsersTableOrderingComposer,
      $$LocalUsersTableAnnotationComposer,
      $$LocalUsersTableCreateCompanionBuilder,
      $$LocalUsersTableUpdateCompanionBuilder,
      (LocalUser, BaseReferences<_$AppDatabase, $LocalUsersTable, LocalUser>),
      LocalUser,
      PrefetchHooks Function()
    >;
typedef $$LocalCurrenciesTableCreateCompanionBuilder =
    LocalCurrenciesCompanion Function({
      Value<int> serverId,
      required String uuid,
      required String code,
      required String nameAr,
      required String symbol,
      required int decimalPlaces,
      required bool isActive,
      Value<DateTime?> updatedAt,
    });
typedef $$LocalCurrenciesTableUpdateCompanionBuilder =
    LocalCurrenciesCompanion Function({
      Value<int> serverId,
      Value<String> uuid,
      Value<String> code,
      Value<String> nameAr,
      Value<String> symbol,
      Value<int> decimalPlaces,
      Value<bool> isActive,
      Value<DateTime?> updatedAt,
    });

class $$LocalCurrenciesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalCurrenciesTable> {
  $$LocalCurrenciesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameAr => $composableBuilder(
    column: $table.nameAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get decimalPlaces => $composableBuilder(
    column: $table.decimalPlaces,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalCurrenciesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalCurrenciesTable> {
  $$LocalCurrenciesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameAr => $composableBuilder(
    column: $table.nameAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get decimalPlaces => $composableBuilder(
    column: $table.decimalPlaces,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalCurrenciesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalCurrenciesTable> {
  $$LocalCurrenciesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

  GeneratedColumn<int> get decimalPlaces => $composableBuilder(
    column: $table.decimalPlaces,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalCurrenciesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalCurrenciesTable,
          LocalCurrency,
          $$LocalCurrenciesTableFilterComposer,
          $$LocalCurrenciesTableOrderingComposer,
          $$LocalCurrenciesTableAnnotationComposer,
          $$LocalCurrenciesTableCreateCompanionBuilder,
          $$LocalCurrenciesTableUpdateCompanionBuilder,
          (
            LocalCurrency,
            BaseReferences<_$AppDatabase, $LocalCurrenciesTable, LocalCurrency>,
          ),
          LocalCurrency,
          PrefetchHooks Function()
        > {
  $$LocalCurrenciesTableTableManager(
    _$AppDatabase db,
    $LocalCurrenciesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalCurrenciesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalCurrenciesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalCurrenciesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> serverId = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> nameAr = const Value.absent(),
                Value<String> symbol = const Value.absent(),
                Value<int> decimalPlaces = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => LocalCurrenciesCompanion(
                serverId: serverId,
                uuid: uuid,
                code: code,
                nameAr: nameAr,
                symbol: symbol,
                decimalPlaces: decimalPlaces,
                isActive: isActive,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> serverId = const Value.absent(),
                required String uuid,
                required String code,
                required String nameAr,
                required String symbol,
                required int decimalPlaces,
                required bool isActive,
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => LocalCurrenciesCompanion.insert(
                serverId: serverId,
                uuid: uuid,
                code: code,
                nameAr: nameAr,
                symbol: symbol,
                decimalPlaces: decimalPlaces,
                isActive: isActive,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalCurrenciesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalCurrenciesTable,
      LocalCurrency,
      $$LocalCurrenciesTableFilterComposer,
      $$LocalCurrenciesTableOrderingComposer,
      $$LocalCurrenciesTableAnnotationComposer,
      $$LocalCurrenciesTableCreateCompanionBuilder,
      $$LocalCurrenciesTableUpdateCompanionBuilder,
      (
        LocalCurrency,
        BaseReferences<_$AppDatabase, $LocalCurrenciesTable, LocalCurrency>,
      ),
      LocalCurrency,
      PrefetchHooks Function()
    >;
typedef $$LocalFinancialAccountsTableCreateCompanionBuilder =
    LocalFinancialAccountsCompanion Function({
      Value<int> serverId,
      required String uuid,
      required String name,
      required String type,
      required int currencyServerId,
      required String currencyCode,
      required String currencySymbol,
      required int currencyDecimalPlaces,
      required int openingBalanceMinor,
      Value<String?> notes,
      required bool isActive,
      Value<DateTime?> updatedAt,
    });
typedef $$LocalFinancialAccountsTableUpdateCompanionBuilder =
    LocalFinancialAccountsCompanion Function({
      Value<int> serverId,
      Value<String> uuid,
      Value<String> name,
      Value<String> type,
      Value<int> currencyServerId,
      Value<String> currencyCode,
      Value<String> currencySymbol,
      Value<int> currencyDecimalPlaces,
      Value<int> openingBalanceMinor,
      Value<String?> notes,
      Value<bool> isActive,
      Value<DateTime?> updatedAt,
    });

class $$LocalFinancialAccountsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalFinancialAccountsTable> {
  $$LocalFinancialAccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currencyServerId => $composableBuilder(
    column: $table.currencyServerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencySymbol => $composableBuilder(
    column: $table.currencySymbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currencyDecimalPlaces => $composableBuilder(
    column: $table.currencyDecimalPlaces,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get openingBalanceMinor => $composableBuilder(
    column: $table.openingBalanceMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalFinancialAccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalFinancialAccountsTable> {
  $$LocalFinancialAccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currencyServerId => $composableBuilder(
    column: $table.currencyServerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencySymbol => $composableBuilder(
    column: $table.currencySymbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currencyDecimalPlaces => $composableBuilder(
    column: $table.currencyDecimalPlaces,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get openingBalanceMinor => $composableBuilder(
    column: $table.openingBalanceMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalFinancialAccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalFinancialAccountsTable> {
  $$LocalFinancialAccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get currencyServerId => $composableBuilder(
    column: $table.currencyServerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencySymbol => $composableBuilder(
    column: $table.currencySymbol,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currencyDecimalPlaces => $composableBuilder(
    column: $table.currencyDecimalPlaces,
    builder: (column) => column,
  );

  GeneratedColumn<int> get openingBalanceMinor => $composableBuilder(
    column: $table.openingBalanceMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalFinancialAccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalFinancialAccountsTable,
          LocalFinancialAccount,
          $$LocalFinancialAccountsTableFilterComposer,
          $$LocalFinancialAccountsTableOrderingComposer,
          $$LocalFinancialAccountsTableAnnotationComposer,
          $$LocalFinancialAccountsTableCreateCompanionBuilder,
          $$LocalFinancialAccountsTableUpdateCompanionBuilder,
          (
            LocalFinancialAccount,
            BaseReferences<
              _$AppDatabase,
              $LocalFinancialAccountsTable,
              LocalFinancialAccount
            >,
          ),
          LocalFinancialAccount,
          PrefetchHooks Function()
        > {
  $$LocalFinancialAccountsTableTableManager(
    _$AppDatabase db,
    $LocalFinancialAccountsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalFinancialAccountsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalFinancialAccountsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalFinancialAccountsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> serverId = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> currencyServerId = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<String> currencySymbol = const Value.absent(),
                Value<int> currencyDecimalPlaces = const Value.absent(),
                Value<int> openingBalanceMinor = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => LocalFinancialAccountsCompanion(
                serverId: serverId,
                uuid: uuid,
                name: name,
                type: type,
                currencyServerId: currencyServerId,
                currencyCode: currencyCode,
                currencySymbol: currencySymbol,
                currencyDecimalPlaces: currencyDecimalPlaces,
                openingBalanceMinor: openingBalanceMinor,
                notes: notes,
                isActive: isActive,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> serverId = const Value.absent(),
                required String uuid,
                required String name,
                required String type,
                required int currencyServerId,
                required String currencyCode,
                required String currencySymbol,
                required int currencyDecimalPlaces,
                required int openingBalanceMinor,
                Value<String?> notes = const Value.absent(),
                required bool isActive,
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => LocalFinancialAccountsCompanion.insert(
                serverId: serverId,
                uuid: uuid,
                name: name,
                type: type,
                currencyServerId: currencyServerId,
                currencyCode: currencyCode,
                currencySymbol: currencySymbol,
                currencyDecimalPlaces: currencyDecimalPlaces,
                openingBalanceMinor: openingBalanceMinor,
                notes: notes,
                isActive: isActive,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalFinancialAccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalFinancialAccountsTable,
      LocalFinancialAccount,
      $$LocalFinancialAccountsTableFilterComposer,
      $$LocalFinancialAccountsTableOrderingComposer,
      $$LocalFinancialAccountsTableAnnotationComposer,
      $$LocalFinancialAccountsTableCreateCompanionBuilder,
      $$LocalFinancialAccountsTableUpdateCompanionBuilder,
      (
        LocalFinancialAccount,
        BaseReferences<
          _$AppDatabase,
          $LocalFinancialAccountsTable,
          LocalFinancialAccount
        >,
      ),
      LocalFinancialAccount,
      PrefetchHooks Function()
    >;
typedef $$LocalCategoriesTableCreateCompanionBuilder =
    LocalCategoriesCompanion Function({
      Value<int> serverId,
      required String uuid,
      required String name,
      required String type,
      Value<String?> notes,
      required bool isActive,
      Value<DateTime?> updatedAt,
    });
typedef $$LocalCategoriesTableUpdateCompanionBuilder =
    LocalCategoriesCompanion Function({
      Value<int> serverId,
      Value<String> uuid,
      Value<String> name,
      Value<String> type,
      Value<String?> notes,
      Value<bool> isActive,
      Value<DateTime?> updatedAt,
    });

class $$LocalCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalCategoriesTable> {
  $$LocalCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalCategoriesTable> {
  $$LocalCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalCategoriesTable> {
  $$LocalCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalCategoriesTable,
          LocalCategory,
          $$LocalCategoriesTableFilterComposer,
          $$LocalCategoriesTableOrderingComposer,
          $$LocalCategoriesTableAnnotationComposer,
          $$LocalCategoriesTableCreateCompanionBuilder,
          $$LocalCategoriesTableUpdateCompanionBuilder,
          (
            LocalCategory,
            BaseReferences<_$AppDatabase, $LocalCategoriesTable, LocalCategory>,
          ),
          LocalCategory,
          PrefetchHooks Function()
        > {
  $$LocalCategoriesTableTableManager(
    _$AppDatabase db,
    $LocalCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalCategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> serverId = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => LocalCategoriesCompanion(
                serverId: serverId,
                uuid: uuid,
                name: name,
                type: type,
                notes: notes,
                isActive: isActive,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> serverId = const Value.absent(),
                required String uuid,
                required String name,
                required String type,
                Value<String?> notes = const Value.absent(),
                required bool isActive,
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => LocalCategoriesCompanion.insert(
                serverId: serverId,
                uuid: uuid,
                name: name,
                type: type,
                notes: notes,
                isActive: isActive,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalCategoriesTable,
      LocalCategory,
      $$LocalCategoriesTableFilterComposer,
      $$LocalCategoriesTableOrderingComposer,
      $$LocalCategoriesTableAnnotationComposer,
      $$LocalCategoriesTableCreateCompanionBuilder,
      $$LocalCategoriesTableUpdateCompanionBuilder,
      (
        LocalCategory,
        BaseReferences<_$AppDatabase, $LocalCategoriesTable, LocalCategory>,
      ),
      LocalCategory,
      PrefetchHooks Function()
    >;
typedef $$LocalPartiesTableCreateCompanionBuilder =
    LocalPartiesCompanion Function({
      Value<int> serverId,
      required String uuid,
      required String type,
      required String name,
      Value<String?> phone,
      Value<String?> address,
      Value<String?> notes,
      required bool isActive,
      required int version,
      Value<DateTime?> lastMovementAt,
      Value<DateTime?> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$LocalPartiesTableUpdateCompanionBuilder =
    LocalPartiesCompanion Function({
      Value<int> serverId,
      Value<String> uuid,
      Value<String> type,
      Value<String> name,
      Value<String?> phone,
      Value<String?> address,
      Value<String?> notes,
      Value<bool> isActive,
      Value<int> version,
      Value<DateTime?> lastMovementAt,
      Value<DateTime?> createdAt,
      Value<DateTime?> updatedAt,
    });

class $$LocalPartiesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalPartiesTable> {
  $$LocalPartiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastMovementAt => $composableBuilder(
    column: $table.lastMovementAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalPartiesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalPartiesTable> {
  $$LocalPartiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastMovementAt => $composableBuilder(
    column: $table.lastMovementAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalPartiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalPartiesTable> {
  $$LocalPartiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get lastMovementAt => $composableBuilder(
    column: $table.lastMovementAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalPartiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalPartiesTable,
          LocalParty,
          $$LocalPartiesTableFilterComposer,
          $$LocalPartiesTableOrderingComposer,
          $$LocalPartiesTableAnnotationComposer,
          $$LocalPartiesTableCreateCompanionBuilder,
          $$LocalPartiesTableUpdateCompanionBuilder,
          (
            LocalParty,
            BaseReferences<_$AppDatabase, $LocalPartiesTable, LocalParty>,
          ),
          LocalParty,
          PrefetchHooks Function()
        > {
  $$LocalPartiesTableTableManager(_$AppDatabase db, $LocalPartiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalPartiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalPartiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalPartiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> serverId = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<DateTime?> lastMovementAt = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => LocalPartiesCompanion(
                serverId: serverId,
                uuid: uuid,
                type: type,
                name: name,
                phone: phone,
                address: address,
                notes: notes,
                isActive: isActive,
                version: version,
                lastMovementAt: lastMovementAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> serverId = const Value.absent(),
                required String uuid,
                required String type,
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required bool isActive,
                required int version,
                Value<DateTime?> lastMovementAt = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => LocalPartiesCompanion.insert(
                serverId: serverId,
                uuid: uuid,
                type: type,
                name: name,
                phone: phone,
                address: address,
                notes: notes,
                isActive: isActive,
                version: version,
                lastMovementAt: lastMovementAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalPartiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalPartiesTable,
      LocalParty,
      $$LocalPartiesTableFilterComposer,
      $$LocalPartiesTableOrderingComposer,
      $$LocalPartiesTableAnnotationComposer,
      $$LocalPartiesTableCreateCompanionBuilder,
      $$LocalPartiesTableUpdateCompanionBuilder,
      (
        LocalParty,
        BaseReferences<_$AppDatabase, $LocalPartiesTable, LocalParty>,
      ),
      LocalParty,
      PrefetchHooks Function()
    >;
typedef $$LocalPartyOpeningBalancesTableCreateCompanionBuilder =
    LocalPartyOpeningBalancesCompanion Function({
      Value<int?> serverId,
      required int partyServerId,
      required int currencyServerId,
      required String currencyCode,
      required String currencyNameAr,
      required String currencySymbol,
      required int currencyDecimalPlaces,
      required String balanceSide,
      required int amountMinor,
      Value<int> rowid,
    });
typedef $$LocalPartyOpeningBalancesTableUpdateCompanionBuilder =
    LocalPartyOpeningBalancesCompanion Function({
      Value<int?> serverId,
      Value<int> partyServerId,
      Value<int> currencyServerId,
      Value<String> currencyCode,
      Value<String> currencyNameAr,
      Value<String> currencySymbol,
      Value<int> currencyDecimalPlaces,
      Value<String> balanceSide,
      Value<int> amountMinor,
      Value<int> rowid,
    });

class $$LocalPartyOpeningBalancesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalPartyOpeningBalancesTable> {
  $$LocalPartyOpeningBalancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get partyServerId => $composableBuilder(
    column: $table.partyServerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currencyServerId => $composableBuilder(
    column: $table.currencyServerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyNameAr => $composableBuilder(
    column: $table.currencyNameAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencySymbol => $composableBuilder(
    column: $table.currencySymbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currencyDecimalPlaces => $composableBuilder(
    column: $table.currencyDecimalPlaces,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get balanceSide => $composableBuilder(
    column: $table.balanceSide,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalPartyOpeningBalancesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalPartyOpeningBalancesTable> {
  $$LocalPartyOpeningBalancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get partyServerId => $composableBuilder(
    column: $table.partyServerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currencyServerId => $composableBuilder(
    column: $table.currencyServerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyNameAr => $composableBuilder(
    column: $table.currencyNameAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencySymbol => $composableBuilder(
    column: $table.currencySymbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currencyDecimalPlaces => $composableBuilder(
    column: $table.currencyDecimalPlaces,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get balanceSide => $composableBuilder(
    column: $table.balanceSide,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalPartyOpeningBalancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalPartyOpeningBalancesTable> {
  $$LocalPartyOpeningBalancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<int> get partyServerId => $composableBuilder(
    column: $table.partyServerId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currencyServerId => $composableBuilder(
    column: $table.currencyServerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyNameAr => $composableBuilder(
    column: $table.currencyNameAr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencySymbol => $composableBuilder(
    column: $table.currencySymbol,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currencyDecimalPlaces => $composableBuilder(
    column: $table.currencyDecimalPlaces,
    builder: (column) => column,
  );

  GeneratedColumn<String> get balanceSide => $composableBuilder(
    column: $table.balanceSide,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );
}

class $$LocalPartyOpeningBalancesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalPartyOpeningBalancesTable,
          LocalPartyOpeningBalance,
          $$LocalPartyOpeningBalancesTableFilterComposer,
          $$LocalPartyOpeningBalancesTableOrderingComposer,
          $$LocalPartyOpeningBalancesTableAnnotationComposer,
          $$LocalPartyOpeningBalancesTableCreateCompanionBuilder,
          $$LocalPartyOpeningBalancesTableUpdateCompanionBuilder,
          (
            LocalPartyOpeningBalance,
            BaseReferences<
              _$AppDatabase,
              $LocalPartyOpeningBalancesTable,
              LocalPartyOpeningBalance
            >,
          ),
          LocalPartyOpeningBalance,
          PrefetchHooks Function()
        > {
  $$LocalPartyOpeningBalancesTableTableManager(
    _$AppDatabase db,
    $LocalPartyOpeningBalancesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalPartyOpeningBalancesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalPartyOpeningBalancesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalPartyOpeningBalancesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int?> serverId = const Value.absent(),
                Value<int> partyServerId = const Value.absent(),
                Value<int> currencyServerId = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<String> currencyNameAr = const Value.absent(),
                Value<String> currencySymbol = const Value.absent(),
                Value<int> currencyDecimalPlaces = const Value.absent(),
                Value<String> balanceSide = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalPartyOpeningBalancesCompanion(
                serverId: serverId,
                partyServerId: partyServerId,
                currencyServerId: currencyServerId,
                currencyCode: currencyCode,
                currencyNameAr: currencyNameAr,
                currencySymbol: currencySymbol,
                currencyDecimalPlaces: currencyDecimalPlaces,
                balanceSide: balanceSide,
                amountMinor: amountMinor,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int?> serverId = const Value.absent(),
                required int partyServerId,
                required int currencyServerId,
                required String currencyCode,
                required String currencyNameAr,
                required String currencySymbol,
                required int currencyDecimalPlaces,
                required String balanceSide,
                required int amountMinor,
                Value<int> rowid = const Value.absent(),
              }) => LocalPartyOpeningBalancesCompanion.insert(
                serverId: serverId,
                partyServerId: partyServerId,
                currencyServerId: currencyServerId,
                currencyCode: currencyCode,
                currencyNameAr: currencyNameAr,
                currencySymbol: currencySymbol,
                currencyDecimalPlaces: currencyDecimalPlaces,
                balanceSide: balanceSide,
                amountMinor: amountMinor,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalPartyOpeningBalancesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalPartyOpeningBalancesTable,
      LocalPartyOpeningBalance,
      $$LocalPartyOpeningBalancesTableFilterComposer,
      $$LocalPartyOpeningBalancesTableOrderingComposer,
      $$LocalPartyOpeningBalancesTableAnnotationComposer,
      $$LocalPartyOpeningBalancesTableCreateCompanionBuilder,
      $$LocalPartyOpeningBalancesTableUpdateCompanionBuilder,
      (
        LocalPartyOpeningBalance,
        BaseReferences<
          _$AppDatabase,
          $LocalPartyOpeningBalancesTable,
          LocalPartyOpeningBalance
        >,
      ),
      LocalPartyOpeningBalance,
      PrefetchHooks Function()
    >;
typedef $$LocalWorkersTableCreateCompanionBuilder =
    LocalWorkersCompanion Function({
      Value<int> serverId,
      required String uuid,
      required String name,
      Value<String?> phone,
      Value<String?> jobTitle,
      required String wageType,
      Value<int?> wageCurrencyServerId,
      Value<String?> wageCurrencyCode,
      Value<String?> wageCurrencySymbol,
      Value<int?> wageCurrencyDecimalPlaces,
      Value<int?> wageAmountMinor,
      Value<DateTime?> hireDate,
      Value<String?> notes,
      required bool isActive,
      required int version,
      Value<DateTime?> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$LocalWorkersTableUpdateCompanionBuilder =
    LocalWorkersCompanion Function({
      Value<int> serverId,
      Value<String> uuid,
      Value<String> name,
      Value<String?> phone,
      Value<String?> jobTitle,
      Value<String> wageType,
      Value<int?> wageCurrencyServerId,
      Value<String?> wageCurrencyCode,
      Value<String?> wageCurrencySymbol,
      Value<int?> wageCurrencyDecimalPlaces,
      Value<int?> wageAmountMinor,
      Value<DateTime?> hireDate,
      Value<String?> notes,
      Value<bool> isActive,
      Value<int> version,
      Value<DateTime?> createdAt,
      Value<DateTime?> updatedAt,
    });

class $$LocalWorkersTableFilterComposer
    extends Composer<_$AppDatabase, $LocalWorkersTable> {
  $$LocalWorkersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jobTitle => $composableBuilder(
    column: $table.jobTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wageType => $composableBuilder(
    column: $table.wageType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wageCurrencyServerId => $composableBuilder(
    column: $table.wageCurrencyServerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wageCurrencyCode => $composableBuilder(
    column: $table.wageCurrencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wageCurrencySymbol => $composableBuilder(
    column: $table.wageCurrencySymbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wageCurrencyDecimalPlaces => $composableBuilder(
    column: $table.wageCurrencyDecimalPlaces,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wageAmountMinor => $composableBuilder(
    column: $table.wageAmountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get hireDate => $composableBuilder(
    column: $table.hireDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalWorkersTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalWorkersTable> {
  $$LocalWorkersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jobTitle => $composableBuilder(
    column: $table.jobTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wageType => $composableBuilder(
    column: $table.wageType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wageCurrencyServerId => $composableBuilder(
    column: $table.wageCurrencyServerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wageCurrencyCode => $composableBuilder(
    column: $table.wageCurrencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wageCurrencySymbol => $composableBuilder(
    column: $table.wageCurrencySymbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wageCurrencyDecimalPlaces => $composableBuilder(
    column: $table.wageCurrencyDecimalPlaces,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wageAmountMinor => $composableBuilder(
    column: $table.wageAmountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get hireDate => $composableBuilder(
    column: $table.hireDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalWorkersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalWorkersTable> {
  $$LocalWorkersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get jobTitle =>
      $composableBuilder(column: $table.jobTitle, builder: (column) => column);

  GeneratedColumn<String> get wageType =>
      $composableBuilder(column: $table.wageType, builder: (column) => column);

  GeneratedColumn<int> get wageCurrencyServerId => $composableBuilder(
    column: $table.wageCurrencyServerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get wageCurrencyCode => $composableBuilder(
    column: $table.wageCurrencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get wageCurrencySymbol => $composableBuilder(
    column: $table.wageCurrencySymbol,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wageCurrencyDecimalPlaces => $composableBuilder(
    column: $table.wageCurrencyDecimalPlaces,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wageAmountMinor => $composableBuilder(
    column: $table.wageAmountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get hireDate =>
      $composableBuilder(column: $table.hireDate, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalWorkersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalWorkersTable,
          LocalWorker,
          $$LocalWorkersTableFilterComposer,
          $$LocalWorkersTableOrderingComposer,
          $$LocalWorkersTableAnnotationComposer,
          $$LocalWorkersTableCreateCompanionBuilder,
          $$LocalWorkersTableUpdateCompanionBuilder,
          (
            LocalWorker,
            BaseReferences<_$AppDatabase, $LocalWorkersTable, LocalWorker>,
          ),
          LocalWorker,
          PrefetchHooks Function()
        > {
  $$LocalWorkersTableTableManager(_$AppDatabase db, $LocalWorkersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalWorkersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalWorkersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalWorkersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> serverId = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> jobTitle = const Value.absent(),
                Value<String> wageType = const Value.absent(),
                Value<int?> wageCurrencyServerId = const Value.absent(),
                Value<String?> wageCurrencyCode = const Value.absent(),
                Value<String?> wageCurrencySymbol = const Value.absent(),
                Value<int?> wageCurrencyDecimalPlaces = const Value.absent(),
                Value<int?> wageAmountMinor = const Value.absent(),
                Value<DateTime?> hireDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => LocalWorkersCompanion(
                serverId: serverId,
                uuid: uuid,
                name: name,
                phone: phone,
                jobTitle: jobTitle,
                wageType: wageType,
                wageCurrencyServerId: wageCurrencyServerId,
                wageCurrencyCode: wageCurrencyCode,
                wageCurrencySymbol: wageCurrencySymbol,
                wageCurrencyDecimalPlaces: wageCurrencyDecimalPlaces,
                wageAmountMinor: wageAmountMinor,
                hireDate: hireDate,
                notes: notes,
                isActive: isActive,
                version: version,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> serverId = const Value.absent(),
                required String uuid,
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<String?> jobTitle = const Value.absent(),
                required String wageType,
                Value<int?> wageCurrencyServerId = const Value.absent(),
                Value<String?> wageCurrencyCode = const Value.absent(),
                Value<String?> wageCurrencySymbol = const Value.absent(),
                Value<int?> wageCurrencyDecimalPlaces = const Value.absent(),
                Value<int?> wageAmountMinor = const Value.absent(),
                Value<DateTime?> hireDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required bool isActive,
                required int version,
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => LocalWorkersCompanion.insert(
                serverId: serverId,
                uuid: uuid,
                name: name,
                phone: phone,
                jobTitle: jobTitle,
                wageType: wageType,
                wageCurrencyServerId: wageCurrencyServerId,
                wageCurrencyCode: wageCurrencyCode,
                wageCurrencySymbol: wageCurrencySymbol,
                wageCurrencyDecimalPlaces: wageCurrencyDecimalPlaces,
                wageAmountMinor: wageAmountMinor,
                hireDate: hireDate,
                notes: notes,
                isActive: isActive,
                version: version,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalWorkersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalWorkersTable,
      LocalWorker,
      $$LocalWorkersTableFilterComposer,
      $$LocalWorkersTableOrderingComposer,
      $$LocalWorkersTableAnnotationComposer,
      $$LocalWorkersTableCreateCompanionBuilder,
      $$LocalWorkersTableUpdateCompanionBuilder,
      (
        LocalWorker,
        BaseReferences<_$AppDatabase, $LocalWorkersTable, LocalWorker>,
      ),
      LocalWorker,
      PrefetchHooks Function()
    >;
typedef $$LocalWorkerOpeningBalancesTableCreateCompanionBuilder =
    LocalWorkerOpeningBalancesCompanion Function({
      Value<int?> serverId,
      required int workerServerId,
      required int currencyServerId,
      required String currencyCode,
      required String currencyNameAr,
      required String currencySymbol,
      required int currencyDecimalPlaces,
      required String balanceSide,
      required int amountMinor,
      Value<int> rowid,
    });
typedef $$LocalWorkerOpeningBalancesTableUpdateCompanionBuilder =
    LocalWorkerOpeningBalancesCompanion Function({
      Value<int?> serverId,
      Value<int> workerServerId,
      Value<int> currencyServerId,
      Value<String> currencyCode,
      Value<String> currencyNameAr,
      Value<String> currencySymbol,
      Value<int> currencyDecimalPlaces,
      Value<String> balanceSide,
      Value<int> amountMinor,
      Value<int> rowid,
    });

class $$LocalWorkerOpeningBalancesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalWorkerOpeningBalancesTable> {
  $$LocalWorkerOpeningBalancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get workerServerId => $composableBuilder(
    column: $table.workerServerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currencyServerId => $composableBuilder(
    column: $table.currencyServerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyNameAr => $composableBuilder(
    column: $table.currencyNameAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencySymbol => $composableBuilder(
    column: $table.currencySymbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currencyDecimalPlaces => $composableBuilder(
    column: $table.currencyDecimalPlaces,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get balanceSide => $composableBuilder(
    column: $table.balanceSide,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalWorkerOpeningBalancesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalWorkerOpeningBalancesTable> {
  $$LocalWorkerOpeningBalancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get workerServerId => $composableBuilder(
    column: $table.workerServerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currencyServerId => $composableBuilder(
    column: $table.currencyServerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyNameAr => $composableBuilder(
    column: $table.currencyNameAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencySymbol => $composableBuilder(
    column: $table.currencySymbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currencyDecimalPlaces => $composableBuilder(
    column: $table.currencyDecimalPlaces,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get balanceSide => $composableBuilder(
    column: $table.balanceSide,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalWorkerOpeningBalancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalWorkerOpeningBalancesTable> {
  $$LocalWorkerOpeningBalancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<int> get workerServerId => $composableBuilder(
    column: $table.workerServerId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currencyServerId => $composableBuilder(
    column: $table.currencyServerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyNameAr => $composableBuilder(
    column: $table.currencyNameAr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencySymbol => $composableBuilder(
    column: $table.currencySymbol,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currencyDecimalPlaces => $composableBuilder(
    column: $table.currencyDecimalPlaces,
    builder: (column) => column,
  );

  GeneratedColumn<String> get balanceSide => $composableBuilder(
    column: $table.balanceSide,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );
}

class $$LocalWorkerOpeningBalancesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalWorkerOpeningBalancesTable,
          LocalWorkerOpeningBalance,
          $$LocalWorkerOpeningBalancesTableFilterComposer,
          $$LocalWorkerOpeningBalancesTableOrderingComposer,
          $$LocalWorkerOpeningBalancesTableAnnotationComposer,
          $$LocalWorkerOpeningBalancesTableCreateCompanionBuilder,
          $$LocalWorkerOpeningBalancesTableUpdateCompanionBuilder,
          (
            LocalWorkerOpeningBalance,
            BaseReferences<
              _$AppDatabase,
              $LocalWorkerOpeningBalancesTable,
              LocalWorkerOpeningBalance
            >,
          ),
          LocalWorkerOpeningBalance,
          PrefetchHooks Function()
        > {
  $$LocalWorkerOpeningBalancesTableTableManager(
    _$AppDatabase db,
    $LocalWorkerOpeningBalancesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalWorkerOpeningBalancesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalWorkerOpeningBalancesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalWorkerOpeningBalancesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int?> serverId = const Value.absent(),
                Value<int> workerServerId = const Value.absent(),
                Value<int> currencyServerId = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<String> currencyNameAr = const Value.absent(),
                Value<String> currencySymbol = const Value.absent(),
                Value<int> currencyDecimalPlaces = const Value.absent(),
                Value<String> balanceSide = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalWorkerOpeningBalancesCompanion(
                serverId: serverId,
                workerServerId: workerServerId,
                currencyServerId: currencyServerId,
                currencyCode: currencyCode,
                currencyNameAr: currencyNameAr,
                currencySymbol: currencySymbol,
                currencyDecimalPlaces: currencyDecimalPlaces,
                balanceSide: balanceSide,
                amountMinor: amountMinor,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int?> serverId = const Value.absent(),
                required int workerServerId,
                required int currencyServerId,
                required String currencyCode,
                required String currencyNameAr,
                required String currencySymbol,
                required int currencyDecimalPlaces,
                required String balanceSide,
                required int amountMinor,
                Value<int> rowid = const Value.absent(),
              }) => LocalWorkerOpeningBalancesCompanion.insert(
                serverId: serverId,
                workerServerId: workerServerId,
                currencyServerId: currencyServerId,
                currencyCode: currencyCode,
                currencyNameAr: currencyNameAr,
                currencySymbol: currencySymbol,
                currencyDecimalPlaces: currencyDecimalPlaces,
                balanceSide: balanceSide,
                amountMinor: amountMinor,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalWorkerOpeningBalancesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalWorkerOpeningBalancesTable,
      LocalWorkerOpeningBalance,
      $$LocalWorkerOpeningBalancesTableFilterComposer,
      $$LocalWorkerOpeningBalancesTableOrderingComposer,
      $$LocalWorkerOpeningBalancesTableAnnotationComposer,
      $$LocalWorkerOpeningBalancesTableCreateCompanionBuilder,
      $$LocalWorkerOpeningBalancesTableUpdateCompanionBuilder,
      (
        LocalWorkerOpeningBalance,
        BaseReferences<
          _$AppDatabase,
          $LocalWorkerOpeningBalancesTable,
          LocalWorkerOpeningBalance
        >,
      ),
      LocalWorkerOpeningBalance,
      PrefetchHooks Function()
    >;
typedef $$LocalAccountingTransactionsTableCreateCompanionBuilder =
    LocalAccountingTransactionsCompanion Function({
      Value<int> serverId,
      required String uuid,
      required String transactionNo,
      required String type,
      required String settlementMode,
      required int currencyServerId,
      required String currencyCode,
      required String currencySymbol,
      required int currencyDecimalPlaces,
      required int amountMinor,
      required int paidNowMinor,
      Value<String> costStatus,
      Value<int?> costTotalMinor,
      Value<int?> grossProfitMinor,
      Value<int?> partyServerId,
      Value<String?> partyName,
      Value<int?> workerServerId,
      Value<String?> workerName,
      Value<int?> categoryServerId,
      Value<String?> categoryName,
      Value<int?> financialAccountServerId,
      Value<String?> financialAccountName,
      Value<int?> targetFinancialAccountServerId,
      Value<String?> targetFinancialAccountName,
      required DateTime occurredAt,
      Value<String?> description,
      Value<String?> notes,
      required String status,
      Value<int?> reversalOfServerId,
      Value<String?> createdByName,
    });
typedef $$LocalAccountingTransactionsTableUpdateCompanionBuilder =
    LocalAccountingTransactionsCompanion Function({
      Value<int> serverId,
      Value<String> uuid,
      Value<String> transactionNo,
      Value<String> type,
      Value<String> settlementMode,
      Value<int> currencyServerId,
      Value<String> currencyCode,
      Value<String> currencySymbol,
      Value<int> currencyDecimalPlaces,
      Value<int> amountMinor,
      Value<int> paidNowMinor,
      Value<String> costStatus,
      Value<int?> costTotalMinor,
      Value<int?> grossProfitMinor,
      Value<int?> partyServerId,
      Value<String?> partyName,
      Value<int?> workerServerId,
      Value<String?> workerName,
      Value<int?> categoryServerId,
      Value<String?> categoryName,
      Value<int?> financialAccountServerId,
      Value<String?> financialAccountName,
      Value<int?> targetFinancialAccountServerId,
      Value<String?> targetFinancialAccountName,
      Value<DateTime> occurredAt,
      Value<String?> description,
      Value<String?> notes,
      Value<String> status,
      Value<int?> reversalOfServerId,
      Value<String?> createdByName,
    });

class $$LocalAccountingTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalAccountingTransactionsTable> {
  $$LocalAccountingTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionNo => $composableBuilder(
    column: $table.transactionNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get settlementMode => $composableBuilder(
    column: $table.settlementMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currencyServerId => $composableBuilder(
    column: $table.currencyServerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencySymbol => $composableBuilder(
    column: $table.currencySymbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currencyDecimalPlaces => $composableBuilder(
    column: $table.currencyDecimalPlaces,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paidNowMinor => $composableBuilder(
    column: $table.paidNowMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get costStatus => $composableBuilder(
    column: $table.costStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costTotalMinor => $composableBuilder(
    column: $table.costTotalMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get grossProfitMinor => $composableBuilder(
    column: $table.grossProfitMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get partyServerId => $composableBuilder(
    column: $table.partyServerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partyName => $composableBuilder(
    column: $table.partyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get workerServerId => $composableBuilder(
    column: $table.workerServerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workerName => $composableBuilder(
    column: $table.workerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get categoryServerId => $composableBuilder(
    column: $table.categoryServerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get financialAccountServerId => $composableBuilder(
    column: $table.financialAccountServerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get financialAccountName => $composableBuilder(
    column: $table.financialAccountName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetFinancialAccountServerId => $composableBuilder(
    column: $table.targetFinancialAccountServerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetFinancialAccountName => $composableBuilder(
    column: $table.targetFinancialAccountName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reversalOfServerId => $composableBuilder(
    column: $table.reversalOfServerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdByName => $composableBuilder(
    column: $table.createdByName,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalAccountingTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalAccountingTransactionsTable> {
  $$LocalAccountingTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionNo => $composableBuilder(
    column: $table.transactionNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get settlementMode => $composableBuilder(
    column: $table.settlementMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currencyServerId => $composableBuilder(
    column: $table.currencyServerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencySymbol => $composableBuilder(
    column: $table.currencySymbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currencyDecimalPlaces => $composableBuilder(
    column: $table.currencyDecimalPlaces,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paidNowMinor => $composableBuilder(
    column: $table.paidNowMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get costStatus => $composableBuilder(
    column: $table.costStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costTotalMinor => $composableBuilder(
    column: $table.costTotalMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get grossProfitMinor => $composableBuilder(
    column: $table.grossProfitMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get partyServerId => $composableBuilder(
    column: $table.partyServerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partyName => $composableBuilder(
    column: $table.partyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get workerServerId => $composableBuilder(
    column: $table.workerServerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workerName => $composableBuilder(
    column: $table.workerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get categoryServerId => $composableBuilder(
    column: $table.categoryServerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get financialAccountServerId => $composableBuilder(
    column: $table.financialAccountServerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get financialAccountName => $composableBuilder(
    column: $table.financialAccountName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetFinancialAccountServerId => $composableBuilder(
    column: $table.targetFinancialAccountServerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetFinancialAccountName => $composableBuilder(
    column: $table.targetFinancialAccountName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reversalOfServerId => $composableBuilder(
    column: $table.reversalOfServerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdByName => $composableBuilder(
    column: $table.createdByName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalAccountingTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalAccountingTransactionsTable> {
  $$LocalAccountingTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get transactionNo => $composableBuilder(
    column: $table.transactionNo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get settlementMode => $composableBuilder(
    column: $table.settlementMode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currencyServerId => $composableBuilder(
    column: $table.currencyServerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencySymbol => $composableBuilder(
    column: $table.currencySymbol,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currencyDecimalPlaces => $composableBuilder(
    column: $table.currencyDecimalPlaces,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get paidNowMinor => $composableBuilder(
    column: $table.paidNowMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get costStatus => $composableBuilder(
    column: $table.costStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get costTotalMinor => $composableBuilder(
    column: $table.costTotalMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get grossProfitMinor => $composableBuilder(
    column: $table.grossProfitMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get partyServerId => $composableBuilder(
    column: $table.partyServerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get partyName =>
      $composableBuilder(column: $table.partyName, builder: (column) => column);

  GeneratedColumn<int> get workerServerId => $composableBuilder(
    column: $table.workerServerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workerName => $composableBuilder(
    column: $table.workerName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get categoryServerId => $composableBuilder(
    column: $table.categoryServerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryName => $composableBuilder(
    column: $table.categoryName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get financialAccountServerId => $composableBuilder(
    column: $table.financialAccountServerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get financialAccountName => $composableBuilder(
    column: $table.financialAccountName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetFinancialAccountServerId => $composableBuilder(
    column: $table.targetFinancialAccountServerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetFinancialAccountName => $composableBuilder(
    column: $table.targetFinancialAccountName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get reversalOfServerId => $composableBuilder(
    column: $table.reversalOfServerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdByName => $composableBuilder(
    column: $table.createdByName,
    builder: (column) => column,
  );
}

class $$LocalAccountingTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalAccountingTransactionsTable,
          LocalAccountingTransaction,
          $$LocalAccountingTransactionsTableFilterComposer,
          $$LocalAccountingTransactionsTableOrderingComposer,
          $$LocalAccountingTransactionsTableAnnotationComposer,
          $$LocalAccountingTransactionsTableCreateCompanionBuilder,
          $$LocalAccountingTransactionsTableUpdateCompanionBuilder,
          (
            LocalAccountingTransaction,
            BaseReferences<
              _$AppDatabase,
              $LocalAccountingTransactionsTable,
              LocalAccountingTransaction
            >,
          ),
          LocalAccountingTransaction,
          PrefetchHooks Function()
        > {
  $$LocalAccountingTransactionsTableTableManager(
    _$AppDatabase db,
    $LocalAccountingTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalAccountingTransactionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalAccountingTransactionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalAccountingTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> serverId = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> transactionNo = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> settlementMode = const Value.absent(),
                Value<int> currencyServerId = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<String> currencySymbol = const Value.absent(),
                Value<int> currencyDecimalPlaces = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<int> paidNowMinor = const Value.absent(),
                Value<String> costStatus = const Value.absent(),
                Value<int?> costTotalMinor = const Value.absent(),
                Value<int?> grossProfitMinor = const Value.absent(),
                Value<int?> partyServerId = const Value.absent(),
                Value<String?> partyName = const Value.absent(),
                Value<int?> workerServerId = const Value.absent(),
                Value<String?> workerName = const Value.absent(),
                Value<int?> categoryServerId = const Value.absent(),
                Value<String?> categoryName = const Value.absent(),
                Value<int?> financialAccountServerId = const Value.absent(),
                Value<String?> financialAccountName = const Value.absent(),
                Value<int?> targetFinancialAccountServerId =
                    const Value.absent(),
                Value<String?> targetFinancialAccountName =
                    const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> reversalOfServerId = const Value.absent(),
                Value<String?> createdByName = const Value.absent(),
              }) => LocalAccountingTransactionsCompanion(
                serverId: serverId,
                uuid: uuid,
                transactionNo: transactionNo,
                type: type,
                settlementMode: settlementMode,
                currencyServerId: currencyServerId,
                currencyCode: currencyCode,
                currencySymbol: currencySymbol,
                currencyDecimalPlaces: currencyDecimalPlaces,
                amountMinor: amountMinor,
                paidNowMinor: paidNowMinor,
                costStatus: costStatus,
                costTotalMinor: costTotalMinor,
                grossProfitMinor: grossProfitMinor,
                partyServerId: partyServerId,
                partyName: partyName,
                workerServerId: workerServerId,
                workerName: workerName,
                categoryServerId: categoryServerId,
                categoryName: categoryName,
                financialAccountServerId: financialAccountServerId,
                financialAccountName: financialAccountName,
                targetFinancialAccountServerId: targetFinancialAccountServerId,
                targetFinancialAccountName: targetFinancialAccountName,
                occurredAt: occurredAt,
                description: description,
                notes: notes,
                status: status,
                reversalOfServerId: reversalOfServerId,
                createdByName: createdByName,
              ),
          createCompanionCallback:
              ({
                Value<int> serverId = const Value.absent(),
                required String uuid,
                required String transactionNo,
                required String type,
                required String settlementMode,
                required int currencyServerId,
                required String currencyCode,
                required String currencySymbol,
                required int currencyDecimalPlaces,
                required int amountMinor,
                required int paidNowMinor,
                Value<String> costStatus = const Value.absent(),
                Value<int?> costTotalMinor = const Value.absent(),
                Value<int?> grossProfitMinor = const Value.absent(),
                Value<int?> partyServerId = const Value.absent(),
                Value<String?> partyName = const Value.absent(),
                Value<int?> workerServerId = const Value.absent(),
                Value<String?> workerName = const Value.absent(),
                Value<int?> categoryServerId = const Value.absent(),
                Value<String?> categoryName = const Value.absent(),
                Value<int?> financialAccountServerId = const Value.absent(),
                Value<String?> financialAccountName = const Value.absent(),
                Value<int?> targetFinancialAccountServerId =
                    const Value.absent(),
                Value<String?> targetFinancialAccountName =
                    const Value.absent(),
                required DateTime occurredAt,
                Value<String?> description = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required String status,
                Value<int?> reversalOfServerId = const Value.absent(),
                Value<String?> createdByName = const Value.absent(),
              }) => LocalAccountingTransactionsCompanion.insert(
                serverId: serverId,
                uuid: uuid,
                transactionNo: transactionNo,
                type: type,
                settlementMode: settlementMode,
                currencyServerId: currencyServerId,
                currencyCode: currencyCode,
                currencySymbol: currencySymbol,
                currencyDecimalPlaces: currencyDecimalPlaces,
                amountMinor: amountMinor,
                paidNowMinor: paidNowMinor,
                costStatus: costStatus,
                costTotalMinor: costTotalMinor,
                grossProfitMinor: grossProfitMinor,
                partyServerId: partyServerId,
                partyName: partyName,
                workerServerId: workerServerId,
                workerName: workerName,
                categoryServerId: categoryServerId,
                categoryName: categoryName,
                financialAccountServerId: financialAccountServerId,
                financialAccountName: financialAccountName,
                targetFinancialAccountServerId: targetFinancialAccountServerId,
                targetFinancialAccountName: targetFinancialAccountName,
                occurredAt: occurredAt,
                description: description,
                notes: notes,
                status: status,
                reversalOfServerId: reversalOfServerId,
                createdByName: createdByName,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalAccountingTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalAccountingTransactionsTable,
      LocalAccountingTransaction,
      $$LocalAccountingTransactionsTableFilterComposer,
      $$LocalAccountingTransactionsTableOrderingComposer,
      $$LocalAccountingTransactionsTableAnnotationComposer,
      $$LocalAccountingTransactionsTableCreateCompanionBuilder,
      $$LocalAccountingTransactionsTableUpdateCompanionBuilder,
      (
        LocalAccountingTransaction,
        BaseReferences<
          _$AppDatabase,
          $LocalAccountingTransactionsTable,
          LocalAccountingTransaction
        >,
      ),
      LocalAccountingTransaction,
      PrefetchHooks Function()
    >;
typedef $$LocalProductsTableCreateCompanionBuilder =
    LocalProductsCompanion Function({
      Value<int> serverId,
      required String uuid,
      Value<String?> sku,
      required String name,
      required String productType,
      required String unit,
      required int currencyServerId,
      required String currencyCode,
      required String currencyNameAr,
      required String currencySymbol,
      required int currencyDecimalPlaces,
      Value<int?> defaultSalePriceMinor,
      required int stockQuantityMilli,
      Value<int?> averageCostMinor,
      required bool isActive,
      required int version,
    });
typedef $$LocalProductsTableUpdateCompanionBuilder =
    LocalProductsCompanion Function({
      Value<int> serverId,
      Value<String> uuid,
      Value<String?> sku,
      Value<String> name,
      Value<String> productType,
      Value<String> unit,
      Value<int> currencyServerId,
      Value<String> currencyCode,
      Value<String> currencyNameAr,
      Value<String> currencySymbol,
      Value<int> currencyDecimalPlaces,
      Value<int?> defaultSalePriceMinor,
      Value<int> stockQuantityMilli,
      Value<int?> averageCostMinor,
      Value<bool> isActive,
      Value<int> version,
    });

class $$LocalProductsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalProductsTable> {
  $$LocalProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productType => $composableBuilder(
    column: $table.productType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currencyServerId => $composableBuilder(
    column: $table.currencyServerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyNameAr => $composableBuilder(
    column: $table.currencyNameAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencySymbol => $composableBuilder(
    column: $table.currencySymbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currencyDecimalPlaces => $composableBuilder(
    column: $table.currencyDecimalPlaces,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultSalePriceMinor => $composableBuilder(
    column: $table.defaultSalePriceMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stockQuantityMilli => $composableBuilder(
    column: $table.stockQuantityMilli,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get averageCostMinor => $composableBuilder(
    column: $table.averageCostMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalProductsTable> {
  $$LocalProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productType => $composableBuilder(
    column: $table.productType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currencyServerId => $composableBuilder(
    column: $table.currencyServerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyNameAr => $composableBuilder(
    column: $table.currencyNameAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencySymbol => $composableBuilder(
    column: $table.currencySymbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currencyDecimalPlaces => $composableBuilder(
    column: $table.currencyDecimalPlaces,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultSalePriceMinor => $composableBuilder(
    column: $table.defaultSalePriceMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stockQuantityMilli => $composableBuilder(
    column: $table.stockQuantityMilli,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get averageCostMinor => $composableBuilder(
    column: $table.averageCostMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalProductsTable> {
  $$LocalProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get productType => $composableBuilder(
    column: $table.productType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get currencyServerId => $composableBuilder(
    column: $table.currencyServerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyNameAr => $composableBuilder(
    column: $table.currencyNameAr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencySymbol => $composableBuilder(
    column: $table.currencySymbol,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currencyDecimalPlaces => $composableBuilder(
    column: $table.currencyDecimalPlaces,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultSalePriceMinor => $composableBuilder(
    column: $table.defaultSalePriceMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stockQuantityMilli => $composableBuilder(
    column: $table.stockQuantityMilli,
    builder: (column) => column,
  );

  GeneratedColumn<int> get averageCostMinor => $composableBuilder(
    column: $table.averageCostMinor,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);
}

class $$LocalProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalProductsTable,
          LocalProduct,
          $$LocalProductsTableFilterComposer,
          $$LocalProductsTableOrderingComposer,
          $$LocalProductsTableAnnotationComposer,
          $$LocalProductsTableCreateCompanionBuilder,
          $$LocalProductsTableUpdateCompanionBuilder,
          (
            LocalProduct,
            BaseReferences<_$AppDatabase, $LocalProductsTable, LocalProduct>,
          ),
          LocalProduct,
          PrefetchHooks Function()
        > {
  $$LocalProductsTableTableManager(_$AppDatabase db, $LocalProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> serverId = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String?> sku = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> productType = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<int> currencyServerId = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<String> currencyNameAr = const Value.absent(),
                Value<String> currencySymbol = const Value.absent(),
                Value<int> currencyDecimalPlaces = const Value.absent(),
                Value<int?> defaultSalePriceMinor = const Value.absent(),
                Value<int> stockQuantityMilli = const Value.absent(),
                Value<int?> averageCostMinor = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> version = const Value.absent(),
              }) => LocalProductsCompanion(
                serverId: serverId,
                uuid: uuid,
                sku: sku,
                name: name,
                productType: productType,
                unit: unit,
                currencyServerId: currencyServerId,
                currencyCode: currencyCode,
                currencyNameAr: currencyNameAr,
                currencySymbol: currencySymbol,
                currencyDecimalPlaces: currencyDecimalPlaces,
                defaultSalePriceMinor: defaultSalePriceMinor,
                stockQuantityMilli: stockQuantityMilli,
                averageCostMinor: averageCostMinor,
                isActive: isActive,
                version: version,
              ),
          createCompanionCallback:
              ({
                Value<int> serverId = const Value.absent(),
                required String uuid,
                Value<String?> sku = const Value.absent(),
                required String name,
                required String productType,
                required String unit,
                required int currencyServerId,
                required String currencyCode,
                required String currencyNameAr,
                required String currencySymbol,
                required int currencyDecimalPlaces,
                Value<int?> defaultSalePriceMinor = const Value.absent(),
                required int stockQuantityMilli,
                Value<int?> averageCostMinor = const Value.absent(),
                required bool isActive,
                required int version,
              }) => LocalProductsCompanion.insert(
                serverId: serverId,
                uuid: uuid,
                sku: sku,
                name: name,
                productType: productType,
                unit: unit,
                currencyServerId: currencyServerId,
                currencyCode: currencyCode,
                currencyNameAr: currencyNameAr,
                currencySymbol: currencySymbol,
                currencyDecimalPlaces: currencyDecimalPlaces,
                defaultSalePriceMinor: defaultSalePriceMinor,
                stockQuantityMilli: stockQuantityMilli,
                averageCostMinor: averageCostMinor,
                isActive: isActive,
                version: version,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalProductsTable,
      LocalProduct,
      $$LocalProductsTableFilterComposer,
      $$LocalProductsTableOrderingComposer,
      $$LocalProductsTableAnnotationComposer,
      $$LocalProductsTableCreateCompanionBuilder,
      $$LocalProductsTableUpdateCompanionBuilder,
      (
        LocalProduct,
        BaseReferences<_$AppDatabase, $LocalProductsTable, LocalProduct>,
      ),
      LocalProduct,
      PrefetchHooks Function()
    >;
typedef $$LocalTransactionItemsTableCreateCompanionBuilder =
    LocalTransactionItemsCompanion Function({
      Value<int> serverId,
      required int transactionServerId,
      Value<int?> productServerId,
      Value<String?> productName,
      Value<String?> productSku,
      required String description,
      required int quantityMilli,
      required String unit,
      required int unitPriceMinor,
      Value<int?> unitCostMinor,
      required int lineTotalMinor,
      Value<int?> lineCostMinor,
      Value<String?> costSource,
    });
typedef $$LocalTransactionItemsTableUpdateCompanionBuilder =
    LocalTransactionItemsCompanion Function({
      Value<int> serverId,
      Value<int> transactionServerId,
      Value<int?> productServerId,
      Value<String?> productName,
      Value<String?> productSku,
      Value<String> description,
      Value<int> quantityMilli,
      Value<String> unit,
      Value<int> unitPriceMinor,
      Value<int?> unitCostMinor,
      Value<int> lineTotalMinor,
      Value<int?> lineCostMinor,
      Value<String?> costSource,
    });

class $$LocalTransactionItemsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalTransactionItemsTable> {
  $$LocalTransactionItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get transactionServerId => $composableBuilder(
    column: $table.transactionServerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productServerId => $composableBuilder(
    column: $table.productServerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productSku => $composableBuilder(
    column: $table.productSku,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantityMilli => $composableBuilder(
    column: $table.quantityMilli,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitPriceMinor => $composableBuilder(
    column: $table.unitPriceMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitCostMinor => $composableBuilder(
    column: $table.unitCostMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lineTotalMinor => $composableBuilder(
    column: $table.lineTotalMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lineCostMinor => $composableBuilder(
    column: $table.lineCostMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get costSource => $composableBuilder(
    column: $table.costSource,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalTransactionItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalTransactionItemsTable> {
  $$LocalTransactionItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get transactionServerId => $composableBuilder(
    column: $table.transactionServerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productServerId => $composableBuilder(
    column: $table.productServerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productSku => $composableBuilder(
    column: $table.productSku,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantityMilli => $composableBuilder(
    column: $table.quantityMilli,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitPriceMinor => $composableBuilder(
    column: $table.unitPriceMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitCostMinor => $composableBuilder(
    column: $table.unitCostMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lineTotalMinor => $composableBuilder(
    column: $table.lineTotalMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lineCostMinor => $composableBuilder(
    column: $table.lineCostMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get costSource => $composableBuilder(
    column: $table.costSource,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalTransactionItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalTransactionItemsTable> {
  $$LocalTransactionItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<int> get transactionServerId => $composableBuilder(
    column: $table.transactionServerId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get productServerId => $composableBuilder(
    column: $table.productServerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get productSku => $composableBuilder(
    column: $table.productSku,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantityMilli => $composableBuilder(
    column: $table.quantityMilli,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get unitPriceMinor => $composableBuilder(
    column: $table.unitPriceMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unitCostMinor => $composableBuilder(
    column: $table.unitCostMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lineTotalMinor => $composableBuilder(
    column: $table.lineTotalMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lineCostMinor => $composableBuilder(
    column: $table.lineCostMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get costSource => $composableBuilder(
    column: $table.costSource,
    builder: (column) => column,
  );
}

class $$LocalTransactionItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalTransactionItemsTable,
          LocalTransactionItem,
          $$LocalTransactionItemsTableFilterComposer,
          $$LocalTransactionItemsTableOrderingComposer,
          $$LocalTransactionItemsTableAnnotationComposer,
          $$LocalTransactionItemsTableCreateCompanionBuilder,
          $$LocalTransactionItemsTableUpdateCompanionBuilder,
          (
            LocalTransactionItem,
            BaseReferences<
              _$AppDatabase,
              $LocalTransactionItemsTable,
              LocalTransactionItem
            >,
          ),
          LocalTransactionItem,
          PrefetchHooks Function()
        > {
  $$LocalTransactionItemsTableTableManager(
    _$AppDatabase db,
    $LocalTransactionItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalTransactionItemsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalTransactionItemsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalTransactionItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> serverId = const Value.absent(),
                Value<int> transactionServerId = const Value.absent(),
                Value<int?> productServerId = const Value.absent(),
                Value<String?> productName = const Value.absent(),
                Value<String?> productSku = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> quantityMilli = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<int> unitPriceMinor = const Value.absent(),
                Value<int?> unitCostMinor = const Value.absent(),
                Value<int> lineTotalMinor = const Value.absent(),
                Value<int?> lineCostMinor = const Value.absent(),
                Value<String?> costSource = const Value.absent(),
              }) => LocalTransactionItemsCompanion(
                serverId: serverId,
                transactionServerId: transactionServerId,
                productServerId: productServerId,
                productName: productName,
                productSku: productSku,
                description: description,
                quantityMilli: quantityMilli,
                unit: unit,
                unitPriceMinor: unitPriceMinor,
                unitCostMinor: unitCostMinor,
                lineTotalMinor: lineTotalMinor,
                lineCostMinor: lineCostMinor,
                costSource: costSource,
              ),
          createCompanionCallback:
              ({
                Value<int> serverId = const Value.absent(),
                required int transactionServerId,
                Value<int?> productServerId = const Value.absent(),
                Value<String?> productName = const Value.absent(),
                Value<String?> productSku = const Value.absent(),
                required String description,
                required int quantityMilli,
                required String unit,
                required int unitPriceMinor,
                Value<int?> unitCostMinor = const Value.absent(),
                required int lineTotalMinor,
                Value<int?> lineCostMinor = const Value.absent(),
                Value<String?> costSource = const Value.absent(),
              }) => LocalTransactionItemsCompanion.insert(
                serverId: serverId,
                transactionServerId: transactionServerId,
                productServerId: productServerId,
                productName: productName,
                productSku: productSku,
                description: description,
                quantityMilli: quantityMilli,
                unit: unit,
                unitPriceMinor: unitPriceMinor,
                unitCostMinor: unitCostMinor,
                lineTotalMinor: lineTotalMinor,
                lineCostMinor: lineCostMinor,
                costSource: costSource,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalTransactionItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalTransactionItemsTable,
      LocalTransactionItem,
      $$LocalTransactionItemsTableFilterComposer,
      $$LocalTransactionItemsTableOrderingComposer,
      $$LocalTransactionItemsTableAnnotationComposer,
      $$LocalTransactionItemsTableCreateCompanionBuilder,
      $$LocalTransactionItemsTableUpdateCompanionBuilder,
      (
        LocalTransactionItem,
        BaseReferences<
          _$AppDatabase,
          $LocalTransactionItemsTable,
          LocalTransactionItem
        >,
      ),
      LocalTransactionItem,
      PrefetchHooks Function()
    >;
typedef $$LocalSyncOperationsTableCreateCompanionBuilder =
    LocalSyncOperationsCompanion Function({
      Value<int> id,
      required String operationUuid,
      required String operationType,
      required String payloadJson,
      Value<String> status,
      Value<int> attempts,
      Value<String?> lastError,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$LocalSyncOperationsTableUpdateCompanionBuilder =
    LocalSyncOperationsCompanion Function({
      Value<int> id,
      Value<String> operationUuid,
      Value<String> operationType,
      Value<String> payloadJson,
      Value<String> status,
      Value<int> attempts,
      Value<String?> lastError,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$LocalSyncOperationsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalSyncOperationsTable> {
  $$LocalSyncOperationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operationUuid => $composableBuilder(
    column: $table.operationUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalSyncOperationsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalSyncOperationsTable> {
  $$LocalSyncOperationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operationUuid => $composableBuilder(
    column: $table.operationUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalSyncOperationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalSyncOperationsTable> {
  $$LocalSyncOperationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get operationUuid => $composableBuilder(
    column: $table.operationUuid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalSyncOperationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalSyncOperationsTable,
          LocalSyncOperation,
          $$LocalSyncOperationsTableFilterComposer,
          $$LocalSyncOperationsTableOrderingComposer,
          $$LocalSyncOperationsTableAnnotationComposer,
          $$LocalSyncOperationsTableCreateCompanionBuilder,
          $$LocalSyncOperationsTableUpdateCompanionBuilder,
          (
            LocalSyncOperation,
            BaseReferences<
              _$AppDatabase,
              $LocalSyncOperationsTable,
              LocalSyncOperation
            >,
          ),
          LocalSyncOperation,
          PrefetchHooks Function()
        > {
  $$LocalSyncOperationsTableTableManager(
    _$AppDatabase db,
    $LocalSyncOperationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalSyncOperationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalSyncOperationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalSyncOperationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> operationUuid = const Value.absent(),
                Value<String> operationType = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => LocalSyncOperationsCompanion(
                id: id,
                operationUuid: operationUuid,
                operationType: operationType,
                payloadJson: payloadJson,
                status: status,
                attempts: attempts,
                lastError: lastError,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String operationUuid,
                required String operationType,
                required String payloadJson,
                Value<String> status = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => LocalSyncOperationsCompanion.insert(
                id: id,
                operationUuid: operationUuid,
                operationType: operationType,
                payloadJson: payloadJson,
                status: status,
                attempts: attempts,
                lastError: lastError,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalSyncOperationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalSyncOperationsTable,
      LocalSyncOperation,
      $$LocalSyncOperationsTableFilterComposer,
      $$LocalSyncOperationsTableOrderingComposer,
      $$LocalSyncOperationsTableAnnotationComposer,
      $$LocalSyncOperationsTableCreateCompanionBuilder,
      $$LocalSyncOperationsTableUpdateCompanionBuilder,
      (
        LocalSyncOperation,
        BaseReferences<
          _$AppDatabase,
          $LocalSyncOperationsTable,
          LocalSyncOperation
        >,
      ),
      LocalSyncOperation,
      PrefetchHooks Function()
    >;
typedef $$LocalAttachmentQueueTableCreateCompanionBuilder =
    LocalAttachmentQueueCompanion Function({
      Value<int> id,
      required String uuid,
      required String transactionUuid,
      Value<int?> transactionServerId,
      required String originalName,
      required String mimeType,
      required int sizeBytes,
      required String bytesBase64,
      Value<String> syncStatus,
      Value<String?> lastError,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$LocalAttachmentQueueTableUpdateCompanionBuilder =
    LocalAttachmentQueueCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<String> transactionUuid,
      Value<int?> transactionServerId,
      Value<String> originalName,
      Value<String> mimeType,
      Value<int> sizeBytes,
      Value<String> bytesBase64,
      Value<String> syncStatus,
      Value<String?> lastError,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$LocalAttachmentQueueTableFilterComposer
    extends Composer<_$AppDatabase, $LocalAttachmentQueueTable> {
  $$LocalAttachmentQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionUuid => $composableBuilder(
    column: $table.transactionUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get transactionServerId => $composableBuilder(
    column: $table.transactionServerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalName => $composableBuilder(
    column: $table.originalName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bytesBase64 => $composableBuilder(
    column: $table.bytesBase64,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalAttachmentQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalAttachmentQueueTable> {
  $$LocalAttachmentQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionUuid => $composableBuilder(
    column: $table.transactionUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get transactionServerId => $composableBuilder(
    column: $table.transactionServerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalName => $composableBuilder(
    column: $table.originalName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bytesBase64 => $composableBuilder(
    column: $table.bytesBase64,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalAttachmentQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalAttachmentQueueTable> {
  $$LocalAttachmentQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get transactionUuid => $composableBuilder(
    column: $table.transactionUuid,
    builder: (column) => column,
  );

  GeneratedColumn<int> get transactionServerId => $composableBuilder(
    column: $table.transactionServerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get originalName => $composableBuilder(
    column: $table.originalName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<String> get bytesBase64 => $composableBuilder(
    column: $table.bytesBase64,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalAttachmentQueueTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalAttachmentQueueTable,
          LocalAttachmentQueueData,
          $$LocalAttachmentQueueTableFilterComposer,
          $$LocalAttachmentQueueTableOrderingComposer,
          $$LocalAttachmentQueueTableAnnotationComposer,
          $$LocalAttachmentQueueTableCreateCompanionBuilder,
          $$LocalAttachmentQueueTableUpdateCompanionBuilder,
          (
            LocalAttachmentQueueData,
            BaseReferences<
              _$AppDatabase,
              $LocalAttachmentQueueTable,
              LocalAttachmentQueueData
            >,
          ),
          LocalAttachmentQueueData,
          PrefetchHooks Function()
        > {
  $$LocalAttachmentQueueTableTableManager(
    _$AppDatabase db,
    $LocalAttachmentQueueTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalAttachmentQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalAttachmentQueueTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalAttachmentQueueTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> transactionUuid = const Value.absent(),
                Value<int?> transactionServerId = const Value.absent(),
                Value<String> originalName = const Value.absent(),
                Value<String> mimeType = const Value.absent(),
                Value<int> sizeBytes = const Value.absent(),
                Value<String> bytesBase64 = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => LocalAttachmentQueueCompanion(
                id: id,
                uuid: uuid,
                transactionUuid: transactionUuid,
                transactionServerId: transactionServerId,
                originalName: originalName,
                mimeType: mimeType,
                sizeBytes: sizeBytes,
                bytesBase64: bytesBase64,
                syncStatus: syncStatus,
                lastError: lastError,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                required String transactionUuid,
                Value<int?> transactionServerId = const Value.absent(),
                required String originalName,
                required String mimeType,
                required int sizeBytes,
                required String bytesBase64,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => LocalAttachmentQueueCompanion.insert(
                id: id,
                uuid: uuid,
                transactionUuid: transactionUuid,
                transactionServerId: transactionServerId,
                originalName: originalName,
                mimeType: mimeType,
                sizeBytes: sizeBytes,
                bytesBase64: bytesBase64,
                syncStatus: syncStatus,
                lastError: lastError,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalAttachmentQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalAttachmentQueueTable,
      LocalAttachmentQueueData,
      $$LocalAttachmentQueueTableFilterComposer,
      $$LocalAttachmentQueueTableOrderingComposer,
      $$LocalAttachmentQueueTableAnnotationComposer,
      $$LocalAttachmentQueueTableCreateCompanionBuilder,
      $$LocalAttachmentQueueTableUpdateCompanionBuilder,
      (
        LocalAttachmentQueueData,
        BaseReferences<
          _$AppDatabase,
          $LocalAttachmentQueueTable,
          LocalAttachmentQueueData
        >,
      ),
      LocalAttachmentQueueData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalUsersTableTableManager get localUsers =>
      $$LocalUsersTableTableManager(_db, _db.localUsers);
  $$LocalCurrenciesTableTableManager get localCurrencies =>
      $$LocalCurrenciesTableTableManager(_db, _db.localCurrencies);
  $$LocalFinancialAccountsTableTableManager get localFinancialAccounts =>
      $$LocalFinancialAccountsTableTableManager(
        _db,
        _db.localFinancialAccounts,
      );
  $$LocalCategoriesTableTableManager get localCategories =>
      $$LocalCategoriesTableTableManager(_db, _db.localCategories);
  $$LocalPartiesTableTableManager get localParties =>
      $$LocalPartiesTableTableManager(_db, _db.localParties);
  $$LocalPartyOpeningBalancesTableTableManager get localPartyOpeningBalances =>
      $$LocalPartyOpeningBalancesTableTableManager(
        _db,
        _db.localPartyOpeningBalances,
      );
  $$LocalWorkersTableTableManager get localWorkers =>
      $$LocalWorkersTableTableManager(_db, _db.localWorkers);
  $$LocalWorkerOpeningBalancesTableTableManager
  get localWorkerOpeningBalances =>
      $$LocalWorkerOpeningBalancesTableTableManager(
        _db,
        _db.localWorkerOpeningBalances,
      );
  $$LocalAccountingTransactionsTableTableManager
  get localAccountingTransactions =>
      $$LocalAccountingTransactionsTableTableManager(
        _db,
        _db.localAccountingTransactions,
      );
  $$LocalProductsTableTableManager get localProducts =>
      $$LocalProductsTableTableManager(_db, _db.localProducts);
  $$LocalTransactionItemsTableTableManager get localTransactionItems =>
      $$LocalTransactionItemsTableTableManager(_db, _db.localTransactionItems);
  $$LocalSyncOperationsTableTableManager get localSyncOperations =>
      $$LocalSyncOperationsTableTableManager(_db, _db.localSyncOperations);
  $$LocalAttachmentQueueTableTableManager get localAttachmentQueue =>
      $$LocalAttachmentQueueTableTableManager(_db, _db.localAttachmentQueue);
}
