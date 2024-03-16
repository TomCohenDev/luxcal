import 'package:LuxCal/core/theme/pallette.dart';
import 'package:LuxCal/core/theme/typography.dart';
import 'package:LuxCal/src/blocs/calendar/calendar_bloc.dart';
import 'package:LuxCal/src/ui/widgets/elevated_container_card.dart';
import 'package:LuxCal/src/ui/widgets/spacer.dart';
import 'package:LuxCal/src/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsWidget extends StatefulWidget {
  const EventsWidget({super.key});

  @override
  State<EventsWidget> createState() => _EventsWidgetState();
}

class _EventsWidgetState extends State<EventsWidget> {
  String tabText = 'Upcoming';
  Alignment alignment = Alignment(-1, -1);

  void chooseTab(String newTabText, Alignment newAlignment) {
    setState(() {
      tabText = newTabText;
      alignment = newAlignment;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalendarBloc, CalendarState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          height: context.height,
          width: context.width,
          color: Color.fromARGB(0, 0, 0, 0),
          child: Stack(
            children: [
              Align(
                alignment: alignment,
                child: Container(
                  height: 200,
                  padding:
                      EdgeInsets.only(top: 10, bottom: 4, right: 8, left: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppPalette.jacarta,
                  ),
                  child: Text(
                    tabText,
                    style: AppTypography.eventsWidgetText
                        .copyWith(color: Colors.transparent),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: ElevatedContainerCard(
                  boxShaow: BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 20),
                  ),
                  child: Container(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        chooseTab("Upcoming", Alignment(-1, -1));
                        context
                            .read<CalendarBloc>()
                            .add(ChangeTab(tab: CalendarTabs.upcoming));
                      },
                      child: Text(
                        "Upcoming",
                        style: AppTypography.eventsWidgetText.copyWith(
                            color: tabText == "Upcoming"
                                ? AppPalette.light_green
                                : const Color.fromARGB(155, 255, 255, 255)),
                      ),
                    ),
                    spacerWidth(25),
                    InkWell(
                      onTap: () {
                        chooseTab("News", Alignment(-0.21, -1));
                        context
                            .read<CalendarBloc>()
                            .add(ChangeTab(tab: CalendarTabs.news));
                      },
                      child: Text(
                        "News",
                        style: AppTypography.eventsWidgetText.copyWith(
                            color: tabText == "News"
                                ? AppPalette.light_green
                                : const Color.fromARGB(155, 255, 255, 255)),
                      ),
                    ),
                    spacerWidth(25),
                    InkWell(
                      onTap: () {
                        chooseTab("Selection", Alignment(0.456, -1));
                        context
                            .read<CalendarBloc>()
                            .add(ChangeTab(tab: CalendarTabs.selected));
                      },
                      child: Text(
                        "Selection",
                        style: AppTypography.eventsWidgetText.copyWith(
                            color: tabText == "Selection"
                                ? AppPalette.light_green
                                : const Color.fromARGB(155, 255, 255, 255)),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment(0.95, -0.99),
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
                    child: Icon(
                      size: 28,
                      Icons.add,
                      color: AppPalette.light_green,
                    )),
              ),
            ],
          ),
        );
      },
    );
  }
}
