import 'package:LuxCal/src/blocs/calendar/calendar_bloc.dart';
import 'package:LuxCal/src/ui/widgets/calendar_widget.dart';
import 'package:LuxCal/src/ui/widgets/custom_scaffold.dart';
import 'package:LuxCal/src/ui/widgets/elevated_container_card.dart';
import 'package:LuxCal/src/ui/widgets/events_widget.dart';
import 'package:LuxCal/src/ui/widgets/spacer.dart';
import 'package:LuxCal/src/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalendarBloc, CalendarState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return CustomScaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _header(),
                      spacer(20),
                      _calendar(context),
                      _events(context),
                    ],
                  ),
                  _contactsButton(context),
                  _settingsButton(context)
                ],
              ),
            ),
          ),
          drawer: _buildDrawer(context),
        );
      },
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => Scaffold.of(context).openDrawer(),
          ),
        ],
      ),
    );
  }

  Padding _contactsButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment(0.9, -1),
        child: InkWell(
          onTap: () {
            context.push("/profile");
          },
          child: Image.asset(
            'assets/icons/contacts.png',
            scale: 0.9,
          ),
        ),
      ),
    );
  }

  Widget _settingsButton(BuildContext context) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Align(
          alignment: Alignment(-0.9, -1),
          child: InkWell(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Icon(
              Icons.list,
              size: 40,
              color: Colors.amber,
            ),
          ),
        ),
      );
    });
  }

  Widget _calendar(BuildContext context) {
    return CalendarWidget();
  }

  Text _header() {
    return Text('Calendar',
        style: GoogleFonts.getFont("Poppins",
            fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold));
  }

  Widget _events(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, right: 10, left: 10),
      child: EventsWidget(),
    );
  }
}
