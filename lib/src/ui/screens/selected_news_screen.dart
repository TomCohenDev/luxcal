import 'package:LuxCal/core/theme/pallette.dart';
import 'package:LuxCal/core/theme/typography.dart';
import 'package:LuxCal/src/blocs/calendar/calendar_bloc.dart';
import 'package:LuxCal/src/models/news_model.dart';
import 'package:LuxCal/src/ui/widgets/custom_scaffold.dart';
import 'package:LuxCal/src/ui/widgets/elevated_container_card.dart';
import 'package:LuxCal/src/ui/widgets/event_fields_widget.dart';
import 'package:LuxCal/src/ui/widgets/spacer.dart';
import 'package:LuxCal/src/utils/auth_utils.dart';
import 'package:LuxCal/src/utils/screen_size.dart';
import 'package:LuxCal/src/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class SelectedNewsScreen extends StatefulWidget {
  final NewsModel newsModel;
  const SelectedNewsScreen({super.key, required this.newsModel});

  @override
  State<SelectedNewsScreen> createState() => _SelectedNewsScreenState();
}

class _SelectedNewsScreenState extends State<SelectedNewsScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController headlineController;
  late TextEditingController contentController;
  late String autherName;
  late String autherNickname;

  Color backgroundColor = Color(0xff875FC0);
  Color fieldColor = Color(0xff6533AB);

  XFile? pickedImage;

  @override
  void initState() {
    headlineController =
        TextEditingController(text: widget.newsModel.headline ?? "");
    contentController =
        TextEditingController(text: widget.newsModel.content ?? "");

    autherName = widget.newsModel.author;
    autherNickname = widget.newsModel.authorNickname;
    super.initState();
  }

  bool isAuther() {
    return (AuthUtils.currentUserId == widget.newsModel.authorId) ||
        AuthUtils.isAppAdmin;
  }

  @override
  void dispose() {
    headlineController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              _buttonrow(context),
              IgnorePointer(
                ignoring: !isAuther(),
                child: Column(
                  children: [
                    _header(widget.newsModel.headline!),
                    spacer(20),
                    _form(),
                    spacer(20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _form() => Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isAuther() ? _titleFromField() : _autherFromField(),
                spacer(20),
                _descriptionFromField(),
              ],
            )),
      );

  Widget _titleFromField() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spacer(10),
          Container(
            child: EventFieldsTextfield(
              textField: TextField(
                controller: headlineController,
                keyboardType: TextInputType.name,
                decoration:
                    InputDecoration(fillColor: fieldColor, filled: true),
              ),
              validator: (value) => Validators.eventTitleValidator(value),
            ),
          ),
        ],
      );

  Widget _autherFromField() => Stack(
        children: [
          spacer(10),
          EventFieldsTextfield(
            textField: TextField(
              keyboardType: TextInputType.name,
              readOnly: true,
              enabled: false,
              decoration: InputDecoration(
                labelText: "",
                fillColor: fieldColor,
                filled: true,
              ),
            ),
            validator: (value) => Validators.eventTitleValidator(value),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 12),
            child: Row(
              children: [
                Text(
                  "${autherNickname}",
                  style: AppTypography.textFieldText,
                ),
                spacerWidth(20),
                Text(
                  "${autherName}",
                  style: AppTypography.textFieldTextLight,
                ),
              ],
            ),
          ),
        ],
      );

  Widget _descriptionFromField() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.newsModel.imageUrl != null)
            ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(widget.newsModel.imageUrl!)),
          spacer(10),
          Stack(
            children: [
              SizedBox(
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
                        fillColor: fieldColor,
                      ),
                    ),
                  ),
                ),
              ),
              if (isAuther())
                Align(
                  alignment: Alignment(0.95, 1),
                  child: IconButton(
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        // Pick an image from the gallery (or use .pickImage(source: ImageSource.camera) for taking a new photo)
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery);

                        // If an image is picked, update the state with the new image
                        if (image != null) {
                          setState(() {
                            pickedImage = image;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.image,
                        color: Colors.black,
                        size: 40,
                      )),
                ),
            ],
          ),
        ],
      );

  Text _header(String title) {
    return Text(title,
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
                final NewsModel updatedNews = widget.newsModel.copyWith(
                  headline: headlineController.text,
                  content: contentController.text,
                );
                if (pickedImage != null) {
                  BlocProvider.of<CalendarBloc>(context)
                      .add(UpdateNews(updatedNews: updatedNews));
                } else {
                  BlocProvider.of<CalendarBloc>(context).add(UpdateNews(
                      updatedNews: updatedNews, pickedImage: pickedImage));
                }

                context.pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30,
              ),
            ),
            if (isAuther())
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: AppPalette.jacarta,
                        title: Center(
                          child: Text("Delete News?",
                              style: AppTypography.buttonText
                                  .copyWith(fontSize: 24)),
                        ),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color.fromARGB(255, 170, 20, 0),
                                  ), // Replace with your color
                                ),
                                onPressed: () {
                                  context.read<CalendarBloc>().add(
                                      DeleteNews(newsId: widget.newsModel.id!));
                                  context.pop();
                                  context.pop();
                                },
                                child: Text("Yes",
                                    style: AppTypography.buttonText
                                        .copyWith(fontSize: 16))),
                            spacerWidth(20),
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color.fromARGB(255, 134, 143, 216),
                                  ), // Replace with your color
                                ),
                                onPressed: () {
                                  context.pop();
                                },
                                child: Text("No",
                                    style: AppTypography.buttonText
                                        .copyWith(fontSize: 16)))
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 30,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
