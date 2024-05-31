import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'my_select_method_channel.dart';

abstract class MySelectPlatform extends PlatformInterface {
  /// Constructs a MySelectPlatform.
  MySelectPlatform() : super(token: _token);

  static final Object _token = Object();

  static MySelectPlatform _instance = MethodChannelMySelect();

  /// The default instance of [MySelectPlatform] to use.
  ///
  /// Defaults to [MethodChannelMySelect].
  static MySelectPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MySelectPlatform] when
  /// they register themselves.
  static set instance(MySelectPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
