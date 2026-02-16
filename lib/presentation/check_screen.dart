import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lora_app/logic/providers.dart';
import 'package:lora_app/model/widget_with_text.dart';
import 'package:lora_app/utilities/colors.dart';

class CheckScreen extends ConsumerWidget {
  const CheckScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusAsync = ref.watch(servicesStatusProvider);
    TextStyle textStyle = const TextStyle(
      fontSize: 14,
      color: Color(0xFF798387),
    );
    final widgetsWithTexts = [
      WidgetWithText(
        widget: Image.asset('assets/pngs/error.png'),
        text: Text('Not supported', style: textStyle),
      ),
      WidgetWithText(
        widget: Image.asset('assets/pngs/Bluetooth.png'),
        text: Text('Bluetooth is turned off', style: textStyle),
      ),
      WidgetWithText(
        widget: Image.asset('assets/pngs/location.png'),
        text: Text('Location is turned off', style: textStyle),
      ),
    ];

    return statusAsync.when(
      data: (status) {
        WidgetWithText widgetWithText = switch (status) {
          ServicesStatus.notSupported => widgetsWithTexts[0],
          ServicesStatus.bluetoothOff => widgetsWithTexts[1],
          ServicesStatus.locationOff => widgetsWithTexts[2],
          ServicesStatus.ready => widgetsWithTexts[2],
          _ => widgetsWithTexts[0],
        };

        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).width,
                  width: double.infinity,
                  child: widgetWithText.widget,
                ),
                const SizedBox(height: 24),
                widgetWithText.text,
                const SizedBox(height: 24),
                if (status != ServicesStatus.notSupported)
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: MyColors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'Turn on',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (status == ServicesStatus.bluetoothOff) {
                        ref.read(bleServiceProvider).turnOn();
                      } else {
                        bool serviceEnabled =
                            await Geolocator.isLocationServiceEnabled();
                        if (!serviceEnabled) {
                          await Geolocator.openLocationSettings();
                        }
                      }
                    },
                  ),
              ],
            ),
          ),
        );
      },
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
