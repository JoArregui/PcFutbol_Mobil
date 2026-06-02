// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_offer.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTransferOfferCollection on Isar {
  IsarCollection<TransferOffer> get transferOffers => this.collection();
}

const TransferOfferSchema = CollectionSchema(
  name: r'TransferOffer',
  id: -8031752181189044641,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.double,
    ),
    r'counterpartyTeamApiId': PropertySchema(
      id: 1,
      name: r'counterpartyTeamApiId',
      type: IsarType.long,
    ),
    r'counterpartyTeamName': PropertySchema(
      id: 2,
      name: r'counterpartyTeamName',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'expiresOnMatchday': PropertySchema(
      id: 4,
      name: r'expiresOnMatchday',
      type: IsarType.long,
    ),
    r'isForOurPlayer': PropertySchema(
      id: 5,
      name: r'isForOurPlayer',
      type: IsarType.bool,
    ),
    r'loanMatchdays': PropertySchema(
      id: 6,
      name: r'loanMatchdays',
      type: IsarType.long,
    ),
    r'offerType': PropertySchema(
      id: 7,
      name: r'offerType',
      type: IsarType.byte,
      enumMap: _TransferOfferofferTypeEnumValueMap,
    ),
    r'playerId': PropertySchema(
      id: 8,
      name: r'playerId',
      type: IsarType.long,
    ),
    r'status': PropertySchema(
      id: 9,
      name: r'status',
      type: IsarType.byte,
      enumMap: _TransferOfferstatusEnumValueMap,
    )
  },
  estimateSize: _transferOfferEstimateSize,
  serialize: _transferOfferSerialize,
  deserialize: _transferOfferDeserialize,
  deserializeProp: _transferOfferDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _transferOfferGetId,
  getLinks: _transferOfferGetLinks,
  attach: _transferOfferAttach,
  version: '3.1.0+1',
);

int _transferOfferEstimateSize(
  TransferOffer object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.counterpartyTeamName.length * 3;
  return bytesCount;
}

void _transferOfferSerialize(
  TransferOffer object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.amount);
  writer.writeLong(offsets[1], object.counterpartyTeamApiId);
  writer.writeString(offsets[2], object.counterpartyTeamName);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeLong(offsets[4], object.expiresOnMatchday);
  writer.writeBool(offsets[5], object.isForOurPlayer);
  writer.writeLong(offsets[6], object.loanMatchdays);
  writer.writeByte(offsets[7], object.offerType.index);
  writer.writeLong(offsets[8], object.playerId);
  writer.writeByte(offsets[9], object.status.index);
}

TransferOffer _transferOfferDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TransferOffer();
  object.amount = reader.readDouble(offsets[0]);
  object.counterpartyTeamApiId = reader.readLong(offsets[1]);
  object.counterpartyTeamName = reader.readString(offsets[2]);
  object.createdAt = reader.readDateTime(offsets[3]);
  object.expiresOnMatchday = reader.readLong(offsets[4]);
  object.id = id;
  object.isForOurPlayer = reader.readBool(offsets[5]);
  object.loanMatchdays = reader.readLong(offsets[6]);
  object.offerType =
      _TransferOfferofferTypeValueEnumMap[reader.readByteOrNull(offsets[7])] ??
          OfferType.purchase;
  object.playerId = reader.readLong(offsets[8]);
  object.status =
      _TransferOfferstatusValueEnumMap[reader.readByteOrNull(offsets[9])] ??
          OfferStatus.pending;
  return object;
}

P _transferOfferDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (_TransferOfferofferTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          OfferType.purchase) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (_TransferOfferstatusValueEnumMap[reader.readByteOrNull(offset)] ??
          OfferStatus.pending) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _TransferOfferofferTypeEnumValueMap = {
  'purchase': 0,
  'loanIn': 1,
  'loanOut': 2,
};
const _TransferOfferofferTypeValueEnumMap = {
  0: OfferType.purchase,
  1: OfferType.loanIn,
  2: OfferType.loanOut,
};
const _TransferOfferstatusEnumValueMap = {
  'pending': 0,
  'accepted': 1,
  'rejected': 2,
  'expired': 3,
};
const _TransferOfferstatusValueEnumMap = {
  0: OfferStatus.pending,
  1: OfferStatus.accepted,
  2: OfferStatus.rejected,
  3: OfferStatus.expired,
};

