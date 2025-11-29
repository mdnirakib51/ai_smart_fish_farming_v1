
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SuperVideoDetailsScreen extends StatefulWidget {
  final String? videoUrl;
  const SuperVideoDetailsScreen({
    super.key,
    required this.videoUrl,
  });

  @override
  State<SuperVideoDetailsScreen> createState() => _SuperVideoDetailsScreenState();
}

class _SuperVideoDetailsScreenState extends State<SuperVideoDetailsScreen> {
  late YoutubePlayerController _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    _initializeYoutubePlayer();
  }

  void _initializeYoutubePlayer() {
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl ?? "") ?? '';
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose(); // Dispose of the controller to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: YoutubePlayer(
        controller: _youtubePlayerController,
        showVideoProgressIndicator: true,
        onEnded: (metadata) {
          // Reset video to the beginning when it ends
          _youtubePlayerController.seekTo(const Duration(seconds: 0));
          _youtubePlayerController.pause();
        },
      ),
    );
  }
}
