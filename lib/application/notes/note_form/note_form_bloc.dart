import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ddd/domain/notes/i_note_repository.dart';
import 'package:flutter_ddd/domain/notes/note.dart';
import 'package:flutter_ddd/domain/notes/note_failure.dart';
import 'package:flutter_ddd/domain/notes/value_objects.dart';
import 'package:flutter_ddd/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

part 'note_form_event.dart';
part 'note_form_state.dart';
part 'note_form_bloc.freezed.dart';

@injectable
class NoteFormBloc extends Bloc<NoteFormEvent, NoteFormState> {
  NoteFormBloc(this._noteRepository) : super(NoteFormState.intial());

  final INoteRepository _noteRepository;

  @override
  Stream<NoteFormState> mapEventToState(NoteFormEvent event) async* {
    yield* event.map(
      initialized: (e) async* {
        yield e.initialNoteOption.fold(() => state,
            (intialNote) => state.copyWith(note: intialNote, isEditing: true));
      },
      bodyChanged: (e) async* {
        yield state.copyWith(
            note: state.note.copyWith(body: NoteBody(e.bodyStr)),
            saveFailureOrSuccessOption: none());
      },
      colorChanged: (e) async* {
        yield state.copyWith(
            note: state.note.copyWith(color: NoteColor(e.color)),
            saveFailureOrSuccessOption: none());
      },
      todosChanged: (e) async* {
        yield state.copyWith(
            note: state.note.copyWith(
              todos: List3(
                e.todos.map((primtive) => primtive.toDomain()),
              ),
            ),
            saveFailureOrSuccessOption: none());
      },
      saved: (e) async* {
        Either<NoteFailure, Unit>? failureOrSuccess;

        yield state.copyWith(
            isSaving: true, saveFailureOrSuccessOption: none());

        if (state.note.failureOption.isNone()) {
          failureOrSuccess = state.isEditing
              ? await _noteRepository.update(state.note)
              : await _noteRepository.create(state.note);
        }

        yield state.copyWith(
            isSaving: false,
            showErrorMessage: true,
            saveFailureOrSuccessOption: optionOf(failureOrSuccess));
      },
    );
  }
}
