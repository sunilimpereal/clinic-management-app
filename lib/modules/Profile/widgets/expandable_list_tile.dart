import 'package:flutter/material.dart';

class ExpandableListTile extends StatefulWidget {
  final String title;
  final List<Widget> expanded;
  final Function() viewAll;
  const ExpandableListTile({super.key, required this.title, required this.viewAll, required this.expanded});

  @override
  State<ExpandableListTile> createState() => _ExpandableListTileState();
}

class _ExpandableListTileState extends State<ExpandableListTile> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListTile(
            // dense: true,
            minLeadingWidth: 0,
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            leading: Icon(isExpanded ? Icons.arrow_drop_down : Icons.arrow_right),
            title: Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: isExpanded
                ? widget.expanded.length > 3
                    ? TextButton(
                        onPressed: () {
                          widget.viewAll();
                        },
                        child: const Text("View All"))
                    : null
                : null,
          ),
        ),
        isExpanded ? const Divider() : Container(),
        isExpanded ? expanded() : Container()
      ],
    );
  }

  expanded() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: widget.expanded.length > 3 ? widget.expanded.sublist(0, 3) : widget.expanded,
      ),
    );
  }
}
