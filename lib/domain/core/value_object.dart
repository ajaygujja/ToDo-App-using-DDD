import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ddd/domain/core/failures.dart';


@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<ValueFailure<T>, T> get value;

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


// @immutable
// class EmailAddress {
//   factory EmailAddress(String input) {
//     return EmailAddress._(
//       validateEmailAddress(input),
//     );
//   }
//   const EmailAddress._(
//     this.value,
//   );

//   final Either<ValueFailure<String>, String> value;

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is EmailAddress && other.value == value;
//   }

//   @override
//   int get hashCode => value.hashCode;

//   @override
//   String toString() => 'EmailAddress(value: $value)';
// }
