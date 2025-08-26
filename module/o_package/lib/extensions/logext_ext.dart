import 'dart:developer' as devtools show log;

import 'package:flutter/widgets.dart';

extension LogExt on Object {
  void log() => devtools.log(toString());

  /// Nesnenin hash'ini kullanarak ValueKey döner
  ValueKey get toKey => ValueKey(hashCode);

  /// String tabanlı key (ID gibi)
  ValueKey toValueKey() => ValueKey(toString());

  /// Type + hash karışımı (çakışma azaltır)
  GlobalKey get toGlobalKey => GlobalKey(debugLabel: 'key_$hashCode');
}
