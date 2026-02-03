// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCardModelCollection on Isar {
  IsarCollection<CardModel> get cardModels => this.collection();
}

const CardModelSchema = CollectionSchema(
  name: r'CardModel',
  id: -4511307714291515206,
  properties: {
    r'backLanguage': PropertySchema(
      id: 0,
      name: r'backLanguage',
      type: IsarType.string,
    ),
    r'definition': PropertySchema(
      id: 1,
      name: r'definition',
      type: IsarType.string,
    ),
    r'easinessFactor': PropertySchema(
      id: 2,
      name: r'easinessFactor',
      type: IsarType.double,
    ),
    r'frontLanguage': PropertySchema(
      id: 3,
      name: r'frontLanguage',
      type: IsarType.string,
    ),
    r'interval': PropertySchema(id: 4, name: r'interval', type: IsarType.long),
    r'isAutoPlayEnabled': PropertySchema(
      id: 5,
      name: r'isAutoPlayEnabled',
      type: IsarType.bool,
    ),
    r'isDirty': PropertySchema(id: 6, name: r'isDirty', type: IsarType.bool),
    r'mnemonic': PropertySchema(
      id: 7,
      name: r'mnemonic',
      type: IsarType.string,
    ),
    r'nextReview': PropertySchema(
      id: 8,
      name: r'nextReview',
      type: IsarType.dateTime,
    ),
    r'remoteId': PropertySchema(
      id: 9,
      name: r'remoteId',
      type: IsarType.string,
    ),
    r'repetition': PropertySchema(
      id: 10,
      name: r'repetition',
      type: IsarType.long,
    ),
    r'status': PropertySchema(id: 11, name: r'status', type: IsarType.string),
    r'term': PropertySchema(id: 12, name: r'term', type: IsarType.string),
    r'updatedAt': PropertySchema(
      id: 13,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
  },

  estimateSize: _cardModelEstimateSize,
  serialize: _cardModelSerialize,
  deserialize: _cardModelDeserialize,
  deserializeProp: _cardModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'remoteId': IndexSchema(
      id: 6301175856541681032,
      name: r'remoteId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'remoteId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'term': IndexSchema(
      id: 5114652110782333408,
      name: r'term',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'term',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'definition': IndexSchema(
      id: 4762223356158710129,
      name: r'definition',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'definition',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'nextReview': IndexSchema(
      id: 316564737852968787,
      name: r'nextReview',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'nextReview',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {
    r'deck': LinkSchema(
      id: 3909043560198174787,
      name: r'deck',
      target: r'DeckModel',
      single: true,
    ),
  },
  embeddedSchemas: {},

  getId: _cardModelGetId,
  getLinks: _cardModelGetLinks,
  attach: _cardModelAttach,
  version: '3.3.0',
);

int _cardModelEstimateSize(
  CardModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.backLanguage.length * 3;
  bytesCount += 3 + object.definition.length * 3;
  bytesCount += 3 + object.frontLanguage.length * 3;
  {
    final value = object.mnemonic;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.remoteId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.status.length * 3;
  bytesCount += 3 + object.term.length * 3;
  return bytesCount;
}

void _cardModelSerialize(
  CardModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.backLanguage);
  writer.writeString(offsets[1], object.definition);
  writer.writeDouble(offsets[2], object.easinessFactor);
  writer.writeString(offsets[3], object.frontLanguage);
  writer.writeLong(offsets[4], object.interval);
  writer.writeBool(offsets[5], object.isAutoPlayEnabled);
  writer.writeBool(offsets[6], object.isDirty);
  writer.writeString(offsets[7], object.mnemonic);
  writer.writeDateTime(offsets[8], object.nextReview);
  writer.writeString(offsets[9], object.remoteId);
  writer.writeLong(offsets[10], object.repetition);
  writer.writeString(offsets[11], object.status);
  writer.writeString(offsets[12], object.term);
  writer.writeDateTime(offsets[13], object.updatedAt);
}

CardModel _cardModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CardModel();
  object.backLanguage = reader.readString(offsets[0]);
  object.definition = reader.readString(offsets[1]);
  object.easinessFactor = reader.readDouble(offsets[2]);
  object.frontLanguage = reader.readString(offsets[3]);
  object.id = id;
  object.interval = reader.readLong(offsets[4]);
  object.isAutoPlayEnabled = reader.readBool(offsets[5]);
  object.isDirty = reader.readBool(offsets[6]);
  object.mnemonic = reader.readStringOrNull(offsets[7]);
  object.nextReview = reader.readDateTime(offsets[8]);
  object.remoteId = reader.readStringOrNull(offsets[9]);
  object.repetition = reader.readLong(offsets[10]);
  object.status = reader.readString(offsets[11]);
  object.term = reader.readString(offsets[12]);
  object.updatedAt = reader.readDateTime(offsets[13]);
  return object;
}

P _cardModelDeserializeProp<P>(
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
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cardModelGetId(CardModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cardModelGetLinks(CardModel object) {
  return [object.deck];
}

void _cardModelAttach(IsarCollection<dynamic> col, Id id, CardModel object) {
  object.id = id;
  object.deck.attach(col, col.isar.collection<DeckModel>(), r'deck', id);
}

extension CardModelQueryWhereSort
    on QueryBuilder<CardModel, CardModel, QWhere> {
  QueryBuilder<CardModel, CardModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhere> anyTerm() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'term'),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhere> anyDefinition() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'definition'),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhere> anyNextReview() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'nextReview'),
      );
    });
  }
}

