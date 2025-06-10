import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinCodeField extends StatefulWidget {
  final void Function(String)? onChanged;
  final void Function(String)? onCompleted;
  const PinCodeField({super.key, this.onChanged, this.onCompleted});

  @override
  State<PinCodeField> createState() => _PinCodeFieldState();
}

class _PinCodeFieldState extends State<PinCodeField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  static const int _pinLength = 6;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final text = _controller.text;

    if (text.length > _pinLength) {
      final trimmedText = text.substring(0, _pinLength);
      _controller.value = TextEditingValue(
        text: trimmedText,
        selection: TextSelection.collapsed(offset: trimmedText.length),
      );
      return;
    }

    widget.onChanged?.call(text);

    if (text.length == _pinLength) {
      widget.onCompleted?.call(text);
    }
  }

  void _clearCode() {
    _controller.clear();
    _focusNode.requestFocus();
  }

  String get _displayText {
    return _controller.text;
  }

  @override
  Widget build(BuildContext context) {
    final currentLength = _controller.text.length;
    final isComplete = currentLength == _pinLength;

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0x1AFFFFFF),
        border: Border.all(
          color: const Color(0x66FFFFFF),
          width: isComplete ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: 0,
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    keyboardType: TextInputType.number,
                    maxLength: _pinLength,
                    style: const TextStyle(fontSize: 1),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(_pinLength),
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        if (newValue.text.length <= _pinLength) {
                          return newValue;
                        }
                        return oldValue;
                      }),
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                    ),
                    cursorColor: Colors.transparent,
                  ),
                ),
                GestureDetector(
                  onTap: () => _focusNode.requestFocus(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pinLength, (index) {
                      final hasDigit = index < currentLength;
                      final isActive =
                          index == currentLength &&
                          _focusNode.hasFocus &&
                          currentLength < _pinLength;

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 35,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color:
                              hasDigit
                                  ? const Color(0x33FFFFFF)
                                  : Colors.transparent,
                          border: Border.all(
                            color:
                                isActive
                                    ? Colors.white
                                    : hasDigit
                                    ? const Color(0x66FFFFFF)
                                    : const Color(0x33FFFFFF),
                            width: isActive ? 2 : 1,
                          ),
                        ),
                        child: Center(
                          child:
                              hasDigit
                                  ? Text(
                                    index < _displayText.length
                                        ? _displayText[index]
                                        : '',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                  : isActive
                                  ? Container(
                                    width: 2,
                                    height: 20,
                                    color: Colors.white,
                                  )
                                  : const Text(
                                    '•',
                                    style: TextStyle(
                                      color: Color(0x4DFFFFFF),
                                      fontSize: 20,
                                    ),
                                  ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          if (currentLength > 0) ...[
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _clearCode,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0x33FFFFFF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.backspace_outlined,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
