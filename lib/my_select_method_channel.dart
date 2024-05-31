import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'my_select_platform_interface.dart';

/// An implementation of [MySelectPlatform] that uses method channels.
class MethodChannelMySelect extends MySelectPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_select');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
