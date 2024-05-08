import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_weather_example_flutter/common/base/vtc_basic_page.dart';
import 'package:open_weather_example_flutter/common/base/vtc_stateful_page.dart';
import 'package:open_weather_example_flutter/common/button/definition_button.dart';
import 'package:open_weather_example_flutter/common/model/login_model.dart';
import 'package:open_weather_example_flutter/common/popup/epos_popup.dart';
import 'package:open_weather_example_flutter/common/resource/definition_color.dart';
import 'package:open_weather_example_flutter/common/resource/definition_widget.dart';
import 'package:open_weather_example_flutter/common/user_management.dart';
import 'package:open_weather_example_flutter/src/features/login/application/providers.dart';

class LoginPage extends VTCStatefulPage {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends VTCStatefulPageState<LoginPage>
    with VTCBasicPage, AfterLayoutMixin {
  final phoneTextController = TextEditingController();
  final passTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        UserManagement().ref.read(loginProvider.notifier).login();
      }
    });
    super.initState();
  }

  @override
  Widget body(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
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
                const LoginButton(),
                const SizedBox(
                  height: 25,
                ),
                const LoginButtonSecond(),
                const SizedBox(
                  height: 25,
                ),
                const LoginButtonThird()
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget? appBar(BuildContext context) {
    return null;
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {}
}

class LoginButton extends ConsumerStatefulWidget {
  const LoginButton({super.key});

  @override
  ConsumerState<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends ConsumerState<LoginButton> {
  String isFirst = 'IsFirst';
  @override
  void initState() {
    isFirst = 'IsSecond';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(loginProvider, (previous, next) {
      final res = next;
      if (res != null) {
        if (res.responseCode! > 0) {
          EposPopup.show(context: context, des: 'Thành công');
        } else {
          EposPopup.show(context: context, des: 'Có lỗi xảy ra');
        }
      } else {
        EposPopup.show(context: context, des: 'Hệ thống bận');
      }
    });
    print('btn ');
    final isTouch = ref.read(loginProvider.notifier).isTouch;
    return EposButton(
        onOK: () async {
          await ref.read(loginProvider.notifier).login();
        },
        title: 'ĐĂNG NHẬP $isTouch',
        textColor: colorBlackPos,
        height: 42,
        backgroundColor: colorYellowAccent);
  }
}

class LoginButtonSecond extends ConsumerWidget {
  const LoginButtonSecond({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('btn Second');
    final isPressed =
        ref.watch(loginProvider) != null ? 'IS ĐĂNG NHẬP' : 'ĐĂNG NHẬP';
    return EposButton(
        onOK: () async {
          await ref.read(loginProvider.notifier).login();
        },
        title: isPressed,
        textColor: colorBlackPos,
        height: 42,
        backgroundColor: colorYellow);
  }
}

class LoginButtonThird extends ConsumerWidget {
  const LoginButtonThird({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('btn Third');

    return EposButton(
        onOK: () async {
          ref.read(loginProvider.notifier).update(
              LoginModel(accessToken: 'dsadasdasdasdas', responseCode: 1));
        },
        title: 'Đăng nhập',
        textColor: colorBlackPos,
        height: 42,
        backgroundColor: colorYellow);
  }
}