extension CardModelQueryWhere
    on QueryBuilder<CardModel, CardModel, QWhereClause> {
  QueryBuilder<CardModel, CardModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> remoteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'remoteId', value: [null]),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> remoteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'remoteId',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> remoteIdEqualTo(
    String? remoteId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'remoteId', value: [remoteId]),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> remoteIdNotEqualTo(
    String? remoteId,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'remoteId',
                lower: [],
                upper: [remoteId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'remoteId',
                lower: [remoteId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'remoteId',
                lower: [remoteId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'remoteId',
                lower: [],
                upper: [remoteId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> termEqualTo(
    String term,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'term', value: [term]),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> termNotEqualTo(
    String term,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'term',
                lower: [],
                upper: [term],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'term',
                lower: [term],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'term',
                lower: [term],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'term',
                lower: [],
                upper: [term],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> termGreaterThan(
    String term, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'term',
          lower: [term],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> termLessThan(
    String term, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'term',
          lower: [],
          upper: [term],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> termBetween(
    String lowerTerm,
    String upperTerm, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'term',
          lower: [lowerTerm],
          includeLower: includeLower,
          upper: [upperTerm],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> termStartsWith(
    String TermPrefix,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'term',
          lower: [TermPrefix],
          upper: ['$TermPrefix\u{FFFFF}'],
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> termIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'term', value: ['']),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> termIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'term', upper: ['']),
            )
            .addWhereClause(
              IndexWhereClause.greaterThan(indexName: r'term', lower: ['']),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.greaterThan(indexName: r'term', lower: ['']),
            )
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'term', upper: ['']),
            );
      }
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> definitionEqualTo(
    String definition,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'definition', value: [definition]),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> definitionNotEqualTo(
    String definition,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'definition',
                lower: [],
                upper: [definition],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'definition',
                lower: [definition],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'definition',
                lower: [definition],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'definition',
                lower: [],
                upper: [definition],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> definitionGreaterThan(
    String definition, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'definition',
          lower: [definition],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> definitionLessThan(
    String definition, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'definition',
          lower: [],
          upper: [definition],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> definitionBetween(
    String lowerDefinition,
    String upperDefinition, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'definition',
          lower: [lowerDefinition],
          includeLower: includeLower,
          upper: [upperDefinition],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> definitionStartsWith(
    String DefinitionPrefix,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'definition',
          lower: [DefinitionPrefix],
          upper: ['$DefinitionPrefix\u{FFFFF}'],
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> definitionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'definition', value: ['']),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> definitionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'definition', upper: ['']),
            )
            .addWhereClause(
              IndexWhereClause.greaterThan(
                indexName: r'definition',
                lower: [''],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.greaterThan(
                indexName: r'definition',
                lower: [''],
              ),
            )
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'definition', upper: ['']),
            );
      }
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> nextReviewEqualTo(
    DateTime nextReview,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'nextReview', value: [nextReview]),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> nextReviewNotEqualTo(
    DateTime nextReview,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'nextReview',
                lower: [],
                upper: [nextReview],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'nextReview',
                lower: [nextReview],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'nextReview',
                lower: [nextReview],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'nextReview',
                lower: [],
                upper: [nextReview],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> nextReviewGreaterThan(
    DateTime nextReview, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'nextReview',
          lower: [nextReview],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> nextReviewLessThan(
    DateTime nextReview, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'nextReview',
          lower: [],
          upper: [nextReview],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterWhereClause> nextReviewBetween(
    DateTime lowerNextReview,
    DateTime upperNextReview, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'nextReview',
          lower: [lowerNextReview],
          includeLower: includeLower,
          upper: [upperNextReview],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension CardModelQueryFilter
    on QueryBuilder<CardModel, CardModel, QFilterCondition> {
  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> backLanguageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'backLanguage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  backLanguageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'backLanguage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  backLanguageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'backLanguage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> backLanguageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'backLanguage',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  backLanguageStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'backLanguage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  backLanguageEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'backLanguage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  backLanguageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'backLanguage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> backLanguageMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'backLanguage',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  backLanguageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'backLanguage', value: ''),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  backLanguageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'backLanguage', value: ''),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> definitionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'definition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  definitionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'definition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> definitionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'definition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> definitionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'definition',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  definitionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'definition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> definitionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'definition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> definitionContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'definition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> definitionMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'definition',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  definitionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'definition', value: ''),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  definitionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'definition', value: ''),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  easinessFactorEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'easinessFactor',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  easinessFactorGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'easinessFactor',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  easinessFactorLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'easinessFactor',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  easinessFactorBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'easinessFactor',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  frontLanguageEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'frontLanguage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  frontLanguageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'frontLanguage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  frontLanguageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'frontLanguage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  frontLanguageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'frontLanguage',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  frontLanguageStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'frontLanguage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  frontLanguageEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'frontLanguage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  frontLanguageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'frontLanguage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  frontLanguageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'frontLanguage',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  frontLanguageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'frontLanguage', value: ''),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  frontLanguageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'frontLanguage', value: ''),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> intervalEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'interval', value: value),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> intervalGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'interval',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> intervalLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'interval',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> intervalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'interval',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  isAutoPlayEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isAutoPlayEnabled', value: value),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> isDirtyEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isDirty', value: value),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> mnemonicIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'mnemonic'),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  mnemonicIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'mnemonic'),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> mnemonicEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'mnemonic',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> mnemonicGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'mnemonic',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> mnemonicLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'mnemonic',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> mnemonicBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'mnemonic',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> mnemonicStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'mnemonic',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> mnemonicEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'mnemonic',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> mnemonicContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'mnemonic',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> mnemonicMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'mnemonic',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> mnemonicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'mnemonic', value: ''),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  mnemonicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'mnemonic', value: ''),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> nextReviewEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'nextReview', value: value),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  nextReviewGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'nextReview',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> nextReviewLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'nextReview',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> nextReviewBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'nextReview',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> remoteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'remoteId'),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  remoteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'remoteId'),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> remoteIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> remoteIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> remoteIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> remoteIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'remoteId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> remoteIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> remoteIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> remoteIdContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> remoteIdMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'remoteId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> remoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'remoteId', value: ''),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  remoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'remoteId', value: ''),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> repetitionEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'repetition', value: value),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  repetitionGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'repetition',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> repetitionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'repetition',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> repetitionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'repetition',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'status',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> statusContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> statusMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'status',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> termEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'term',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> termGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'term',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> termLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'term',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> termBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'term',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> termStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'term',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> termEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'term',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> termContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'term',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> termMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'term',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> termIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'term', value: ''),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> termIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'term', value: ''),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> updatedAtEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition>
  updatedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'updatedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension CardModelQueryObject
    on QueryBuilder<CardModel, CardModel, QFilterCondition> {}

