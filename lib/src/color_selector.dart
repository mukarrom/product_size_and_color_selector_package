import 'package:flutter/material.dart';
import 'package:product_size_color_selector/src/app_colors.dart';

class ColorSelector extends StatefulWidget {
  const ColorSelector({
    super.key,
    this.colors = const ["Green", "Red", "Blue", "Yellow"],
    this.onChangeColor,
  });

  final List<String> colors;
  final void Function(String)? onChangeColor;

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  late Color _selectedColor;
  final Map<String, Color> _colors = {};

  @override
  void initState() {
    for (String color in widget.colors) {
      _colors[color] = AppColors.colors[color] ?? Colors.black;
    }
    _selectedColor = widget.colors.isNotEmpty
        ? _colors[widget.colors.first] ?? AppColors.themeColor
        : AppColors.themeColor;
    super.initState();
  }

  Widget _buildColorCircle(MapEntry<String, Color> entry) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = entry.value;
        });
        widget.onChangeColor?.call(entry.key);
      },
      child: Container(
        decoration: BoxDecoration(
          color: entry.value,
          shape: BoxShape.circle,
          border: Border.all(
            color: entry.value == Colors.white
                ? AppColors.themeColor
                : Colors.transparent,
            // : _selectedColor == entry.value
            //     ? Colors.black
            //     : Colors.transparent,
            width: _selectedColor == entry.value ? 2.0 : 0.0,
          ),
        ),
        width: 28,
        height: 28,
        child: Icon(
          Icons.check,
          color: _selectedColor != entry.value
              ? Colors.transparent
              : entry.value == Colors.white
                  ? AppColors.themeColor
                  : Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: _colors.entries.map(_buildColorCircle).toList(),
    );
  }
}
