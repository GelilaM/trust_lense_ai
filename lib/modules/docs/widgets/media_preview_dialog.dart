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

  void _onVideoUpdate() {
    final c = _controller;
    if (c == null || !mounted) return;
    if (c.value.hasError) {
      setState(() => _isError = true);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.isVideo) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
        ..addListener(_onVideoUpdate);
      _controller!.initialize().then((_) {
        if (!mounted) return;
        if (_controller!.value.hasError) {
          setState(() => _isError = true);
          return;
        }
        setState(() {});
        _controller!.play();
      }).catchError((_) {
        if (mounted) setState(() => _isError = true);
      });
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_onVideoUpdate);
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
      final detail = _controller?.value.errorDescription;
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 48),
            SizedBox(height: 16.h),
            Text(
              'Could not load media',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              detail != null && detail.contains('404')
                  ? 'Not found (404). The file may be missing on the server or the URL may need to match your API base address.'
                  : (detail ??
                        'Network or format error. If this persists, confirm the API serves these paths over HTTP.'),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 13.sp,
                height: 1.35,
              ),
            ),
          ],
        ),
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
    final size = MediaQuery.sizeOf(context);
    final w = size.width;
    final h = size.height;
    return ColoredBox(
      color: Colors.black,
      child: InteractiveViewer(
        minScale: 0.5,
        maxScale: 4,
        boundaryMargin: const EdgeInsets.all(64),
        child: Image.network(
          widget.url,
          fit: BoxFit.contain,
          width: w,
          height: h,
          alignment: Alignment.center,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.broken_image, color: Colors.white, size: 64);
          },
        ),
      ),
    );
  }
}
