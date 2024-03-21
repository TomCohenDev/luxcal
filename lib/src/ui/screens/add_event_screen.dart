import 'dart:io';

import 'package:LuxCal/core/theme/pallette.dart';
import 'package:LuxCal/core/theme/typography.dart';
import 'package:LuxCal/src/blocs/calendar/calendar_bloc.dart';
import 'package:LuxCal/src/models/event_model.dart';
import 'package:LuxCal/src/ui/widgets/custom_scaffold.dart';
import 'package:LuxCal/src/ui/widgets/elevated_container_card.dart';
import 'package:LuxCal/src/ui/widgets/event_fields_widget.dart';
import 'package:LuxCal/src/ui/widgets/spacer.dart';
import 'package:LuxCal/src/ui/widgets/textfield.dart';
import 'package:LuxCal/src/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  Color pickedColor = Colors.red;
  XFile? pickedImage;

  void _onButtonPress() {
    if (formKey.currentState?.validate() ?? false) {
      final EventModel newEvent = EventModel(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(), // unique ID for the new event
        title: titleController.text,
        description: descriptionController.text,
        startDate: startDate!,
        endDate: endDate!,

        color: pickedColor,
        location: locationController.text,
      );

      context.read<CalendarBloc>().add(AddEvent(newEvent, pickedImage));
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              _buttonrow(context),
              Column(
                children: [
                  _header(),
                  spacer(20),
                  _form(),
                  spacer(20),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: Color.fromARGB(255, 255, 135, 61),
        shape: CircleBorder(),
        child: Icon(
          FontAwesomeIcons.check,
          size: 60,
          color: Colors.white,
        ),
        onPressed: () {
          _onButtonPress();
        },
      ),
    );
  }

  Widget _form() => Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _titleFromField(),
                    spacerWidth(10),
                    _colorFormField(),
                  ],
                ),
                spacer(20),
                _datesFromField(),
                spacer(20),
                _locationFromField(),
                spacer(20),
                _descriptionFromField(),
              ],
            )),
      );

  Widget _colorFormField() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Container(
        height: 45,
        width: 45,
        padding: EdgeInsets.all(1.5),
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: AppPalette.jacarta,
                  content: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: MaterialColorPicker(
                      allowShades: false,
                      selectedColor: pickedColor,
                      spacing: 15,
                      onMainColorChange: (colorSwatch) {
                        final int colorValue = colorSwatch!.value;
                        setState(() => pickedColor = Color(colorValue));
                        context.pop();
                      },
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            decoration:
                BoxDecoration(color: pickedColor, shape: BoxShape.circle),
          ),
        ),
      ),
    );
  }

  Widget _datesFromField() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Event Duration:",
            style: AppTypography.textFieldText.copyWith(fontSize: 16),
          ),
        ),
        spacer(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IntrinsicWidth(
              child: ElevatedContainerCard(
                  height: context.height * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (date != null) {
                              setState(() {
                                startDate = date;
                              });
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Start Date:   ",
                                style: AppTypography.textFieldText
                                    .copyWith(fontSize: 13),
                              ),
                              Text(
                                startDate != null
                                    ? "${startDate!.day}/${startDate!.month}/${startDate!.year.toString().split('0')[1]}"
                                    : "DD/MM/YY",
                                style: AppTypography.textFieldText
                                    .copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        spacer(10),
                        InkWell(
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (date != null) {
                              setState(() {
                                endDate = date;
                              });
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "End Date:   ",
                                style: AppTypography.textFieldText
                                    .copyWith(fontSize: 13),
                              ),
                              Text(
                                endDate != null
                                    ? "${endDate!.day}/${endDate!.month}/${endDate!.year.toString().split('0')[1]}"
                                    : "DD/MM/YY",
                                style: AppTypography.textFieldText
                                    .copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            spacerWidth(10),
            IntrinsicWidth(
              child: ElevatedContainerCard(
                  height: context.height * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            final time = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            if (time != null) {
                              setState(() {
                                startDate = startDate!.copyWith(
                                  hour: time.hour,
                                  minute: time.minute,
                                );
                              });
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Start Time:   ",
                                style: AppTypography.textFieldText
                                    .copyWith(fontSize: 13),
                              ),
                              Text(
                                startDate != null
                                    ? "${startDate!.hour}:${startDate!.minute}"
                                    : "hh:mm",
                                style: AppTypography.textFieldText
                                    .copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        spacer(10),
                        InkWell(
                          onTap: () async {
                            final time = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            if (time != null) {
                              setState(() {
                                endDate = endDate!.copyWith(
                                  hour: time.hour,
                                  minute: time.minute,
                                );
                              });
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "End Time:   ",
                                style: AppTypography.textFieldText
                                    .copyWith(fontSize: 13),
                              ),
                              Text(
                                endDate != null
                                    ? "${endDate!.hour}:${endDate!.minute}"
                                    : "hh:mm",
                                style: AppTypography.textFieldText
                                    .copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  } 

  Widget _titleFromField() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Event Title:",
              style: AppTypography.textFieldText.copyWith(fontSize: 16),
            ),
          ),
          spacer(10),
          Container(
            width: context.width * 0.8,
            child: EventFieldsTextfield(
              textField: TextField(
                controller: titleController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Event Title",
                ),
              ),
            ),
          ),
        ],
      );

  Widget _locationFromField() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Location:",
              style: AppTypography.textFieldText.copyWith(fontSize: 16),
            ),
          ),
          spacer(10),
          Container(
            width: context.width * 0.94,
            child: EventFieldsTextfield(
              textField: TextField(
                controller: locationController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Location",
                ),
              ),
            ),
          ),
        ],
      );

  Widget _descriptionFromField() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Description:",
              style: AppTypography.textFieldText.copyWith(fontSize: 16),
            ),
          ),
          spacer(10),
          Stack(
            children: [
              Container(
                width: context.width * 0.94,
                child: IntrinsicHeight(
                  child: EventFieldsTextfield(
                    textField: TextField(
                      expands: true,
                      minLines: null,
                      maxLines: null,
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: "Description",
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0.95, 1),
                child: IconButton(
                    onPressed: () async {
                      final ImagePicker _picker = ImagePicker();
                      // Pick an image from the gallery (or use .pickImage(source: ImageSource.camera) for taking a new photo)
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);

                      // If an image is picked, update the state with the new image
                      if (image != null) {
                        setState(() {
                          pickedImage = image;
                        });
                      }
                    },
                    icon: Icon(
                      Icons.image,
                      color: Color.fromARGB(211, 7, 197, 255),
                      size: 40,
                    )),
              ),
            ],
          ),
        ],
      );

  Text _header() {
    return Text('Create Event',
        style: GoogleFonts.getFont("Poppins",
            fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold));
  }

  Widget _buttonrow(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, right: 10, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              onTap: () {
                context.pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: Color(0xffFCB833),
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
