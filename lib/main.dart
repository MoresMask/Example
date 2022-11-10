import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/bloc/users_bloc.dart';
import 'package:flutter_application_2/models/user_model.dart';
import 'package:flutter_application_2/response/response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => UserRepository(),
        child: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersBloc(
        RepositoryProvider.of<UserRepository>(context),
      )..add(LoadedUserEvent()),
      child: Scaffold(
          body: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
        if (state is UserLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UserLoadedState) {
          List<UserModel> userList = state.users;
          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.orange,
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: ListTile(
                    title: Text(
                      userList[index].name,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      userList[index].email,
                      style: TextStyle(color: Colors.white),
                    )),
              );
            },
          );
        }
        return Container();
      })),
    );
  }
}
