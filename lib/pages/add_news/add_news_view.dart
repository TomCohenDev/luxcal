import 'package:LuxCal/backend/auth/auth_util.dart';
import 'package:flutter/material.dart';

import '../add_event/constants.dart';
import '../add_event/date_time_selector.dart';
import '../../backend/records/news_record.dart';
import '../../widgets/custom/button.dart';

class AddNewsPage extends StatefulWidget {
  @override
  _AddNewsPageState createState() => _AddNewsPageState();
}

class _AddNewsPageState extends State<AddNewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: AddNewsWidget(
            onNewsAdd: (news) => Navigator.pop(context),
          ),
        ),
      ),
    );
  }
}

class AddNewsWidget extends StatefulWidget {
  final void Function(NewsRecord)? onNewsAdd;

  const AddNewsWidget({Key? key, this.onNewsAdd}) : super(key: key);

  @override
  _AddNewsWidgetState createState() => _AddNewsWidgetState();
}

class _AddNewsWidgetState extends State<AddNewsWidget> {
  final GlobalKey<FormState> _form = GlobalKey();

  String _headline = "";
  DateTime _publishedDate = DateTime.now();
  String _author = "";
  String _content = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: AppConstants.inputDecoration.copyWith(
                labelText: "Headline",
              ),
              onSaved: (value) => _headline = value?.trim() ?? "",
              validator: (value) {
                if (value == null || value == "")
                  return "Please enter a headline.";

                return null;
              },
            ),
            SizedBox(height: 15),
            // DateTimeSelectorFormField(
            //   decoration: AppConstants.inputDecoration.copyWith(
            //     labelText: "Published Date",
            //   ),
            //   validator: (value) {
            //     if (value == null || value == "")
            //       return "Please select a published date.";

            //     return null;
            //   },
            //   onSave: (date) => _publishedDate = date!,
            //   type: DateTimeSelectionType.date,
            // ),
            SizedBox(height: 15),
            TextFormField(
              decoration: AppConstants.inputDecoration.copyWith(
                labelText: "Author",
              ),
              onSaved: (value) => _author = value?.trim() ?? "",
              validator: (value) {
                if (value == null || value == "")
                  return "Please enter an author.";

                return null;
              },
            ),
            SizedBox(height: 15),
            TextFormField(
              decoration: AppConstants.inputDecoration.copyWith(
                labelText: "Content",
              ),
              onSaved: (value) => _content = value?.trim() ?? "",
              validator: (value) {
                if (value == null || value == "")
                  return "Please enter content.";

                return null;
              },
              maxLines: 10,
            ),
            SizedBox(height: 15),
            CustomMainButton(
              onPressed: _createNews,
              buttonText: "Add News",
            ),
          ],
        ),
      ),
    );
  }

  void _createNews() async {
    if (!(_form.currentState?.validate() ?? true)) return;

    _form.currentState?.save();

    Map<String, dynamic> newsData = createNewsRecordData(
      headline: _headline,
      publishedDate: _publishedDate,
      author: currentUserDocument!.uid,
      content: _content,
    );

    await NewsRecord.collection.add(newsData);

    _resetForm();
  }

  void _resetForm() {
    _form.currentState?.reset();
  }
}
