import 'package:flutter/material.dart';
import 'package:clinic_app/utils/constants/color_konstants.dart';

class DropdownWithSearch<T> extends StatelessWidget {
  final T selected;
  final List<T> items;
  final String label;
  final TextStyle? selectedItemStyle;
  final BoxDecoration? decoration, disabledDecoration;
  final double? searchBarRadius;
  final double? dialogRadius;
  final bool disabled;

  final Function(T) onChanged;

  const DropdownWithSearch({
    Key? key,
    required this.selected,
    required this.items,
    required this.label,
    required this.onChanged,
    this.selectedItemStyle,
    this.decoration,
    this.disabledDecoration,
    this.searchBarRadius,
    this.dialogRadius,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (items.isNotEmpty) {
              final button = context.findRenderObject() as RenderBox;
              final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
              final position = button.localToGlobal(Offset.zero, ancestor: overlay);
              final size = button.size;

              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  position.dx,
                  position.dy + size.height,
                  position.dx + size.width,
                  position.dy + size.height * (items.length + 1),
                ),
                items: items.map((item) {
                  return PopupMenuItem<T>(
                    value: item,
                    child: ListTile(
                      title: Text(
                        item.toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                      onTap: () {
                        Navigator.pop(context, item);
                      },
                    ),
                  );
                }).toList(),
              ).then((value) {
                if (value != null) {
                  onChanged(value);
                }
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: ColorKonstants.primaryColor,
                  content: Text("Select State first"),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: !disabled
                ? decoration ??
                BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.6),
                      width: 0.5,
                    ),
                  ),
                  //color: Colors.white,
                )
                : disabledDecoration ?? BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.6),
                  width: 0.5,
                ),
              ),
              color: Colors.grey.shade300,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selected.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: selectedItemStyle ?? const TextStyle(fontSize: 14),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down_rounded)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SearchDialog<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final TextStyle? titleStyle;
  final TextStyle? itemStyle;
  final double? dialogRadius;

  const SearchDialog({
    Key? key,
    required this.title,
    required this.items,
    this.titleStyle,
    this.dialogRadius,
    this.itemStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    title,
                    style: titleStyle ?? const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 5),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  dialogRadius != null
                      ? Radius.circular(dialogRadius!)
                      : const Radius.circular(5),
                ),
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context, items[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 18),
                        child: Text(
                          items[index].toString(),
                          style: itemStyle ?? const TextStyle(fontSize: 14),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CustomDialog extends StatelessWidget {
  /// Creates a dialog.
  ///
  /// Typically used in conjunction with [showDialog].
  const CustomDialog({
    Key? key,
    this.child,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.shape,
    this.constraints = const BoxConstraints(
        minWidth: 280.0, minHeight: 280.0, maxHeight: 400.0, maxWidth: 400.0),
  }) : super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget? child;

  /// The duration of the animation to show when the system keyboard intrudes
  /// into the space that the dialog is placed in.
  ///
  /// Defaults to 100 milliseconds.
  final Duration insetAnimationDuration;

  /// The curve to use for the animation shown when the system keyboard intrudes
  /// into the space that the dialog is placed in.
  ///
  /// Defaults to [Curves.fastOutSlowIn].
  final Curve insetAnimationCurve;

  /// {@template flutter.material.dialog.shape}
  /// The shape of this dialog's border.
  ///
  /// Defines the dialog's [Material.shape].
  ///
  /// The default shape is a [RoundedRectangleBorder] with a radius of 2.0.
  /// {@endtemplate}
  final ShapeBorder? shape;
  final BoxConstraints constraints;

  Color _getColor(BuildContext context) {
    return Theme.of(context).dialogBackgroundColor;
  }

  static const RoundedRectangleBorder _defaultDialogShape =
      RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)));

  @override
  Widget build(BuildContext context) {
    final DialogTheme dialogTheme = DialogTheme.of(context);
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 22.0, vertical: 24.0),
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: ConstrainedBox(
            constraints: constraints,
            child: Material(
              elevation: 15.0,
              color: _getColor(context),
              type: MaterialType.card,
              shape: shape ?? dialogTheme.shape ?? _defaultDialogShape,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
