import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailContainer extends StatefulWidget {
  final void Function(String email)? onChanged;
  final TextEditingController? controller;

  const EmailContainer({
    super.key,
    this.onChanged,
    this.controller,
  });

  @override
  State<EmailContainer> createState() => _EmailContainerState();
}

class _EmailContainerState extends State<EmailContainer> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged); 
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    final email = _controller.text.trim();
    widget.onChanged?.call(email);
  }

  @override
  Widget build(BuildContext context) {
    final hasText = _controller.text.isNotEmpty;

    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0x1AFFFFFF),
        border: Border.all(
          color: const Color(0x66FFFFFF),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.emailAddress,
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
              ],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'mail@mail.com',
                hintStyle: TextStyle(
                  color: Color(0x4DFFFFFF),
                  fontSize: 18,
                ),
              ),
              cursorColor: Colors.white,
              textInputAction: TextInputAction.done,
            ),
          ),
          if (hasText)
            GestureDetector(
              onTap: () {
                _controller.clear();
                widget.onChanged?.call('');
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
