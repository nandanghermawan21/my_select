import 'package:flutter_test/flutter_test.dart';
import 'package:my_select/my_select.dart';
import 'package:my_select/my_select_platform_interface.dart';
import 'package:my_select/my_select_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMySelectPlatform
    with MockPlatformInterfaceMixin
    implements MySelectPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MySelectPlatform initialPlatform = MySelectPlatform.instance;

  test('$MethodChannelMySelect is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMySelect>());
  });

  test('getPlatformVersion', () async {
    MySelect mySelectPlugin = MySelect();
    MockMySelectPlatform fakePlatform = MockMySelectPlatform();
    MySelectPlatform.instance = fakePlatform;

    expect(await mySelectPlugin.getPlatformVersion(), '42');
  });
}
