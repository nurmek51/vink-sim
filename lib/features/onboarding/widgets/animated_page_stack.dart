import 'package:flutter/material.dart';

class AnimatedPageStack extends StatefulWidget {
  final int index;
  final List<WidgetBuilder> pageBuilders;
  final Duration duration;
  final Curve curve;

  const AnimatedPageStack({
    super.key,
    required this.index,
    required this.pageBuilders,
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.easeInOut,
  });

  @override
  State<AnimatedPageStack> createState() => _AnimatedPageStackState();
}

class _AnimatedPageStackState extends State<AnimatedPageStack>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<Offset> _inAnimation;
  late Animation<Offset> _outAnimation;

  late Widget _outgoing;
  late Widget _incoming;

  int _currentIndex = 0;
  bool _isAnimating = false;



  Widget _getPage(int index) {
    // Always rebuild pages to ensure context (like Localization) is fresh
    return widget.pageBuilders[index](context);
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _outgoing = _getPage(_currentIndex);
    _incoming = _getPage(_currentIndex);
  }

  @override
  void didUpdateWidget(covariant AnimatedPageStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.index != _currentIndex && !_isAnimating) {
      _startTransition(widget.index);
    }
  }

  void _startTransition(int newIndex) {
    final isForward = newIndex > _currentIndex;

    _outgoing = _getPage(_currentIndex);
    _incoming = _getPage(newIndex);

    _inAnimation = Tween<Offset>(
      begin: Offset(isForward ? 1 : -1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _outAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(isForward ? -1 : 1, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    setState(() => _isAnimating = true);

    _controller.forward(from: 0).then((_) {
      setState(() {
        _currentIndex = newIndex;
        _isAnimating = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isAnimating) {
      return Stack(
        children: [
          SlideTransition(position: _outAnimation, child: _outgoing),
          SlideTransition(position: _inAnimation, child: _incoming),
        ],
      );
    }

    return _getPage(_currentIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}