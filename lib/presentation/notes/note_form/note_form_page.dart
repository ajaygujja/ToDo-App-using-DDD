import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ddd/application/notes/note_form/note_form_bloc.dart';
import 'package:flutter_ddd/domain/notes/note.dart';
import 'package:flutter_ddd/injection.dart';
import 'package:flutter_ddd/presentation/notes/note_form/widgets/body_field_widget.dart';
import 'package:flutter_ddd/presentation/notes/note_form/widgets/color_field.dart';
import 'package:flutter_ddd/presentation/routes/router.gr.dart';

class NoteFormPage extends StatelessWidget {
  const NoteFormPage({Key? key, required this.editednote}) : super(key: key);

  final Note? editednote;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NoteFormBloc>()
        ..add(NoteFormEvent.initialized(optionOf(editednote))),
      child: BlocConsumer<NoteFormBloc, NoteFormState>(
        listenWhen: (previous, current) =>
            previous.saveFailureOrSuccessOption !=
            current.saveFailureOrSuccessOption,
        listener: (context, state) {
          state.saveFailureOrSuccessOption.fold(
            () {},
            (either) {
              either.fold((failure) {
                FlushbarHelper.createError(
                  message: failure.map(
                      insufficientPermission: (_) =>
                          'Insufficient permissions ❌',
                      unableToUpdate: (_) =>
                          "Couldn't update the note. Was it deleted from another device?",
                      unexpected: (_) =>
                          'Unexpected error occured, please contact support.'),
                ).show(context);
              }, (_) {
                AutoRouter.of(context).popUntil((route) =>
                    route.settings.name == const NoteOverviewRoute().routeName);
              });
            },
          );
        },
        buildWhen: (previous, current) => previous.isSaving != current.isSaving,
        builder: (context, state) {
          return Stack(
            children: [
              const NoteFormScaffold(),
              SavingInProgressOverlay(
                isSaving: state.isSaving,
              )
            ],
          );
        },
      ),
    );
  }
}

class SavingInProgressOverlay extends StatelessWidget {
  const SavingInProgressOverlay({
    Key? key,
    required this.isSaving,
  }) : super(key: key);

  final bool isSaving;
  @override
  Widget build(BuildContext context) {
    // final isSaving = true;
    return IgnorePointer(
      ignoring: !isSaving,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color:
                isSaving ? Colors.black.withOpacity(0.8) : Colors.transparent),
        child: Visibility(
          visible: isSaving,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Saving',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 16, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NoteFormScaffold extends StatelessWidget {
  const NoteFormScaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NoteFormBloc, NoteFormState>(
          buildWhen: (previous, current) =>
              previous.isEditing != current.isEditing,
          builder: (context, state) {
            return Text(state.isEditing ? 'Edit a Note' : 'Create a note');
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<NoteFormBloc>().add(const NoteFormEvent.saved());
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: BlocBuilder<NoteFormBloc, NoteFormState>(
        buildWhen: (previous, current) =>
            previous.showErrorMessage != current.showErrorMessage,
        builder: (context, state) {
          return Form(
              autovalidateMode: state.showErrorMessage,
              child: SingleChildScrollView(
                child: Column(
                  children: const [BodyField(), ColorField()],
                ),
              ));
        },
      ),
    );
  }
}
