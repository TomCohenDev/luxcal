import 'package:LuxCal/src/blocs/calendar/calendar_bloc.dart';
import 'package:LuxCal/src/models/user_model.dart';
import 'package:LuxCal/src/ui/widgets/custom_scaffold.dart';
import 'package:LuxCal/src/ui/widgets/spacer.dart';
import 'package:LuxCal/src/ui/widgets/textfield.dart';
import 'package:LuxCal/src/utils/extensions.dart';
import 'package:LuxCal/src/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController contactNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            _buttonrow(context),
            Column(
              children: [
                _header(),
                spacer(20),
                _searchBar(),
                spacer(20),
                _contactsList(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Text _header() {
    return Text('Contacts',
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
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog();
                  },
                );
              },
              child: Icon(
                Icons.person,
                color: Color(0xff86D8CA),
                size: 40,
              ),
            ),
          ],
        ),
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
          shrinkWrap: true,
          itemCount: state.contacts!.length,
          itemBuilder: (context, index) {
            return _contactTile(state.contacts![index]);
          },
        );
      },
    );
  }

  Widget _contactTile(UserModel contactModel) {
    // You might want to dynamically assign colors or icons based on some property of the contactModel
    Color backgroundColor = Colors.blue; // example color
    IconData iconData = Icons.person; // default icon
    String nickname =
        contactModel.nickName!; // assuming the UserModel has a nickname field

    // You might have a function to choose the color and icon based on the contactModel
    // backgroundColor = _getColorForContact(contactModel);
    // iconData = _getIconForContact(contactModel);

    return Container(
      padding: EdgeInsets.all(10), // add padding
      margin: EdgeInsets.symmetric(vertical: 4), // add margin between tiles
      decoration: BoxDecoration(
        color: backgroundColor, // use the dynamic color here
        borderRadius: BorderRadius.circular(10), // round the corners
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white, // Icon background color
          child: Icon(iconData, color: Colors.black), // The icon itself
        ),
        title:
            Text(contactModel.fullName!, style: TextStyle(color: Colors.white)),
        subtitle: Text(nickname, style: TextStyle(color: Colors.white)),
        trailing:
            Icon(Icons.phone, color: Colors.white), // phone icon on the right
        onTap: () {
          // action to perform on tap, like opening contact details or initiating a call
        },
      ),
    );
  }
}
