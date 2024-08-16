import 'package:flutter/material.dart';

class DropDownSelector<T> extends StatefulWidget {
  const DropDownSelector({
    required this.labels,
    required this.values,
    required this.onSelected,
    super.key,
  }) : assert(labels.length == values.length,
  'labels and values lists must have the same length');

  final List<String> labels;
  final List<T> values;
  final void Function(T value) onSelected;

  @override
  State<DropDownSelector<T>> createState() => _DropDownSelectorState<T>();
}

class _DropDownSelectorState<T> extends State<DropDownSelector<T>> {
  String? _selectedLabel;

  @override
  void initState() {
    super.initState();
    _selectedLabel = widget.labels[0];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownButton<String>(
          value: _selectedLabel,
          style: Theme.of(context).textTheme.labelMedium,
          items: widget.labels.map((String label) {
            return DropdownMenuItem<String>(
              value: label,
              child: Text(label),
            );
          }).toList(),
          onChanged: (newLabel) {
            setState(() {
              _selectedLabel = newLabel;
            });

            if (newLabel == null) return;

            final selectedIndex = widget.labels.indexOf(newLabel);
            widget.onSelected(widget.values[selectedIndex]);
          },
          underline: const SizedBox(), // Remove the default underline
        ),
      ],
    );
  }
}
