import 'package:flutter/material.dart';

class DraggableSheet extends StatefulWidget {
  final Widget child;

  static final controller = DraggableScrollableController();

  DraggableSheet({super.key, required this.child});

  @override
  State<DraggableSheet> createState() => DraggableSheetState();
}

class DraggableSheetState extends State<DraggableSheet> {
  static GlobalKey getsheetKey() {
    return GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (builder, constraints) {
      final sheetKey = GlobalKey();
      return DraggableScrollableSheet(
          key: sheetKey,
          initialChildSize: 0.42,
          maxChildSize: 0.42,
          minChildSize: 0.23,
          expand: true,
          snap: true,
          snapSizes: [0.23, 0.42],
          builder: (BuildContext context, ScrollController scrollScontroller) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 1))
                ],
              ),
              child: CustomScrollView(
                controller: scrollScontroller,
                slivers: [
                  SliverToBoxAdapter(
                    child: widget.child,
                  )
                ],
              ),
            );
          });
    });
  }
}
