// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
part of home_view;

class _HomeMobile extends StatefulWidget {
  final UserCredential userCredential;
  const _HomeMobile({required this.userCredential});

  @override
  State<_HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<_HomeMobile> with LogMixin {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _widgetOptions = [
      NotificationView(
        userCredential: widget.userCredential,
      ),
      Text(
        'Grade',
        style: optionStyle,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userCredential.user!.email!),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.purple,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
