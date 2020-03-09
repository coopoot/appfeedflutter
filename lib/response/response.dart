class Response {
  int postId;
  int personId;
  String created;
  String photoUri;
  int likes;
  Person person;
  List<Comments> comments;

  Response(
      {this.postId,
        this.personId,
        this.created,
        this.photoUri,
        this.likes,
        this.person,
        this.comments});

  Response.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    personId = json['personId'];
    created = json['created'];
    photoUri = json['photoUri'];
    likes = json['likes'];
    person =
    json['person'] != null ? new Person.fromJson(json['person']) : null;
    if (json['comments'] != null) {
      comments = new List<Comments>();
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
  }
}

class Person {
  int personId;
  String name;
  String profilePhotoUri;

  Person({this.personId, this.name, this.profilePhotoUri});

  Person.fromJson(Map<String, dynamic> json) {
    personId = json['personId'];
    name = json['name'];
    profilePhotoUri = json['profilePhotoUri'];
  }
}

class Comments {
  int commentId;
  int postId;
  int personId;
  Person person;
  String text;

  Comments(
      {this.commentId, this.postId, this.personId, this.person, this.text});

  Comments.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    postId = json['postId'];
    personId = json['personId'];
    person =
    json['person'] != null ? new Person.fromJson(json['person']) : null;
    text = json['text'];
  }
}