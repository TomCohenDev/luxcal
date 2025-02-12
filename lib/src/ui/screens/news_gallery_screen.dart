import 'package:LuxCal/src/utils/screen_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../utils/download_all_zip.dart';
import '../../utils/download_utils.dart';

class NewsGalleryScreen extends StatefulWidget {
  final String newsId;
  final bool isMaker;
  const NewsGalleryScreen({
    Key? key,
    required this.newsId,
    required this.isMaker,
  }) : super(key: key);

  @override
  _NewsGalleryScreenState createState() => _NewsGalleryScreenState();
}

class _NewsGalleryScreenState extends State<NewsGalleryScreen> {
  bool _isZipping = false;

  /// Fetch all image URLs for the news doc from Firestore.
  Future<List<String>> _fetchImageUrls() async {
    List<String> imageUrls = [];
    final imagesRef = FirebaseFirestore.instance
        .collection('news')
        .doc(widget.newsId)
        .collection('images');

    final querySnapshot = await imagesRef.get();
    for (var doc in querySnapshot.docs) {
      imageUrls.add(doc['url']);
    }
    return imageUrls;
  }

  /// Zip and download all images as a single file
  Future<void> _downloadAllAsZip() async {
    try {
      setState(() {
        _isZipping = true;
      });
      final imageUrls = await _fetchImageUrls();
      if (imageUrls.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No images found')),
        );
        return;
      }
      // Call the cross-platform zip function.
      await downloadAllImagesAsZip(imageUrls, zipName: 'news_images.zip');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ZIP download complete')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading ZIP: $e')),
      );
    } finally {
      setState(() {
        _isZipping = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _downloadAllAsZip,
          ),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder<List<String>>(
            future: _fetchImageUrls(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading images'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No images found'));
              } else {
                final imageUrls = snapshot.data!;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        child: Container(
                          width: context.width / 2,
                          child: Image.network(
                            imageUrls[index],
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade300,
                                child: const Center(
                                  child: Text(
                                    'Failed to load',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
          if (_isZipping)
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }
}

class FullImageScreen extends StatelessWidget {
  final String imageUrl;
  final bool isMaker;
  const FullImageScreen({
    Key? key,
    required this.imageUrl,
    required this.isMaker,
  }) : super(key: key);

  Future<void> _deleteImage(BuildContext context) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collectionGroup('images')
          .where('url', isEqualTo: imageUrl)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final docSnapshot = querySnapshot.docs.first;
        String imagePath = docSnapshot['path'];
        await docSnapshot.reference.delete();
        await FirebaseStorage.instance.ref(imagePath).delete();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image deleted successfully')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image not found')),
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
      final fileName = imageUrl.split('/').last.split('?').first;
      await saveNetworkImage(imageUrl, fileName);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image saved to gallery')),
      );
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
        title: const Text('Image'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _downloadImage(context),
          ),
          if (isMaker)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Image'),
                    content: const Text(
                        'Are you sure you want to delete this image?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await _deleteImage(context);
                }
              },
            ),
        ],
      ),
      body: Center(
        child: Image.network(
          imageUrl,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.shade300,
              child: const Center(
                child: Text(
                  'Failed to load',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
