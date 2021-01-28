import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: User())],
      child: MaterialApp(
        routes: {
          Routes.home: (context) => Scaffold(
                appBar: AppBar(
                  title: Text("Home"),
                  leading: IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                body: Home(),
              ),
          Routes.userInfo: (context) => Scaffold(
                appBar: AppBar(
                  title: Text("User Info"),
                  leading: IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                body: UserInformation(),
              )
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("My Provider Preview"),
          ),
          body: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  void setCredential(BuildContext context, {String user, String pass}) {
    Provider.of<User>(context, listen: false)
        .setCridentials(username: user, password: pass);
  }

  // username text controller and password text controller
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Username"),
          TextField(
            autocorrect: false,
            controller: usernameController,
          ),
          Text("Password"),
          TextField(
            controller: passwordController,
            autocorrect: false,
            obscureText: true,
          ),
          RaisedButton(
            child: Text("Login"),
            onPressed: () {
              setCredential(context,
                  user: usernameController.text, pass: passwordController.text);
              Navigator.pushNamed(context, Routes.home);
            },
          )
        ],
      ),
    );
  }
}

// Backend
class User extends ChangeNotifier {
  String user;
  String pass;
  String uid;
  double weight;
  double inches;
  double ft;
  double fat;

  void setFat(double bodyfat) {
    if (bodyfat != null) {
      this.fat = bodyfat;
      notifyListeners();
    }
  }

  void setWeight(double weight) {
    if (weight != null) {
      this.weight = weight;
      notifyListeners();
    }
  }

  void setHeight(double inches, double ft) {
    if (inches != null) {
      this.inches = inches;
    }

    if (ft != null) {
      this.ft = ft;
    }
    notifyListeners();
  }

  void setCridentials({String username, String password}) {
    if (username != null) {
      user = username;
    }
    if (password != null) {
      pass = password;
    }

    notifyListeners();
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User currentUser = Provider.of<User>(context, listen: true);
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            "Username: ${currentUser.user == null ? "N/A" : currentUser.user}"),
        Text(
            "Password: ${currentUser.pass == null ? "N/A" : currentUser.pass}"),
        Text("Body Information"),
        Divider(
          thickness: 2.0,
          indent: 50,
          endIndent: 50,
        ),
        Text(
          "Weight: ${currentUser.weight}\nInches: ${currentUser.inches}\nFt: ${currentUser.ft}\nFat: ${currentUser.fat}",
          textAlign: TextAlign.center,
        ),
        RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.userInfo);
            },
            child: Text("Edit"))
      ],
    ));
  }
}

class Routes {
  static const home = "/home";
  static const userInfo = "/userInfo";
}

class UserInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: true);
    final weight = TextEditingController();
    final inches = TextEditingController();
    final ft = TextEditingController();
    final fat = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(50),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Weight"),
              TextField(
                decoration: InputDecoration(hintText: user.weight.toString()),
                controller: weight,
                keyboardType: TextInputType.number,
              ),
              Text("Inches"),
              TextField(
                decoration: InputDecoration(hintText: user.inches.toString()),
                controller: inches,
                keyboardType: TextInputType.number,
              ),
              Text("feet"),
              TextField(
                decoration: InputDecoration(hintText: user.ft.toString()),
                controller: ft,
                keyboardType: TextInputType.number,
              ),
              Text("Body Fat"),
              TextField(
                decoration: InputDecoration(hintText: user.fat.toString()),
                controller: fat,
                keyboardType: TextInputType.number,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                  user.setWeight(double.parse(weight.text));
                  user.setFat(double.parse(fat.text));
                  user.setHeight(
                      double.parse(inches.text), double.parse(ft.text));
                },
                child: Text("Save"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
