// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_showcase_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MovieShowcaseStatus extends MovieShowcaseStatus {
  @override
  final List<MovieSummary> items;
  @override
  final bool isLoadingVisible;
  @override
  final String? errorMessage;

  factory _$MovieShowcaseStatus(
          [void Function(MovieShowcaseStatusBuilder)? updates]) =>
      (new MovieShowcaseStatusBuilder()..update(updates))._build();

  _$MovieShowcaseStatus._(
      {required this.items, required this.isLoadingVisible, this.errorMessage})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        items, r'MovieShowcaseStatus', 'items');
    BuiltValueNullFieldError.checkNotNull(
        isLoadingVisible, r'MovieShowcaseStatus', 'isLoadingVisible');
  }

  @override
  MovieShowcaseStatus rebuild(
          void Function(MovieShowcaseStatusBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MovieShowcaseStatusBuilder toBuilder() =>
      new MovieShowcaseStatusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MovieShowcaseStatus &&
        items == other.items &&
        isLoadingVisible == other.isLoadingVisible &&
        errorMessage == other.errorMessage;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, isLoadingVisible.hashCode);
    _$hash = $jc(_$hash, errorMessage.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MovieShowcaseStatus')
          ..add('items', items)
          ..add('isLoadingVisible', isLoadingVisible)
          ..add('errorMessage', errorMessage))
        .toString();
  }
}

class MovieShowcaseStatusBuilder
    implements Builder<MovieShowcaseStatus, MovieShowcaseStatusBuilder> {
  _$MovieShowcaseStatus? _$v;

  List<MovieSummary>? _items;
  List<MovieSummary>? get items => _$this._items;
  set items(List<MovieSummary>? items) => _$this._items = items;

  bool? _isLoadingVisible;
  bool? get isLoadingVisible => _$this._isLoadingVisible;
  set isLoadingVisible(bool? isLoadingVisible) =>
      _$this._isLoadingVisible = isLoadingVisible;

  String? _errorMessage;
  String? get errorMessage => _$this._errorMessage;
  set errorMessage(String? errorMessage) => _$this._errorMessage = errorMessage;

  MovieShowcaseStatusBuilder();

  MovieShowcaseStatusBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items;
      _isLoadingVisible = $v.isLoadingVisible;
      _errorMessage = $v.errorMessage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MovieShowcaseStatus other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MovieShowcaseStatus;
  }

  @override
  void update(void Function(MovieShowcaseStatusBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MovieShowcaseStatus build() => _build();

  _$MovieShowcaseStatus _build() {
    final _$result = _$v ??
        new _$MovieShowcaseStatus._(
            items: BuiltValueNullFieldError.checkNotNull(
                items, r'MovieShowcaseStatus', 'items'),
            isLoadingVisible: BuiltValueNullFieldError.checkNotNull(
                isLoadingVisible, r'MovieShowcaseStatus', 'isLoadingVisible'),
            errorMessage: errorMessage);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
