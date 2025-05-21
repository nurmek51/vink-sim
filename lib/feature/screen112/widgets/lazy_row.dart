import 'package:flex_travel_sim/feature/screen112/widgets/custom_container.dart';
import 'package:flutter/material.dart';

class LazyRow extends StatefulWidget {
  final String selected;
  final ValueChanged<String> onSelected;  

  const LazyRow({
    super.key,
    required this.selected,
    required this.onSelected,
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
        children: [
          CustomContainer(
            text: 'Быстрая',
            height: 38,
            widgth: 97,
            isSelected: widget.selected == 'Быстрая',
            onTap: () => widget.onSelected('Быстрая'),
          ),
          SizedBox(width: 5),
          CustomContainer(
            text: 'Вручную',
            height: 38,
            widgth: 99,
            isSelected: widget.selected == 'Вручную',
            onTap: () => widget.onSelected('Вручную'),            
          ),
          SizedBox(width: 5),
          CustomContainer(
            text: 'QR код',
            height: 38,
            widgth: 87,
            isSelected: widget.selected == 'QR код',
            onTap: () => widget.onSelected('QR код'),            
          ),
          SizedBox(width: 5),
          CustomContainer(
            text: 'На другое устройство',
            height: 38,
            widgth: 199,
            isSelected: widget.selected == 'На другое устройство',
            onTap: () => widget.onSelected('На другое устройство'),            
          ),                    
                                            
        ],
      ),
    );
  }
}
