import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ddd/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:flutter_ddd/presentation/notes/note_overview/widgets/critical_failure_display.dart';
import 'package:flutter_ddd/presentation/notes/note_overview/widgets/error_note_card.dart';
import 'package:flutter_ddd/presentation/notes/note_overview/widgets/note_card_widget.dart';

class NoteOverviewBody extends StatelessWidget {
  const NoteOverviewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteWatcherBloc, NoteWatcherState>(
      builder: (context, state) {
        return state.map(
          initial: (_) => Container(),
          loadInProgress: (_) =>
              const Center(child: CircularProgressIndicator()),
          loadSuccess: (state) {
            return ListView.builder(
              itemCount: state.notes.size,
              itemBuilder: (context, index) {
                final notes = state.notes[index];
                if (notes.failureOption.isSome()) {
                  return ErrorNoteCard(
                    note: notes,
                  );
                } else {
                  return NoteCard(note: notes);
                }
              },
            );
          },
          loadFailure: (state) {
            return CriticalFailureDisplay(failure: state.noteFailure);
          },
        );
      },
    );
  }
}
