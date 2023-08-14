import 'dart:convert';
import 'package:haina/model/prompt.dart';
import 'package:http/http.dart' as http;


Future<List<Prompt>> getPrompts() async {
  final List<Prompt> prompts = [];
  final response = await http.get(
    Uri.parse(
        'https://pan.oldwei.com/d/file/json/prompts.json?sign=UdEckFD4tbx8fVA21NiwhC_DH1AGTGYv1PwltzHNjK0=:0'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
  );
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);

    for (var item in jsonResponse) {
      prompts.add(Prompt(item['act'], item['prompt']));
    }
  } else {
    throw Exception('Failed to load prompts');
  }
  return prompts;
}
