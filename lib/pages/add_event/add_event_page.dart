import 'dart:io';

import 'package:LuxCal/backend/auth/auth_util.dart';
import 'package:LuxCal/backend/auth/firebase_user_provider.dart';
import 'package:LuxCal/widgets/custom/button.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';

import '../../backend/records/event_record.dart';
import '../../utils/utils.dart';
import '../../widgets/custom/model.dart';
import 'add_event_logic.dart';
import 'add_event_model.dart';
import 'colors.dart';
import 'constants.dart';
import 'date_time_selector.dart';
import 'event.dart';
import 'package:intl/intl.dart';

class AddEventPage extends StatefulWidget {
  final bool withDuration;

  const AddEventPage({Key? key, this.withDuration = false}) : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: AddEventWidget(
            onEventAdd: (p0) => Navigator.pop(context),
          ),
        ),
      ),
    );
  }
}

class AddEventWidget extends StatefulWidget {
  final void Function(CalendarEventData<Event>)? onEventAdd;

  const AddEventWidget({
    Key? key,
    this.onEventAdd,
  }) : super(key: key);

  @override
  _AddEventWidgetState createState() => _AddEventWidgetState();
}

class _AddEventWidgetState extends State<AddEventWidget> {
  late AddEventModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddEventModel());
  }

  @override
  void dispose() {
    super.dispose();
    _model.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _model.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: AppConstants.inputDecoration.copyWith(
                labelText: "Event Title",
              ),
              style: TextStyle(
                color: AppColors.black,
                fontSize: 17.0,
              ),
              onSaved: (value) => _model.title = value?.trim() ?? "",
              validator: (value) {
                if (value == null || value == "")
                  return "Please enter event title.";

                return null;
              },
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(width: 20.0),
            Row(
              children: [
                Expanded(
                  child: DateTimeSelectorFormField(
                    controller: _model.startDateController,
                    decoration: AppConstants.inputDecoration.copyWith(
                      labelText: "Start Time",
                    ),
                    validator: (value) {
                      if (value == null || value == "")
                        return "Please select date.";

                      return null;
                    },
                    textStyle: TextStyle(
                      color: AppColors.black,
                      fontSize: 17.0,
                    ),
                    onSelect: (date) async {
                      if (date != null) {
                        // _model.startDate = date;
                        final startTime = await selectTime(context);
                        _model.startDate = DateTime(date.year, date.month,
                            date.day, startTime.hour, startTime.minute);
                        print(_model.startDate);
                      }
                    },
                    type: DateTimeSelectionType.date,
                  ),
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: DateTimeSelectorFormField(
                    controller: _model.endDateController,
                    decoration: AppConstants.inputDecoration.copyWith(
                      labelText: "End Time",
                    ),
                    validator: (value) {
                      if (value == null || value == "")
                        return "Please select date";

                      try {
                        DateTime startDate = DateFormat('dd/MM/yyyy')
                            .parse(_model.startDateController.text);
                        DateTime endDate = DateFormat('dd/MM/yyyy')
                            .parse(_model.endDateController.text);

                        if (endDate.isBefore(startDate)) {
                          return "End Date is after Start Date";
                        }
                      } catch (e) {
                        return "Invalid date format";
                      }
                      return null;
                    },
                    textStyle: TextStyle(
                      color: AppColors.black,
                      fontSize: 17.0,
                    ),
                    // onSave: (date) => _model.endDate = date,
                    onSelect: (date) async {
                      if (date != null) {
                        // _model.endDate = date;
                        final endTime = await selectTime(context);
                        _model.endDate = DateTime(date.year, date.month,
                            date.day, endTime.hour, endTime.minute);
                      }
                    },
                    type: DateTimeSelectionType.date,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              focusNode: _model.descriptionNode,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 17.0,
              ),
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              selectionControls: MaterialTextSelectionControls(),
              minLines: 1,
              maxLines: 10,
              maxLength: 1000,
              validator: (value) {
                if (value == null || value.trim() == "")
                  return "Please enter event description.";

                return null;
              },
              onSaved: (value) => _model.description = value?.trim() ?? "",
              decoration: AppConstants.inputDecoration.copyWith(
                hintText: "Event Description",
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Text(
                  "Event Color: ",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 17,
                  ),
                ),
                GestureDetector(
                  onTap: _displayColorPicker,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: _model.color,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            imagePreview(_model.selectedImage),
            ElevatedButton(
              onPressed: () async {
                File? image = await pickImage();
                setState(() {
                  _model.selectedImage = image;
                });
              },
              child: Text("Pick Image"),
            ),
            CustomMainButton(
              onPressed: () {
                createEvent(context, _model, widget.onEventAdd);
              },
              buttonText: "Add Event",
            ),
          ],
        ),
      ),
    );
  }

  Widget imagePreview(File? selectedImage) {
    if (selectedImage == null) {
      return Text("No image selected.");
    }
    return Image.file(selectedImage);
  }

  void _displayColorPicker() {
    var color = _model.color;
    showDialog(
      context: context,
      useSafeArea: true,
      barrierColor: Colors.black26,
      builder: (_) => SimpleDialog(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(
            color: AppColors.bluishGrey,
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.all(20.0),
        children: [
          Text(
            "Event Color",
            style: TextStyle(
              color: AppColors.black,
              fontSize: 25.0,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            height: 1.0,
            color: AppColors.bluishGrey,
          ),
          ColorPicker(
            displayThumbColor: true,
            enableAlpha: false,
            pickerColor: color,
            onColorChanged: (c) {
              color = c;
            },
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 30.0),
              child: CustomMainButton(
                buttonText: "Select",
                onPressed: () {
                  if (mounted)
                    setState(() {
                      _model.color = color;
                    });
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
