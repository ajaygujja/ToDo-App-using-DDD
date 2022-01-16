// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_ddd/app/app.dart';
import 'package:flutter_ddd/bootstrap.dart';
import 'package:flutter_ddd/injection.dart';
import 'package:injectable/injectable.dart';

void main() {
  configureInjection(Environment.dev);
  bootstrap(() => const App());
}
