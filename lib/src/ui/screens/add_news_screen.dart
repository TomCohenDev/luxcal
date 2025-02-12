import 'dart:typed_data'; // For Uint8List
import 'package:LuxCal/core/theme/pallette.dart';
import 'package:LuxCal/core/theme/typography.dart';
import 'package:LuxCal/src/blocs/calendar/calendar_bloc.dart';
import 'package:LuxCal/src/models/news_model.dart';
import 'package:LuxCal/src/ui/widgets/custom_scaffold.dart';
import 'package:LuxCal/src/ui/widgets/event_fields_widget.dart';
import 'package:LuxCal/src/ui/widgets/spacer.dart';
import 'package:LuxCal/src/ui/widgets/textfield.dart';
import 'package:LuxCal/src/utils/auth_utils.dart';
import 'package:LuxCal/src/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  Uint8List? _imageBytes; // Used for cross-platform image preview
  bool isUploading = false;

  /// This method uses your original upload logic.
  /// It dispatches the event to add the news, shows a loading overlay,
  /// waits for a simulated upload (replace with your actual mechanism),
  /// and then pops the screen.
  Future<void> _onButtonPress() async {
    if (formKey.currentState?.validate() ?? false) {
      setState(() {
        isUploading = true;
      });

      final newNews = NewsModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        author: AuthUtils.currentUser.fullName!,
        headline: headlineController.text,
        content: contentController.text,
        publicationDate: DateTime.now(),
        authorId: AuthUtils.currentUserId,
        authorNickname: AuthUtils.currentUser.nickName!,
      );

      try {
        // Dispatch your original upload event.
        context.read<CalendarBloc>().add(AddNews(newNews, pickedImage));

        // Simulate waiting for the upload to complete.
        await Future.delayed(const Duration(seconds: 2));

        // After upload completes, pop the screen.
        if (mounted) {
          context.pop();
        }
      } catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Failed to upload news. Please try again."),
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            isUploading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _buttonRow(context),
                  _header(),
                  spacer(20),
                  _form(),
                  spacer(20),
                ],
              ),
            ),
            if (isUploading)
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: const Color.fromARGB(255, 255, 135, 61),
        shape: const CircleBorder(),
        child: const Icon(
          FontAwesomeIcons.check,
          size: 60,
          color: Colors.white,
        ),
        onPressed: isUploading ? null : _onButtonPress,
      ),
    );
  }

  Widget _form() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headlineFormField(),
              // Show image preview if an image is picked.
              if (_imageBytes != null) ...[
                spacer(20),
                Container(
                  width: context.width * 0.94,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(
                      _imageBytes!,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
              spacer(20),
              _contentFormField(),
            ],
          ),
        ),
      );

  Widget _headlineFormField() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              "Headline:",
              style: AppTypography.textFieldText,
            ),
          ),
          spacer(10),
          Container(
            width: context.width * 0.94,
            child: EventFieldsTextfield(
              textField: TextField(
                controller: headlineController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "Headline",
                ),
              ),
            ),
          ),
        ],
      );

  Widget _contentFormField() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              "Content:",
              style: AppTypography.textFieldText,
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
                      decoration: const InputDecoration(
                        labelText: "Content",
                      ),
                    ),
                  ),
                ),
              ),
              // Image picker button.
              Positioned(
                right: 0,
                bottom: 0,
                child: IconButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      final bytes = await image.readAsBytes();
                      setState(() {
                        pickedImage = image;
                        _imageBytes = bytes;
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.image,
                    color: Color.fromARGB(211, 7, 197, 255),
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  Widget _header() {
    return Text(
      'Add News',
      style: GoogleFonts.getFont(
        "Poppins",
        fontSize: 35,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buttonRow(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, right: 10, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => context.pop(),
              child: const Icon(
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
