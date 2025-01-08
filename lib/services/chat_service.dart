import 'package:cloud_functions/cloud_functions.dart';

class ChatService {
  ChatService._();

  static final FirebaseFunctions _functions = FirebaseFunctions.instance;

  static Future<String> checkHealth() async {
    final result = await _functions.httpsCallable('healthCheck').call();
    return result.data;
  }

  static Future<String> chatWithOpenAI(String prompt) async {
    final result = await _functions.httpsCallable('chatWithOpenAI').call({
      'prompt': prompt,
    });
    return result.data;
  }
}
