import 'dart:async';

import 'package:flutter/material.dart';
import 'package:open_weather_example_flutter/common/button/epos_button.dart';
import 'package:open_weather_example_flutter/common/extension/color_extension.dart';
import 'package:open_weather_example_flutter/common/resource/definition_color.dart';

mixin EposPopup {
  static Future<void> show({
    required BuildContext context,
    String? titleNoti,
    String? des,
    bool isBtnOk = false,
    String textOk = 'Đồng ý',
    VoidCallback? onOk,
    bool isBtnClose = true,
    String textClose = 'Đóng',
    VoidCallback? onClose,
    Widget? content,
    bool canPop = true,
  }) async {
    final widthBtn = MediaQuery.of(context).size.width / 3.2;
    final okWidget = EposButtonCustom(
      buttonStyleEnum: ButtonStyleEnum.RRectangle,
      bgColor: HexColor.fromHex('0060AF'),
      radiusRRectangle: 24,
      padding: const EdgeInsets.symmetric(vertical: 24),
      width: widthBtn,
      onPressed: onOk ??
          () {
            Navigator.of(context).pop();
          },
      child: Text(
        textOk,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: const TextStyle(color: colorWhite, fontWeight: FontWeight.bold),
      ),
    );
    final closeWidget = EposButtonCustom(
      buttonStyleEnum: ButtonStyleEnum.RRectangle,
      bgColor: Colors.transparent,
      isBorder: true,
      width: widthBtn,
      radiusRRectangle: 24,
      padding: const EdgeInsets.symmetric(vertical: 24),
      onPressed: onClose ??
          () {
            Navigator.of(context).pop();
          },
      child: Text(
        textClose,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
    unawaited(
      showDialog(
        context: context,
        barrierDismissible: !(isBtnOk && isBtnClose),
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: PopScope(
              canPop: canPop,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        titleNoti ?? 'Thông báo',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: content ?? const SizedBox(),
                    ),
                    if (des == null)
                      const SizedBox()
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          des,
                          style: const TextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    const SizedBox(
                      height: 24,
                    ),
                    if (isBtnOk && isBtnClose)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          closeWidget,
                          okWidget,
                        ],
                      )
                    else if (isBtnOk)
                      okWidget
                    else if (isBtnClose)
                      closeWidget,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
