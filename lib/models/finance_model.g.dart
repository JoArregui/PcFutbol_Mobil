// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetClubFinanceCollection on Isar {
  IsarCollection<ClubFinance> get clubFinances => this.collection();
}

const ClubFinanceSchema = CollectionSchema(
  name: r'ClubFinance',
  id: 9119571086285811571,
  properties: {
    r'balance': PropertySchema(
      id: 0,
      name: r'balance',
      type: IsarType.double,
    ),
    r'maxWageBill': PropertySchema(
      id: 1,
      name: r'maxWageBill',
      type: IsarType.double,
    ),
    r'sponsorIncomePerMatch': PropertySchema(
      id: 2,
      name: r'sponsorIncomePerMatch',
      type: IsarType.double,
    ),
    r'sponsorSlot1Brand': PropertySchema(
      id: 3,
      name: r'sponsorSlot1Brand',
      type: IsarType.string,
    ),
    r'sponsorSlot1Income': PropertySchema(
      id: 4,
      name: r'sponsorSlot1Income',
      type: IsarType.double,
    ),
    r'sponsorSlot2Brand': PropertySchema(
      id: 5,
      name: r'sponsorSlot2Brand',
      type: IsarType.string,
    ),
    r'sponsorSlot2Income': PropertySchema(
      id: 6,
      name: r'sponsorSlot2Income',
      type: IsarType.double,
    ),
    r'sponsorSlot3Brand': PropertySchema(
      id: 7,
      name: r'sponsorSlot3Brand',
      type: IsarType.string,
    ),
    r'sponsorSlot3Income': PropertySchema(
      id: 8,
      name: r'sponsorSlot3Income',
      type: IsarType.double,
    ),
    r'stadiumExtraCapacity': PropertySchema(
      id: 9,
      name: r'stadiumExtraCapacity',
      type: IsarType.long,
    ),
    r'stadiumMaintenance': PropertySchema(
      id: 10,
      name: r'stadiumMaintenance',
      type: IsarType.double,
    ),
    r'ticketPrice': PropertySchema(
      id: 11,
      name: r'ticketPrice',
      type: IsarType.double,
    ),
    r'transferBudget': PropertySchema(
      id: 12,
      name: r'transferBudget',
      type: IsarType.double,
    ),
    r'wageBill': PropertySchema(
      id: 13,
      name: r'wageBill',
      type: IsarType.double,
    )
  },
  estimateSize: _clubFinanceEstimateSize,
  serialize: _clubFinanceSerialize,
  deserialize: _clubFinanceDeserialize,
  deserializeProp: _clubFinanceDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _clubFinanceGetId,
  getLinks: _clubFinanceGetLinks,
  attach: _clubFinanceAttach,
  version: '3.1.0+1',
);

int _clubFinanceEstimateSize(
  ClubFinance object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.sponsorSlot1Brand.length * 3;
  bytesCount += 3 + object.sponsorSlot2Brand.length * 3;
  bytesCount += 3 + object.sponsorSlot3Brand.length * 3;
  return bytesCount;
}

void _clubFinanceSerialize(
  ClubFinance object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.balance);
  writer.writeDouble(offsets[1], object.maxWageBill);
  writer.writeDouble(offsets[2], object.sponsorIncomePerMatch);
  writer.writeString(offsets[3], object.sponsorSlot1Brand);
  writer.writeDouble(offsets[4], object.sponsorSlot1Income);
  writer.writeString(offsets[5], object.sponsorSlot2Brand);
  writer.writeDouble(offsets[6], object.sponsorSlot2Income);
  writer.writeString(offsets[7], object.sponsorSlot3Brand);
  writer.writeDouble(offsets[8], object.sponsorSlot3Income);
  writer.writeLong(offsets[9], object.stadiumExtraCapacity);
  writer.writeDouble(offsets[10], object.stadiumMaintenance);
  writer.writeDouble(offsets[11], object.ticketPrice);
  writer.writeDouble(offsets[12], object.transferBudget);
  writer.writeDouble(offsets[13], object.wageBill);
}

