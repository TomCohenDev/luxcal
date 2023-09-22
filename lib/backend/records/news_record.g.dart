// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<NewsRecord> _$newsRecordSerializer = new _$NewsRecordSerializer();

class _$NewsRecordSerializer implements StructuredSerializer<NewsRecord> {
  @override
  final Iterable<Type> types = const [NewsRecord, _$NewsRecord];
  @override
  final String wireName = 'NewsRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, NewsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.headline;
    if (value != null) {
      result
        ..add('headline')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.publishedDate;
    if (value != null) {
      result
        ..add('publishedDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.author;
    if (value != null) {
      result
        ..add('author')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.content;
    if (value != null) {
      result
        ..add('content')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  NewsRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NewsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'headline':
          result.headline = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'publishedDate':
          result.publishedDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'author':
          result.author = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$NewsRecord extends NewsRecord {
  @override
  final String? headline;
  @override
  final DateTime? publishedDate;
  @override
  final String? author;
  @override
  final String? content;

  factory _$NewsRecord([void Function(NewsRecordBuilder)? updates]) =>
      (new NewsRecordBuilder()..update(updates))._build();

  _$NewsRecord._({this.headline, this.publishedDate, this.author, this.content})
      : super._();

  @override
  NewsRecord rebuild(void Function(NewsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NewsRecordBuilder toBuilder() => new NewsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NewsRecord &&
        headline == other.headline &&
        publishedDate == other.publishedDate &&
        author == other.author &&
        content == other.content;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, headline.hashCode);
    _$hash = $jc(_$hash, publishedDate.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NewsRecord')
          ..add('headline', headline)
          ..add('publishedDate', publishedDate)
          ..add('author', author)
          ..add('content', content))
        .toString();
  }
}

class NewsRecordBuilder implements Builder<NewsRecord, NewsRecordBuilder> {
  _$NewsRecord? _$v;

  String? _headline;
  String? get headline => _$this._headline;
  set headline(String? headline) => _$this._headline = headline;

  DateTime? _publishedDate;
  DateTime? get publishedDate => _$this._publishedDate;
  set publishedDate(DateTime? publishedDate) =>
      _$this._publishedDate = publishedDate;

  String? _author;
  String? get author => _$this._author;
  set author(String? author) => _$this._author = author;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  NewsRecordBuilder();

  NewsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _headline = $v.headline;
      _publishedDate = $v.publishedDate;
      _author = $v.author;
      _content = $v.content;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NewsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NewsRecord;
  }

  @override
  void update(void Function(NewsRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NewsRecord build() => _build();

  _$NewsRecord _build() {
    final _$result = _$v ??
        new _$NewsRecord._(
            headline: headline,
            publishedDate: publishedDate,
            author: author,
            content: content);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
