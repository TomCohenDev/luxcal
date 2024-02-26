import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:revampedai/aaasrc/ui/screens/auth_screen.dart';
import 'package:revampedai/backend/firebase_analytics/analytics.dart';
import 'package:revampedai/custom/revamped_loading_animation.dart';
import 'package:revampedai/widgets/login/login_widget.dart';
import 'package:video_player/video_player.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late VideoPlayerController _videoPlayerController;
  final storage = GetStorage();
  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'intro'});

    _videoPlayerController =
        VideoPlayerController.asset('assets/videos/intro.mp4');

    _videoPlayerController.initialize().then((_) {
      setState(() {});

      _videoPlayerController.play();
      logFirebaseEvent('intro_page', parameters: {'video': 'start'});
    });
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.isInitialized) {
        print(_videoPlayerController.value.position);

        final difference = _videoPlayerController.value.duration -
            _videoPlayerController.value.position;
        if (difference <= Duration(milliseconds: 50)) {
          storage.write('wasIntroVideoDisplayed', true);
          logFirebaseEvent('intro_page', parameters: {'video': 'finsih'});
          if (mounted) {
            context.go('/auth');
          }
        }
      }
    });
  }

  @override
  void dispose() {
    print("object");
    _videoPlayerController.dispose();
    _videoPlayerController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(backgroundColor: Colors.transparent),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: _videoPlayerController.value.isInitialized
            ? _buildVideoPlayer()
            : Container(),
      ),
    );
  }

  Widget _buildVideoPlayer() => AspectRatio(
      aspectRatio: 9 / 16, child: VideoPlayer(_videoPlayerController));
}
