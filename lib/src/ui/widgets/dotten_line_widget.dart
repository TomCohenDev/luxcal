import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';

class DottedLineWidget extends StatefulWidget {
  const DottedLineWidget({
    Key? key,
    this.lineLength,
    this.lineThickness,
    this.dashLength,
    this.dashColor,
    this.dashGapLength,
    this.dashRadius,
    this.reverse = false,
  }) : super(key: key);

  final double? lineLength;
  final double? lineThickness;
  final double? dashLength;
  final Color? dashColor;
  final double? dashGapLength;
  final double? dashRadius;
  final bool? reverse;

  @override
  _DottedLineWidgetState createState() => _DottedLineWidgetState();
}

class _DottedLineWidgetState extends State<DottedLineWidget> {
  List<Widget> _getChildren() {
    final children = [
      //SMALL LINE
      Container(
        height: widget.lineThickness! + 7,
        width: 3,
        decoration: BoxDecoration(color: widget.dashColor!),
      ),
      //DOTTED LINE
      DottedLine(
        direction: Axis.horizontal,
        lineLength: widget.lineLength! - widget.lineThickness! - 4 - 3,
        lineThickness: widget.lineThickness!,
        dashLength: widget.dashLength!,
        dashColor: widget.dashColor!,
        dashRadius: widget.dashRadius!,
        dashGapLength: widget.dashGapLength!,
      ),
      //START CIRCLE
      Container(
        height: widget.lineThickness! + 4,
        width: widget.lineThickness! + 4,
        decoration:
            BoxDecoration(color: widget.dashColor!, shape: BoxShape.circle),
      ),
    ];
    return widget.reverse! ? children.reversed.toList() : children;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _getChildren(),
      ),
    );
  }
}
