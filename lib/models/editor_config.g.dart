// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editor_config.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEditorConfigCollection on Isar {
  IsarCollection<EditorConfig> get editorConfigs => this.collection();
}

const EditorConfigSchema = CollectionSchema(
  name: r'EditorConfig',
  id: 6987910856563256384,
  properties: {
    r'leagueName': PropertySchema(
      id: 0,
      name: r'leagueName',
      type: IsarType.string,
    ),
    r'seasonLabel': PropertySchema(
      id: 1,
      name: r'seasonLabel',
      type: IsarType.string,
    ),
    r'userTeamNameOverride': PropertySchema(
      id: 2,
      name: r'userTeamNameOverride',
      type: IsarType.string,
    )
  },
  estimateSize: _editorConfigEstimateSize,
  serialize: _editorConfigSerialize,
  deserialize: _editorConfigDeserialize,
  deserializeProp: _editorConfigDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _editorConfigGetId,
  getLinks: _editorConfigGetLinks,
  attach: _editorConfigAttach,
  version: '3.1.0+1',
);

int _editorConfigEstimateSize(
  EditorConfig object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.leagueName.length * 3;
  bytesCount += 3 + object.seasonLabel.length * 3;
  bytesCount += 3 + object.userTeamNameOverride.length * 3;
  return bytesCount;
}

void _editorConfigSerialize(
  EditorConfig object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.leagueName);
  writer.writeString(offsets[1], object.seasonLabel);
  writer.writeString(offsets[2], object.userTeamNameOverride);
}

EditorConfig _editorConfigDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EditorConfig();
  object.id = id;
  object.leagueName = reader.readString(offsets[0]);
  object.seasonLabel = reader.readString(offsets[1]);
  object.userTeamNameOverride = reader.readString(offsets[2]);
  return object;
}

P _editorConfigDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _editorConfigGetId(EditorConfig object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _editorConfigGetLinks(EditorConfig object) {
  return [];
}

void _editorConfigAttach(
    IsarCollection<dynamic> col, Id id, EditorConfig object) {
  object.id = id;
}

extension EditorConfigQueryWhereSort
    on QueryBuilder<EditorConfig, EditorConfig, QWhere> {
  QueryBuilder<EditorConfig, EditorConfig, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EditorConfigQueryWhere
    on QueryBuilder<EditorConfig, EditorConfig, QWhereClause> {
  QueryBuilder<EditorConfig, EditorConfig, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<EditorConfig, EditorConfig, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterWhereClause> idBetween(
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

extension EditorConfigQueryFilter
    on QueryBuilder<EditorConfig, EditorConfig, QFilterCondition> {
  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition> idBetween(
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

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      leagueNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'leagueName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      leagueNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'leagueName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      leagueNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'leagueName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      leagueNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'leagueName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      leagueNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'leagueName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      leagueNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'leagueName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      leagueNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'leagueName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      leagueNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'leagueName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      leagueNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'leagueName',
        value: '',
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      leagueNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'leagueName',
        value: '',
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      seasonLabelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'seasonLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      seasonLabelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'seasonLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      seasonLabelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'seasonLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      seasonLabelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'seasonLabel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      seasonLabelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'seasonLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      seasonLabelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'seasonLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      seasonLabelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'seasonLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      seasonLabelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'seasonLabel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      seasonLabelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'seasonLabel',
        value: '',
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      seasonLabelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'seasonLabel',
        value: '',
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      userTeamNameOverrideEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userTeamNameOverride',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      userTeamNameOverrideGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userTeamNameOverride',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      userTeamNameOverrideLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userTeamNameOverride',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      userTeamNameOverrideBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userTeamNameOverride',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      userTeamNameOverrideStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userTeamNameOverride',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      userTeamNameOverrideEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userTeamNameOverride',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      userTeamNameOverrideContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userTeamNameOverride',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      userTeamNameOverrideMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userTeamNameOverride',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      userTeamNameOverrideIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userTeamNameOverride',
        value: '',
      ));
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterFilterCondition>
      userTeamNameOverrideIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userTeamNameOverride',
        value: '',
      ));
    });
  }
}

extension EditorConfigQueryObject
    on QueryBuilder<EditorConfig, EditorConfig, QFilterCondition> {}

extension EditorConfigQueryLinks
    on QueryBuilder<EditorConfig, EditorConfig, QFilterCondition> {}

extension EditorConfigQuerySortBy
    on QueryBuilder<EditorConfig, EditorConfig, QSortBy> {
  QueryBuilder<EditorConfig, EditorConfig, QAfterSortBy> sortByLeagueName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leagueName', Sort.asc);
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterSortBy>
      sortByLeagueNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leagueName', Sort.desc);
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterSortBy> sortBySeasonLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seasonLabel', Sort.asc);
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterSortBy>
      sortBySeasonLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seasonLabel', Sort.desc);
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterSortBy>
      sortByUserTeamNameOverride() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userTeamNameOverride', Sort.asc);
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterSortBy>
      sortByUserTeamNameOverrideDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userTeamNameOverride', Sort.desc);
    });
  }
}

extension EditorConfigQuerySortThenBy
    on QueryBuilder<EditorConfig, EditorConfig, QSortThenBy> {
  QueryBuilder<EditorConfig, EditorConfig, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterSortBy> thenByLeagueName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leagueName', Sort.asc);
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterSortBy>
      thenByLeagueNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leagueName', Sort.desc);
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterSortBy> thenBySeasonLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seasonLabel', Sort.asc);
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterSortBy>
      thenBySeasonLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seasonLabel', Sort.desc);
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterSortBy>
      thenByUserTeamNameOverride() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userTeamNameOverride', Sort.asc);
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QAfterSortBy>
      thenByUserTeamNameOverrideDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userTeamNameOverride', Sort.desc);
    });
  }
}

extension EditorConfigQueryWhereDistinct
    on QueryBuilder<EditorConfig, EditorConfig, QDistinct> {
  QueryBuilder<EditorConfig, EditorConfig, QDistinct> distinctByLeagueName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leagueName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QDistinct> distinctBySeasonLabel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'seasonLabel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EditorConfig, EditorConfig, QDistinct>
      distinctByUserTeamNameOverride({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userTeamNameOverride',
          caseSensitive: caseSensitive);
    });
  }
}

extension EditorConfigQueryProperty
    on QueryBuilder<EditorConfig, EditorConfig, QQueryProperty> {
  QueryBuilder<EditorConfig, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EditorConfig, String, QQueryOperations> leagueNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leagueName');
    });
  }

  QueryBuilder<EditorConfig, String, QQueryOperations> seasonLabelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'seasonLabel');
    });
  }

  QueryBuilder<EditorConfig, String, QQueryOperations>
      userTeamNameOverrideProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userTeamNameOverride');
    });
  }
}
