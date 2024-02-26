import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revampedai/aaacore/theme/typography.dart';
import 'package:revampedai/aaasrc/utils/size_conversion_utils.dart';

class DropdownInternalWidget extends StatefulWidget {
  const DropdownInternalWidget({
    super.key,
    this.initialValue = "",
    required this.unit,
    this.category,
    this.reverseLine = false,
    this.onChange,
    this.val,
  });
  final String initialValue;
  final String unit;
  final String? category;
  final bool? reverseLine;
  final void Function(String)? onChange;
  final String? val;

  @override
  State<DropdownInternalWidget> createState() => _DropdownInternalWidgetState();
}

class _DropdownInternalWidgetState extends State<DropdownInternalWidget> {
  String selectedValue = "";
  List<String> items = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    items = SizeConversionUtils.getSizeList(widget.unit, widget.category!);

    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        // value: selectedValue,

        customButton: IntrinsicWidth(
          child: Container(
            constraints: BoxConstraints(minWidth: 60),
            color: Color.fromARGB(0, 208, 65, 65),
            child: Align(
              alignment: widget.reverseLine!
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Text(
                  selectedValue == ""
                      ? widget.initialValue
                      : widget.initialValue,
                  style: AppTypography.drodpdownText),
            ),
          ),
        ),
        items: itemList(),
        onChanged: (value) {
          setState(() {
            selectedValue = value!;
          });
          print(selectedValue);
          widget.onChange!(value!);
        },
        dropdownStyleData: DropdownStyleData(
            // maxHeight: 300,
            width: 100,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
            ),
            elevation: 8,
            // offset: const Offset(100, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            )),
        // menuItemStyleData: MenuItemStyleData(
        //   padding: const EdgeInsets.only(left: 16, right: 16),
        // ),
      ),
    );
  }

  List<DropdownMenuItem<String>> itemList() {
    return items.reversed
        .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: AppTypography.drodpdownText,
                overflow: TextOverflow.ellipsis,
              ),
            ))
        .toList();
  }
}
