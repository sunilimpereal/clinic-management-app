import 'package:flutter/material.dart';

class AllergyItemTile extends StatefulWidget {
  final String title;
  final String image;
  final List<String> items;
  final List<String> selectedItems;
  final Function(List<String>) onChanged;
  final IconData iconData;
  const AllergyItemTile({
    super.key,
    required this.title,
    required this.image,
    required this.items,
    required this.onChanged,
    required this.selectedItems,
    required this.iconData,
  });

  @override
  State<AllergyItemTile> createState() => _AllergyItemTileState();
}

class _AllergyItemTileState extends State<AllergyItemTile> {
  bool isExapanded = false;
  bool isAdd = false;
  String lastValue = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            setState(() {
              isExapanded = !isExapanded;
            });
          },
          minLeadingWidth: 0,
          leading: Container(
            width: 30,
            height: 0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              // image: DecorationImage(
              //     // image: AssetImage(widget.image),
              //     ),
            ),
            child: Icon(widget.iconData),
          ),
          title: Text(widget.title),
          trailing: isExapanded ? const Icon(Icons.minimize_rounded) : const Icon(Icons.add_circle_outline),
        ),
        isExapanded
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                        children: widget.items
                            .map((e) => TextFormField(
                                  initialValue: e,
                                  // labelText: null,
                                  onChanged: (value) {
                                    widget.items.remove(e);
                                    if (value.isNotEmpty) {
                                      widget.items.add(value);
                                    }
                                    widget.onChanged(widget.items);
                                    // setState(() {
                                    //   isAdd = !isAdd;
                                    // });
                                  },
                                  onFieldSubmitted: (value) {},
                                ))
                            .toList()),
                    TextButton(
                        onPressed: () {
                          if (widget.items.last != "") {
                            widget.items.add("");
                            widget.onChanged(widget.items);
                            setState(() {});
                            Future.delayed(const Duration(milliseconds: 200)).then((value) {
                              FocusScope.of(context).nextFocus();
                            });
                          }
                        },
                        child: const Text(
                          "+Add new",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ))
                  ],
                ),
              )
            : Container(),
        const Divider()
      ],
    );
  }
}
