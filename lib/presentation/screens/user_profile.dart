import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appointment_app/logic/user/user_cubit.dart';
import 'package:appointment_app/presentation/screens/user_update_profile.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().fetchUserProfile(); // جلب بيانات المستخدم عند بدء الصفحة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is UserLoaded) {
            final user = state.user;
            return _buildUserProfile(user);
          } else {
            return const Center(child: Text('No user data available'));
          }
        },
      ),
    );
  }

  Widget _buildUserProfile(user) {
    return Column(
      children: [
        const SizedBox(height: 50),
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/images/avatar.png'),
        ),
        const SizedBox(height: 10),
        Text(
          user.name ?? 'No Name',
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
        const SizedBox(height: 5),
        Text(
          user.email,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 20),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {}, // TODO: implement functionality
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('My Appointment'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {}, // TODO: implement functionality
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Medical Records'),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),

        Expanded(
          child: ListView(
            children: [
              _ProfileListTile(
                icon: Icons.person,
                label: 'Personal Information',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) =>  UserUpdateProfile(user: user,)),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileListTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ProfileListTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade200,
        child: Icon(icon, color: Colors.blue),
      ),
      title: Text(label),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