Id _transferOfferGetId(TransferOffer object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _transferOfferGetLinks(TransferOffer object) {
  return [];
}

void _transferOfferAttach(
    IsarCollection<dynamic> col, Id id, TransferOffer object) {
  object.id = id;
}

extension TransferOfferQueryWhereSort
    on QueryBuilder<TransferOffer, TransferOffer, QWhere> {
  QueryBuilder<TransferOffer, TransferOffer, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TransferOfferQueryWhere
    on QueryBuilder<TransferOffer, TransferOffer, QWhereClause> {
  QueryBuilder<TransferOffer, TransferOffer, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<TransferOffer, TransferOffer, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterWhereClause> idBetween(
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

extension TransferOfferQueryFilter
    on QueryBuilder<TransferOffer, TransferOffer, QFilterCondition> {
  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      amountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      amountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      amountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      amountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      counterpartyTeamApiIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'counterpartyTeamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      counterpartyTeamApiIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'counterpartyTeamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      counterpartyTeamApiIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'counterpartyTeamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      counterpartyTeamApiIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'counterpartyTeamApiId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      counterpartyTeamNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'counterpartyTeamName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      counterpartyTeamNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'counterpartyTeamName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      counterpartyTeamNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'counterpartyTeamName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      counterpartyTeamNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'counterpartyTeamName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      counterpartyTeamNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'counterpartyTeamName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      counterpartyTeamNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'counterpartyTeamName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      counterpartyTeamNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'counterpartyTeamName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      counterpartyTeamNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'counterpartyTeamName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      counterpartyTeamNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'counterpartyTeamName',
        value: '',
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      counterpartyTeamNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'counterpartyTeamName',
        value: '',
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      expiresOnMatchdayEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expiresOnMatchday',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      expiresOnMatchdayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expiresOnMatchday',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      expiresOnMatchdayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expiresOnMatchday',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      expiresOnMatchdayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expiresOnMatchday',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      isForOurPlayerEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isForOurPlayer',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      loanMatchdaysEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loanMatchdays',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      loanMatchdaysGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'loanMatchdays',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      loanMatchdaysLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'loanMatchdays',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      loanMatchdaysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'loanMatchdays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      offerTypeEqualTo(OfferType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'offerType',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      offerTypeGreaterThan(
    OfferType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'offerType',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      offerTypeLessThan(
    OfferType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'offerType',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      offerTypeBetween(
    OfferType lower,
    OfferType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'offerType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      playerIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playerId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      playerIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playerId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      playerIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playerId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      playerIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      statusEqualTo(OfferStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      statusGreaterThan(
    OfferStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      statusLessThan(
    OfferStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterFilterCondition>
      statusBetween(
    OfferStatus lower,
    OfferStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TransferOfferQueryObject
    on QueryBuilder<TransferOffer, TransferOffer, QFilterCondition> {}

extension TransferOfferQueryLinks
    on QueryBuilder<TransferOffer, TransferOffer, QFilterCondition> {}

extension TransferOfferQuerySortBy
    on QueryBuilder<TransferOffer, TransferOffer, QSortBy> {
  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy> sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy> sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      sortByCounterpartyTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'counterpartyTeamApiId', Sort.asc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      sortByCounterpartyTeamApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'counterpartyTeamApiId', Sort.desc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      sortByCounterpartyTeamName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'counterpartyTeamName', Sort.asc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      sortByCounterpartyTeamNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'counterpartyTeamName', Sort.desc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      sortByExpiresOnMatchday() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresOnMatchday', Sort.asc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      sortByExpiresOnMatchdayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresOnMatchday', Sort.desc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      sortByIsForOurPlayer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isForOurPlayer', Sort.asc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      sortByIsForOurPlayerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isForOurPlayer', Sort.desc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      sortByLoanMatchdays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loanMatchdays', Sort.asc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      sortByLoanMatchdaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loanMatchdays', Sort.desc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy> sortByOfferType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'offerType', Sort.asc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      sortByOfferTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'offerType', Sort.desc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy> sortByPlayerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerId', Sort.asc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      sortByPlayerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerId', Sort.desc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension TransferOfferQuerySortThenBy
    on QueryBuilder<TransferOffer, TransferOffer, QSortThenBy> {
  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy> thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy> thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      thenByCounterpartyTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'counterpartyTeamApiId', Sort.asc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      thenByCounterpartyTeamApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'counterpartyTeamApiId', Sort.desc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      thenByCounterpartyTeamName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'counterpartyTeamName', Sort.asc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      thenByCounterpartyTeamNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'counterpartyTeamName', Sort.desc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      thenByExpiresOnMatchday() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresOnMatchday', Sort.asc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      thenByExpiresOnMatchdayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresOnMatchday', Sort.desc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      thenByIsForOurPlayer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isForOurPlayer', Sort.asc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      thenByIsForOurPlayerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isForOurPlayer', Sort.desc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      thenByLoanMatchdays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loanMatchdays', Sort.asc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      thenByLoanMatchdaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loanMatchdays', Sort.desc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy> thenByOfferType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'offerType', Sort.asc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      thenByOfferTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'offerType', Sort.desc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy> thenByPlayerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerId', Sort.asc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy>
      thenByPlayerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerId', Sort.desc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension TransferOfferQueryWhereDistinct
    on QueryBuilder<TransferOffer, TransferOffer, QDistinct> {
  QueryBuilder<TransferOffer, TransferOffer, QDistinct> distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QDistinct>
      distinctByCounterpartyTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'counterpartyTeamApiId');
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QDistinct>
      distinctByCounterpartyTeamName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'counterpartyTeamName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QDistinct>
      distinctByExpiresOnMatchday() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expiresOnMatchday');
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QDistinct>
      distinctByIsForOurPlayer() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isForOurPlayer');
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QDistinct>
      distinctByLoanMatchdays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loanMatchdays');
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QDistinct> distinctByOfferType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'offerType');
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QDistinct> distinctByPlayerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playerId');
    });
  }

  QueryBuilder<TransferOffer, TransferOffer, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }
}

extension TransferOfferQueryProperty
    on QueryBuilder<TransferOffer, TransferOffer, QQueryProperty> {
  QueryBuilder<TransferOffer, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TransferOffer, double, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<TransferOffer, int, QQueryOperations>
      counterpartyTeamApiIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'counterpartyTeamApiId');
    });
  }

  QueryBuilder<TransferOffer, String, QQueryOperations>
      counterpartyTeamNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'counterpartyTeamName');
    });
  }

  QueryBuilder<TransferOffer, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<TransferOffer, int, QQueryOperations>
      expiresOnMatchdayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expiresOnMatchday');
    });
  }

  QueryBuilder<TransferOffer, bool, QQueryOperations> isForOurPlayerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isForOurPlayer');
    });
  }

  QueryBuilder<TransferOffer, int, QQueryOperations> loanMatchdaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loanMatchdays');
    });
  }

  QueryBuilder<TransferOffer, OfferType, QQueryOperations> offerTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'offerType');
    });
  }

  QueryBuilder<TransferOffer, int, QQueryOperations> playerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playerId');
    });
  }

  QueryBuilder<TransferOffer, OfferStatus, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }
}
