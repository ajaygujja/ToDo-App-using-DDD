// ignore_for_file: unnecessary_null_comparison

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ddd/domain/core/failures.dart';
import 'package:flutter_ddd/domain/core/value_objects.dart';
import 'package:flutter_ddd/domain/core/value_transformer.dart';
import 'package:flutter_ddd/domain/core/value_validators.dart';
import 'package:kt_dart/kt.dart';

class NoteBody extends ValueObject<String> {
  const NoteBody._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 1000;

  factory NoteBody(String input) {
    assert(input != null, "Value Can't be null");
    return NoteBody._(
      validateMaxStringLength(input, maxLength).flatMap(validateStringNotEmpty),
    );
  }
}

class TodoName extends ValueObject<String> {
  const TodoName._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 30;

  factory TodoName(String? input) {
    assert(input != null, "Value Can't be null");
    return TodoName._(
      validateMaxStringLength(input!, maxLength)
          .flatMap(validateStringNotEmpty)
          .flatMap(validateSingleLine),
    );
  }
}

class NoteColor extends ValueObject<Color> {
  const NoteColor._(this.value);

  @override
  final Either<ValueFailure<Color>, Color> value;

  factory NoteColor(Color input) {
    assert(input != null, "Value Can't be null");
    return NoteColor._(
      right(makeColorOpaque(input)),
    );
  }

  static const List<Color> predefinedColors = [
    Color(0xfffafafa), // canvas
    Color(0xfffa8072), // salmon
    Color(0xfffedc56), // mustard
    Color(0xffd0f0c0), // tea
    Color(0xfffca3b7), // flamingo
    Color(0xff997950), // tortilla
    Color(0xfffffdd0), // cream
  ];
}

class List3<T> extends ValueObject<KtList<T>> {
  const List3._(this.value);

  @override
  final Either<ValueFailure<KtList<T>>, KtList<T>> value;

  static const maxLength = 3;

  factory List3(KtList<T> input) {
    return List3._(
      validateMaxListLength(input, maxLength),
    );
  }

  int get length {
    return value.getOrElse(emptyList).size;
  }

  bool get isFull {
    return length == maxLength;
  }
}
