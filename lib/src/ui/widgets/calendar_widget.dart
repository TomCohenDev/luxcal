import 'package:LuxCal/core/theme/pallette.dart';
import 'package:LuxCal/core/theme/typography.dart';
import 'package:LuxCal/src/models/event_model.dart';
import 'package:LuxCal/src/services/api/fetch_jew_holidays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:LuxCal/src/blocs/calendar/calendar_bloc.dart';
import 'package:LuxCal/src/ui/widgets/elevated_container_card.dart';
import 'package:kosher_dart/kosher_dart.dart';

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
                  context
                      .read<CalendarBloc>()
                      .add(GetHolidaysForYear(year: dateTime.year));
                  Navigator.pop(context, dateTime);
                },
              ),
            ),
          ),
        );
      },
    );
    print("picked day $picked");
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
                  defaultBuilder: (context, day, focusedDay) {
                    final geoString =
                        "${day.month.toString()}.${day.day.toString()}";
                    final jewMonthString =
                        JewishDate.fromDateTime(day).toString().split(' ')[1];
                    final jewDayString =
                        JewishDate.fromDateTime(day).toString().split(' ')[0];
                    String hebrew = "$jewDayString $jewMonthString";
                    if (jewMonthString.length > 4) {
                      hebrew =
                          "$jewDayString ${jewMonthString.substring(0, 4)}";
                    }
                    return Container(
                      // margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppPalette.jacarta,
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(geoString,
                              style: AppTypography.calendarDays
                                  .copyWith(fontSize: 14)),
                          Text(hebrew,
                              style: AppTypography.calendarDays.copyWith(
                                  fontSize: 11,
                                  color: const Color.fromARGB(
                                      174, 255, 255, 255))),
                        ],
                      ),
                    );
                  },
                  selectedBuilder: (context, day, focusedDay) {
                    final geoString =
                        "${day.month.toString()}.${day.day.toString()}";
                    final jewMonthString =
                        JewishDate.fromDateTime(day).toString().split(' ')[1];
                    final jewDayString =
                        JewishDate.fromDateTime(day).toString().split(' ')[0];
                    String hebrew = "$jewDayString $jewMonthString";
                    if (jewMonthString.length > 4) {
                      // take the first 4 characters from jewMonthString
                      hebrew =
                          "$jewDayString ${jewMonthString.substring(0, 4)}";
                    }

                    return Container(
                        // margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppPalette.teal,
                          shape: BoxShape.circle,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(geoString,
                                style: AppTypography.calendarDays
                                    .copyWith(fontSize: 14)),
                            Text(hebrew,
                                style: AppTypography.calendarDays.copyWith(
                                    fontSize: 11,
                                    color: const Color.fromARGB(
                                        174, 255, 255, 255))),
                          ],
                        ));
                  },
                  todayBuilder: (context, day, focusedDay) {
                    final geoString =
                        "${day.month.toString()}.${day.day.toString()}";
                    final jewMonthString =
                        JewishDate.fromDateTime(day).toString().split(' ')[1];
                    final jewDayString =
                        JewishDate.fromDateTime(day).toString().split(' ')[0];
                    String hebrew = "$jewDayString $jewMonthString";
                    if (jewMonthString.length > 4) {
                      // take the first 4 characters from jewMonthString

                      hebrew =
                          "$jewDayString ${jewMonthString.substring(0, 4)}";
                    }

                    return Container(
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 77, 70, 116),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3))
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(geoString,
                                style: AppTypography.calendarDays
                                    .copyWith(fontSize: 14)),
                            Text(hebrew,
                                style: AppTypography.calendarDays.copyWith(
                                    fontSize: 11,
                                    color: const Color.fromARGB(
                                        174, 255, 255, 255))),
                          ],
                        ));
                  },
                  markerBuilder: (context, date, events) {
                    return _buildEventsMarker(
                        date, events, state.focusedDay, state.selectedDay);
                  },
                  outsideBuilder: (context, day, focusedDay) {
                    final geoString =
                        "${day.month.toString()}.${day.day.toString()}";
                    final jewMonthString =
                        JewishDate.fromDateTime(day).toString().split(' ')[1];
                    final jewDayString =
                        JewishDate.fromDateTime(day).toString().split(' ')[0];
                    String hebrew = "$jewDayString $jewMonthString";
                    if (jewMonthString.length > 4) {
                      // take the first 4 characters from jewMonthString

                      hebrew =
                          "$jewDayString ${jewMonthString.substring(0, 4)}";
                    }

                    return Container(
                      // margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppPalette.jacarta,
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(geoString,
                              style: AppTypography.calendarDays.copyWith(
                                  fontSize: 14,
                                  color: Color.fromARGB(97, 255, 255, 255))),
                          Text(hebrew,
                              style: AppTypography.calendarDays.copyWith(
                                  fontSize: 11,
                                  color: Color.fromARGB(73, 255, 255, 255))),
                        ],
                      ),
                    );
                  },
                ),
                eventLoader: (date) {
                  // Normalize the query date to match the keys in your events map
                  final normalizedDate =
                      DateTime.utc(date.year, date.month, date.day);
                  return events[normalizedDate] ?? [];
                },
                calendarStyle: _calendarStyle(),
                headerStyle: _headerStyle(state),
                daysOfWeekStyle: _dayOfTheWeekStyle(),
                firstDay: DateTime(DateTime.now().year - 100, 1),
                lastDay: DateTime(DateTime.now().year + 100, 1),
                focusedDay: state.focusedDay,
                selectedDayPredicate: (day) =>
                    isSameDay(day, state.selectedDay),
                onDaySelected: (selectedDay, focusedDay) async {
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

  Widget _buildEventsMarker(DateTime date, List<EventModel> events,
      DateTime focusedDay, DateTime selectedDay) {
    return Padding(
        padding: const EdgeInsets.only(top: 44),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return Container(
              margin: const EdgeInsets.only(right: 2.0, bottom: 5, left: 2),
              decoration: BoxDecoration(color: event.color),
              width: 9.0,
              height: 9.0,
            );
          },
        ));
  }

  HeaderStyle _headerStyle(CalendarState state) => HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextFormatter: (date, locale) {
          String hebMonthName = '';
          JewishDate jewishDate = JewishDate.fromDateTime(date);
          print("picked jew day $jewishDate");
          var parts = jewishDate.toString().split(' ');

          if (parts.length >= 3) {
            hebMonthName = parts[1];
          }
          return "$hebMonthName  |  ${DateFormat.yMMMM(locale).format(date)}";
        },
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
            child: Icon(Icons.chevron_left, color: Colors.white)),
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
                  offset: const Offset(0, 3))
            ]),
        markerDecoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      );
  DaysOfWeekStyle _dayOfTheWeekStyle() => DaysOfWeekStyle(
        weekdayStyle: AppTypography.dayoftheweek,
        weekendStyle: AppTypography.dayoftheweek,
      );
}
