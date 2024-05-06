// firebase_util.dart

import 'dart:convert';
import 'dart:io';

Future<String?> getIosClientIdFromGoogleServicesJson() async {
  final file = File('path_to_your_google_services_json/google-services.json');
  if (await file.exists()) {
    final jsonString = await file.readAsString();
    final jsonMap = json.decode(jsonString);
    return jsonMap['client'][0]['oauth_client'][0]['client_id'];
  }
  return null;
}

Future<void> updateInfoPlistWithIosClientId(String iosClientId) async {
  final file = File('path_to_your_info_plist/Info.plist');
  if (await file.exists()) {
    String plistContent = await file.readAsString();
    final iosClientIdPlistEntry = '''
      <string>$iosClientId</string>
    ''';
    final newPlistContent = plistContent.replaceFirst(
        '</array>',
        '$iosClientIdPlistEntry</array>'
    );
    await file.writeAsString(newPlistContent);
  }
}
