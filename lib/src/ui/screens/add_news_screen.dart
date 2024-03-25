import 'package:LuxCal/core/theme/pallette.dart';
import 'package:LuxCal/core/theme/typography.dart';
import 'package:LuxCal/src/blocs/calendar/calendar_bloc.dart';
import 'package:LuxCal/src/models/event_model.dart';
import 'package:LuxCal/src/models/news_model.dart';
import 'package:LuxCal/src/ui/widgets/custom_scaffold.dart';
import 'package:LuxCal/src/ui/widgets/elevated_container_card.dart';
import 'package:LuxCal/src/ui/widgets/event_fields_widget.dart';
import 'package:LuxCal/src/ui/widgets/spacer.dart';
import 'package:LuxCal/src/ui/widgets/textfield.dart';
import 'package:LuxCal/src/utils/auth_utils.dart';
import 'package:LuxCal/src/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({super.key});

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController headlineController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  XFile? pickedImage;

  void _onButtonPress() {
    if (formKey.currentState?.validate() ?? false) {
      // Assuming form validation is passed
      final NewsModel newNews = NewsModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        author: AuthUtils.currentUser.fullName!,
        headline: headlineController.text,
        content: contentController.text,
        publicationDate: DateTime.now(),
        authorId: AuthUtils.currentUserId
      );

      context.read<CalendarBloc>().add(AddNews(newNews, pickedImage));
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
                _headlineFromField(),
                spacer(20),
                _contentFromField(),
              ],
            )),
      );

  Widget _headlineFromField() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Headline:",
              style: AppTypography.textFieldText.copyWith(fontSize: 16),
            ),
          ),
          spacer(10),
          Container(
            width: context.width * 0.94,
            child: EventFieldsTextfield(
              textField: TextField(
                controller: headlineController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Headline",
                ),
              ),
            ),
          ),
        ],
      );

  Widget _contentFromField() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Content:",
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
                      controller: contentController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: "Content",
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
    return Text('Add News',
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
