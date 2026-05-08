import 'package:flutter/material.dart';

/// A built-in color picker dialog for the example app.
/// No external dependency needed — uses HSV wheel approach.
class ChromaColorPicker extends StatefulWidget {
  final Color initialColor;
  final String title;

  const ChromaColorPicker({
    super.key,
    required this.initialColor,
    this.title = 'Pick a Color',
  });

  /// Show the color picker as a dialog and return the selected color.
  static Future<Color?> show(
    BuildContext context, {
    Color initialColor = Colors.blue,
    String title = 'Pick a Color',
  }) {
    return showDialog<Color>(
      context: context,
      builder: (_) => ChromaColorPicker(
        initialColor: initialColor,
        title: title,
      ),
    );
  }

  @override
  State<ChromaColorPicker> createState() => _ChromaColorPickerState();
}

class _ChromaColorPickerState extends State<ChromaColorPicker> {
  late double _hue;
  late double _saturation;
  late double _value;

  @override
  void initState() {
    super.initState();
    final hsv = HSVColor.fromColor(widget.initialColor);
    _hue = hsv.hue;
    _saturation = hsv.saturation;
    _value = hsv.value;
  }

  Color get _currentColor =>
      HSVColor.fromAHSV(1.0, _hue, _saturation, _value).toColor();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ====== Color Preview ======
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: _currentColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colorScheme.outlineVariant,
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                _colorToHex(_currentColor),
                style: TextStyle(
                  color: _contrastColor(_currentColor),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ====== Hue Slider ======
            _SliderRow(
              label: 'Hue',
              value: _hue,
              max: 360,
              activeColor: HSVColor.fromAHSV(1, _hue, 1, 1).toColor(),
              gradient: LinearGradient(
                colors: List.generate(
                  7,
                  (i) => HSVColor.fromAHSV(1, i * 60, 1, 1).toColor(),
                ),
              ),
              onChanged: (v) => setState(() => _hue = v),
            ),

            const SizedBox(height: 12),

            // ====== Saturation Slider ======
            _SliderRow(
              label: 'Saturation',
              value: _saturation,
              max: 1,
              activeColor: _currentColor,
              gradient: LinearGradient(
                colors: [
                  HSVColor.fromAHSV(1, _hue, 0, _value).toColor(),
                  HSVColor.fromAHSV(1, _hue, 1, _value).toColor(),
                ],
              ),
              onChanged: (v) => setState(() => _saturation = v),
            ),

            const SizedBox(height: 12),

            // ====== Brightness/Value Slider ======
            _SliderRow(
              label: 'Brightness',
              value: _value,
              max: 1,
              activeColor: _currentColor,
              gradient: LinearGradient(
                colors: [
                  HSVColor.fromAHSV(1, _hue, _saturation, 0).toColor(),
                  HSVColor.fromAHSV(1, _hue, _saturation, 1).toColor(),
                ],
              ),
              onChanged: (v) => setState(() => _value = v),
            ),

            const SizedBox(height: 20),

            // ====== Quick Color Grid ======
            Text(
              'Quick Colors',
              style: theme.textTheme.labelMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Colors.red,
                Colors.pink,
                Colors.purple,
                Colors.deepPurple,
                Colors.indigo,
                Colors.blue,
                Colors.cyan,
                Colors.teal,
                Colors.green,
                Colors.lime,
                Colors.amber,
                Colors.orange,
                Colors.deepOrange,
                Colors.brown,
                Colors.grey,
                Colors.blueGrey,
              ].map((c) => _ColorDot(
                    color: c,
                    selected: _isCloseColor(c),
                    onTap: () {
                      final hsv = HSVColor.fromColor(c);
                      setState(() {
                        _hue = hsv.hue;
                        _saturation = hsv.saturation;
                        _value = hsv.value;
                      });
                    },
                  ))
                  .toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _currentColor),
          child: const Text('Select'),
        ),
      ],
    );
  }

  bool _isCloseColor(Color c) {
    final hsv = HSVColor.fromColor(c);
    return (hsv.hue - _hue).abs() < 5 &&
        (hsv.saturation - _saturation).abs() < 0.15 &&
        (hsv.value - _value).abs() < 0.15;
  }

  static String _colorToHex(Color color) {
    return '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }

  static Color _contrastColor(Color color) {
    // Simple luminance-based contrast
    final luminance = (0.299 * color.r + 0.587 * color.g + 0.114 * color.b);
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}

// ====== Slider Row Widget ======
class _SliderRow extends StatelessWidget {
  final String label;
  final double value;
  final double max;
  final Color activeColor;
  final LinearGradient gradient;
  final ValueChanged<double> onChanged;

  const _SliderRow({
    required this.label,
    required this.value,
    required this.max,
    required this.activeColor,
    required this.gradient,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 4),
        Container(
          height: 28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: gradient,
          ),
          child: SliderTheme(
            data: SliderThemeData(
              trackHeight: 28,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              thumbColor: Colors.white,
              overlayShape: SliderComponentShape.noOverlay,
              trackShape: const _TransparentTrackShape(),
              activeTrackColor: Colors.transparent,
              inactiveTrackColor: Colors.transparent,
            ),
            child: Slider(
              value: value,
              min: 0,
              max: max,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

// Custom transparent track so gradient shows through
class _TransparentTrackShape extends RoundedRectSliderTrackShape {
  const _TransparentTrackShape();

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 0,
  }) {
    // Don't paint anything — the gradient container is the track
  }
}

// ====== Quick Color Dot ======
class _ColorDot extends StatelessWidget {
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _ColorDot({
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? Colors.white : Colors.transparent,
            width: 2.5,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.6),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
      ),
    );
  }
}
