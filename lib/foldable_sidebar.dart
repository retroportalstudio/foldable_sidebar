library foldable_sidebar;

import 'package:flutter/material.dart';

enum FSBStatus {
  FSB_OPEN,
  FSB_CLOSE,
}

class FoldableSidebarBuilder extends StatelessWidget {
  final FSBStatus status;
  final Color? drawerBackgroundColor;
  final Widget drawer;
  final Widget screenContents;

  const FoldableSidebarBuilder(
      {Key? key,
      required this.status,
      required this.drawer,
      required this.screenContents,
      this.drawerBackgroundColor})
      : super(key: key);

  Tween<double> getTween() {
    switch (status) {
      case FSBStatus.FSB_OPEN:
        return Tween<double>(begin: 0.0, end: 1.0);
      case FSBStatus.FSB_CLOSE:
        return Tween<double>(begin: 1.0, end: 0.0);
      default:
        return Tween<double>(begin: 0.0, end: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return TweenAnimationBuilder<double>(
          curve: Curves.fastOutSlowIn,
          tween: getTween(),
          duration: Duration(milliseconds: 700),
          builder: (context, data, child) {
            final double drawerWidth = constraints.maxWidth * 0.60 * data;
            final double portionAngle = 1.57 * (1 - data);
            final double perspective = 0.007 * (1 - data);
            final height = constraints.maxHeight;
            final Widget drawerContainer = Container(
              height: height,
              child: drawer,
            );
            return Container(
              height: height,
              color: drawerBackgroundColor ?? Colors.grey.withAlpha(50),
              child: FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.fitHeight,
                child: Row(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          width: drawerWidth,
                          height: height,
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: ClipRect(
                            child: Align(
                              widthFactor: 0.5 * data,
                              alignment: Alignment.centerLeft,
                              child: Transform(
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 0, perspective)
                                    ..rotateY(portionAngle),
                                  alignment: Alignment.centerLeft,
                                  child: AbsorbPointer(
                                      absorbing: true, child: drawerContainer)),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: ClipRect(
                            child: Align(
                              widthFactor: 0.5 * data,
                              alignment: Alignment.centerRight,
                              child: Transform(
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 0, -perspective)
                                    ..rotateY(portionAngle),
                                  alignment: Alignment.centerRight,
                                  child: AbsorbPointer(
                                      absorbing: true, child: drawerContainer)),
                            ),
                          ),
                        ),
                        if (data == 1.0) ...[drawerContainer],
                        if (data != 1.0) ...[
                          Positioned(
                              top: height * 0.25,
                              left: drawerWidth / 2,
                              child: Opacity(
                                opacity: 1 - data,
                                child: Container(
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        color: Colors.black, blurRadius: 10)
                                  ]),
                                  width: 2,
                                  height: height * 0.75,
                                ),
                              )),
                        ]
                      ],
                    ),
                    Container(
                      width: constraints.maxWidth,
                      height: height,
                      child: screenContents,
                    )
                  ],
                ),
              ),
            );
          });
    });
  }
}
