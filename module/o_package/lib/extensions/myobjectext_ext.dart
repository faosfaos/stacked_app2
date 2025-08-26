import '../o_extensions_class/o_text.dart';

extension MyObjectExt on Object {
  OText get oText => OText(toString());
}
