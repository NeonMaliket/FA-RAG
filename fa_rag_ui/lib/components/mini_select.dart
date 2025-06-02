import 'package:fa_rag_ui/theme/rag_theme.dart';
import 'package:flutter/material.dart';

const int _maxSelectItemLengthw = 17;

class MiniSelect extends StatefulWidget {
  const MiniSelect({
    super.key,
    required this.items,
    this.initialIndex = 0,
    required this.onChanged,
    this.lable = "",
    this.icon,
  });

  final Icon? icon;
  final String lable;
  final int initialIndex;
  final List<String> items;
  final Function(int?) onChanged;

  @override
  State<MiniSelect> createState() => _MiniSelectState();
}

class _MiniSelectState extends State<MiniSelect> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final select = Tooltip(
      message: widget.items.isEmpty ? "" : widget.items[selectedIndex],
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          focusColor: Colors.transparent,
          value: selectedIndex,
          isDense: true,
          isExpanded: false,
          menuMaxHeight: 200,
          icon: widget.icon,
          iconSize: 20,
          iconEnabledColor: context.theme().colorScheme.secondary,
          items: widget.items
              .map(
                (item) => DropdownMenuItem(
                  value: widget.items.indexOf(item),
                  child: Text(_decorateDropdownValue(item)),
                ),
              )
              .toList(),
          onChanged: (index) {
            widget.onChanged(index);
            selectedIndex = index ?? 0;
            setState(() {});
          },
        ),
      ),
    );
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 250),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        child: ListTile(
          title: widget.lable.isNotEmpty
              ? Text(
                  widget.lable,
                  style: TextStyle(
                    color: context.theme().colorScheme.secondary,
                  ),
                )
              : select,
          subtitle: widget.lable.isNotEmpty ? select : null,
        ),
      ),
    );
  }

  String _decorateDropdownValue(String value) {
    if (value.length < _maxSelectItemLengthw) {
      return value;
    }

    return "${value.substring(0, _maxSelectItemLengthw)}...";
  }
}
