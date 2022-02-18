import 'package:flutter/material.dart';
import 'package:flutter_ddd/domain/notes/note_failure.dart';

class CriticalFailureDisplay extends StatelessWidget {
  const CriticalFailureDisplay({Key? key, required this.failure})
      : super(key: key);

  final NoteFailure failure;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          '😱',
          style: TextStyle(fontSize: 100),
        ),
        Text(
          failure.maybeMap(
            orElse: () => 'Unexpected error.\nPlease, contact support.',
            insufficientPermission: (_) => 'Insufficient permissions',
          ),
          style: const TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            debugPrint('Sending Email');
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.mail),
              SizedBox(width: 4),
              Text('I NEED HELP'),
            ],
          ),
        ),
      ],
    );
  }
}
