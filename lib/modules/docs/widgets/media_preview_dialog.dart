import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MediaPreviewDialog extends StatefulWidget {
  final String url;
  final String title;
  final bool isVideo;

  const MediaPreviewDialog({
    super.key,
    required this.url,
    required this.title,
    this.isVideo = false,
  });

  @override
  State<MediaPreviewDialog> createState() => _MediaPreviewDialogState();
}

class _MediaPreviewDialogState extends State<MediaPreviewDialog> {
  VideoPlayerController? _controller;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    if (widget.isVideo) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
        ..initialize().then((_) {
          setState(() {});
          _controller?.play();
        }).catchError((error) {
          setState(() {
            _isError = true;
          });
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black12,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          Center(
            child: widget.isVideo
                ? _buildVideoPlayer()
                : _buildImagePlayer(),
          ),
          Positioned(
            top: 40.h,
            left: 20.w,
            right: 20.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (_isError) {
      return const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, color: Colors.white, size: 48),
          SizedBox(height: 16),
          Text('Failed to load video', style: TextStyle(color: Colors.white)),
        ],
      );
    }

    if (_controller == null || !_controller!.value.isInitialized) {
      return const CircularProgressIndicator(color: Colors.white);
    }

    return AspectRatio(
      aspectRatio: _controller!.value.aspectRatio,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          VideoPlayer(_controller!),
          _buildControls(),
          VideoProgressIndicator(
            _controller!,
            allowScrubbing: true,
            colors: const VideoProgressColors(
              playedColor: Color(0xFF0F766E),
              bufferedColor: Colors.white24,
              backgroundColor: Colors.white12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      color: Colors.black26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 32.sp,
            ),
            onPressed: () {
              setState(() {
                _controller!.value.isPlaying
                    ? _controller!.pause()
                    : _controller!.play();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlayer() {
    return InteractiveViewer(
      child: Image.network(
        widget.url,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const CircularProgressIndicator(color: Colors.white);
        },
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, color: Colors.white, size: 64);
        },
      ),
    );
  }
}
