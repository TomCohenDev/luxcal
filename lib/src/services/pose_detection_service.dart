import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:revampedai/aaasrc/blocs/pose_detection/pose_detection_cubit.dart';
import 'package:revampedai/widgets/upload_photo/pose_detection/vision_detector_views/painters/pose_painter.dart';

class PoseDetectionService {
  final PoseDetector _poseDetector =
      PoseDetector(options: PoseDetectorOptions());

  StreamController<bool> _poseStatusController =
      StreamController<bool>.broadcast();
  Stream<bool> get poseStatusStream => _poseStatusController.stream;

  CameraController? _controller;
  bool _isBusy = false;
  bool _isInitialized = false;
  String screen = 'orientation';
  bool _canProcess = true;

  bool userPoseIsGood = false;
  bool ensureCameraIsInitialized = false;
  bool shouldTakePicture = false;
  Map<PoseLandmarkType, PoseLandmark>? poseLandmarks;
  String? _text;
  Map<PoseLandmarkType, PoseLandmark>? _landmarks;
  int countdownCurrent = 3;
  CustomPaint? customPaint;
  double disShoulders = 0;
  double disWrists = 0;
  double disAnkles = 0;
  double shouldersHeight = 0;
  int _cameraIndex = -1;
  CameraLensDirection initialDirection = CameraLensDirection.front;
  bool timerRunning = false;
  bool isTakingPictureInProccess = false;

  void startPoseDetection(CameraController controller) {
    _controller = controller;
    _controller?.startImageStream((CameraImage image) async {
      _processCameraImage(image);
      // if (userPoseIsGood) {
      //   onuserPoseIsGoodChanged(true);
      // }
    });
  }

  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    // Use the sensor orientation from the CameraController
    final imageRotation = InputImageRotationValue.fromRawValue(
        _controller!.description.sensorOrientation);
    if (imageRotation == null) return;

    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw);
    if (inputImageFormat == null) return;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    processImage(inputImage);
    if (shouldTakePicture) {
      if (!isTakingPictureInProccess) {
        isTakingPictureInProccess = true;
        print("takePicture");
      }
    }
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;

    final poses = await _poseDetector.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = PosePainter(poses, inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation, true);

      if (painter.poses.isNotEmpty) {
        ensureCameraIsInitialized = true;
        poseLandmarks = painter.poses.first.landmarks;
        userPoseIsGood = checkPoseAlignment(painter.poses.first.landmarks);
        _poseStatusController.sink.add(userPoseIsGood);

        if (userPoseIsGood) {
          if (!timerRunning) {
            // startTimer();
          }
          timerRunning = true;
        } else {
          countdownCurrent = 3;
          // if (_timer != null && timerRunning) {
          //   _timer!.cancel();
          // }
          timerRunning = false;
        }
      } else {
        countdownCurrent = 3;
      }
      customPaint = CustomPaint(painter: painter);
    } else {
      _text = 'Poses found: ${poses.length}\n\n';
      customPaint = null;
    }
    _isBusy = false;
  }

  bool checkPoseAlignment(Map<PoseLandmarkType, PoseLandmark> landmarks) {
    _landmarks = landmarks;
    disShoulders = landmarks[PoseLandmarkType.leftShoulder]!.x -
        landmarks[PoseLandmarkType.rightShoulder]!.x;

    disWrists = landmarks[PoseLandmarkType.leftWrist]!.x -
        landmarks[PoseLandmarkType.rightWrist]!.x;

    disAnkles = landmarks[PoseLandmarkType.leftAnkle]!.x -
        landmarks[PoseLandmarkType.rightAnkle]!.x;

    shouldersHeight = (landmarks[PoseLandmarkType.rightShoulder]!.y +
            landmarks[PoseLandmarkType.leftShoulder]!.y) /
        2;

    // print("shouldersHeight = $shouldersHeight");
    // print("disShoulders = $disShoulders");
    // print("disWrists = $disWrists");
    // print("disAnkles = $disAnkles");

    int errorMarginShoulderHeight = 100;
    int errorMarginDisShoulders = 50;
    int errorMarginDisWrists = 80;
    int errorMarginDisAnkles = 60;

    int wantedShoulderHeight = 402;
    int wantedDisShoulders = 209;
    int wantedDisWrists = 424;
    int wantedDisAnkles = 128;

// Shoulders
    bool rightShoulderHeightPos = isLandmarkinPosition(shouldersHeight.toInt(),
        wantedShoulderHeight, errorMarginShoulderHeight);
    bool leftShoulderHeightPos = isLandmarkinPosition(
        landmarks[PoseLandmarkType.leftShoulder]!.y.toInt(),
        wantedShoulderHeight,
        errorMarginShoulderHeight);
    bool shouldersPos = isLandmarkinPosition(
        disShoulders.toInt(), wantedDisShoulders, errorMarginDisShoulders);

    //wrists
    bool wristsPos = isLandmarkinPosition(
        disWrists.toInt(), wantedDisWrists, errorMarginDisWrists);

    //ankles
    bool anklesPos = isLandmarkinPosition(
        disAnkles.toInt(), wantedDisAnkles, errorMarginDisAnkles);
    if (rightShoulderHeightPos &&
        leftShoulderHeightPos &&
        shouldersPos &&
        wristsPos &&
        anklesPos) {
      return true;
    }

    return false;
  }

  bool isLandmarkinPosition(
      int currentLandmarkVal, int wanted, int errorMargin) {
    if (currentLandmarkVal > wanted - errorMargin &&
        currentLandmarkVal < wanted + errorMargin) {
      return true;
    }
    return false;
  }

  // Future<Map<PoseLandmarkType, PoseLandmark>?> processImage(CameraImage image, CameraController controller) async {
  //   if (_isBusy) return null;
  //   _isBusy = true;

  //   final WriteBuffer allBytes = WriteBuffer();
  //   for (final Plane plane in image.planes) {
  //     allBytes.putUint8List(plane.bytes);
  //   }
  //   final bytes = allBytes.done().buffer.asUint8List();

  //   final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());
  //   final InputImageRotation imageRotation = InputImageRotationValue.fromRawValue(controller.description.sensorOrientation) ?? InputImageRotation.rotation0deg;
  //   final InputImageFormat inputImageFormat = InputImageFormatValue.fromRawValue(image.format.raw) ?? InputImageFormat.nv21;

  //   final planeData = image.planes.map((Plane plane) {
  //     return InputImagePlaneMetadata(
  //       bytesPerRow: plane.bytesPerRow,
  //       height: plane.height,
  //       width: plane.width,
  //     );
  //   }).toList();

  //   final inputImageData = InputImageData(
  //     size: imageSize,
  //     imageRotation: imageRotation,
  //     inputImageFormat: inputImageFormat,
  //     planeData: planeData,
  //   );

  //   final inputImage = InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
  //   final poses = await _poseDetector.processImage(inputImage);
  //   _isBusy = false;

  //   if (poses.isNotEmpty) {
  //     return poses.first.landmarks;
  //   }
  //   return null;
  // }

  void dispose() {
    _poseDetector.close();
    _controller?.stopImageStream();
    _poseStatusController
        .close(); // Don't forget to close the stream controller
  }
}
