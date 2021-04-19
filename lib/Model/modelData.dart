class ListofItems{

  List<Items> items;

  ListofItems({this.items});

  ListofItems.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  List<String> tags;
  Owner owner;
  bool isAnswered;
  int viewCount;
  int acceptedAnswerId;
  int answerCount;
  int score;
  int lastActivityDate;
  int creationDate;
  int lastEditDate;
  int questionId;
  String contentLicense;
  String link;
  String title;

  Items(
      {this.tags,
        this.owner,
        this.isAnswered,
        this.viewCount,
        this.acceptedAnswerId,
        this.answerCount,
        this.score,
        this.lastActivityDate,
        this.creationDate,
        this.lastEditDate,
        this.questionId,
        this.contentLicense,
        this.link,
        this.title});

  Items.fromJson(Map<String, dynamic> json) {
    tags = json['tags'].cast<String>();
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    isAnswered = json['is_answered'];
    viewCount = json['view_count'];
    acceptedAnswerId = json['accepted_answer_id'];
    answerCount = json['answer_count'];
    score = json['score'];
    lastActivityDate = json['last_activity_date'];
    creationDate = json['creation_date'];
    lastEditDate = json['last_edit_date'];
    questionId = json['question_id'];
    contentLicense = json['content_license'];
    link = json['link'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tags'] = this.tags;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    data['is_answered'] = this.isAnswered;
    data['view_count'] = this.viewCount;
    data['accepted_answer_id'] = this.acceptedAnswerId;
    data['answer_count'] = this.answerCount;
    data['score'] = this.score;
    data['last_activity_date'] = this.lastActivityDate;
    data['creation_date'] = this.creationDate;
    data['last_edit_date'] = this.lastEditDate;
    data['question_id'] = this.questionId;
    data['content_license'] = this.contentLicense;
    data['link'] = this.link;
    data['title'] = this.title;
    return data;
  }
}

class Owner {
  int reputation;
  int userId;
  String userType;
  int acceptRate;
  String profileImage;
  String displayName;
  String link;

  Owner(
      {this.reputation,
        this.userId,
        this.userType,
        this.acceptRate,
        this.profileImage,
        this.displayName,
        this.link});

  Owner.fromJson(Map<String, dynamic> json) {
    reputation = json['reputation'];
    userId = json['user_id'];
    userType = json['user_type'];
    acceptRate = json['accept_rate'];
    profileImage = json['profile_image'];
    displayName = json['display_name'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reputation'] = this.reputation;
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['accept_rate'] = this.acceptRate;
    data['profile_image'] = this.profileImage;
    data['display_name'] = this.displayName;
    data['link'] = this.link;
    return data;
  }
}