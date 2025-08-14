import 'package:flex_travel_sim/features/esim_management/widgets/setup/custom_container.dart';
import 'package:flutter/material.dart';

class LazyRow extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelectedIndex;
  final List<String> options;

  const LazyRow({
    super.key,
    required this.selectedIndex,
    required this.onSelectedIndex,
    required this.options,
  });

  @override
  State<LazyRow> createState() => _LazyRowState();
}

class _LazyRowState extends State<LazyRow> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _scrollViewKey = GlobalKey();
  late List<GlobalKey> _itemKeys;

  @override
  void initState() {
    super.initState();
    _itemKeys = List.generate(widget.options.length, (_) => GlobalKey());

  WidgetsBinding.instance.addPostFrameCallback((_) {
    _jumpToSelected(widget.selectedIndex);
  });

  }

  @override
  void didUpdateWidget(covariant LazyRow old) {
    super.didUpdateWidget(old);
    if (old.options.length != widget.options.length) {
      _itemKeys = List.generate(widget.options.length, (_) => GlobalKey());
    }
  }

  void _onItemTap(int index) {
    widget.onSelectedIndex(index);

    final itemContext = _itemKeys[index].currentContext;
    final scrollContext = _scrollViewKey.currentContext;
    if (itemContext == null || scrollContext == null) return;

    final RenderBox itemBox = itemContext.findRenderObject() as RenderBox;
    final RenderBox scrollBox = scrollContext.findRenderObject() as RenderBox;

    final Offset itemOffset = itemBox.localToGlobal(
      Offset.zero,
      ancestor: scrollBox,
    );

    final double itemLeft = itemOffset.dx;
    final double itemRight = itemLeft + itemBox.size.width;
    final double viewWidth = scrollBox.size.width;
    const double padding = 16.0;

    double targetOffset = _scrollController.offset;

    // Если таб выходит вправо за экран — скроллим вправо
    if (itemRight > viewWidth) {
      targetOffset += (itemRight - viewWidth) + padding;
    }
    // Если таб выходит влево за экран — скроллим влево
    else if (itemLeft < 0) {
      targetOffset += itemLeft - padding;
    }

    // Ограничиваем в допустимых пределах
    targetOffset = targetOffset.clamp(
      _scrollController.position.minScrollExtent,
      _scrollController.position.maxScrollExtent,
    );

    // Анимируем прокрутку
    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  void _jumpToSelected(int index) {
    final itemContext = _itemKeys[index].currentContext;
    final scrollContext = _scrollViewKey.currentContext;
    if (itemContext == null || scrollContext == null) return;

    final RenderBox itemBox = itemContext.findRenderObject() as RenderBox;
    final RenderBox scrollBox = scrollContext.findRenderObject() as RenderBox;

    final Offset itemOffset = itemBox.localToGlobal(
      Offset.zero,
      ancestor: scrollBox,
    );

    final double itemLeft = itemOffset.dx;
    final double itemRight = itemLeft + itemBox.size.width;
    final double viewWidth = scrollBox.size.width;
    const double padding = 16.0;

    double targetOffset = _scrollController.offset;

    if (itemRight > viewWidth) {
      targetOffset += (itemRight - viewWidth) + padding;
    } else if (itemLeft < 0) {
      targetOffset += itemLeft - padding;
    }

    targetOffset = targetOffset.clamp(
      _scrollController.position.minScrollExtent,
      _scrollController.position.maxScrollExtent,
    );

    _scrollController.jumpTo(targetOffset);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      key: _scrollViewKey,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(widget.options.length, (index) {
            final optionText = widget.options[index];
            return Row(
              children: [
                Container(
                  key: _itemKeys[index],
                  child: CustomContainer(
                    text: optionText,
                    isSelected: widget.selectedIndex == index,
                    onTap: () => _onItemTap(index),
                  ),
                ),
                const SizedBox(width: 8,)
              ],
            );
          }),
        ),
      ),
    );
  }
}