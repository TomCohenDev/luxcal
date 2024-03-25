import 'dart:async';
import 'dart:io';

import 'package:LuxCal/src/models/news_model.dart'; // Ensure this import path is correct
import 'package:LuxCal/src/models/event_model.dart'; // Assuming you have an Event model; add this import if needed
import 'package:LuxCal/src/models/user_model.dart';
import 'package:LuxCal/src/services/api/fetch_jew_holidays.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:table_calendar/table_calendar.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  List<int> gottenYears = [];

  CalendarBloc() : super(CalendarState.initial()) {
    on<DaySelected>(_onDaySelected);
    on<YearSelected>(_onYearSelected);
    on<ChangeTab>(_onChangeTab);
    on<InilaizeCalendar>(_initialzeCalendar);
    on<AddEvent>(_onAddEvent);
    on<AddNews>(_onAddNews);
    on<DeleteEvent>(_onDeleteEvent);
    on<DeleteNews>(_onDeleteNews);
    on<UpdateEvent>(_onUpdateEvent);
    on<UpdateNews>(_onUpdateNews);
    on<GetHolidaysForYear>(_onGetHolidaysForYear);
    add(InilaizeCalendar());
  }
  Future<void> _onGetHolidaysForYear(
      GetHolidaysForYear event, Emitter<CalendarState> emit) async {
    if (gottenYears.contains(event.year)) {
      return;
    }
    gottenYears.add(event.year);
    try {
      // Fetch holiday events for the given year
      final holidayEvents = await fetchHolidays(event.year);

      // Fetch the existing events from the state or Firestore
      final existingEvents = state.events ?? await _getEvents();

      // Combine the existing events with the holiday events
      final allEvents = List<EventModel>.from(existingEvents)
        ..addAll(holidayEvents);

      // Emit the updated state with the combined events list
      emit(state.copyWith(events: allEvents));
    } catch (error) {
      print("Failed to fetch holiday events: $error");
      // Optionally, handle the error by emitting a failure state or showing a message
    }
  }

  Future<void> _onUpdateEvent(
      UpdateEvent event, Emitter<CalendarState> emit) async {
    try {
      String? pickedImage;

      if (event.pickedImage != null) {
        pickedImage = await _uploadImageToStorage(
            event.pickedImage!, 'event/${event.updatedEvent.id}/image.jpg');
      }

      final docRef = await _firestore
          .collection('events')
          .where("id", isEqualTo: event.updatedEvent.id)
          .get()
          .then((value) => value.docs.first.reference);
      if (event.pickedImage != null) {
        final finalEvent = event.updatedEvent.copyWith(imageUrl: pickedImage);
        await docRef.update(finalEvent.toFirestore());
      } else {
        await docRef.update(event.updatedEvent.toFirestore());
      }
      List<EventModel> updatedEvents = await _getEvents();
      emit(state.copyWith(events: updatedEvents));
    } catch (error) {
      print("Failed to update event: $error");
    }
  }

  Future<void> _onUpdateNews(
      UpdateNews event, Emitter<CalendarState> emit) async {
    try {
      String? pickedImage;
      if (event.pickedImage != null) {
        if (event.pickedImage != null) {
          pickedImage = await _uploadImageToStorage(
              event.pickedImage!, 'news/${event.updatedNews.id}/image.jpg');
        }
      }

      final docRef = await _firestore
          .collection('news')
          .where("id", isEqualTo: event.updatedNews.id)
          .get()
          .then((value) => value.docs.first.reference);

      if (event.pickedImage != null) {
        final finalNews = event.updatedNews.copyWith(imageUrl: pickedImage);
        await docRef.update(finalNews.toFirestore());
      } else {
        await docRef.update(event.updatedNews.toFirestore());
      }
      List<NewsModel> updatedNews = await _getNews();
      emit(state.copyWith(news: updatedNews));
    } catch (error) {
      print("Failed to update news: $error");
    }
  }

  Future<void> _onDeleteEvent(
      DeleteEvent event, Emitter<CalendarState> emit) async {
    try {
      // Delete the event from Firestore
      await _firestore
          .collection('events')
          .where("id", isEqualTo: event.eventId)
          .get()
          .then(
        (value) {
          value.docs.first.reference.delete();
        },
      );

      // Fetch the updated list of events
      List<EventModel> updatedEvents = await _getEvents();

      // Emit the new state with the updated events list
      emit(state.copyWith(events: updatedEvents));
    } catch (error) {
      print("Failed to delete event: $error");
      // Optionally, handle the error by emitting a failure state or showing a message
    }
  }

  Future<void> _onDeleteNews(
      DeleteNews event, Emitter<CalendarState> emit) async {
    try {
      // Delete the event from Firestore
      await _firestore
          .collection('news')
          .where("id", isEqualTo: event.newsId)
          .get()
          .then(
        (value) {
          value.docs.first.reference.delete();
        },
      );

      // Fetch the updated list of events
      List<NewsModel> updatedNews = await _getNews();

      // Emit the new state with the updated events list
      emit(state.copyWith(news: updatedNews));
    } catch (error) {
      print("Failed to delete event: $error");
      // Optionally, handle the error by emitting a failure state or showing a message
    }
  }

  void _onAddNews(AddNews event, Emitter<CalendarState> emit) async {
    try {
      String? imageUrl;
      if (event.image != null) {
        imageUrl = await _uploadImageToStorage(
            event.image!, 'news/${event.news.id}/image.jpg');
      }

      await _firestore
          .collection('news')
          .add(event.news.copyWith(imageUrl: imageUrl).toFirestore());
      List<NewsModel> updatedNews = await _getNews();
      emit(state.copyWith(news: updatedNews));
    } catch (error) {
      print(error);
    }
  }

  FutureOr<void> _onAddEvent(
      AddEvent event, Emitter<CalendarState> emit) async {
    try {
      String? imageUrl;
      if (event.image != null) {
        imageUrl = await _uploadImageToStorage(
            event.image!, 'events/${event.event.id}/image.jpg');
      }

      await _firestore
          .collection('events')
          .add(event.event.copyWith(imageUrl: imageUrl).toFirestore());
      List<EventModel> updatedEvents = await _getEvents();
      emit(state.copyWith(events: updatedEvents));
    } catch (error) {
      print(error);
    }
  }

  void _onDaySelected(DaySelected event, Emitter<CalendarState> emit) {
    emit(state.copyWith(
        selectedDay: event.selectedDay, focusedDay: event.focusedDay));
  }

  void _onYearSelected(YearSelected event, Emitter<CalendarState> emit) {
    emit(state.copyWith(focusedDay: event.focusedDay));
  }

  FutureOr<void> _onChangeTab(ChangeTab event, Emitter<CalendarState> emit) {
    emit(state.copyWith(tab: event.tab));
  }

  FutureOr<void> _initialzeCalendar(
      InilaizeCalendar event, Emitter<CalendarState> emit) async {
    emit(state.copyWith(status: CalendarStatus.loadingInfo));
    final contacts = await _getContacts();
    final existingEvents = await _getEvents(); // Events from Firestore
    final currentYear = DateTime.now().year;
    gottenYears.add(currentYear);
    final holidayEvents = await fetchHolidays(
        currentYear); // Fetch holiday events for the current year
    final news = await _getNews(); // Fetch news
    final allEvents = List<EventModel>.from(existingEvents)
      ..addAll(holidayEvents);
    emit(state.copyWith(
      contacts: contacts,
      events: allEvents,
      news: news,
      status: CalendarStatus.loaded,
    ));
  }

  // Retrieves the contacts from Firestore and updates the state.
  Future<List<UserModel>> _getContacts() async {
    final snapshot = await _firestore.collection('users').get();
    return snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
  }

  // Retrieves the events from Firestore and updates the state.
  Future<List<EventModel>> _getEvents() async {
    final snapshot = await _firestore.collection('events').get();
    return snapshot.docs
        .map((doc) => EventModel.fromFirestore(doc.data()))
        .toList();
  }

  // Retrieves news from Firestore and updates the state.
  Future<List<NewsModel>> _getNews() async {
    final snapshot = await _firestore.collection('news').get();
    return snapshot.docs
        .map((doc) => NewsModel.fromFirestore(doc.data()))
        .toList();
  }

// Assuming 'image' is an XFile object obtained from image_picker
  Future<String> _uploadImageToStorage(XFile image, String targetPath) async {
    try {
      // Create a reference to the location you want to upload to in Firebase Storage
      final ref = _storage.ref(targetPath);

      // Upload the file
      final uploadTask = await ref.putFile(File(image.path));

      // Once the file upload is complete, get the download URL
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      // Return the download URL of the image
      return downloadUrl;
    } catch (e) {
      // If something goes wrong, log the error and rethrow or return a default value
      print(e); // Consider logging to a service or console
      throw e; // Or you might want to return a default image URL or an empty string
    }
  }
}
