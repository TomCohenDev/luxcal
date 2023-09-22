// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<EventRecord> _$eventRecordSerializer = new _$EventRecordSerializer();

class _$EventRecordSerializer implements StructuredSerializer<EventRecord> {
  @override
  final Iterable<Type> types = const [EventRecord, _$EventRecord];
  @override
  final String wireName = 'EventRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, EventRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.startdate;
    if (value != null) {
      result
        ..add('startdate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.enddate;
    if (value != null) {
      result
        ..add('enddate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.starttime;
    if (value != null) {
      result
        ..add('starttime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.endtime;
    if (value != null) {
      result
        ..add('endtime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.color;
    if (value != null) {
      result
        ..add('color')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.created_date;
    if (value != null) {
      result
        ..add('created_date')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.imageUrl;
    if (value != null) {
      result
        ..add('imageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.location;
    if (value != null) {
      result
        ..add('location')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.event_creator;
    if (value != null) {
      result
        ..add('event_creator')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  EventRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EventRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'startdate':
          result.startdate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'enddate':
          result.enddate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'starttime':
          result.starttime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'endtime':
          result.endtime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'color':
          result.color = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'created_date':
          result.created_date = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'location':
          result.location = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'event_creator':
          result.event_creator = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$EventRecord extends EventRecord {
  @override
  final String? title;
  @override
  final DateTime? startdate;
  @override
  final DateTime? enddate;
  @override
  final DateTime? starttime;
  @override
  final DateTime? endtime;
  @override
  final String? color;
  @override
  final DateTime? created_date;
  @override
  final String? imageUrl;
  @override
  final String? location;
  @override
  final String? description;
  @override
  final String? event_creator;

  factory _$EventRecord([void Function(EventRecordBuilder)? updates]) =>
      (new EventRecordBuilder()..update(updates))._build();

  _$EventRecord._(
      {this.title,
      this.startdate,
      this.enddate,
      this.starttime,
      this.endtime,
      this.color,
      this.created_date,
      this.imageUrl,
      this.location,
      this.description,
      this.event_creator})
      : super._();

  @override
  EventRecord rebuild(void Function(EventRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EventRecordBuilder toBuilder() => new EventRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EventRecord &&
        title == other.title &&
        startdate == other.startdate &&
        enddate == other.enddate &&
        starttime == other.starttime &&
        endtime == other.endtime &&
        color == other.color &&
        created_date == other.created_date &&
        imageUrl == other.imageUrl &&
        location == other.location &&
        description == other.description &&
        event_creator == other.event_creator;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, startdate.hashCode);
    _$hash = $jc(_$hash, enddate.hashCode);
    _$hash = $jc(_$hash, starttime.hashCode);
    _$hash = $jc(_$hash, endtime.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, created_date.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, event_creator.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EventRecord')
          ..add('title', title)
          ..add('startdate', startdate)
          ..add('enddate', enddate)
          ..add('starttime', starttime)
          ..add('endtime', endtime)
          ..add('color', color)
          ..add('created_date', created_date)
          ..add('imageUrl', imageUrl)
          ..add('location', location)
          ..add('description', description)
          ..add('event_creator', event_creator))
        .toString();
  }
}

class EventRecordBuilder implements Builder<EventRecord, EventRecordBuilder> {
  _$EventRecord? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  DateTime? _startdate;
  DateTime? get startdate => _$this._startdate;
  set startdate(DateTime? startdate) => _$this._startdate = startdate;

  DateTime? _enddate;
  DateTime? get enddate => _$this._enddate;
  set enddate(DateTime? enddate) => _$this._enddate = enddate;

  DateTime? _starttime;
  DateTime? get starttime => _$this._starttime;
  set starttime(DateTime? starttime) => _$this._starttime = starttime;

  DateTime? _endtime;
  DateTime? get endtime => _$this._endtime;
  set endtime(DateTime? endtime) => _$this._endtime = endtime;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  DateTime? _created_date;
  DateTime? get created_date => _$this._created_date;
  set created_date(DateTime? created_date) =>
      _$this._created_date = created_date;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  String? _location;
  String? get location => _$this._location;
  set location(String? location) => _$this._location = location;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _event_creator;
  String? get event_creator => _$this._event_creator;
  set event_creator(String? event_creator) =>
      _$this._event_creator = event_creator;

  EventRecordBuilder();

  EventRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _startdate = $v.startdate;
      _enddate = $v.enddate;
      _starttime = $v.starttime;
      _endtime = $v.endtime;
      _color = $v.color;
      _created_date = $v.created_date;
      _imageUrl = $v.imageUrl;
      _location = $v.location;
      _description = $v.description;
      _event_creator = $v.event_creator;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EventRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$EventRecord;
  }

  @override
  void update(void Function(EventRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EventRecord build() => _build();

  _$EventRecord _build() {
    final _$result = _$v ??
        new _$EventRecord._(
            title: title,
            startdate: startdate,
            enddate: enddate,
            starttime: starttime,
            endtime: endtime,
            color: color,
            created_date: created_date,
            imageUrl: imageUrl,
            location: location,
            description: description,
            event_creator: event_creator);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
