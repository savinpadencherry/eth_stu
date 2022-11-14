// ignore_for_file: body_might_complete_normally_nullable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noti_test_student/core/logger.dart';
import 'package:noti_test_student/core/models/notifications.dart';
import 'package:noti_test_student/core/models/student.dart';

class AuthService with LogMixin {
  final studentDataRef = FirebaseFirestore.instance.collection('Students');
  final notificationFeedRef =
      FirebaseFirestore.instance.collection('Notifications');
  final feedRef = FirebaseFirestore.instance.collection('feed');

  Future<UserCredential?> signUpUser(
      {required String email, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await createUserDataInFireStore(userCredential: credential);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        warningLog('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        warningLog('The account already exists for that email.');
      }
    } catch (e) {
      warningLog(
        e.toString(),
      );
    }
  }

  Future<Student> createUserDataInFireStore(
      {required UserCredential userCredential}) async {
    await studentDataRef.doc(userCredential.user!.uid).set({
      'email': userCredential.user!.email,
      'userId': userCredential.user!.uid,
    });
    Student student = Student(
      email: userCredential.user!.email,
      userId: userCredential.user!.uid,
    );
    return student;
  }

  Future<Student> fetchUserDataInFireStore(
      {required UserCredential userCredential}) async {
    Student student = await studentDataRef
        .where('userId', isEqualTo: userCredential.user!.uid)
        .get()
        .then((value) {
      return Student(
        email: userCredential.user!.email,
        userId: userCredential.user!.uid,
      );
    });
    return student;
  }

  Future<List<Notifications>> getNotifications({required String userId}) async {
    List<Notifications> notifications = [];
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await notificationFeedRef.doc(userId).collection('notifications').get();
    for (var notification in snapshot.docs) {
      final data = notification.data();
      notifications.add(
        Notifications(
          studentName: data['studentName'],
          studentUserId: data['studentUserId'],
          teacherName: data['teacherName'],
          type: data['type'],
          message: data['message'],
        ),
      );
    }
    warningLog('$notifications');
    return notifications;
  }

  Future<List<Student>> getListofStudents() async {
    List<Student> students = [];
    QuerySnapshot<Map<String, dynamic>> snapshots = await studentDataRef.get();
    for (var student in snapshots.docs) {
      final data = student.data();
      students.add(
        Student(
          email: data['email'],
          userId: data['userId'],
        ),
      );
    }
    warningLog('$students');
    return students;
  }

  putTheNotificationInTheShareuserFeed(
      {required Student student, required Notifications notifications}) async {
    await notificationFeedRef
        .doc(student.userId)
        .collection('notifications')
        .add({
      'studentName': student.email,
      'teacherName': notifications.teacherName,
      'studentUserId': student.userId,
      'type': notifications.type,
      'message': notifications.message
    });
    warningLog('Done');
  }

  Future<UserCredential?> logInUser(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      fetchUserDataInFireStore(userCredential: credential);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        warningLog('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        warningLog('The account already exists for that email.');
      }
    } catch (e) {
      warningLog(
        e.toString(),
      );
    }
  }
}