extension CardModelQueryLinks
    on QueryBuilder<CardModel, CardModel, QFilterCondition> {
  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> deck(
    FilterQuery<DeckModel> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'deck');
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterFilterCondition> deckIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'deck', 0, true, 0, true);
    });
  }
}

extension CardModelQuerySortBy on QueryBuilder<CardModel, CardModel, QSortBy> {
  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByBackLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backLanguage', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByBackLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backLanguage', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByDefinition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'definition', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByDefinitionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'definition', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByEasinessFactor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'easinessFactor', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByEasinessFactorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'easinessFactor', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByFrontLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frontLanguage', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByFrontLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frontLanguage', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interval', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByIntervalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interval', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByIsAutoPlayEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAutoPlayEnabled', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy>
  sortByIsAutoPlayEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAutoPlayEnabled', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByIsDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirty', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByIsDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirty', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByMnemonic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mnemonic', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByMnemonicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mnemonic', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByNextReview() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextReview', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByNextReviewDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextReview', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByRepetition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repetition', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByRepetitionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repetition', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByTerm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'term', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByTermDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'term', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension CardModelQuerySortThenBy
    on QueryBuilder<CardModel, CardModel, QSortThenBy> {
  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByBackLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backLanguage', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByBackLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backLanguage', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByDefinition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'definition', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByDefinitionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'definition', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByEasinessFactor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'easinessFactor', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByEasinessFactorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'easinessFactor', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByFrontLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frontLanguage', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByFrontLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frontLanguage', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interval', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByIntervalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interval', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByIsAutoPlayEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAutoPlayEnabled', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy>
  thenByIsAutoPlayEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAutoPlayEnabled', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByIsDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirty', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByIsDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDirty', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByMnemonic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mnemonic', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByMnemonicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mnemonic', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByNextReview() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextReview', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByNextReviewDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextReview', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByRepetition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repetition', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByRepetitionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repetition', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByTerm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'term', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByTermDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'term', Sort.desc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CardModel, CardModel, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension CardModelQueryWhereDistinct
    on QueryBuilder<CardModel, CardModel, QDistinct> {
  QueryBuilder<CardModel, CardModel, QDistinct> distinctByBackLanguage({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'backLanguage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CardModel, CardModel, QDistinct> distinctByDefinition({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'definition', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CardModel, CardModel, QDistinct> distinctByEasinessFactor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'easinessFactor');
    });
  }

  QueryBuilder<CardModel, CardModel, QDistinct> distinctByFrontLanguage({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'frontLanguage',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<CardModel, CardModel, QDistinct> distinctByInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'interval');
    });
  }

  QueryBuilder<CardModel, CardModel, QDistinct> distinctByIsAutoPlayEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isAutoPlayEnabled');
    });
  }

  QueryBuilder<CardModel, CardModel, QDistinct> distinctByIsDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDirty');
    });
  }

  QueryBuilder<CardModel, CardModel, QDistinct> distinctByMnemonic({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mnemonic', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CardModel, CardModel, QDistinct> distinctByNextReview() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextReview');
    });
  }

  QueryBuilder<CardModel, CardModel, QDistinct> distinctByRemoteId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CardModel, CardModel, QDistinct> distinctByRepetition() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repetition');
    });
  }

  QueryBuilder<CardModel, CardModel, QDistinct> distinctByStatus({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CardModel, CardModel, QDistinct> distinctByTerm({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'term', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CardModel, CardModel, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension CardModelQueryProperty
    on QueryBuilder<CardModel, CardModel, QQueryProperty> {
  QueryBuilder<CardModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CardModel, String, QQueryOperations> backLanguageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'backLanguage');
    });
  }

  QueryBuilder<CardModel, String, QQueryOperations> definitionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'definition');
    });
  }

  QueryBuilder<CardModel, double, QQueryOperations> easinessFactorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'easinessFactor');
    });
  }

  QueryBuilder<CardModel, String, QQueryOperations> frontLanguageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frontLanguage');
    });
  }

  QueryBuilder<CardModel, int, QQueryOperations> intervalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'interval');
    });
  }

  QueryBuilder<CardModel, bool, QQueryOperations> isAutoPlayEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isAutoPlayEnabled');
    });
  }

  QueryBuilder<CardModel, bool, QQueryOperations> isDirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDirty');
    });
  }

  QueryBuilder<CardModel, String?, QQueryOperations> mnemonicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mnemonic');
    });
  }

  QueryBuilder<CardModel, DateTime, QQueryOperations> nextReviewProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextReview');
    });
  }

  QueryBuilder<CardModel, String?, QQueryOperations> remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteId');
    });
  }

  QueryBuilder<CardModel, int, QQueryOperations> repetitionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repetition');
    });
  }

  QueryBuilder<CardModel, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<CardModel, String, QQueryOperations> termProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'term');
    });
  }

  QueryBuilder<CardModel, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
