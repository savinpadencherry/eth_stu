// ignore_for_file: prefer_const_constructors_in_immutables

part of login_view;

class _LoginMobile extends StatefulWidget {
  _LoginMobile();

  @override
  State<_LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<_LoginMobile> with LogMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  submit() async {
    warningLog(nameController.text);
    warningLog(passwordController.text);
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
    form.save();
    final UserCredential? user = await getIt<AuthService>().logInUser(
      email: nameController.text.trim(),
      password: passwordController.text.trim(),
    );
    if (user != null) {
      getIt<NavigatorService>().buildAndPush(
        HomeView(
          userCredential: user,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'NotificationTest',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Log in',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Must Contain a email';
                    }
                    if (!isEmail(value.trim())) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text(
                  'Forgot Password',
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: submit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
