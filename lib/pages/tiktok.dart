import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class TiktikPage extends StatefulWidget {
  const TiktikPage({super.key});

  @override
  State<TiktikPage> createState() => _TiktikPageState();
}

class _TiktikPageState extends State<TiktikPage> {
  final List<VideoItem> videos = [
    VideoItem(
      url:
          'https://vhdsykipnfvohmmuvbnw.supabase.co/storage/v1/object/public/storages//video_2025-03-28_14-35-20.mp4',
      description: 'Красивое видео с неоновыми огнями',
      likes: '1.2M',
      comments: '10K',
    ),
    VideoItem(
      url:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      description: 'Природа весной',
      likes: '2.5M',
      comments: '15K',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Swiper(
        itemBuilder: (context, index) {
          return VideoPlayerScreen(video: videos[index]);
        },
        itemCount: videos.length,
        scrollDirection: Axis.vertical,
        pagination: const SwiperPagination(),
      ),
    );
  }
}

class VideoItem {
  final String url;
  final String description;
  final String likes;
  final String comments;

  VideoItem({
    required this.url,
    required this.description,
    required this.likes,
    required this.comments,
  });
}

class VideoPlayerScreen extends StatefulWidget {
  final VideoItem video;

  const VideoPlayerScreen({super.key, required this.video});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      _videoPlayerController = VideoPlayerController.network(widget.video.url);
      await _videoPlayerController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: true,
        aspectRatio: 9 / 16,
        allowFullScreen: false,
        allowMuting: true,
        showControls: true,
        placeholder: const Center(child: CircularProgressIndicator()),
      );

      setState(() {});
    } catch (e) {
      print('Ошибка загрузки видео: $e');
      setState(() {
        _chewieController = null;
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (_chewieController != null)
          Chewie(controller: _chewieController!)
        else
          Center(
            child: Text(
              'Ошибка загрузки видео',
              style: TextStyle(color: Colors.white),
            ),
          ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.video.description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.favorite, color: Colors.white),
                  const SizedBox(width: 5),
                  Text(
                    widget.video.likes,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 20),
                  Icon(Icons.comment, color: Colors.white),
                  const SizedBox(width: 5),
                  Text(
                    widget.video.comments,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
