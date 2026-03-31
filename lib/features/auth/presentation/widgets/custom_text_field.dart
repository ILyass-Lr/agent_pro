import 'package:flutter/material.dart';

class CustomTextField<TState, TField> extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.state,
    required this.field,
    required this.valueSelector,
    this.errorTextSelector,
    required this.onChanged,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.hideCounterForField,
    this.hideValidationIndicatorForField,
    this.helperText = "*requis",
    this.isPasswordField = false,
    this.maxLength,
  });

  final TState state;
  final TField field;
  final String Function(TState state, TField field) valueSelector;
  final String? Function(TState state, TField field)? errorTextSelector;
  final Function(String) onChanged;
  final String labelText;
  final String hintText;
  final Widget prefixIcon;
  final bool Function(TField field)? hideCounterForField;
  final bool Function(TField field)? hideValidationIndicatorForField;
  final bool isPasswordField;
  final int? maxLength;
  final String helperText;

  @override
  State<CustomTextField<TState, TField>> createState() => _CustomTextFieldState<TState, TField>();
}

class _CustomTextFieldState<TState, TField> extends State<CustomTextField<TState, TField>> {
  bool _obscureText = true;
  bool _isFocused = false;
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _valueFromState());
    _focusNode = FocusNode()
      ..addListener(() {
        if (mounted) {
          setState(() => _isFocused = _focusNode.hasFocus);
        }
      });
  }

  @override
  void didUpdateWidget(covariant CustomTextField<TState, TField> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_focusNode.hasFocus) {
      final nextValue = _valueFromState();
      if (_controller.text != nextValue) {
        _controller.text = nextValue;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String _valueFromState() {
    return widget.valueSelector(widget.state, widget.field);
  }

  bool _hideCounter() {
    return widget.hideCounterForField?.call(widget.field) ?? false;
  }

  bool _hideValidationIndicator() {
    return widget.hideValidationIndicatorForField?.call(widget.field) ?? false;
  }

  bool _hasValidationError() {
    final errorText = _errorText();
    return errorText != null && errorText.isNotEmpty;
  }

  bool _hasNoValidationError() {
    return !_hasValidationError();
  }

  String? _errorText() {
    return widget.errorTextSelector?.call(widget.state, widget.field);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    const Color white = Colors.white;
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      onChanged: widget.onChanged,
      obscureText: widget.isPasswordField ? _obscureText : false,
      style: textTheme.bodyMedium!.copyWith(color: white),
      maxLength: widget.maxLength,
      buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
        if (_hideCounter() || widget.maxLength == null) {
          return null;
        }
        return Text(
          '$currentLength/$maxLength',
          style: textTheme.bodySmall!.copyWith(color: white),
        );
      },

      decoration: InputDecoration(
        helperText: (_hasNoValidationError() && _isFocused) ? widget.helperText : "",
        helperStyle: textTheme.bodySmall!.copyWith(color: white),
        labelText: widget.labelText,
        labelStyle: textTheme.bodyLarge!.copyWith(color: white),
        hintText: widget.hintText,
        hintStyle: textTheme.bodyMedium!.copyWith(
          color: colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
        ),
        prefixIcon: widget.prefixIcon,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: colorScheme.outline)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.outline, width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber, width: 1),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber, width: 2),
        ),
        suffixIcon: widget.isPasswordField
            ? GestureDetector(
                onTap: () => setState(() => _obscureText = !_obscureText),
                child: Icon(
                  _obscureText ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
                  color: colorScheme.inversePrimary,
                ),
              )
            : (_hasValidationError() && !_hideValidationIndicator())
            ? const Icon(Icons.error_outline, color: Colors.amber)
            : null,

        errorText: _errorText(),
        errorStyle: textTheme.bodySmall!.copyWith(color: Colors.amber),
      ),
    );
  }
}
