import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vink_sim/features/auth/domain/entities/country.dart';
import 'package:vink_sim/features/auth/data/country_data.dart';
import 'package:vink_sim/features/auth/presentation/widgets/country_picker_bottom_sheet.dart';

class MobileNumberField extends StatefulWidget {
  final void Function(String digits, String formatted)? onChanged;
  final void Function(Country country)? onCountryChanged;
  final Country? initialCountry;
  final String? initialPhone;

  const MobileNumberField({
    super.key,
    this.onChanged,
    this.onCountryChanged,
    this.initialCountry,
    this.initialPhone,
  });

  @override
  State<MobileNumberField> createState() => _MobileNumberFieldState();
}

class _MobileNumberFieldState extends State<MobileNumberField> {
  final TextEditingController _controller = TextEditingController();
  String _lastFormatted = '';
  bool _isInternalUpdate = false;
  late Country _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.initialCountry ?? CountryData.defaultCountry;
    
    if (widget.initialPhone != null && widget.initialPhone!.isNotEmpty) {
      String phoneWithoutDialCode = widget.initialPhone!;
      if (phoneWithoutDialCode.startsWith(_selectedCountry.dialCode)) {
        phoneWithoutDialCode = phoneWithoutDialCode.substring(_selectedCountry.dialCode.length);
      }
      final formatted = _formatPhoneNumber(phoneWithoutDialCode);
      _controller.text = formatted;
      _lastFormatted = formatted;
      
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final fullNumber = _selectedCountry.dialCode + phoneWithoutDialCode;
        widget.onChanged?.call(fullNumber, formatted);
      });
    }
    
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (_isInternalUpdate) return;

    final rawText = _controller.text;
    final cursorPosition = _controller.selection.baseOffset;

    final digits = rawText.replaceAll(RegExp(r'\D'), '');

    if (digits.isEmpty) {
      widget.onChanged?.call('', '');
      return;
    }

    final formatted = _formatPhoneNumber(digits);

    if (formatted == _lastFormatted) return;
    _lastFormatted = formatted;

    int newCursorPosition = _calculateCursorPosition(
      rawText,
      formatted,
      cursorPosition,
    );

    _isInternalUpdate = true;
    _controller.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newCursorPosition),
    );
    _isInternalUpdate = false;

    final fullNumber = _selectedCountry.dialCode + digits;
    widget.onChanged?.call(fullNumber, formatted);
  }

  int _calculateCursorPosition(
    String oldText,
    String newText,
    int oldPosition,
  ) {
    if (oldText.isEmpty) return newText.length;

    double ratio = oldPosition / oldText.length;
    int newPosition = (ratio * newText.length).round();

    return newPosition.clamp(0, newText.length);
  }

  String _formatPhoneNumber(String digits) {
    if (digits.isEmpty) return '';

    if (_selectedCountry.dialCode == '+7') {
      return _formatRussianNumber(digits);
    } else if (_selectedCountry.dialCode == '+1') {
      return _formatUSNumber(digits);
    } else {
      return _formatGenericNumber(digits);
    }
  }

  String _formatRussianNumber(String digits) {
    final buffer = StringBuffer();

    if (digits.isNotEmpty) {
      buffer.write('(');
      final operatorCodeEnd = digits.length >= 3 ? 3 : digits.length;
      buffer.write(digits.substring(0, operatorCodeEnd));
      if (digits.length >= 3) {
        buffer.write(')');
      }
    }

    if (digits.length > 3) {
      buffer.write(' ');
      final firstGroupEnd = digits.length >= 6 ? 6 : digits.length;
      buffer.write(digits.substring(3, firstGroupEnd));
    }

    if (digits.length > 6) {
      buffer.write(' ');
      final secondGroupEnd = digits.length >= 8 ? 8 : digits.length;
      buffer.write(digits.substring(6, secondGroupEnd));
    }

    if (digits.length > 8) {
      buffer.write(' ');
      buffer.write(digits.substring(8));
    }

    return buffer.toString();
  }

  String _formatUSNumber(String digits) {
    final buffer = StringBuffer();

    if (digits.isNotEmpty) {
      buffer.write('(');
      final areaCodeEnd = digits.length >= 3 ? 3 : digits.length;
      buffer.write(digits.substring(0, areaCodeEnd));
      if (digits.length >= 3) {
        buffer.write(')');
      }
    }

    if (digits.length > 3) {
      buffer.write(' ');
      final firstGroupEnd = digits.length >= 6 ? 6 : digits.length;
      buffer.write(digits.substring(3, firstGroupEnd));
    }

    if (digits.length > 6) {
      buffer.write('-');
      buffer.write(digits.substring(6));
    }

    return buffer.toString();
  }

  String _formatGenericNumber(String digits) {
    final buffer = StringBuffer();

    for (int i = 0; i < digits.length; i += 3) {
      if (i > 0) buffer.write(' ');
      final end = (i + 3 < digits.length) ? i + 3 : digits.length;
      buffer.write(digits.substring(i, end));
    }

    return buffer.toString();
  }

  bool get _isValidPhoneNumber {
    final digits = _controller.text.replaceAll(RegExp(r'\D'), '');

    if (_selectedCountry.dialCode == '+7') {
      return digits.isNotEmpty && digits.length == 10;
    } else if (_selectedCountry.dialCode == '+1') {
      return digits.isNotEmpty && digits.length == 10;
    } else {
      return digits.isNotEmpty && digits.length >= 7 && digits.length <= 15;
    }
  }

  String get _placeholderText {
    if (_selectedCountry.dialCode == '+7') {
      return '(700) 000 00 00';
    } else if (_selectedCountry.dialCode == '+1') {
      return '(555) 000-0000';
    } else {
      return 'Phone number';
    }
  }

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black.withValues(alpha: 0.8),
      builder:
          (context) => CountryPickerBottomSheet(
            selectedCountry: _selectedCountry,
            onCountrySelected: (country) {
              setState(() {
                _selectedCountry = country;
              });
              _controller.clear();
              widget.onChanged?.call('', '');
              widget.onCountryChanged?.call(country);
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0x1AFFFFFF),
        border: Border.all(
          color:
              _isValidPhoneNumber
                  ? const Color(0xFF4CAF50)
                  : const Color(0x66FFFFFF),
          width: _isValidPhoneNumber ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: _showCountryPicker,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Color(0x33FFFFFF), width: 1),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _selectedCountry.flag,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _selectedCountry.dialCode,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Color(0x66FFFFFF),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(15),
                ],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: _placeholderText,
                  hintStyle: const TextStyle(
                    color: Color(0x4DFFFFFF),
                    fontSize: 18,
                  ),
                ),
                cursorColor: Colors.white,
                textInputAction: TextInputAction.done,
              ),
            ),
          ),
          if (_controller.text.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () {
                  _controller.clear();
                  widget.onChanged?.call('', '');
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Color(0x33FFFFFF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
