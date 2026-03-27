import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:record/record.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import '../../../routes/app_routes.dart';
import '../../../core/services/verification_service.dart';


class VoiceVerificationController extends GetxController {
  final _verificationService = Get.find<VerificationService>();
  final audioRecorder = AudioRecorder();

  final isRecording = false.obs;
  final isPreviewMode = false.obs;
  final capturedAudioPath = ''.obs;
  final activeTip = 'Tap to start voice verification'.obs;

  VideoPlayerController? audioPlayerController;
  final String _voicePhrase = 'My name is [Your Name]';

  @override
  void onInit() {
    super.onInit();
    activeTip.value = 'Tap below and say: "$_voicePhrase"';
  }

  @override
  void onClose() {
    audioRecorder.dispose();
    audioPlayerController?.dispose();
    super.onClose();
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecorder.hasPermission()) {
        final directory = await getTemporaryDirectory();
        final path = '${directory.path}/liveness_audio.m4a';

        const config = RecordConfig(encoder: AudioEncoder.aacLc);

        await audioRecorder.start(config, path: path);
        isRecording.value = true;
        activeTip.value = 'Recording... Say the phrase clearly';
      }
    } catch (e) {
      debugPrint('Error starting audio record: $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      final path = await audioRecorder.stop();
      isRecording.value = false;
      if (path != null) {
        capturedAudioPath.value = path;
        isPreviewMode.value = true;
        _initializeAudioPreview(path);
      }
    } catch (e) {
      debugPrint('Error stopping audio record: $e');
    }
  }

  Future<void> _initializeAudioPreview(String path) async {
    audioPlayerController = VideoPlayerController.file(File(path));
    await audioPlayerController!.initialize();
    audioPlayerController!.setLooping(true);
    audioPlayerController!.play();
    update();
  }

  void togglePlayback() {
    if (audioPlayerController != null) {
      if (audioPlayerController!.value.isPlaying) {
        audioPlayerController!.pause();
      } else {
        audioPlayerController!.play();
      }
      update();
    }
  }

  void retake() {
    isPreviewMode.value = false;
    capturedAudioPath.value = '';
    audioPlayerController?.dispose();
    audioPlayerController = null;
    activeTip.value = 'Tap below and say: "$_voicePhrase"';
  }

  void confirm() {
    if (isPreviewMode.value && capturedAudioPath.value.isNotEmpty) {
      audioPlayerController?.pause();
      _verificationService.setAudioPath(capturedAudioPath.value);
      Get.toNamed(Routes.processing);
    }
  }


  void downloadDoc() async {
    try {
      if (capturedAudioPath.value.isNotEmpty) {
        final audioFile = File(capturedAudioPath.value);
        if (!await audioFile.exists()) throw 'Audio file not found';

        Directory? downloadsDir;
        if (Platform.isAndroid) {
          downloadsDir = Directory('/storage/emulated/0/Download');
          if (!await downloadsDir.exists()) {
            downloadsDir = await getExternalStorageDirectory();
          }
        } else {
          downloadsDir = await getDownloadsDirectory();
        }

        if (downloadsDir != null) {
          final fileName =
              'trust_lens_authorization_${DateTime.now().millisecondsSinceEpoch}.m4a';
          final publicPath = '${downloadsDir.path}/$fileName';
          await audioFile.copy(publicPath);

          Get.snackbar(
            'Success',
            'Recording saved to Downloads',
            backgroundColor: Colors.green.withValues(alpha: 0.7),
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to save recording');
    }
  }

  String get voicePhrase => _voicePhrase;
}
