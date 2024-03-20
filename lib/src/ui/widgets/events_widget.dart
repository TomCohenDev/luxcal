import 'package:LuxCal/core/theme/pallette.dart';
import 'package:LuxCal/core/theme/typography.dart';
import 'package:LuxCal/src/blocs/calendar/calendar_bloc.dart';
import 'package:LuxCal/src/ui/widgets/elevated_container_card.dart';
import 'package:LuxCal/src/ui/widgets/spacer.dart';
import 'package:LuxCal/src/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EventsWidget extends StatefulWidget {
  const EventsWidget({super.key});

  @override
  State<EventsWidget> createState() => _EventsWidgetState();
}

class _EventsWidgetState extends State<EventsWidget> {
  int tabIndex = 1;
  Alignment alignment = Alignment(-1, -1);

  void chooseTab(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalendarBloc, CalendarState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          width: context.width,
          color: Color.fromARGB(0, 0, 0, 0),
          child: Stack(
            children: [
              tabContainers(context, state),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: ElevatedContainerCard(
                  width: context.width,
                  height: context.height * 0.25,
                  boxShaow: BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 20),
                  ),
                  child: Container(),
                ),
              ),
              Align(
                alignment: const Alignment(0.95, -0.99),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: AppPalette.jacarta,
                          title: Center(
                            child: Text("Add",
                                style: AppTypography.buttonText
                                    .copyWith(fontSize: 24)),
                          ),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(Color(
                                            0xFF185478)), // Replace with your color
                                  ),
                                  onPressed: () {
                                    context.pop();

                                    context.push("/addEvent");
                                  },
                                  child: Text("Event",
                                      style: AppTypography.buttonText
                                          .copyWith(fontSize: 16))),
                              spacerWidth(20),
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 24, 120,
                                                38)), // Replace with your color
                                  ),
                                  onPressed: () {
                                    context.pop();

                                    context.push("/addNews");
                                  },
                                  child: Text("News",
                                      style: AppTypography.buttonText
                                          .copyWith(fontSize: 16)))
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppPalette.jacarta,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      size: 28,
                      Icons.add,
                      color: AppPalette.light_green,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget tabContainers(BuildContext context, CalendarState state) {
    return Row(
      children: [
        _tabContainer("Upcoming", 1),
        _tabContainer("News", 2),
        _tabContainer("${state.selectedDay.day}.${state.selectedDay.month}", 3),
      ],
    );
  }

  Widget _tabContainer(String text, int index) {
    return InkWell(
      onTap: () {
        chooseTab(index);
      },
      child: Container(
        height: 100,
        padding: EdgeInsets.only(top: 10, bottom: 4, right: 8, left: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: tabIndex == index ? AppPalette.jacarta : Colors.transparent),
        child: Text(
          text,
          style: AppTypography.eventsWidgetText.copyWith(
              color: tabIndex == index
                  ? AppPalette.light_green
                  : const Color.fromARGB(155, 255, 255, 255)),
        ),
      ),
    );
  }
}
