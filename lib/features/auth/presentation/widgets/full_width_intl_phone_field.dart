import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/helpers.dart';
import 'package:intl_phone_field/phone_number.dart';

class FullWidthIntlPhoneField extends StatefulWidget {
  /// Whether to hide the text being edited (e.g., for passwords).
  final bool obscureText;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// How the text should be aligned vertically.
  final TextAlignVertical? textAlignVertical;
  final VoidCallback? onTap;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;
  final FormFieldSetter<PhoneNumber>? onSaved;

  /// {@macro flutter.widgets.editableText.onChanged}
  final ValueChanged<PhoneNumber>? onChanged;

  final ValueChanged<Country>? onCountryChanged;

  /// An optional method that validates an input. Returns an error string to display if the input is invalid, or null otherwise.
  final FutureOr<String?> Function(PhoneNumber?)? validator;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType keyboardType;

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// Defines the keyboard focus for this widget.
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  final void Function(String)? onSubmitted;

  /// If false the widget is "disabled".
  final bool enabled;

  /// The appearance of the keyboard.
  final Brightness? keyboardAppearance;

  /// Initial Value for the field.
  final String? initialValue;

  final String languageCode;

  /// 2 letter ISO Code or country dial code.
  final String? initialCountryCode;

  /// List of Country to display see countries.dart for format
  final List<Country>? countries;

  /// The decoration to show around the text field.
  final InputDecoration decoration;

  /// The style to use for the text being edited.
  final TextStyle? style;

  /// Disable view Min/Max Length check
  final bool disableLengthCheck;

  /// Won't work if [enabled] is set to `false`.
  final bool showDropdownIcon;

  final BoxDecoration dropdownDecoration;

  /// The style use for the country dial code.
  final TextStyle? dropdownTextStyle;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// The text that describes the search input field.
  final String searchText;

  /// Position of an icon [leading, trailing]
  final IconPosition dropdownIconPosition;

  /// Icon of the drop down button.
  final Icon dropdownIcon;

  /// Whether this text field should focus itself if nothing else is already focused.
  final bool autofocus;

  /// Autovalidate mode for text form field.
  final AutovalidateMode? autovalidateMode;

  /// Whether to show or hide country flag.
  final bool showCountryFlag;

  /// Message to be displayed on autoValidate error
  final String? invalidNumberMessage;

  /// The color of the cursor.
  final Color? cursorColor;

  /// How tall the cursor will be.
  final double? cursorHeight;

  /// How rounded the corners of the cursor should be.
  final Radius? cursorRadius;

  /// How thick the cursor will be.
  final double cursorWidth;

  /// Whether to show cursor.
  final bool? showCursor;

  /// The padding of the Flags Button.
  final EdgeInsetsGeometry flagsButtonPadding;

  /// The type of action button to use for the keyboard.
  final TextInputAction? textInputAction;

  /// Optional set of styles to allow for customizing the country search & pick dialog
  final PickerDialogStyle? pickerDialogStyle;

  /// The margin of the country selector button.
  final EdgeInsets flagsButtonMargin;

  /// Enable the autofill hint for phone number.
  final bool disableAutoFillHints;

  const FullWidthIntlPhoneField({
    super.key,
    this.initialCountryCode,
    this.languageCode = 'en',
    this.disableAutoFillHints = false,
    this.obscureText = false,
    this.textAlign = TextAlign.left,
    this.textAlignVertical,
    this.onTap,
    this.readOnly = false,
    this.initialValue,
    this.keyboardType = TextInputType.phone,
    this.controller,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.style,
    this.dropdownTextStyle,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.countries,
    this.onCountryChanged,
    this.onSaved,
    this.showDropdownIcon = true,
    this.dropdownDecoration = const BoxDecoration(),
    this.inputFormatters,
    this.enabled = true,
    this.keyboardAppearance,
    @Deprecated('Use searchFieldInputDecoration of PickerDialogStyle instead')
    this.searchText = 'Cherchez le code pays',
    this.dropdownIconPosition = IconPosition.leading,
    this.dropdownIcon = const Icon(Icons.arrow_drop_down, color: Colors.white),
    this.autofocus = false,
    this.textInputAction,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.showCountryFlag = true,
    this.cursorColor,
    this.disableLengthCheck = false,
    this.flagsButtonPadding = const EdgeInsets.only(left: 8),
    this.invalidNumberMessage = 'Invalid Mobile Number',
    this.cursorHeight,
    this.cursorRadius = Radius.zero,
    this.cursorWidth = 2.0,
    this.showCursor = true,
    this.pickerDialogStyle,
    this.flagsButtonMargin = EdgeInsets.zero,
  });

