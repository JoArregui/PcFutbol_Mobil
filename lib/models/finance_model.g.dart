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
    r'transferBudget': PropertySchema(
      id: 2,
      name: r'transferBudget',
      type: IsarType.double,
    ),
    r'wageBill': PropertySchema(
      id: 3,
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
  writer.writeDouble(offsets[2], object.transferBudget);
  writer.writeDouble(offsets[3], object.wageBill);
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
  object.transferBudget = reader.readDouble(offsets[2]);
  object.wageBill = reader.readDouble(offsets[3]);
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
