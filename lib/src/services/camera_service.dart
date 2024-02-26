import 'package:camera/camera.dart';

class CameraService {
  CameraController? _controller;
  bool _isInitialized = false;

  Future<void> initializeCamera({bool useFrontCamera = false}) async {
    // Obtaining a list of the available cameras on the device.
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      // Selecting the camera. Front camera if requested, otherwise back camera.
      CameraDescription selectedCamera = useFrontCamera
          ? cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.front,
              orElse: () => cameras.first)
          : cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.back,
              orElse: () => cameras.first);

      // Create a CameraController.
      _controller = CameraController(
        selectedCamera,
        ResolutionPreset.veryHigh,
        enableAudio: false, // set true if you need audio
      );

      // Initialize the controller.
      await _controller!.initialize();
      _isInitialized = true;
    } else {
      throw Exception('No cameras available');
    }
  }

  bool get isInitialized => _isInitialized;

  CameraController? get controller {
    if (!_isInitialized) {
      throw Exception('Camera not initialized');
    }
    return _controller;
  }

  Future<String> takePicture() async {
    if (!_isInitialized || !_controller!.value.isInitialized) {
      throw Exception('Camera not initialized');
    }

    if (_controller!.value.isTakingPicture) {
      // If a picture is already being captured, do nothing.
      return Future.error('A picture is already being captured');
    }

    final XFile file = await _controller!.takePicture();
    return file.path;
  }

  

  void dispose() {
    _controller?.dispose();
  }
}
