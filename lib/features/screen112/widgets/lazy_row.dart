import 'package:flex_travel_sim/features/screen112/widgets/custom_container.dart';
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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.options.length, (index) {
          final optionText = widget.options[index];
          return Row(
            children: [
              CustomContainer(
                text: optionText,
                isSelected: widget.selectedIndex == index,
                onTap: () => widget.onSelectedIndex(index),
              ),
              SizedBox(width: 8,)
            ],
          );
        }),
      ),
    );
  }
}
