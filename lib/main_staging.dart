import 'package:flutter_ddd/bootstrap.dart';
import 'package:flutter_ddd/injection.dart';
import 'package:flutter_ddd/presentation/core/app_widget.dart';
import 'package:injectable/injectable.dart';

void main() {
  configureInjection(Environment.test);
  bootstrap(() => AppWidget());
}
