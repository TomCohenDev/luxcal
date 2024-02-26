import 'package:flutter/material.dart';
import 'package:revampedai/aaacore/theme/pallette.dart';
import 'package:revampedai/aaacore/theme/typography.dart';
import 'package:revampedai/aaasrc/ui/widgets/elevated_container_card.dart';

class SwitchButton extends StatefulWidget {
  SwitchButton(
      {super.key,
      this.height = 50,
      this.width = 250,
      required this.options,
      this.onSwitch});
  double height;
  double width;
  List<String> options;
  final Function(String)? onSwitch;

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  String selectedOption = "";
  @override
  void initState() {
    super.initState();
    selectedOption = widget.options[0];
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedContainerCard(
      height: widget.height,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.options.length,
        itemBuilder: (context, index) {
          return _listTile(widget.options[index]);
        },
      ),
    );
  }

  Widget _listTile(String option) {
    bool isSelected = selectedOption == option;
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
          selectedOption = option;
        });
        if (widget.onSwitch != null) {
          widget.onSwitch!(option);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: isSelected
                ? AppPalette.gradients.main
                : AppPalette.gradients.white),
        child: Center(
          child: Text(option,
              style: isSelected
                  ? AppTypography.switchSelected
                  : AppTypography.switchUnselected),
        ),
      ),
    );
  }
}
