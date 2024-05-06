import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_weather_example_flutter/common/base/vtc_stateful_page.dart';
import 'package:open_weather_example_flutter/common/button/definition_button.dart';
import 'package:open_weather_example_flutter/common/popup/epos_popup.dart';
import 'package:open_weather_example_flutter/common/resource/definition_color.dart';
import 'package:open_weather_example_flutter/common/resource/definition_widget.dart';
import 'package:open_weather_example_flutter/src/features/login/application/providers.dart';

class LoginPage extends VTCStatefulPage {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends VTCStatefulPageState<LoginPage> {
  final phoneTextController = TextEditingController();
  final passTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
                image: AssetImage('assets/images/login/background.jpg'),
                fit: BoxFit.cover),
          ),
        ),
        Form(
          key: formKey,
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  cursorColor: colorBluePos,
                  controller: phoneTextController,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).unfocus();
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập số điện thoại';
                    }

                    return null;
                  },
                  onChanged: (value) {},
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Nhập số điện thoại',
                    filled: true,
                    fillColor: Colors.white,
                    errorBorder: inputBorderRed,
                    focusedErrorBorder: inputBorderRed,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorWhite,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorWhite,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  cursorColor: colorBluePos,
                  controller: passTextController,
                  obscureText: true,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).unfocus();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }

                    return null;
                  },
                  onChanged: (value) {
                    passTextController.text = value;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Nhập mật khẩu',
                    filled: true,
                    fillColor: Colors.white,
                    errorBorder: inputBorderRed,
                    focusedErrorBorder: inputBorderRed,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorWhite,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorWhite,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () async {
                          unawaited(EposPopup.show(
                            titleNoti: 'Thông báo',
                            des:
                                'Bạn cần truy cập vào app VTCPay để lấy lại mật khẩu',
                            isBtnOk: true,
                            textOk: 'Đồng ý',
                            textClose: 'Hủy',
                            context: context,
                          ));
                        },
                        child: const Text('Quên mật khẩu?',
                            style: TextStyle(
                                color: colorWhite,
                                fontStyle: FontStyle.italic,
                                fontSize: 12)))),
                const SizedBox(
                  height: 20,
                ),
                EposButton(
                    onOK: () async {},
                    title: 'ĐĂNG NHẬP',
                    textColor: colorBlackPos,
                    height: 42,
                    backgroundColor: colorYellowAccent),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LoginButton extends ConsumerWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
//     ref.listen(loginProvider, (previous, next) {
//   if(next.responseCode!  > 0){
//     showDialog(context: context, builder: (_){
//       return Center(child: CircularProgressIndicator(),);
//     });
//   }else{
//     Navigator.pop(context);
//   }
// });
    return EposButton(
        onOK: () async {
          // final loginRes = ref.read(loginProvider);
          ref.read(loginProvider).whenData((value) {
            if (value.responseCode! > 0) {
            } else {}
          });
        },
        title: 'ĐĂNG NHẬP',
        textColor: colorBlackPos,
        height: 42,
        backgroundColor: colorYellowAccent);
  }
}
