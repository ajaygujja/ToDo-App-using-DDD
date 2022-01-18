import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ddd/domain/core/errors.dart';
import 'package:flutter_ddd/domain/core/failures.dart';
import 'package:uuid/uuid.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<ValueFailure<T>, T> get value;

  bool isValid() => value.isRight();

  T getOrCrash() {
    return value.fold((f) => throw UnexpectedValueError(f), id);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ValueObject<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}

class UniqueId extends ValueObject<String> {
  const UniqueId._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;

  factory UniqueId() {
    return UniqueId._(
      right(const Uuid().v1())
        );
  }

  factory UniqueId.fromUniqueString(String? uniqueId) {
    assert(uniqueId != null,"uniqueId can't be null");
    return UniqueId._(
      right(uniqueId!),
    );
  }
}
