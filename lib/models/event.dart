import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String eventname;
  final String venue;
  final String uid;
  final String eventId;
  final String username;
  final String userid;
  final String eventUrl;
  final String profImage;
  final datePublished;
  final likes;

  const Event({
    required this.eventname,
    required this.venue,
    required this.uid,
    required this.eventId,
    required this.username,
    required this.userid,
    required this.eventUrl,
    required this.profImage,
    required this.datePublished,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        "eventname": eventname,
        "venue": venue,
        "uid": uid,
        "eventId": eventId,
        "username": username,
        "Id": userid,
        "eventUrl": eventUrl,
        "profImage": profImage,
        "likes": likes,
        "datePublished": datePublished,
      };

  static Event fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Event(
      eventname: snapshot['eventname'],
      venue: snapshot['venue'],
      uid: snapshot['uid'],
      eventId: snapshot['eventId'],
      username: snapshot['username'],
      userid: snapshot['Id'],
      eventUrl: snapshot['eventUrl'],
      profImage: snapshot['profImage'],
      likes: snapshot['likes'],
      datePublished: snapshot['datePublished'],
    );
  }
}
