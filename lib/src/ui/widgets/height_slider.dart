import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeightSlider extends StatefulWidget {
  final int maxHeight;
  final int minHeight;
  final double widgetHeight;
  final double widgetWidth;
  final String unit;
  final String? personImagePath;
  final Color numberLineColor;

  final ValueChanged<int> onChange;
  int personHeight;

  HeightSlider({
    Key? key,
    required this.onChange,
    this.numberLineColor = const Color(0xFF514DFF),
    this.maxHeight = 190,
    this.minHeight = 140,
    required this.widgetHeight,
    required this.widgetWidth,
    this.unit = 'inch',
    required this.personHeight,
    this.personImagePath,
  }) : super(key: key);

  int get totalUnits => maxHeight - minHeight;

  @override
  _HeightSliderState createState() => _HeightSliderState();
}

class _HeightSliderState extends State<HeightSlider> {
  double _currentSliderValue = 160;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.widgetHeight,
      width: widget.widgetWidth,
      decoration: BoxDecoration(
        color: Color.fromARGB(0, 0, 0, 0),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          numberLine(),
          svgImage(),
          sliderWidget(),
        ],
      ),
    );
  }

  Widget indicatorLineSlider() {
    return Container(
      height: 43,
      color: Color.fromARGB(0, 255, 193, 7),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: sliderLabel(),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: List.generate(
                    40,
                    (i) => Expanded(
                          child: Container(
                            height: 2.0,
                            decoration: BoxDecoration(
                                color: i.isEven
                                    ? widget.numberLineColor
                                    : Colors.transparent),
                          ),
                        )),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                color: widget.numberLineColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.unfold_more,
                color: Colors.white,
                size: 0.6 * 32.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sliderLabel() {
    return Center(
      child: Text(
        widget.unit == "inch"
            ? "${_currentSliderValue ~/ 30.48}' ${((_currentSliderValue % 30.48) / 2.54).round()}\""
            : "${_currentSliderValue.toInt()} cm",
        style: TextStyle(
          fontSize: 16.0,
          color: widget.numberLineColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget sliderWidget() {
    double x = -0.0226 * _currentSliderValue + 3.292;
    return Container(
      child: Stack(
        children: [
          Align(
            alignment: Alignment(0, x),
            child: indicatorLineSlider(),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 20.0,
              activeTickMarkColor: Colors.transparent,
              activeTrackColor: Colors.transparent,
              disabledActiveTickMarkColor: Colors.transparent,
              disabledActiveTrackColor: Colors.transparent,
              disabledInactiveTickMarkColor: Colors.transparent,
              disabledInactiveTrackColor: Colors.transparent,
              disabledThumbColor: Colors.transparent,
              inactiveTickMarkColor: Colors.transparent,
              disabledSecondaryActiveTrackColor: Colors.transparent,
              inactiveTrackColor: Colors.transparent,
              overlappingShapeStrokeColor: Colors.transparent,
              overlayColor: Colors.transparent,
              secondaryActiveTrackColor: Colors.transparent,
              thumbColor: Colors.transparent,
              valueIndicatorColor: Colors.transparent,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
              valueIndicatorTextStyle: TextStyle(
                color: Colors.transparent,
              ),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
            ),
            child: Transform.rotate(
              angle: -math.pi / 2,
              alignment: Alignment(0, -0.4),
              child: Container(
                color: Color.fromARGB(0, 0, 0, 0),
                width: widget.widgetHeight * 0.53,
                child: Slider(
                  activeColor: Colors.transparent,
                  value: _currentSliderValue,
                  min: widget.minHeight.toDouble(),
                  max: widget.maxHeight.toDouble(),
                  divisions: widget.totalUnits,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                      widget.onChange(_currentSliderValue.toInt());
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget numberLine() {
    // Calculate the normalized slider value (from 0.0 to 1.0)
    double normalizedSliderValue = (_currentSliderValue - widget.minHeight) /
        (widget.maxHeight - widget.minHeight);

    // Adjusted start and end points for sliderPercent
    double startPercent = 0.12;
    double endPercent = 1.0;

    // Interpolate sliderPercent between startPercent and endPercent
    double sliderPercent =
        startPercent + (endPercent - startPercent) * normalizedSliderValue;

    // Calculate sliderFilledHeight based on sliderPercent
    double sliderFilledHeight = widget.widgetHeight * 0.6 * sliderPercent;

    return Align(
      alignment: Alignment(0.9, -1),
      child: Container(
        height: widget.widgetHeight * 0.6,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 15), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 0 /*paddingTop*/),
                child: Container(
                  height: sliderFilledHeight, //filledHeight,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 206, 94, 177),
                        Color.fromARGB(255, 250, 205, 116),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            _drawLabels(stepCM: 10, stepINCH: 10),
          ],
        ),
      ),
    );
  }

  Widget svgImage() {
    double imageHeight = 0.0112 * _currentSliderValue - 1.128;
    double paddingTop = 0.4 * _currentSliderValue - 56;
    paddingTop = math.max(0, paddingTop);
    paddingTop = math.min(20, paddingTop);
    return Align(
      alignment: Alignment(0.5, 1),
      child: Container(
        height: widget.widgetHeight * imageHeight,
        child: Padding(
          padding: EdgeInsets.only(top: paddingTop),
          child: SvgPicture.asset(
            "assets/images/person.svg",
            fit: BoxFit.contain,
            // height: personImageHeight,
            // width: personImageHeight / 3,
          ),
        ),
      ),
    );
  }

  Widget _drawLabels({int? stepCM, int? stepINCH}) {
    int range = (widget.maxHeight - widget.minHeight) ~/
            (widget.unit == "inch" ? stepINCH! : stepCM!) +
        1;

    List<Widget> labels = List.generate(
      range,
      (idx) {
        return Text(
          widget.unit == "inch"
              ? "${((widget.maxHeight - stepINCH! * idx) ~/ 30.48)}'${(((widget.maxHeight - stepINCH * idx) % 30.48) / 2.54).round()}\""
              : "${widget.maxHeight - stepCM! * idx}",
          style: TextStyle(
              color: _currentSliderValue >= (widget.maxHeight - stepCM! * idx)
                  ? Colors.white
                  : widget.numberLineColor,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        );
      },
    );

    return IgnorePointer(
      child: Padding(
        padding: EdgeInsets.only(
          // right: 12.0,
          bottom: 12.0,
          top: 12.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: labels,
        ),
      ),
    );
  }
}
