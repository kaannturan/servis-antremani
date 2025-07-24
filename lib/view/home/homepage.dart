import 'package:flutter/material.dart';
import 'package:rastgele_antreman/models/user_model.dart';
import 'package:rastgele_antreman/service/user_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  UserService service = UserService();
  List<UserData?> user = [];
  bool? isLoading;

  @override
  void initState() {
    super.initState();
    service.fetchUser().then(
      (e) {
        if (e != null && e.data != null) {
          setState(() {
            user = e.data!;
            isLoading = true;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api Denemesi"),
      ),
      body: isLoading == null
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : isLoading == true
              ? ListView.builder(
                  itemCount: user.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(user[index]!.avatar!),
                      ),
                      title: Row(
                        children: [
                          Text(user[index]!.firstName!),
                          const SizedBox(width: 4),
                          Text(user[index]!.lastName!)
                        ],
                      ),
                      subtitle: Text(user[index]!.email!),
                    );
                  },
                )
              : const Center(
                  child: Text("hata oluştu"),
                ),
    );
  }
}
