// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_lineup.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserLineupCollection on Isar {
  IsarCollection<UserLineup> get userLineups => this.collection();
}

const UserLineupSchema = CollectionSchema(
  name: r'UserLineup',
  id: 1503161085836371174,
  properties: {
    r'benchPlayerIds': PropertySchema(
      id: 0,
      name: r'benchPlayerIds',
      type: IsarType.longList,
    ),
    r'formation': PropertySchema(
      id: 1,
      name: r'formation',
      type: IsarType.string,
    ),
    r'starterPlayerIds': PropertySchema(
      id: 2,
      name: r'starterPlayerIds',
      type: IsarType.longList,
    )
  },
  estimateSize: _userLineupEstimateSize,
  serialize: _userLineupSerialize,
  deserialize: _userLineupDeserialize,
  deserializeProp: _userLineupDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _userLineupGetId,
  getLinks: _userLineupGetLinks,
  attach: _userLineupAttach,
  version: '3.1.0+1',
);

int _userLineupEstimateSize(
  UserLineup object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.benchPlayerIds.length * 8;
  bytesCount += 3 + object.formation.length * 3;
  bytesCount += 3 + object.starterPlayerIds.length * 8;
  return bytesCount;
}

void _userLineupSerialize(
  UserLineup object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLongList(offsets[0], object.benchPlayerIds);
  writer.writeString(offsets[1], object.formation);
  writer.writeLongList(offsets[2], object.starterPlayerIds);
}

UserLineup _userLineupDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserLineup();
  object.benchPlayerIds = reader.readLongList(offsets[0]) ?? [];
  object.formation = reader.readString(offsets[1]);
  object.id = id;
  object.starterPlayerIds = reader.readLongList(offsets[2]) ?? [];
  return object;
}

P _userLineupDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongList(offset) ?? []) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLongList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userLineupGetId(UserLineup object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userLineupGetLinks(UserLineup object) {
  return [];
}

void _userLineupAttach(IsarCollection<dynamic> col, Id id, UserLineup object) {
  object.id = id;
}

extension UserLineupQueryWhereSort
    on QueryBuilder<UserLineup, UserLineup, QWhere> {
  QueryBuilder<UserLineup, UserLineup, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserLineupQueryWhere
    on QueryBuilder<UserLineup, UserLineup, QWhereClause> {
  QueryBuilder<UserLineup, UserLineup, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserLineupQueryFilter
    on QueryBuilder<UserLineup, UserLineup, QFilterCondition> {
  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      benchPlayerIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'benchPlayerIds',
        value: value,
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      benchPlayerIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'benchPlayerIds',
        value: value,
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      benchPlayerIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'benchPlayerIds',
        value: value,
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      benchPlayerIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'benchPlayerIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      benchPlayerIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'benchPlayerIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      benchPlayerIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'benchPlayerIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      benchPlayerIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'benchPlayerIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      benchPlayerIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'benchPlayerIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      benchPlayerIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'benchPlayerIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      benchPlayerIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'benchPlayerIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition> formationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'formation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      formationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'formation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition> formationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'formation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition> formationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'formation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      formationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'formation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition> formationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'formation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition> formationContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'formation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition> formationMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'formation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      formationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'formation',
        value: '',
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      formationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'formation',
        value: '',
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      starterPlayerIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'starterPlayerIds',
        value: value,
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      starterPlayerIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'starterPlayerIds',
        value: value,
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      starterPlayerIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'starterPlayerIds',
        value: value,
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      starterPlayerIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'starterPlayerIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      starterPlayerIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'starterPlayerIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      starterPlayerIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'starterPlayerIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      starterPlayerIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'starterPlayerIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      starterPlayerIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'starterPlayerIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      starterPlayerIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'starterPlayerIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterFilterCondition>
      starterPlayerIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'starterPlayerIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension UserLineupQueryObject
    on QueryBuilder<UserLineup, UserLineup, QFilterCondition> {}

extension UserLineupQueryLinks
    on QueryBuilder<UserLineup, UserLineup, QFilterCondition> {}

extension UserLineupQuerySortBy
    on QueryBuilder<UserLineup, UserLineup, QSortBy> {
  QueryBuilder<UserLineup, UserLineup, QAfterSortBy> sortByFormation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formation', Sort.asc);
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterSortBy> sortByFormationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formation', Sort.desc);
    });
  }
}

extension UserLineupQuerySortThenBy
    on QueryBuilder<UserLineup, UserLineup, QSortThenBy> {
  QueryBuilder<UserLineup, UserLineup, QAfterSortBy> thenByFormation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formation', Sort.asc);
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterSortBy> thenByFormationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formation', Sort.desc);
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserLineup, UserLineup, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension UserLineupQueryWhereDistinct
    on QueryBuilder<UserLineup, UserLineup, QDistinct> {
  QueryBuilder<UserLineup, UserLineup, QDistinct> distinctByBenchPlayerIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'benchPlayerIds');
    });
  }

  QueryBuilder<UserLineup, UserLineup, QDistinct> distinctByFormation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'formation', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserLineup, UserLineup, QDistinct> distinctByStarterPlayerIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'starterPlayerIds');
    });
  }
}

extension UserLineupQueryProperty
    on QueryBuilder<UserLineup, UserLineup, QQueryProperty> {
  QueryBuilder<UserLineup, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserLineup, List<int>, QQueryOperations>
      benchPlayerIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'benchPlayerIds');
    });
  }

  QueryBuilder<UserLineup, String, QQueryOperations> formationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'formation');
    });
  }

  QueryBuilder<UserLineup, List<int>, QQueryOperations>
      starterPlayerIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'starterPlayerIds');
    });
  }
}
