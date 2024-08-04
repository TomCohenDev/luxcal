import 'dart:io';
import 'dart:typed_data';

import 'package:LuxCal/src/utils/auth_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saver_gallery/saver_gallery.dart';

class EventGalleryScreen extends StatefulWidget {
  final String eventId;
  final bool isMaker;
  const EventGalleryScreen(
      {super.key, required this.eventId, required this.isMaker});

  @override
  _EventGalleryScreenState createState() => _EventGalleryScreenState();
}

class _EventGalleryScreenState extends State<EventGalleryScreen> {
  Future<List<String>> _fetchImageUrls() async {
    List<String> imageUrls = [];

    CollectionReference imagesRef = FirebaseFirestore.instance
        .collection('events')
        .doc(widget.eventId)
        .collection('images');

    QuerySnapshot querySnapshot = await imagesRef.get();

    for (var doc in querySnapshot.docs) {
      imageUrls.add(doc['url']);
    }

    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Gallery'),
      ),
      body: FutureBuilder<List<String>>(
        future: _fetchImageUrls(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading images'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No images found'));
          } else {
            final imageUrls = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullImageScreen(
                          imageUrl: imageUrls[index],
                          isMaker: widget.isMaker,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(imageUrls[index]),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class FullImageScreen extends StatelessWidget {
  final String imageUrl;
  final bool isMaker;
  const FullImageScreen(
      {super.key, required this.imageUrl, required this.isMaker});

  Future<void> _deleteImage(BuildContext context) async {
    try {
      // Find the document with the given URL
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collectionGroup('images')
          .where('url', isEqualTo: imageUrl)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the document ID and path from the query snapshot
        DocumentSnapshot docSnapshot = querySnapshot.docs.first;
        String docId = docSnapshot.id;
        String imagePath = docSnapshot['path'];

        // Delete the image from Firestore
        await docSnapshot.reference.delete();

        // Delete the image from Firebase Storage
        await FirebaseStorage.instance.ref(imagePath).delete();

        // Show a confirmation message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image deleted successfully')),
        );

        // Navigate back to the previous screen
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image not found')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting image: $e')),
      );
    }
  }

  Future<void> _downloadImage(BuildContext context) async {
    try {
      final hasAccess = await Gal.requestAccess();
      if (hasAccess) {
        final imagePath =
            '${Directory.systemTemp.path}/${imageUrl.split('/').last}.jpg';
        await Dio().download('$imageUrl', imagePath);
        await Gal.putImage(imagePath);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image saved to gallery')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Permission denied')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () => _downloadImage(context),
          ),
          if (isMaker)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                // Confirm deletion
                bool confirm = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Delete Image'),
                    content:
                        Text('Are you sure you want to delete this image?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                );

                if (confirm) {
                  await _deleteImage(context);
                }
              },
            ),
        ],
      ),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}
