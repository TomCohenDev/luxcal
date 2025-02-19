import 'package:LuxCal/core/theme/typography.dart';
import 'package:LuxCal/src/blocs/auth/auth_bloc.dart';
import 'package:LuxCal/src/blocs/calendar/calendar_bloc.dart';
import 'package:LuxCal/src/models/user_model.dart';
import 'package:LuxCal/src/ui/widgets/custom_scaffold.dart';
import 'package:LuxCal/src/ui/widgets/elevated_container_card.dart';
import 'package:LuxCal/src/ui/widgets/event_fields_widget.dart';
import 'package:LuxCal/src/ui/widgets/spacer.dart';
import 'package:LuxCal/src/ui/widgets/textfield.dart';
import 'package:LuxCal/src/ui/widgets/textfield2.dart';
import 'package:LuxCal/src/utils/auth_utils.dart';
import 'package:LuxCal/src/utils/extensions.dart';
import 'package:LuxCal/src/utils/screen_size.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../widgets/export_user_data_stub.dart'
    if (dart.library.html) '../widgets/exportUserData.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  Color selectedColor = AuthUtils.currentUser.nickNameColor ?? Colors.blue;
  final TextEditingController contactNameController = TextEditingController();
  List<UserModel> filteredContacts = [];

  @override
  void initState() {
    super.initState();
    contactNameController.addListener(_filterContacts);
  }

  @override
  void dispose() {
    contactNameController.dispose();
    nicknameController.dispose();
    fullNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  void _filterContacts() {
    final query = contactNameController.text.toLowerCase();
    final bloc = context.read<CalendarBloc>();
    final allContacts = bloc.state.contacts ?? [];
    if (query.isEmpty) {
      setState(() {
        filteredContacts = allContacts;
      });
    } else {
      setState(() {
        filteredContacts = allContacts.where((contact) {
          return contact.fullName!.toLowerCase().contains(query) ||
              (contact.nickName?.toLowerCase().contains(query) ?? false) ||
              contact.phoneNumber!.contains(query);
        }).toList();
      });
    }
  }

  Color getfieldColor(Color backgroundColor) {
    int r = (backgroundColor.red + 18 <= 255) ? backgroundColor.red + 18 : 255;
    int g =
        (backgroundColor.green + 18 <= 255) ? backgroundColor.green + 18 : 255;
    int b =
        (backgroundColor.blue + 18 <= 255) ? backgroundColor.blue + 18 : 255;

    return Color.fromARGB(backgroundColor.alpha, r, g, b);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: BlocBuilder<CalendarBloc, CalendarState>(
            builder: (context, state) {
              if (state.contacts != null &&
                  contactNameController.text.isEmpty) {
                filteredContacts = state.contacts!;
              }

              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  _buttonrow(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kIsWeb ? 400 : 0.0),
                    child: Column(
                      children: [
                        _header(),
                        spacer(20),
                        _searchBar(),
                        spacer(20),
                        _contactsList(),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Text _header() {
    return Text(kIsWeb ? 'LuxCal Users' : 'Contacts',
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
            if (!kIsWeb) _profileButton(context),
            if (kIsWeb)
              Padding(
                padding: const EdgeInsets.only(right: 250.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Assuming that `state.contacts` is a List<UserModel>.
                    final userList =
                        context.read<CalendarBloc>().state.contacts;
                    if (userList != null && userList.isNotEmpty) {
                      exportUserDataToExcel(userList);
                    } else {
                      print("No user data available to export.");
                    }
                  },
                  child: Text("Export to Excel"),
                ),
              ),
          ],
        ),
      ),
    );
  }

  InkWell _profileButton(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: selectedColor,
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () {
                            context.pop();
                            final userModel = AuthUtils.currentUser.copyWith(
                                fullName: fullNameController.text,
                                nickName: nicknameController.text,
                                nickNameColor: Color(selectedColor.value));
                            context
                                .read<AuthBloc>()
                                .add(UserUpdated(userModel));
                          },
                          icon: Icon(
                            Icons.close,
                            size: 30,
                            color: Colors.white,
                          )),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text('Profile',
                          style: GoogleFonts.getFont("Poppins",
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                spacer(15),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Nickname:",
                        style:
                            AppTypography.textFieldText.copyWith(fontSize: 16),
                      ),
                    ),
                    spacer(10),
                    Container(
                      width: context.width * 0.8,
                      child: EventFieldsTextfield(
                        textField: TextField(
                          controller: nicknameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              fillColor: getfieldColor(selectedColor)),
                        ),
                      ),
                    ),
                  ],
                ),
                spacer(15),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Full Name:",
                        style:
                            AppTypography.textFieldText.copyWith(fontSize: 16),
                      ),
                    ),
                    spacer(10),
                    Container(
                      width: context.width * 0.8,
                      child: EventFieldsTextfield(
                        textField: TextField(
                          controller: fullNameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              fillColor: getfieldColor(selectedColor)),
                        ),
                      ),
                    ),
                  ],
                ),
                spacer(15),
                Container(
                  height: 100,
                  child: SingleChildScrollView(
                    child: MaterialColorPicker(
                      allowShades: false,
                      selectedColor: selectedColor,
                      spacing: 15,
                      onMainColorChange: (colorSwatch) {
                        final int colorValue = colorSwatch!.value;
                        setState(() => selectedColor = Color(colorValue));
                        AuthUtils.currentUser.nickNameColor = Color(colorValue);
                      },
                    ),
                  ),
                )
              ]),
            );
          },
        );
      },
      child: Icon(
        Icons.person,
        color: Color(0xff86D8CA),
        size: 40,
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      height: 50,
      width: context.width * 0.9,
      child: CustomTextField(
        textField: TextField(
          controller: contactNameController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _contactsList() {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: filteredContacts.length,
          itemBuilder: (context, index) {
            final contact = filteredContacts[index];
            if (contact.email == 'admin@luxcal.com') {
              return SizedBox.shrink();
            }
            return _contactTile(contact);
          },
        );
      },
    );
  }

  Widget _contactTile(UserModel contactModel) {
    Color backgroundColor =
        contactModel.nickNameColor ?? Colors.blue; // example color
    String? nickname = contactModel.nickName;

    return Container(
      padding: EdgeInsets.all(10), // add padding
      margin: EdgeInsets.symmetric(
          vertical: 6, horizontal: 6), // add margin between tiles
      decoration: BoxDecoration(
        color: backgroundColor, // use the dynamic color here
        borderRadius: BorderRadius.circular(40), // round the corners
      ),
      child: ListTile(
        title: Text(contactModel.fullName ?? "",
            style: AppTypography.buttonText
                .copyWith(fontSize: 24, fontWeight: FontWeight.w700)),
        subtitle: Text(nickname ?? "",
            style: AppTypography.buttonText
                .copyWith(fontSize: 20, fontWeight: FontWeight.w200)),
        trailing: Icon(kIsWeb ? FontAwesomeIcons.gear : FontAwesomeIcons.phone,
            color: Colors.white), // phone icon on the right
        onTap: () async {
          fullNameController.text = contactModel.fullName!;
          nicknameController.text = contactModel.nickName!;
          phoneNumberController.text = contactModel.phoneNumber!;

          if (kIsWeb) {
            await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Color(contactModel.nickNameColor!.value),
                  content: Column(mainAxisSize: MainAxisSize.min, children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                              onPressed: () {
                                context.pop();
                                final userModel = contactModel.copyWith(
                                  fullName: fullNameController.text,
                                  nickName: nicknameController.text,
                                  phoneNumber: phoneNumberController.text,
                                );

                                final _firestore = FirebaseFirestore.instance;
                                _firestore
                                    .collection('users')
                                    .doc(contactModel.uid)
                                    .update(userModel.toDocument());

                                setState(() {});
                              },
                              icon: Icon(
                                Icons.close,
                                size: 30,
                                color: Colors.white,
                              )),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              onPressed: () async {
                                await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Delete Contact'),
                                        content: Text(
                                            'Are you sure you want to delete this contact?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              context.pop();
                                            },
                                            child: Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              context.pop();
                                              // final _firestore =
                                              //     FirebaseFirestore.instance;
                                              // _firestore
                                              //     .collection('users')
                                              //     .doc(contactModel.uid)
                                              //     .delete();
                                              deleteUserViaHttp(
                                                  contactModel.uid!);
                                            },
                                            child: Text('Delete'),
                                          ),
                                        ],
                                      );
                                    });
                                context.pop();

                                // context
                                //     .read<AuthBloc>()
                                //     .add(UserUpdated(userModel));
                              },
                              icon: Icon(
                                Icons.delete,
                                size: 30,
                                color: Colors.white,
                              )),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text('Profile',
                              style: GoogleFonts.getFont("Poppins",
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    spacer(15),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Nickname:",
                            style: AppTypography.textFieldText
                                .copyWith(fontSize: 16),
                          ),
                        ),
                        spacer(10),
                        Container(
                          width: context.width * 0.25,
                          child: EventFieldsTextfield(
                            textField: TextField(
                              controller: nicknameController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  fillColor: getfieldColor(selectedColor)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    spacer(15),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Full Name:",
                            style: AppTypography.textFieldText
                                .copyWith(fontSize: 16),
                          ),
                        ),
                        spacer(10),
                        Container(
                          width: context.width * 0.25,
                          child: EventFieldsTextfield(
                            textField: TextField(
                              controller: fullNameController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  fillColor: getfieldColor(selectedColor)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    spacer(10),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Phone Number:",
                            style: AppTypography.textFieldText
                                .copyWith(fontSize: 16),
                          ),
                        ),
                        spacer(10),
                        Container(
                          width: context.width * 0.25,
                          child: EventFieldsTextfield(
                            textField: TextField(
                              controller: phoneNumberController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  fillColor: getfieldColor(selectedColor)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                );
              },
            );
          } else {
            _makePhoneCall(contactModel.phoneNumber!);
          }
        },
      ),
    );
  }

  Future<void> deleteUserViaHttp(String uid) async {
    final url = Uri.parse(
        'https://us-central1-luxcal-75a29.cloudfunctions.net/deleteUser');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          // Add any required authentication headers here.
        },
        body: jsonEncode({'uid': uid}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data['message']);
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (error) {
      print('Error deleting user via HTTP: $error');
    }
  }
}
