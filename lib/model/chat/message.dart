class ConversationData {
  int active;
  int activeConversationId;
  List<Chat> chat;
  List<ChatList> chatList;
  List<History> history;
  bool usingContext;

  ConversationData({
    required this.active,
    required this.activeConversationId,
    required this.chat,
    required this.chatList,
    required this.history,
    required this.usingContext,
  });

  factory ConversationData.fromJson(Map<String, dynamic> json) {
    return ConversationData(
      active: json['active'],
      activeConversationId: json['activeConversationId'],
      chat: List<Chat>.from(json['chat'].map((x) => Chat.fromJson(x))),
      chatList: List<ChatList>.from(
          json['chatList'].map((x) => ChatList.fromJson(x))),
      history:
          List<History>.from(json['history'].map((x) => History.fromJson(x))),
      usingContext: json['usingContext'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'active': active,
      'activeConversationId': activeConversationId,
      'chat': List<dynamic>.from(chat.map((x) => x.toJson())),
      'chatList': List<dynamic>.from(chatList.map((x) => x.toJson())),
      'history': List<dynamic>.from(history.map((x) => x.toJson())),
      'usingContext': usingContext,
    };
  }
}

class Chat {
  List<ChatData> data;
  int uuid;

  Chat({
    required this.data,
    required this.uuid,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      data: List<ChatData>.from(json['data'].map((x) => ChatData.fromJson(x))),
      uuid: json['uuid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
      'uuid': uuid,
    };
  }
}

class ChatData {
  ConversationOptions? conversationOptions;
  String dateTime;
  bool error;
  bool inversion;
  bool loading;
  RequestOptions requestOptions;
  String text;

  ChatData({
    this.conversationOptions,
    required this.dateTime,
    required this.error,
    required this.inversion,
    required this.loading,
    required this.requestOptions,
    required this.text,
  });

  factory ChatData.fromJson(Map<String, dynamic> json) {
    return ChatData(
      conversationOptions: ConversationOptions.fromJson(json['conversationOptions']),
      dateTime: json['dateTime'],
      error: json['error'],
      inversion: json['inversion'],
      loading: json['loading'],
      requestOptions: RequestOptions.fromJson(json['requestOptions']),
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conversationOptions': conversationOptions?.toJson(),
      'dateTime': dateTime,
      'error': error,
      'inversion': inversion,
      'loading': loading,
      'requestOptions': requestOptions.toJson(),
      'text': text,
    };
  }
}

class ConversationOptions {
  String? nothing;

  ConversationOptions({this.nothing});

  factory ConversationOptions.fromJson(Map<String, dynamic> json) {
    return ConversationOptions(
      nothing: json['nothing'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nothing': nothing,
    };
  }
}

class RequestOptions {
  String prompt;
  Options? options;

  RequestOptions({
    required this.prompt,
    this.options,
  });

  // Factory constructor to create an instance from a JSON map
  factory RequestOptions.fromJson(Map<String, dynamic> json) {
    return RequestOptions(
      prompt: json['prompt'],
      options: Options.fromJson(json['options']),
    );
  }

  // Convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'prompt': prompt,
      'options': options?.toJson(),
    };
  }
}

class Options {
  String? nothing;

  Options({this.nothing});

  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
      nothing: json['nothing'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nothing': nothing,
    };
  }
}

class ChatList {
  String icon;
  int key;
  String label;

  ChatList({
    required this.icon,
    required this.key,
    required this.label,
  });

  factory ChatList.fromJson(Map<String, dynamic> json) {
    return ChatList(
      icon: json['icon'],
      key: json['key'],
      label: json['label'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'icon': icon,
      'key': key,
      'label': label,
    };
  }
}

class History {
  int conversationId;
  bool isEdit;
  String title;
  int uuid;

  History({
    required this.conversationId,
    required this.isEdit,
    required this.title,
    required this.uuid,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      conversationId: json['conversationId'],
      isEdit: json['isEdit'],
      title: json['title'],
      uuid: json['uuid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conversationId': conversationId,
      'isEdit': isEdit,
      'title': title,
      'uuid': uuid,
    };
  }
}
