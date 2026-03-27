import 'package:get/get.dart';

class VerificationService extends GetxService {
  final frontPath = RxnString();
  final backPath = RxnString();
  final videoPath = RxnString();
  final audioPath = RxnString();

  void setIdentityPaths(String front, String back) {
    frontPath.value = front;
    backPath.value = back;
  }

  void setVideoPath(String path) {
    videoPath.value = path;
  }

  void setAudioPath(String path) {
    audioPath.value = path;
  }

  bool get isComplete => 
    frontPath.value != null && 
    backPath.value != null && 
    videoPath.value != null && 
    audioPath.value != null;

  void clear() {
    frontPath.value = null;
    backPath.value = null;
    videoPath.value = null;
    audioPath.value = null;
  }
}
