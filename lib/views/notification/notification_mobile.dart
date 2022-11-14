// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

part of notification_view;

class _NotificationMobile extends StatefulWidget {
  final UserCredential userCredential;
  _NotificationMobile({
    required this.userCredential,
  });

  @override
  State<_NotificationMobile> createState() => _NotificationMobileState();
}

class _NotificationMobileState extends State<_NotificationMobile>
    with LogMixin {
  List<Notifications> notification = [];
  List<NotificationWidget> notificationWidgets = [];
  @override
  void initState() {
    getNotis();
    super.initState();
  }

  getNotis() async {
    List<Notifications> notis = [];
    List<NotificationWidget> notiWidgets = [];
    notis = await getIt<AuthService>()
        .getNotifications(userId: widget.userCredential.user!.uid);
    for (var noti in notis) {
      notiWidgets.add(NotificationWidget(notification: noti));
    }
    setState(() {
      notification = notis;
      notificationWidgets = notiWidgets;
    });
  }

  @override
  Widget build(BuildContext context) {
    warningLog('${widget.userCredential}');
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () => getNotis(),
      child: ListView(
        children: notificationWidgets,
      ),
    ));
  }
}