ClubFinance _clubFinanceDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ClubFinance();
  object.balance = reader.readDouble(offsets[0]);
  object.id = id;
  object.maxWageBill = reader.readDouble(offsets[1]);
  object.sponsorIncomePerMatch = reader.readDouble(offsets[2]);
  object.sponsorSlot1Brand = reader.readString(offsets[3]);
  object.sponsorSlot1Income = reader.readDouble(offsets[4]);
  object.sponsorSlot2Brand = reader.readString(offsets[5]);
  object.sponsorSlot2Income = reader.readDouble(offsets[6]);
  object.sponsorSlot3Brand = reader.readString(offsets[7]);
  object.sponsorSlot3Income = reader.readDouble(offsets[8]);
  object.stadiumExtraCapacity = reader.readLong(offsets[9]);
  object.stadiumMaintenance = reader.readDouble(offsets[10]);
  object.ticketPrice = reader.readDouble(offsets[11]);
  object.transferBudget = reader.readDouble(offsets[12]);
  object.wageBill = reader.readDouble(offsets[13]);
  return object;
}

P _clubFinanceDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readDouble(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    case 11:
      return (reader.readDouble(offset)) as P;
    case 12:
      return (reader.readDouble(offset)) as P;
    case 13:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _clubFinanceGetId(ClubFinance object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _clubFinanceGetLinks(ClubFinance object) {
  return [];
}

void _clubFinanceAttach(
    IsarCollection<dynamic> col, Id id, ClubFinance object) {
  object.id = id;
}

extension ClubFinanceQueryWhereSort
    on QueryBuilder<ClubFinance, ClubFinance, QWhere> {
  QueryBuilder<ClubFinance, ClubFinance, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ClubFinanceQueryWhere
    on QueryBuilder<ClubFinance, ClubFinance, QWhereClause> {
  QueryBuilder<ClubFinance, ClubFinance, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ClubFinance, ClubFinance, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterWhereClause> idBetween(
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

extension ClubFinanceQueryFilter
    on QueryBuilder<ClubFinance, ClubFinance, QFilterCondition> {
  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition> balanceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'balance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      balanceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'balance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition> balanceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'balance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition> balanceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'balance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      maxWageBillEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxWageBill',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      maxWageBillGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxWageBill',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      maxWageBillLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxWageBill',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      maxWageBillBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxWageBill',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorIncomePerMatchEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sponsorIncomePerMatch',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorIncomePerMatchGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sponsorIncomePerMatch',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorIncomePerMatchLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sponsorIncomePerMatch',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorIncomePerMatchBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sponsorIncomePerMatch',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot1BrandEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sponsorSlot1Brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot1BrandGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sponsorSlot1Brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot1BrandLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sponsorSlot1Brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot1BrandBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sponsorSlot1Brand',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot1BrandStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sponsorSlot1Brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot1BrandEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sponsorSlot1Brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot1BrandContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sponsorSlot1Brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot1BrandMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sponsorSlot1Brand',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot1BrandIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sponsorSlot1Brand',
        value: '',
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot1BrandIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sponsorSlot1Brand',
        value: '',
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot1IncomeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sponsorSlot1Income',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot1IncomeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sponsorSlot1Income',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot1IncomeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sponsorSlot1Income',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot1IncomeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sponsorSlot1Income',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot2BrandEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sponsorSlot2Brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot2BrandGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sponsorSlot2Brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot2BrandLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sponsorSlot2Brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot2BrandBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sponsorSlot2Brand',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot2BrandStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sponsorSlot2Brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot2BrandEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sponsorSlot2Brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot2BrandContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sponsorSlot2Brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot2BrandMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sponsorSlot2Brand',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot2BrandIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sponsorSlot2Brand',
        value: '',
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot2BrandIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sponsorSlot2Brand',
        value: '',
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot2IncomeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sponsorSlot2Income',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot2IncomeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sponsorSlot2Income',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot2IncomeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sponsorSlot2Income',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot2IncomeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sponsorSlot2Income',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot3BrandEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sponsorSlot3Brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot3BrandGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sponsorSlot3Brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot3BrandLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sponsorSlot3Brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot3BrandBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sponsorSlot3Brand',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot3BrandStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sponsorSlot3Brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot3BrandEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sponsorSlot3Brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot3BrandContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sponsorSlot3Brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot3BrandMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sponsorSlot3Brand',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot3BrandIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sponsorSlot3Brand',
        value: '',
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot3BrandIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sponsorSlot3Brand',
        value: '',
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot3IncomeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sponsorSlot3Income',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot3IncomeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sponsorSlot3Income',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot3IncomeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sponsorSlot3Income',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      sponsorSlot3IncomeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sponsorSlot3Income',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      stadiumExtraCapacityEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stadiumExtraCapacity',
        value: value,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      stadiumExtraCapacityGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stadiumExtraCapacity',
        value: value,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      stadiumExtraCapacityLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stadiumExtraCapacity',
        value: value,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      stadiumExtraCapacityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stadiumExtraCapacity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      stadiumMaintenanceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stadiumMaintenance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      stadiumMaintenanceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stadiumMaintenance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      stadiumMaintenanceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stadiumMaintenance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      stadiumMaintenanceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stadiumMaintenance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      ticketPriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ticketPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      ticketPriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ticketPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      ticketPriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ticketPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      ticketPriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ticketPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      transferBudgetEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transferBudget',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      transferBudgetGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'transferBudget',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      transferBudgetLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'transferBudget',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      transferBudgetBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'transferBudget',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition> wageBillEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wageBill',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      wageBillGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'wageBill',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition>
      wageBillLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'wageBill',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterFilterCondition> wageBillBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'wageBill',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension ClubFinanceQueryObject
    on QueryBuilder<ClubFinance, ClubFinance, QFilterCondition> {}

extension ClubFinanceQueryLinks
    on QueryBuilder<ClubFinance, ClubFinance, QFilterCondition> {}

extension ClubFinanceQuerySortBy
    on QueryBuilder<ClubFinance, ClubFinance, QSortBy> {
  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy> sortByBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balance', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy> sortByBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balance', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy> sortByMaxWageBill() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxWageBill', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy> sortByMaxWageBillDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxWageBill', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      sortBySponsorIncomePerMatch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorIncomePerMatch', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      sortBySponsorIncomePerMatchDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorIncomePerMatch', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      sortBySponsorSlot1Brand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot1Brand', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      sortBySponsorSlot1BrandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot1Brand', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      sortBySponsorSlot1Income() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot1Income', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      sortBySponsorSlot1IncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot1Income', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      sortBySponsorSlot2Brand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot2Brand', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      sortBySponsorSlot2BrandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot2Brand', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      sortBySponsorSlot2Income() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot2Income', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      sortBySponsorSlot2IncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot2Income', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      sortBySponsorSlot3Brand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot3Brand', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      sortBySponsorSlot3BrandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot3Brand', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      sortBySponsorSlot3Income() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot3Income', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      sortBySponsorSlot3IncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot3Income', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      sortByStadiumExtraCapacity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stadiumExtraCapacity', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      sortByStadiumExtraCapacityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stadiumExtraCapacity', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      sortByStadiumMaintenance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stadiumMaintenance', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      sortByStadiumMaintenanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stadiumMaintenance', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy> sortByTicketPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticketPrice', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy> sortByTicketPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticketPrice', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy> sortByTransferBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferBudget', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      sortByTransferBudgetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferBudget', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy> sortByWageBill() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wageBill', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy> sortByWageBillDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wageBill', Sort.desc);
    });
  }
}

extension ClubFinanceQuerySortThenBy
    on QueryBuilder<ClubFinance, ClubFinance, QSortThenBy> {
  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy> thenByBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balance', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy> thenByBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balance', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy> thenByMaxWageBill() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxWageBill', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy> thenByMaxWageBillDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxWageBill', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      thenBySponsorIncomePerMatch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorIncomePerMatch', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      thenBySponsorIncomePerMatchDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorIncomePerMatch', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      thenBySponsorSlot1Brand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot1Brand', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      thenBySponsorSlot1BrandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot1Brand', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      thenBySponsorSlot1Income() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot1Income', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      thenBySponsorSlot1IncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot1Income', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      thenBySponsorSlot2Brand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot2Brand', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      thenBySponsorSlot2BrandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot2Brand', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      thenBySponsorSlot2Income() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot2Income', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      thenBySponsorSlot2IncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot2Income', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      thenBySponsorSlot3Brand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot3Brand', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      thenBySponsorSlot3BrandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot3Brand', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      thenBySponsorSlot3Income() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot3Income', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      thenBySponsorSlot3IncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sponsorSlot3Income', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      thenByStadiumExtraCapacity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stadiumExtraCapacity', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      thenByStadiumExtraCapacityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stadiumExtraCapacity', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      thenByStadiumMaintenance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stadiumMaintenance', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      thenByStadiumMaintenanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stadiumMaintenance', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy> thenByTicketPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticketPrice', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy> thenByTicketPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ticketPrice', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy> thenByTransferBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferBudget', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy>
      thenByTransferBudgetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferBudget', Sort.desc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy> thenByWageBill() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wageBill', Sort.asc);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QAfterSortBy> thenByWageBillDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wageBill', Sort.desc);
    });
  }
}

