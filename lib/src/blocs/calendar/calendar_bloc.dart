import 'dart:async';
import 'dart:io';

import 'package:LuxCal/src/models/news_model.dart'; // Ensure this import path is correct
import 'package:LuxCal/src/models/event_model.dart'; // Assuming you have an Event model; add this import if needed
import 'package:LuxCal/src/models/user_model.dart';
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

  CalendarBloc() : super(CalendarState.initial()) {
    on<DaySelected>(_onDaySelected);
    on<YearSelected>(_onYearSelected);
    on<ChangeTab>(_onChangeTab);
    on<InilaizeCalendar>(_initialzeCalendar);
    on<AddEvent>(_onAddEvent);
    on<AddNews>(_onAddNews);

    add(InilaizeCalendar());
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
    List<EventModel> events = await _getEvents();
    final news = await _getNews();
    events.addAll(await _getHebrewEvents());
    emit(state.copyWith(
        contacts: contacts,
        events: events,
        news: news,
        status: CalendarStatus.loaded));
  }

  // Retrieves the contacts from Firestore and updates the state.
  Future<List<UserModel>> _getContacts() async {
    final snapshot = await _firestore.collection('users').get();
    return snapshot.docs
        .map((doc) => UserModel.fromFirestore(doc.data()))
        .toList();
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

  List<EventModel> _getHebrewEvents() {
    return [];
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
