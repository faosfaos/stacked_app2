import 'package:flutter/widgets.dart';

import '../form_builder_field_option.dart';

/// An option for filter chips.
///
/// The type `T` is the type of the value the entry represents. All the entries
/// in a given menu must represent values with consistent types.
class OFormBuilderChipOption<T> extends OFormBuilderFieldOption<T> {
  /// The avatar to display in list of options.
  final Widget? avatar;

  /// Creates an option for fields with selection options
  const OFormBuilderChipOption({
    super.key,
    required super.value,
    this.avatar,
    super.child,
  });

  @override
  Widget build(BuildContext context) {
    return child ?? Text(value.toString());
  }
}
