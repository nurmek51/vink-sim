import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class MobileNumberField extends StatefulWidget {
  final void Function(String digits, String formatted)? onChanged;
  const MobileNumberField({super.key, this.onChanged});

  @override
  State<MobileNumberField> createState() => _MobileNumberFieldState();
}

class _MobileNumberFieldState extends State<MobileNumberField> {
  final TextEditingController _controller = TextEditingController();
  String _lastFormatted = '';
  bool _isInternalUpdate = false;

  @override
  void initState() {
    super.initState();
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

    widget.onChanged?.call(digits, formatted);
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

    String normalizedDigits = digits;
    if (normalizedDigits.startsWith('8') && normalizedDigits.length > 1) {
      normalizedDigits = '7${normalizedDigits.substring(1)}';
    }
    if (!normalizedDigits.startsWith('7') && normalizedDigits.length <= 10) {
      normalizedDigits = '7$normalizedDigits';
    }

    if (normalizedDigits.length > 11) {
      normalizedDigits = normalizedDigits.substring(0, 11);
    }

    final buffer = StringBuffer();

    if (normalizedDigits.isNotEmpty) {
      buffer.write('+${normalizedDigits[0]}');
    }

    if (normalizedDigits.length > 1) {
      buffer.write(' (');
      final operatorCodeEnd = min(normalizedDigits.length, 4);
      buffer.write(normalizedDigits.substring(1, operatorCodeEnd));

      if (normalizedDigits.length >= 4) {
        buffer.write(')');
      }
    }

    if (normalizedDigits.length > 4) {
      buffer.write(' ');
      final firstGroupEnd = min(normalizedDigits.length, 7);
      buffer.write(normalizedDigits.substring(4, firstGroupEnd));
    }

    if (normalizedDigits.length > 7) {
      buffer.write(' ');
      final secondGroupEnd = min(normalizedDigits.length, 9);
      buffer.write(normalizedDigits.substring(7, secondGroupEnd));
    }

    if (normalizedDigits.length > 9) {
      buffer.write(' ');
      buffer.write(normalizedDigits.substring(9));
    }

    return buffer.toString();
  }

  bool get _isValidPhoneNumber {
    final digits = _controller.text.replaceAll(RegExp(r'\D'), '');
    return digits.length >= 11;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
          Expanded(
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d+\s\(\)\-]')),
                LengthLimitingTextInputFormatter(18),
              ],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '+7 (700) 000 00 00',
                hintStyle: TextStyle(color: Color(0x4DFFFFFF), fontSize: 18),
              ),
              cursorColor: Colors.white,
              textInputAction: TextInputAction.done,
            ),
          ),
          if (_controller.text.isNotEmpty)
            GestureDetector(
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
        ],
      ),
    );
  }
}