extension ClubFinanceQueryWhereDistinct
    on QueryBuilder<ClubFinance, ClubFinance, QDistinct> {
  QueryBuilder<ClubFinance, ClubFinance, QDistinct> distinctByBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'balance');
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QDistinct> distinctByMaxWageBill() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxWageBill');
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QDistinct>
      distinctBySponsorIncomePerMatch() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sponsorIncomePerMatch');
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QDistinct> distinctBySponsorSlot1Brand(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sponsorSlot1Brand',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QDistinct>
      distinctBySponsorSlot1Income() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sponsorSlot1Income');
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QDistinct> distinctBySponsorSlot2Brand(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sponsorSlot2Brand',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QDistinct>
      distinctBySponsorSlot2Income() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sponsorSlot2Income');
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QDistinct> distinctBySponsorSlot3Brand(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sponsorSlot3Brand',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QDistinct>
      distinctBySponsorSlot3Income() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sponsorSlot3Income');
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QDistinct>
      distinctByStadiumExtraCapacity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stadiumExtraCapacity');
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QDistinct>
      distinctByStadiumMaintenance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stadiumMaintenance');
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QDistinct> distinctByTicketPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ticketPrice');
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QDistinct> distinctByTransferBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transferBudget');
    });
  }

  QueryBuilder<ClubFinance, ClubFinance, QDistinct> distinctByWageBill() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'wageBill');
    });
  }
}

