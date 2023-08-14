import 'package:haina/common/util/prompt.dart';
import 'package:get/get.dart';
import 'package:haina/model/prompt.dart';

class PromptController extends GetxController {
  final prompts = <Prompt>[].obs;

  @override
  void onInit() async {
    prompts.value = await getPrompts() as List<Prompt>;
    super.onInit();
  }
}

