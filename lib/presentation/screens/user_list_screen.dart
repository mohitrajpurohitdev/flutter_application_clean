import 'package:flutter/material.dart';
import 'package:flutter_application_clean/domain/usercases/get_users.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user_list_bloc.dart';
import '../widgets/user_card.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text(
          'Users',
          style: TextStyle(fontFamily: 'SFPro', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
          ),
        ),
        child:  BlocProvider(
          create: (context) => UserListBloc(
            RepositoryProvider.of<GetUsers>(context),
          )..add(LoadUsers(2)),
          child: UserListView(),
        ),
      ),
    );
  }
}

class UserListView extends StatefulWidget {
  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 200) {
      final state = context.read<UserListBloc>().state;
      if (state is UserListLoaded) {
        context.read<UserListBloc>().add(LoadUsers(state.page + 1));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserListBloc, UserListState>(
      builder: (context, state) {
        if (state is UserListLoading && state.users.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserListLoaded){
          final users = state.users;
          return ListView.builder(
            controller: _scrollController,
            itemCount: users.length + (state is UserListLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= users.length) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Padding(

                  padding: const EdgeInsets.all( 10.0),
                  child: UserCard(user: users[index]),
                );
              }
            },
          );
        } else if (state is UserListError) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      },
    );
  }
}