  @override
  State<FullWidthIntlPhoneField> createState() => _FullWidthIntlPhoneFieldState();
}

class _FullWidthIntlPhoneFieldState extends State<FullWidthIntlPhoneField> {
  late List<Country> _countryList;
  late Country _selectedCountry;
  late String number;

  String? validatorMessage;

  @override
  void initState() {
    super.initState();
    _countryList = widget.countries ?? countries;
    number = widget.initialValue ?? '';
    if (widget.initialCountryCode == null && number.startsWith('+')) {
      number = number.substring(1);
      _selectedCountry = countries.firstWhere(
        (country) => number.startsWith(country.fullCountryCode),
        orElse: () => _countryList.first,
      );

      number = number.replaceFirst(RegExp("^${_selectedCountry.fullCountryCode}"), '');
    } else {
      _selectedCountry = _countryList.firstWhere(
        (item) => item.code == (widget.initialCountryCode ?? 'US'),
        orElse: () => _countryList.first,
      );

      if (number.startsWith('+')) {
        number = number.replaceFirst(RegExp("^\\+${_selectedCountry.fullCountryCode}"), '');
      } else {
        number = number.replaceFirst(RegExp("^${_selectedCountry.fullCountryCode}"), '');
      }
    }

    if (widget.autovalidateMode == AutovalidateMode.always) {
      final initialPhoneNumber = PhoneNumber(
        countryISOCode: _selectedCountry.code,
        countryCode: '+${_selectedCountry.dialCode}',
        number: widget.initialValue ?? '',
      );

      final value = widget.validator?.call(initialPhoneNumber);

      if (value is String) {
        validatorMessage = value;
      } else {
        (value as Future).then((msg) {
          validatorMessage = msg;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _openCountrySearchView() async {
    final Country? selectedCountry = await Navigator.of(context, rootNavigator: true).push<Country>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => _CountrySearchViewPage(
          countryList: _countryList,
          selectedCountry: _selectedCountry,
          languageCode: widget.languageCode.toLowerCase(),
          searchText: widget.searchText,
        ),
      ),
    );

    if (selectedCountry != null) {
      _selectedCountry = selectedCountry;
      widget.onCountryChanged?.call(selectedCountry);
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: (widget.controller == null) ? number : null,
      autofillHints: widget.disableAutoFillHints ? null : [AutofillHints.telephoneNumberNational],
      readOnly: widget.readOnly,
      obscureText: widget.obscureText,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      cursorColor: widget.cursorColor,
      onTap: widget.onTap,
      controller: widget.controller,
      focusNode: widget.focusNode,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorWidth: widget.cursorWidth,
      showCursor: widget.showCursor,
      onFieldSubmitted: widget.onSubmitted,
      decoration: widget.decoration.copyWith(
        prefixIcon: _buildFlagsButton(),
        counterText: !widget.enabled ? '' : null,
        focusedBorder:
            widget.decoration.focusedBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2),
            ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber, width: 1),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber, width: 2),
        ),
      ),
      style: widget.style,
      onSaved: (value) {
        widget.onSaved?.call(
          PhoneNumber(
            countryISOCode: _selectedCountry.code,
            countryCode: '+${_selectedCountry.dialCode}${_selectedCountry.regionCode}',
            number: value ?? '',
          ),
        );
      },
      onChanged: (value) async {
        final phoneNumber = PhoneNumber(
          countryISOCode: _selectedCountry.code,
          countryCode: '+${_selectedCountry.fullCountryCode}',
          number: value,
        );

        if (widget.autovalidateMode != AutovalidateMode.disabled) {
          validatorMessage = await widget.validator?.call(phoneNumber);
        }

        widget.onChanged?.call(phoneNumber);
      },
      validator: (value) {
        if (value == null || !isNumeric(value)) return validatorMessage;
        if (!widget.disableLengthCheck) {
          return value.length >= _selectedCountry.minLength &&
                  value.length <= _selectedCountry.maxLength
              ? null
              : widget.invalidNumberMessage;
        }

        return validatorMessage;
      },
      maxLength: widget.disableLengthCheck ? null : _selectedCountry.maxLength,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      keyboardAppearance: widget.keyboardAppearance,
      autofocus: widget.autofocus,
      textInputAction: widget.textInputAction,
      autovalidateMode: widget.autovalidateMode,
    );
  }

  Container _buildFlagsButton() {
    return Container(
      margin: widget.flagsButtonMargin,
      child: DecoratedBox(
        decoration: widget.dropdownDecoration,
        child: InkWell(
          borderRadius: widget.dropdownDecoration.borderRadius as BorderRadius?,
          onTap: widget.enabled ? _openCountrySearchView : null,
          child: Padding(
            padding: widget.flagsButtonPadding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 4),
                if (widget.enabled &&
                    widget.showDropdownIcon &&
                    widget.dropdownIconPosition == IconPosition.leading) ...[
                  widget.dropdownIcon,
                  const SizedBox(width: 4),
                ],
                if (widget.showCountryFlag) ...[
                  kIsWeb
                      ? Image.asset(
                          'assets/flags/${_selectedCountry.code.toLowerCase()}.png',
                          package: 'intl_phone_field',
                          width: 32,
                        )
                      : Text(_selectedCountry.flag, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 4),
                ],
                FittedBox(
                  child: Text('+${_selectedCountry.dialCode}', style: widget.dropdownTextStyle),
                ),
                if (widget.enabled &&
                    widget.showDropdownIcon &&
                    widget.dropdownIconPosition == IconPosition.trailing) ...[
                  const SizedBox(width: 4),
                  widget.dropdownIcon,
                ],
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CountrySearchViewPage extends StatefulWidget {
  final List<Country> countryList;
  final Country selectedCountry;
  final String languageCode;
  final String searchText;

  const _CountrySearchViewPage({
    required this.countryList,
    required this.selectedCountry,
    required this.languageCode,
    required this.searchText,
  });

  @override
  State<_CountrySearchViewPage> createState() => _CountrySearchViewPageState();
}

class _CountrySearchViewPageState extends State<_CountrySearchViewPage> {
  late final TextEditingController _searchController;
  late String _selectedCountryCode;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _selectedCountryCode = widget.selectedCountry.code;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final backgroundColor = colorScheme.surface;
    final List<Country> filteredCountries = widget.countryList.stringSearch(_searchController.text)
      ..sort(
        (a, b) =>
            a.localizedName(widget.languageCode).compareTo(b.localizedName(widget.languageCode)),
      );

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SearchBar(
              padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.all(4)),

              controller: _searchController,
              autoFocus: true,
              hintText: widget.searchText,
              backgroundColor: WidgetStatePropertyAll<Color>(backgroundColor),
              elevation: const WidgetStatePropertyAll<double>(0),
              shadowColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
              side: const WidgetStatePropertyAll<BorderSide>(BorderSide.none),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
              trailing: <Widget>[
                IconButton(
                  icon: Icon(Icons.close, color: colorScheme.onSurfaceVariant),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
              onChanged: (_) {
                if (mounted) {
                  setState(() {});
                }
              },
            ),
            const SizedBox(height: 8),
            Divider(height: 1, thickness: 1, color: colorScheme.outline),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: filteredCountries.length,
                itemBuilder: (ctx, index) {
                  final country = filteredCountries[index];
                  final isSelected = country.code == _selectedCountryCode;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RadioGroup<String>(
                      groupValue: _selectedCountryCode,
                      onChanged: (_) {
                        _selectedCountryCode = country.code;
                        Navigator.of(context).pop(country);
                      },
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: kIsWeb
                                ? Image.asset(
                                    'assets/flags/${country.code.toLowerCase()}.png',
                                    package: 'intl_phone_field',
                                    width: 32,
                                  )
                                : Text(country.flag, style: const TextStyle(fontSize: 18)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            title: Text(
                              country.localizedName(widget.languageCode),
                              style: textTheme.bodyLarge,
                            ),
                            trailing: Row(
                              mainAxisSize: .min,
                              mainAxisAlignment: .end,
                              children: [
                                Text(
                                  '+${country.dialCode}',
                                  style: textTheme.labelSmall!.copyWith(
                                    color: country.fullCountryCode == _selectedCountryCode
                                        ? colorScheme.secondary
                                        : colorScheme.onSurfaceVariant,
                                  ),
                                ),

                                Radio<String>(value: country.code),
                              ],
                            ),
                            selected: isSelected,
                            onTap: () {
                              _selectedCountryCode = country.code;
                              Navigator.of(context).pop(country);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum IconPosition { leading, trailing }
