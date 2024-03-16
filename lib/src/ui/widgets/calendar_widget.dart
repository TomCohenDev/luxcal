import 'package:LuxCal/core/theme/pallette.dart';
import 'package:LuxCal/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:LuxCal/src/blocs/calendar/calendar_bloc.dart';
import 'package:LuxCal/src/ui/widgets/elevated_container_card.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({Key? key}) : super(key: key);

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
              print(state.focusedDay);
              return TableCalendar(
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

                // eventLoader: (day) {
                //   // Optionally, implement event loader logic if needed based on the state's events
                //   return state.events
                //           ?.where((event) => isSameDay(event.date, day))
                //           .toList() ??
                //       [];
                // },
              );
            },
          ),
        ),
      ),
    );
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
