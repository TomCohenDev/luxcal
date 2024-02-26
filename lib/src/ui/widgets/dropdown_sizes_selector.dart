import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revampedai/aaacore/theme/theme.dart';
import 'package:revampedai/aaacore/theme/typography.dart';
import 'package:revampedai/aaasrc/blocs/onboarding/onboarding_bloc.dart';
import 'package:revampedai/backend/api_requests/person_measurement.dart';

import 'dotten_line_widget.dart';
import 'dropdown_internal.dart';

class DropdownSizesSelector extends StatefulWidget {
  String? initialValue;
  // final String text;
  final bool? reverseLine;
  final double? lineLength;
  final String unit;
  final String category;
  final String? fireabseField;
  final String? val;

  // final bool isShoe;
  final void Function(String)? onChange;

  DropdownSizesSelector({
    Key? key,
    this.initialValue,
    // required this.text,
    required this.unit,
    required this.category,
    this.val,

    // this.isShoe = false,
    this.reverseLine = false,
    this.onChange,
    this.fireabseField,
    this.lineLength = 140,
  }) : super(key: key);

  @override
  State<DropdownSizesSelector> createState() => _DropdownSizesSelectorState();
}

class _DropdownSizesSelectorState extends State<DropdownSizesSelector> {
  String? dropdownValue;
  String? initialValue;

  String getInitialValue() {
    final sizes = context.read<OnboardingBloc>().onboardingSizes;
    switch (widget.category) {
      case "TOPS":
        return getInitialValueFromSizeStandart(
            sizes.top_eu!, sizes.top_uk!, sizes.top_us!);
      case "DRESSES":
        return getInitialValueFromSizeStandart(
            sizes.dress_eu!, sizes.dress_uk!, sizes.dress_us!);
      case "JEANS":
        return getInitialValueFromSizeStandart(
            sizes.jeans_eu!, sizes.jeans_uk!, sizes.jeans_us!);
      case "PANTS":
        return getInitialValueFromSizeStandart(
            sizes.bottom_eu!, sizes.bottom_uk!, sizes.bottom_us!);
      case "SHOES":
        return getInitialValueFromSizeStandart(
            sizes.shoe_eu!, sizes.shoe_uk!, sizes.shoe_us!);
    }
    return "";
  }

  String getInitialValueFromSizeStandart(
    String size_eu,
    String size_uk,
    String size_us,
  ) {
    switch (widget.unit) {
      case "EU":
        return size_eu;
      case "UK":
        return size_uk;
      case "US":
        return size_us;
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        initialValue = getInitialValue();
        return Container(
          width: widget.lineLength,
          // height: 60,
          color: Color.fromARGB(0, 111, 108, 255),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  dropdownSizes(),
                  dottenLine(),
                  sizeText(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget dropdownSizes() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(bottom: 13),
        child: Align(
            alignment: widget.reverseLine!
                ? AlignmentDirectional(0.8, 1)
                : AlignmentDirectional(-0.8, 1),
            child: DropdownInternalWidget(
              val: widget.val,
              onChange: widget.onChange,
              category: widget.category,
              unit: widget.unit,
              initialValue: initialValue!,
              reverseLine: widget.reverseLine!,
            )),
      ),
    );
  }

  Widget dottenLine() => Padding(
        padding: EdgeInsets.only(bottom: 12.5),
        child: DottedLineWidget(
          lineLength: widget.lineLength,
          lineThickness: 2.0,
          dashLength: 2.0,
          dashColor: context.theme.colorScheme.secondary,
          dashGapLength: 2.0,
          dashRadius: 10.0,
          reverse: widget.reverseLine,
        ),
      );

  Widget sizeText() => Align(
        alignment: widget.reverseLine!
            ? AlignmentDirectional(1, 1)
            : AlignmentDirectional(-1, 1),
        child: Padding(
          padding: widget.reverseLine!
              ? const EdgeInsets.only(right: 12.0)
              : const EdgeInsets.only(left: 12.0),
          child: Text(widget.category, style: AppTypography.dropdownBottomText),
        ),
      );
}
