// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTeamCollection on Isar {
  IsarCollection<Team> get teams => this.collection();
}

const TeamSchema = CollectionSchema(
  name: r'Team',
  id: -3518492973250071660,
  properties: {
    r'apiId': PropertySchema(
      id: 0,
      name: r'apiId',
      type: IsarType.long,
    ),
    r'budget': PropertySchema(
      id: 1,
      name: r'budget',
      type: IsarType.long,
    ),
    r'city': PropertySchema(
      id: 2,
      name: r'city',
      type: IsarType.string,
    ),
    r'logoUrl': PropertySchema(
      id: 3,
      name: r'logoUrl',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    ),
    r'stadium': PropertySchema(
      id: 5,
      name: r'stadium',
      type: IsarType.string,
    )
  },
  estimateSize: _teamEstimateSize,
  serialize: _teamSerialize,
  deserialize: _teamDeserialize,
  deserializeProp: _teamDeserializeProp,
  idName: r'id',
  indexes: {
    r'apiId': IndexSchema(
      id: 92618221247000178,
      name: r'apiId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'apiId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _teamGetId,
  getLinks: _teamGetLinks,
  attach: _teamAttach,
  version: '3.1.0+1',
);

int _teamEstimateSize(
  Team object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.city.length * 3;
  bytesCount += 3 + object.logoUrl.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.stadium.length * 3;
  return bytesCount;
}

void _teamSerialize(
  Team object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.apiId);
  writer.writeLong(offsets[1], object.budget);
  writer.writeString(offsets[2], object.city);
  writer.writeString(offsets[3], object.logoUrl);
  writer.writeString(offsets[4], object.name);
  writer.writeString(offsets[5], object.stadium);
}

Team _teamDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Team(
    apiId: reader.readLong(offsets[0]),
    budget: reader.readLong(offsets[1]),
    city: reader.readString(offsets[2]),
    logoUrl: reader.readString(offsets[3]),
    name: reader.readString(offsets[4]),
    stadium: reader.readString(offsets[5]),
  );
  object.id = id;
  return object;
}

P _teamDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _teamGetId(Team object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _teamGetLinks(Team object) {
  return [];
}

void _teamAttach(IsarCollection<dynamic> col, Id id, Team object) {
  object.id = id;
}

extension TeamByIndex on IsarCollection<Team> {
  Future<Team?> getByApiId(int apiId) {
    return getByIndex(r'apiId', [apiId]);
  }

  Team? getByApiIdSync(int apiId) {
    return getByIndexSync(r'apiId', [apiId]);
  }

  Future<bool> deleteByApiId(int apiId) {
    return deleteByIndex(r'apiId', [apiId]);
  }

  bool deleteByApiIdSync(int apiId) {
    return deleteByIndexSync(r'apiId', [apiId]);
  }

  Future<List<Team?>> getAllByApiId(List<int> apiIdValues) {
    final values = apiIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'apiId', values);
  }

  List<Team?> getAllByApiIdSync(List<int> apiIdValues) {
    final values = apiIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'apiId', values);
  }

  Future<int> deleteAllByApiId(List<int> apiIdValues) {
    final values = apiIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'apiId', values);
  }

  int deleteAllByApiIdSync(List<int> apiIdValues) {
    final values = apiIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'apiId', values);
  }

  Future<Id> putByApiId(Team object) {
    return putByIndex(r'apiId', object);
  }

  Id putByApiIdSync(Team object, {bool saveLinks = true}) {
    return putByIndexSync(r'apiId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByApiId(List<Team> objects) {
    return putAllByIndex(r'apiId', objects);
  }

  List<Id> putAllByApiIdSync(List<Team> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'apiId', objects, saveLinks: saveLinks);
  }
}

extension TeamQueryWhereSort on QueryBuilder<Team, Team, QWhere> {
  QueryBuilder<Team, Team, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Team, Team, QAfterWhere> anyApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'apiId'),
      );
    });
  }
}

