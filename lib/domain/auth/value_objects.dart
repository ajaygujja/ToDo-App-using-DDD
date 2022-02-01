import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ddd/domain/core/failures.dart';
import 'package:flutter_ddd/domain/core/value_objects.dart';
import 'package:flutter_ddd/domain/core/value_validators.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
class EmailAddress extends ValueObject<String> {
  factory EmailAddress(String input) {
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }
  const EmailAddress._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

@immutable
class Password extends ValueObject<String> {
  factory Password(String input) {
    return Password._(
      validatePassword(input),
    );
  }
  const Password._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}
