import 'dart:io';
import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

/// Full-screen crop editor for captured ID images. Returns the new file path via [Get.back].
class IdImageCropPage extends StatefulWidget {
  const IdImageCropPage({super.key, required this.imagePath});

  final String imagePath;

  @override
  State<IdImageCropPage> createState() => _IdImageCropPageState();
}

class _IdImageCropPageState extends State<IdImageCropPage> {
  final CropController _cropController = CropController();

  Uint8List? _bytes;
  String? _error;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      final file = File(widget.imagePath);
      if (!await file.exists()) {
        setState(() => _error = 'Image not found');
        return;
      }
      final data = await file.readAsBytes();
      if (!mounted) return;
      setState(() => _bytes = data);
    } catch (e) {
      if (mounted) setState(() => _error = '$e');
    }
  }

  Future<void> _onCropped(CropResult result) async {
    switch (result) {
      case CropSuccess(:final croppedImage):
        setState(() => _saving = true);
        try {
          final dir = await getTemporaryDirectory();
          final path =
              '${dir.path}/id_crop_${DateTime.now().millisecondsSinceEpoch}.jpg';
          final out = File(path);
          await out.writeAsBytes(croppedImage);
          if (mounted) Get.back(result: path);
        } catch (e) {
          if (mounted) {
            setState(() => _saving = false);
            Get.snackbar('Error', 'Could not save cropped image');
          }
        }
      case CropFailure(:final cause):
        if (mounted) {
          Get.snackbar('Crop failed', '$cause');
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF0D141F);
    const accent = Color(0xFF44DDC2);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _saving ? null : () => Get.back(),
        ),
        title: Text(
          'Crop & straighten',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
          ),
        ),
        actions: [
          if (_bytes != null && _error == null)
            TextButton(
              onPressed: _saving ? null : () => _cropController.crop(),
              child: _saving
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: accent,
                      ),
                    )
                  : Text(
                      'Apply',
                      style: GoogleFonts.inter(
                        color: accent,
                        fontWeight: FontWeight.w800,
                        fontSize: 16.sp,
                      ),
                    ),
            ),
        ],
      ),
      body: _buildBody(bg, accent),
    );
  }

  Widget _buildBody(Color bg, Color accent) {
    if (_error != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Text(
            _error!,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: Colors.white70),
          ),
        ),
      );
    }
    if (_bytes == null) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF44DDC2)),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 12.h),
          child: Text(
            'Drag the handles to choose the ID area. Pinch to zoom when needed.',
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: Colors.white.withValues(alpha: 0.65),
              height: 1.4,
            ),
          ),
        ),
        Expanded(
          child: Crop(
            image: _bytes!,
            controller: _cropController,
            interactive: true,
            onCropped: _onCropped,
            baseColor: bg,
            maskColor: Colors.black.withValues(alpha: 0.55),
            radius: 4,
            cornerDotBuilder: (_, __) => DotControl(color: accent),
          ),
        ),
      ],
    );
  }
}
