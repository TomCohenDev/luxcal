import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/custom/button.dart';

Future<void> networkErrorDialog(context, String routeName) {
  Navigator.pop(context);
  return showDialog(
    barrierColor: null,
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Material(
          color: Color.fromARGB(145, 0, 0, 0),
          child: WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                title: Center(
                    child: Text(
                  'Connection Issue!',
                  style: TextStyle(fontSize: 24),
                )),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Please make sure you are connected to the internet',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    Container(
                        height: 85,
                        child: Icon(
                          FontAwesomeIcons.exclamationTriangle,
                          size: 100,
                          color: Colors.red,
                        )),
                    SizedBox(height: 50),
                    CustomMainButton(
                      width: MediaQuery.of(context).size.width * 0.52,
                      height: 40.0,
                      buttonText: 'Try Again',
                      onPressed: () async {
                        switch (routeName) {
                          case "apiCall":
                            Navigator.popUntil(
                                context,
                                (route) =>
                                    route.settings.name == 'UploadPhotoWidget');
                            break;
                          case "startapp":
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) =>
                            //           RoutingWidget()), // Replace with your root screen widget
                            // );
                            break;
                          default:
                        }
                      },
                    ),
                    SizedBox(height: 25),
                  ],
                ),
              )),
        ),
      );
    },
  );
}