import 'package:flex_travel_sim/constants/lozalization.dart';
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
            text: AppLocalization.fastSelectedRow,
            height: 38,
            widgth: 97,
            isSelected: widget.selected == AppLocalization.fastSelectedRow,
            onTap: () => widget.onSelected(AppLocalization.fastSelectedRow),
          ),
          SizedBox(width: 5),
          CustomContainer(
            text: AppLocalization.manualSelectedRow,
            height: 38,
            widgth: 99,
            isSelected: widget.selected == AppLocalization.manualSelectedRow,
            onTap: () => widget.onSelected(AppLocalization.manualSelectedRow),            
          ),
          SizedBox(width: 5),
          CustomContainer(
            text: AppLocalization.qrCodeSelectedRow,
            height: 38,
            widgth: 87,
            isSelected: widget.selected == AppLocalization.qrCodeSelectedRow,
            onTap: () => widget.onSelected(AppLocalization.qrCodeSelectedRow),            
          ),
          SizedBox(width: 5),
          CustomContainer(
            text: AppLocalization.toAnotherDeviceSelectedRow,
            height: 38,
            widgth: 199,
            isSelected: widget.selected == AppLocalization.toAnotherDeviceSelectedRow,
            onTap: () => widget.onSelected(AppLocalization.toAnotherDeviceSelectedRow),            
          ),                    
                                            
        ],
      ),
    );
  }
}