extension TeamQueryWhere on QueryBuilder<Team, Team, QWhereClause> {
  QueryBuilder<Team, Team, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Team, Team, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Team, Team, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Team, Team, QAfterWhereClause> idBetween(
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

  QueryBuilder<Team, Team, QAfterWhereClause> apiIdEqualTo(int apiId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'apiId',
        value: [apiId],
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterWhereClause> apiIdNotEqualTo(int apiId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'apiId',
              lower: [],
              upper: [apiId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'apiId',
              lower: [apiId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'apiId',
              lower: [apiId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'apiId',
              lower: [],
              upper: [apiId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Team, Team, QAfterWhereClause> apiIdGreaterThan(
    int apiId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'apiId',
        lower: [apiId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterWhereClause> apiIdLessThan(
    int apiId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'apiId',
        lower: [],
        upper: [apiId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterWhereClause> apiIdBetween(
    int lowerApiId,
    int upperApiId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'apiId',
        lower: [lowerApiId],
        includeLower: includeLower,
        upper: [upperApiId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TeamQueryFilter on QueryBuilder<Team, Team, QFilterCondition> {
  QueryBuilder<Team, Team, QAfterFilterCondition> apiIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apiId',
        value: value,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> apiIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'apiId',
        value: value,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> apiIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'apiId',
        value: value,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> apiIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'apiId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> budgetEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'budget',
        value: value,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> budgetGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'budget',
        value: value,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> budgetLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'budget',
        value: value,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> budgetBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'budget',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> cityEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> cityGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> cityLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> cityBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'city',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> cityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> cityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> cityContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> cityMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'city',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> cityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'city',
        value: '',
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> cityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'city',
        value: '',
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Team, Team, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Team, Team, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Team, Team, QAfterFilterCondition> logoUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> logoUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'logoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> logoUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'logoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> logoUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'logoUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> logoUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'logoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> logoUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'logoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> logoUrlContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'logoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> logoUrlMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'logoUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> logoUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logoUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> logoUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'logoUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> stadiumEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stadium',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> stadiumGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stadium',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> stadiumLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stadium',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> stadiumBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stadium',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> stadiumStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stadium',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> stadiumEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stadium',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> stadiumContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stadium',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> stadiumMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stadium',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> stadiumIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stadium',
        value: '',
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> stadiumIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stadium',
        value: '',
      ));
    });
  }
}

extension TeamQueryObject on QueryBuilder<Team, Team, QFilterCondition> {}

extension TeamQueryLinks on QueryBuilder<Team, Team, QFilterCondition> {}

extension TeamQuerySortBy on QueryBuilder<Team, Team, QSortBy> {
  QueryBuilder<Team, Team, QAfterSortBy> sortByApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiId', Sort.asc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> sortByApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiId', Sort.desc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> sortByBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'budget', Sort.asc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> sortByBudgetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'budget', Sort.desc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> sortByCity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.asc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> sortByCityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.desc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> sortByLogoUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoUrl', Sort.asc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> sortByLogoUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoUrl', Sort.desc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> sortByStadium() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stadium', Sort.asc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> sortByStadiumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stadium', Sort.desc);
    });
  }
}

extension TeamQuerySortThenBy on QueryBuilder<Team, Team, QSortThenBy> {
  QueryBuilder<Team, Team, QAfterSortBy> thenByApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiId', Sort.asc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> thenByApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiId', Sort.desc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> thenByBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'budget', Sort.asc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> thenByBudgetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'budget', Sort.desc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> thenByCity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.asc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> thenByCityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.desc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> thenByLogoUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoUrl', Sort.asc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> thenByLogoUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoUrl', Sort.desc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> thenByStadium() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stadium', Sort.asc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> thenByStadiumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stadium', Sort.desc);
    });
  }
}

extension TeamQueryWhereDistinct on QueryBuilder<Team, Team, QDistinct> {
  QueryBuilder<Team, Team, QDistinct> distinctByApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'apiId');
    });
  }

  QueryBuilder<Team, Team, QDistinct> distinctByBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'budget');
    });
  }

  QueryBuilder<Team, Team, QDistinct> distinctByCity(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'city', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Team, Team, QDistinct> distinctByLogoUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logoUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Team, Team, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Team, Team, QDistinct> distinctByStadium(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stadium', caseSensitive: caseSensitive);
    });
  }
}

extension TeamQueryProperty on QueryBuilder<Team, Team, QQueryProperty> {
  QueryBuilder<Team, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Team, int, QQueryOperations> apiIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'apiId');
    });
  }

  QueryBuilder<Team, int, QQueryOperations> budgetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'budget');
    });
  }

  QueryBuilder<Team, String, QQueryOperations> cityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'city');
    });
  }

  QueryBuilder<Team, String, QQueryOperations> logoUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logoUrl');
    });
  }

  QueryBuilder<Team, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Team, String, QQueryOperations> stadiumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stadium');
    });
  }
}
