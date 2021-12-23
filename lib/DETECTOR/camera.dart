import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

import '../main.dart';

class livecamera extends StatefulWidget {
  @override
  _livecameraState createState() => _livecameraState();
}

class _livecameraState extends State<livecamera> {
  bool isworking = false;
  String result = " ";
  late CameraController cameraController;
  CameraImage? imgCamera;

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/mobilenet_v1_1.0_224.tflite",
      labels: "assets/mobilenet_v1_1.0_224.txt",
    );
    await initCamera();
  }

  initCamera() async {
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController.startImageStream((imageFromStream) => {
              if (!isworking)
                {
                  isworking = true,
                  imgCamera = imageFromStream,
                  runModelonStramframe(),
                }
            });
      });
    });
  }

  runModelonStramframe() async {
    if (imgCamera != null) {
      var recongnition = await Tflite.runModelOnFrame(
        bytesList: imgCamera!.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: imgCamera!.height,
        imageWidth: imgCamera!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 5,
        threshold: 0.1,
        asynch: true,
      );
      result = "";

      recongnition!.forEach((responce) {
        result += responce["label"] +
            "   " +
            (responce["confidence"] as double).toStringAsFixed(2) +
            " \n \n";
      });

      setState(() {
        result;
      });
      isworking = false;
    }
  }

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  void dispose() async {
    super.dispose();
    await Tflite.close();
    cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/imgpik.jpg'),
              ),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Center(
                      child: Container(
                        color: Colors.black,
                        height: 320,
                        width: 360,
                        child: Image.asset('assets/camera.jpg'),
                      ),
                    ),
                    Center(
                      child: FlatButton(
                        onPressed: () {
                          initCamera();
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 0),
                          height: 270,
                          width: 360,
                          child: imgCamera == null
                              ? Container(
                                  height: 170,
                                  width: 240,
                                  child: Icon(
                                    Icons.photo_camera_front,
                                    color: Colors.blueAccent,
                                    size: 40,
                                  ),
                                )
                              : AspectRatio(
                                  aspectRatio:
                                      cameraController.value.aspectRatio,
                                  child: CameraPreview(
                                    cameraController,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 55),
                    child: SingleChildScrollView(
                      child: Text(
                        result,
                        style: TextStyle(
                          backgroundColor: Colors.black,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
