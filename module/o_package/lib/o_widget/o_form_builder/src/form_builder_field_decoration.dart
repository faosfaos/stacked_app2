import 'package:flutter/material.dart';

import 'form_builder_field.dart';

/// Extends [OFormBuilderField] and add a `decoration` (InputDecoration) property
///
/// This class override `decoration.enable` with [enable] value
class OFormBuilderFieldDecoration<T> extends OFormBuilderField<T> {
  OFormBuilderFieldDecoration({
    super.key,
    super.onSaved,
    super.initialValue,
    super.autovalidateMode,
    super.enabled = true,
    super.validator,
    super.restorationId,
    required super.name,
    super.valueTransformer,
    super.onChanged,
    super.onReset,
    super.focusNode,
    //super.errorBuilder,
    required super.builder,
    this.decoration = const InputDecoration(),
  }) : assert(
         decoration.enabled == enabled ||
             (enabled == false && decoration.enabled),
         '''decoration.enabled will be used instead of enabled FormBuilderField property.
            This will create conflicts and unexpected behaviors on focus, errorText, and other properties.
            Please, to enable or disable the field, use the enabled property of FormBuilderField.''',
       );
  final InputDecoration decoration;

  @override
  FormBuilderFieldDecorationState<OFormBuilderFieldDecoration<T>, T>
  createState() =>
      FormBuilderFieldDecorationState<OFormBuilderFieldDecoration<T>, T>();
}

class FormBuilderFieldDecorationState<
  F extends OFormBuilderFieldDecoration<T>,
  T
>
    extends FormBuilderFieldState<OFormBuilderField<T>, T> {
  @override
  F get widget => super.widget as F;

  /// Get the decoration with the current state
  InputDecoration get decoration {
    final String? efectiveErrorText = widget.enabled || readOnly
        ? widget.decoration.errorText ?? errorText
        : null;

    return widget.decoration.copyWith(
      errorText: efectiveErrorText,
      enabled: widget.decoration.enabled ? widget.enabled : false,
    );
  }

  @override
  bool get hasError => super.hasError || widget.decoration.errorText != null;

  @override
  bool get isValid => super.isValid && widget.decoration.errorText == null;
}
