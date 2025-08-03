import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 

class NoLeadingZeroFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (oldValue.text.isEmpty && newValue.text == '0') {
      return oldValue;
    }
    final cleaned = newValue.text.replaceFirst(RegExp(r'^0+'), '');
    if (cleaned != newValue.text) {
      final selectionIndex = cleaned.length;
      return TextEditingValue(
        text: cleaned,
        selection: TextSelection.collapsed(offset: selectionIndex),
      );
    }
    return newValue;
  }
}

class CounterWidget extends StatefulWidget {
  final int value;
  final ValueChanged<int> onAmountChanged;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CounterWidget({
    required this.value,
    required this.onAmountChanged,
    required this.onIncrement,
    required this.onDecrement,
    super.key,
  });

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value.toString());
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _updateAmountFromController();
        setState(() => _isEditing = false);
      }
    });
  }

  @override
  void didUpdateWidget(covariant CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final currentTextValue = int.tryParse(_controller.text);
    if (widget.value != currentTextValue && !_isEditing) {
      _controller.text = widget.value.toString();
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
  }

  void _updateAmountFromController() {
    final int? parsed = int.tryParse(_controller.text);
    if (parsed != null) {
      widget.onAmountChanged(parsed);
    } else if (_controller.text.isEmpty) {
      widget.onAmountChanged(0);
      _controller.text = '0';
    } else {
      widget.onAmountChanged(0);
      _controller.text = '0';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.grayBlue,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (_focusNode.hasFocus) _focusNode.unfocus();
              widget.onDecrement();
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: AppColors.containerGradientPrimary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.remove, color: Colors.white),
            ),
          ),


          IntrinsicWidth(
            child: GestureDetector(
              onTap: () {
                setState(() => _isEditing = true);
                _focusNode.requestFocus();
                _controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: _controller.text.length),
                );
              },
              child: AbsorbPointer(
                absorbing: _focusNode.hasFocus,
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _focusNode.unfocus(),
                  onEditingComplete: () => _focusNode.unfocus(),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    NoLeadingZeroFormatter(),              
                    LengthLimitingTextInputFormatter(3),
                  ],
                  style: FlexTypography.headline.xMedium.copyWith(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    suffixText: '\$',                       
                    suffixStyle: FlexTypography.headline.xMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  onChanged: (text) {
                    final parsed = int.tryParse(text);
                    if (parsed != null) {
                      widget.onAmountChanged(parsed);
                    } else if (text.isEmpty) {
                      widget.onAmountChanged(0);
                    }
                  },
                  readOnly: false,
                  cursorColor: Colors.white,
                ),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              if (_focusNode.hasFocus) _focusNode.unfocus();
              widget.onIncrement();
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: AppColors.containerGradientPrimary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
