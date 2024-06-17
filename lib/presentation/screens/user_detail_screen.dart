import 'package:flutter/material.dart';
import 'package:flutter_application_clean/domain/usercases/get_user_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user_detail_bloc.dart';

class UserDetailScreen extends StatelessWidget {
  final int userId;

  UserDetailScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail'),
      ),
      body: BlocProvider(
        create: (context) => UserDetailBloc(
          context.read<GetUserDetail>(),
        )..add(LoadUserDetail(userId)),
        child: UserDetailView(),
      ),
    );
  }
}

class UserDetailView extends StatefulWidget {
  @override
  _UserDetailViewState createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<UserDetailView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.4,
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailBloc, UserDetailState>(
      builder: (context, state) {
        if (state is UserDetailLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is UserDetailLoaded) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'avatar_${state.user.id}',
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(state.user.avatar),
                      ),
                    ),
                    SizedBox(height: 20),
                    AnimatedOpacity(
                      opacity: _controller.value,
                      duration: _controller.duration!,
                      child: Column(
                        children: [
                          Text(
                            '${state.user.firstName} ${state.user.lastName}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            state.user.email,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const  Divider(),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               const Text(
                                  'Bio',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const  SizedBox(height: 10),
                                Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros elementum tristique. Duis cursus, mi quis viverra ornare, eros dolor interdum nulla.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const  SizedBox(height: 20),
                                const Text(
                                  'Interests',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: [
                                    Chip(
                                      label: Text('Football'),
                                    ),
                                    Chip(
                                      label: Text('Reading'),
                                    ),
                                    Chip(
                                      label: Text('Traveling'),
                                    ),
                                    Chip(
                                      label: Text('Music'),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Skills',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const  SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: LinearProgressIndicator(
                                        value: 0.8,
                                        backgroundColor: Colors.grey[300],
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.blue),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text('Flutter'),
                                  ],
                                ),
                                const  SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: LinearProgressIndicator(
                                        value: 0.7,
                                        backgroundColor: Colors.grey[300],
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.green),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text('Dart'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Recent Activity',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                ListTile(
                                  leading: Icon(Icons.check_circle,
                                      color: Colors.green),
                                  title: Text('Completed a Flutter project'),
                                  subtitle: Text('2 days ago'),
                                ),
                                ListTile(
                                  leading: Icon(Icons.check_circle,
                                      color: Colors.green),
                                  title: Text('Joined a new team'),
                                  subtitle: Text('1 week ago'),
                                ),
                                ListTile(
                                  leading: Icon(Icons.check_circle,
                                      color: Colors.green),
                                  title: Text('Published an article on Medium'),
                                  subtitle: Text('3 weeks ago'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (state is UserDetailError) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      },
    );
  }
}
