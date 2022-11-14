// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

part of share_page_view;

class _SharePageMobile extends StatefulWidget {
  final Notifications notification;
  _SharePageMobile({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  State<_SharePageMobile> createState() => _SharePageMobileState();
}

class _SharePageMobileState extends State<_SharePageMobile> with LogMixin {
  List<Student> student = [];
  List<StudentWidget> studentWidget = [];
  @override
  void initState() {
    getStudentsToShare();
    super.initState();
  }

  getStudentsToShare() async {
    List<Student> students = [];
    List<StudentWidget> studentsWidget = [];
    students = await getIt<AuthService>().getListofStudents();
    students
        .where((stud) => stud.userId != widget.notification.studentUserId)
        .forEach((stu) {
      studentsWidget.add(
        StudentWidget(
          student: stu,
          notification: widget.notification,
        ),
      );
    });
    warningLog('$students');
    setState(() {
      student = students;
      studentWidget = studentsWidget;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share it to'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () => getStudentsToShare(),
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: studentWidget,
        ),
      ),
    );
  }
}
