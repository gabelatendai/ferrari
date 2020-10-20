import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:griev_app/Models/Events.dart';
import 'package:griev_app/Models/griev.dart';
// import 'package:griev_app/Models/updates.dart';

final CollectionReference myCollection =
    FirebaseFirestore.instance.collection('grievdb');
final CollectionReference updates =
    FirebaseFirestore.instance.collection('events');

class FirestoreService {
  Future<Griev> createTODOTask(
      String subject, String category, String description) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(myCollection.doc());

      final Griev task = new Griev(subject, category, description);
      final Map<String, dynamic> data = task.toMap();
      await tx.set(ds.reference, data);
      return data;
    };

    return FirebaseFirestore.instance
        .runTransaction(createTransaction)
        .then((mapData) {
      return Griev.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getTaskList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = myCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }
}

class FirestoreEventsService {
  Future<Events> createTODOTask(String subject, String description) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(updates.doc());

      final Events task = new Events(subject, description);
      final Map<String, dynamic> data = task.toMap();
      await tx.set(ds.reference, data);
      return data;
    };

    return FirebaseFirestore.instance
        .runTransaction(createTransaction)
        .then((mapData) {
      return Events.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getTaskList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = updates.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }
}
