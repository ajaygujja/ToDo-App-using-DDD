import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ddd/application/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ddd/application/notes/note_actor/note_actor_bloc.dart';
import 'package:flutter_ddd/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:flutter_ddd/injection.dart';
import 'package:flutter_ddd/presentation/notes/note_overview/widgets/notes_overview_body.dart';
import 'package:flutter_ddd/presentation/notes/note_overview/widgets/uncompleted_switch.dart';
import 'package:flutter_ddd/presentation/routes/router.gr.dart';

class NoteOverviewPage extends StatelessWidget {
  const NoteOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AutoRouter.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteWatcherBloc>(
          create: (context) => getIt<NoteWatcherBloc>()
            ..add(
              const NoteWatcherEvent.watchAllStarted(),
            ),
        ),
        BlocProvider<NoteActorBloc>(
          create: (context) => getIt<NoteActorBloc>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.maybeMap(
                  orElse: () {},
                  unauthenticated: (_) =>
                      AutoRouter.of(context).push(const SignInRoute()));
            },
          ),
          BlocListener<NoteActorBloc, NoteActorState>(
            listener: (context, state) {
              state.maybeMap(
                  orElse: () {},
                  deleteFailure: (state) {
                    FlushbarHelper.createError(
                            duration: const Duration(seconds: 5),
                            message: state.noteFailure.map(
                                insufficientPermission: (_) =>
                                    'Insufficient permissions ❌',
                                unableToUpdate: (_) => 'Impossible error',
                                unexpected: (_) =>
                                    'Unexpected error occured while deleting, please contact support.'))
                        .show(context);
                  });
            },
            child: Container(),
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Notes'),
            leading: IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEvent.signedOut());
              },
              icon: const Icon(Icons.exit_to_app),
            ),
            actions: const [
              // IconButton(onPressed: () {}, icon: const Icon(Icons.check_box))
              UncompletedSwitch()
            ],
          ),
          body: const NoteOverviewBody(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
