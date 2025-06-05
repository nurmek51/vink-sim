import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class MobileNumberField extends StatefulWidget {
  final void Function(String digits, String formatted)? onChanged;
  const MobileNumberField({
    super.key,
    this.onChanged,
  });

  @override
  State<MobileNumberField> createState() => _MobileNumberFieldState();
}

class _MobileNumberFieldState extends State<MobileNumberField> {
  final TextEditingController _controller = TextEditingController();
  String _lastFormatted = '';

  
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
    final rawText = _controller.text;
    final selectionIndex = _controller.selection.baseOffset;

    final digits = rawText.replaceAll(RegExp(r'\D'), '');
    final formatted = _formatPhoneNumber(digits);

    if (formatted == _lastFormatted) return;
    _lastFormatted = formatted;

    int newOffset = selectionIndex + (formatted.length - rawText.length);

    newOffset = newOffset.clamp(0, formatted.length);

    _controller.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newOffset),
    );

    widget.onChanged?.call(digits, formatted); 

    setState(() {});
  }
  
  String _formatPhoneNumber(String digits) {
    if (digits.isEmpty) return '';
    digits = digits.replaceFirst(RegExp(r'^8'), '7');
    if (!digits.startsWith('7')) digits = '7$digits';

    final buffer = StringBuffer();
    buffer.write('+${digits[0]}');

    if (digits.length > 1) {
      buffer.write(' (');
      buffer.write(digits.substring(1, min(digits.length, 4)));
    }

    if (digits.length >= 4) {
      buffer.write(') ');
      buffer.write(digits.substring(4, min(digits.length, 7)));
    }

    if (digits.length >= 7) {
      buffer.write(' ');
      buffer.write(digits.substring(7, min(digits.length, 9)));
    }

    if (digits.length >= 9) {
      buffer.write(' ');
      buffer.write(digits.substring(9, min(digits.length, 11)));
    }

    return buffer.toString().replaceAll(RegExp(r'\s+$'), '');
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0x4DFFFFFF),
        border: Border.all(color: Color(0x66FFFFFF)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11),
              ],
              style: const TextStyle(color: Colors.white, fontSize: 18),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '+7 (700) 000 000',
                hintStyle: TextStyle(color: Color(0x4DFFFFFF), fontSize: 18),
              ),
              cursorColor: Colors.white,
            ),
          ),
          if (_controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _controller.clear();
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0x33FFFFFF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 18),
              ),
            ),
        ],
      ),
    );
  }
}
