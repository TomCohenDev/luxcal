import 'package:LuxCal/core/theme/pallette.dart';
import 'package:LuxCal/core/theme/typography.dart';
import 'package:LuxCal/src/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:LuxCal/src/blocs/calendar/calendar_bloc.dart';
import 'package:LuxCal/src/ui/widgets/elevated_container_card.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  // Utility method to group events by their start date
  Map<DateTime, List<EventModel>> _groupEventsByDate(List<EventModel> events) {
    Map<DateTime, List<EventModel>> data = {};
    for (var event in events) {
      // Get the range of dates from startDate to endDate
      DateTime startDate = event.startDate;
      final endDate = event.endDate;

      // While the current date is not after the end date, add the event to that date
      while (!startDate.isAfter(endDate)) {
        final date =
            DateTime.utc(startDate.year, startDate.month, startDate.day);
        data.putIfAbsent(date, () => []).add(event);

        // Move to the next day
        startDate = startDate.add(Duration(days: 1));
      }
    }
    return data;
  }

  Future<void> _selectYear(BuildContext context, DateTime focusedDay) async {
    final DateTime? picked = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppPalette.jacarta,
          content: SizedBox(
            // Need to use container to add size constraint.
            width: 300,
            height: 300,
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.dark(),
              ),
              child: YearPicker(
                firstDate: DateTime(DateTime.now().year - 100, 1),
                lastDate: DateTime(DateTime.now().year + 100, 1),
                selectedDate: focusedDay,
                onChanged: (DateTime dateTime) {
                  Navigator.pop(context, dateTime);
                },
              ),
            ),
          ),
        );
      },
    );
    print(picked);
    if (picked != null && picked != focusedDay) {
      BlocProvider.of<CalendarBloc>(context)
          .add(YearSelected(focusedDay: picked));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0, left: 4),
      child: ElevatedContainerCard(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: BlocBuilder<CalendarBloc, CalendarState>(
            builder: (context, state) {
              final events = _groupEventsByDate(state.events!);
              return TableCalendar<EventModel>(
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    return _buildEventsMarker(date, events);
                  },
                ),
                eventLoader: (date) {
                  // Normalize the query date to match the keys in your events map
                  final normalizedDate =
                      DateTime.utc(date.year, date.month, date.day);
                  return events[normalizedDate] ?? [];
                },
                calendarStyle: _calendarStyle(),
                headerStyle: _headerStyle(),
                daysOfWeekStyle: _dayOfTheWeekStyle(),
                firstDay: DateTime(DateTime.now().year - 100, 1),
                lastDay: DateTime(DateTime.now().year + 100, 1),
                focusedDay: state.focusedDay,
                selectedDayPredicate: (day) =>
                    isSameDay(day, state.selectedDay),
                onDaySelected: (selectedDay, focusedDay) {
                  BlocProvider.of<CalendarBloc>(context).add(DaySelected(
                      selectedDay: selectedDay, focusedDay: focusedDay));
                },
                calendarFormat: state.calendarFormat,
                onHeaderTapped: (focusedDay) {
                  _selectYear(context, focusedDay);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List<EventModel> events) {
    return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: event.color),
              width: 9.0,
              height: 9.0,
            );
          },
        ));
  }

  HeaderStyle _headerStyle() => HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextFormatter: (date, locale) =>
            DateFormat.yMMMM(locale).format(date),
        titleTextStyle: AppTypography.calendarTitle,
        leftChevronIcon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppPalette.teal,
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
              Icons.chevron_left,
              color: Colors.white,
            )),
        rightChevronIcon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppPalette.teal,
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
              Icons.chevron_right,
              color: Colors.white,
            )),
        headerPadding: EdgeInsets.only(top: 10, bottom: 6),
        headerMargin: EdgeInsets.only(bottom: 8),
      );

  CalendarStyle _calendarStyle() => CalendarStyle(
      outsideDaysVisible: true,
      weekendTextStyle: AppTypography.calendarDays,
      holidayTextStyle: AppTypography.calendarDays,
      todayTextStyle: AppTypography.calendarDays,
      defaultTextStyle: AppTypography.calendarDays,
      selectedTextStyle: AppTypography.calendarDays,
      selectedDecoration:
          BoxDecoration(color: AppPalette.teal, shape: BoxShape.circle),
      todayDecoration: BoxDecoration(
        color: const Color.fromARGB(255, 77, 70, 116),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      markerDecoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      )
      // defaultDecoration: BoxDecoration(
      //   shape: BoxShape.rectangle,
      //   borderRadius: BorderRadius.circular(8.0),
      // ),
      // weekendDecoration: BoxDecoration(
      //   shape: BoxShape.rectangle,
      //   borderRadius: BorderRadius.circular(8.0),
      // ),
      // markerDecoration: BoxDecoration(
      //   color: Colors.brown,
      //   shape: BoxShape.circle,
      // ),
      // rowDecoration: BoxDecoration(
      //     // Add any additional row styling here
      //     ),
      );
  DaysOfWeekStyle _dayOfTheWeekStyle() => DaysOfWeekStyle(
        weekdayStyle: AppTypography.dayoftheweek,
        weekendStyle: AppTypography.dayoftheweek,
      );
}
