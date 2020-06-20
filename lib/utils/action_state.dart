import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mp_chart/mp/controller/scatter_chart_controller.dart';
import 'package:mp_chart/mp/core/data_interfaces/i_data_set.dart';
import 'package:mp_chart/mp/core/data_interfaces/i_scatter_data_set.dart';
import 'package:mp_chart/mp/core/data_set/scatter_data_set.dart';
import 'package:mp_chart/mp/core/utils/color_utils.dart';
import './util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'globals.dart' as Globals;

PopupMenuItem item(String text, String id) {
  return PopupMenuItem<String>(
      value: id,
      child: Container(
          padding: EdgeInsets.only(top: 15.0),
          child: Center(
              child: Text(
            text,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorUtils.BLACK,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ))));
}

abstract class ActionState<T extends StatefulWidget> extends State<T> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     appBar: AppBar(
    //         automaticallyImplyLeading: false,
    //         backgroundColor: Globals.mainColorDark,
    //         actions: <Widget>[
    //           PopupMenuButton<String>(
    //             itemBuilder: getBuilder(),
    //             onSelected: (String action) {
    //               itemClick(action);
    //             },
    //           ),
    //         ],
    //         // Here we take the value from the MyHomePage object that was created by
    //         // the App.build method, and use it to set our appbar title.
    //         title: Text(getTitle())),
    //     body: getBody());
    return Container(child: getBody());
  }

  void itemClick(String action);

  Widget getBody();

  String getTitle();

  PopupMenuItemBuilder<String> getBuilder();

  // Updated on 6/19/2020 by Fabian Dean Flores
  void captureImg(CaptureCallback callback) {
    Permission.storage.isGranted.then((permission) {
      if (permission != PermissionStatus.granted.isGranted) {
        Permission.storage.request().then((permission) {
          if (permission.isGranted ||
              (permission.isUndetermined && Platform.isIOS)) {
            callback();
          }
        });
      } else {
        callback();
      }
    });
  }
}

typedef CaptureCallback = void Function();

abstract class SimpleActionState<T extends StatefulWidget>
    extends ActionState<T> {
  @override
  void itemClick(String action) {
    Util.openGithub();
  }

  @override
  getBuilder() {
    return (BuildContext context) =>
        <PopupMenuItem<String>>[item('View on GitHub', 'A')];
  }
}

abstract class ScatterActionState<T extends StatefulWidget>
    extends ActionState<T> {
  ScatterChartController controller;

  @override
  getBuilder() {
    return (BuildContext context) => <PopupMenuItem<String>>[
          item('View on GitHub', 'A'),
          item('Toggle Values', 'B'),
          item('Toggle Icons', 'C'),
          item('Toggle Highlight', 'D'),
          item('Animate X', 'E'),
          item('Animate Y', 'F'),
          item('Animate XY', 'G'),
          item('Toggle PinchZoom', 'H'),
          item('Toggle Auto Scale', 'I'),
          item('Save to Gallery', 'J'),
        ];
  }

  @override
  void itemClick(String action) {
    if (controller.state == null) {
      return;
    }

    switch (action) {
      case 'A':
        Util.openGithub();
        break;
      case 'B':
        List<IScatterDataSet> sets = controller.data.dataSets;
        for (IScatterDataSet iSet in sets) {
          ScatterDataSet set = iSet as ScatterDataSet;
          set.setDrawValues(!set.isDrawValuesEnabled());
        }
        controller.state.setStateIfNotDispose();
        break;
      case 'C':
        for (IDataSet set in controller.data.dataSets)
          set.setDrawIcons(!set.isDrawIconsEnabled());
        controller.state.setStateIfNotDispose();
        break;
      case 'D':
        if (controller.data != null) {
          controller.data
              .setHighlightEnabled(!controller.data.isHighlightEnabled());
          controller.state.setStateIfNotDispose();
        }
        break;
      case 'E':
        controller.animator
          ..reset()
          ..animateX1(3000);
        break;
      case 'F':
        controller.animator
          ..reset()
          ..animateY1(3000);
        break;
      case 'G':
        controller.animator
          ..reset()
          ..animateXY1(3000, 3000);
        break;
      case 'H':
        controller.pinchZoomEnabled = !controller.pinchZoomEnabled;
        controller.state.setStateIfNotDispose();
        break;
      case 'I':
        controller.autoScaleMinMaxEnabled = !controller.autoScaleMinMaxEnabled;
        controller.state.setStateIfNotDispose();
        break;
      case 'J':
        captureImg(() {
          controller.state.capture();
        });
        break;
    }
  }
}