extension ClubFinanceQueryProperty
    on QueryBuilder<ClubFinance, ClubFinance, QQueryProperty> {
  QueryBuilder<ClubFinance, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ClubFinance, double, QQueryOperations> balanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'balance');
    });
  }

  QueryBuilder<ClubFinance, double, QQueryOperations> maxWageBillProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxWageBill');
    });
  }

  QueryBuilder<ClubFinance, double, QQueryOperations>
      sponsorIncomePerMatchProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sponsorIncomePerMatch');
    });
  }

  QueryBuilder<ClubFinance, String, QQueryOperations>
      sponsorSlot1BrandProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sponsorSlot1Brand');
    });
  }

  QueryBuilder<ClubFinance, double, QQueryOperations>
      sponsorSlot1IncomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sponsorSlot1Income');
    });
  }

  QueryBuilder<ClubFinance, String, QQueryOperations>
      sponsorSlot2BrandProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sponsorSlot2Brand');
    });
  }

  QueryBuilder<ClubFinance, double, QQueryOperations>
      sponsorSlot2IncomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sponsorSlot2Income');
    });
  }

  QueryBuilder<ClubFinance, String, QQueryOperations>
      sponsorSlot3BrandProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sponsorSlot3Brand');
    });
  }

  QueryBuilder<ClubFinance, double, QQueryOperations>
      sponsorSlot3IncomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sponsorSlot3Income');
    });
  }

  QueryBuilder<ClubFinance, int, QQueryOperations>
      stadiumExtraCapacityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stadiumExtraCapacity');
    });
  }

  QueryBuilder<ClubFinance, double, QQueryOperations>
      stadiumMaintenanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stadiumMaintenance');
    });
  }

  QueryBuilder<ClubFinance, double, QQueryOperations> ticketPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ticketPrice');
    });
  }

  QueryBuilder<ClubFinance, double, QQueryOperations> transferBudgetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transferBudget');
    });
  }

  QueryBuilder<ClubFinance, double, QQueryOperations> wageBillProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'wageBill');
    });
  }
}
