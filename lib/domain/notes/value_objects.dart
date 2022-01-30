// ignore_for_file: sort_unnamed_constructors_first, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ddd/domain/core/failures.dart';
import 'package:flutter_ddd/domain/core/value_object.dart';
import 'package:flutter_ddd/domain/core/value_transformer.dart';
import 'package:flutter_ddd/domain/core/value_validators.dart';
import 'package:kt_dart/collection.dart';

class NoteBody extends ValueObject<String> {
  factory NoteBody(String? input) {
    assert(input != null, "Value Can't be null");
    return NoteBody._(
      validateMaxStringLength(input!, maxLength)
          .flatMap(validateStringNotEmpty),
    );
  }

  const NoteBody._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 1000;
}

class TodoName extends ValueObject<String> {
  factory TodoName(String? input) {
    assert(input != null, "Value Can't be null");
    return TodoName._(
      validateMaxStringLength(input!, maxLength)
          .flatMap(validateStringNotEmpty)
          .flatMap(validateSingleLine),
    );
  }

  const TodoName._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 30;
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
  factory List3(KtList<T>? input) {
    assert(input != null, "Value Can't be null");
    return List3<T>._(
      validateMaxListLength(input!, maxLength),
    );
  }

  const List3._(this.value);
  @override
  final Either<ValueFailure<KtList<T>>, KtList<T>> value;

  static const maxLength = 3;

  int get length {
    return value.getOrElse(emptyList).size;
  }

  bool get isFull {
    return length == maxLength;
  }
}
