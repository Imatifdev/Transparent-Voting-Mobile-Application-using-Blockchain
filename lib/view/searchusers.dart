import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchText = '';
  List<DocumentSnapshot> _users = [];

  void _searchUsers(String searchText) {
    setState(() {
      if (searchText.isNotEmpty && searchText.trim().length > 0) {
        _searchText = searchText;
      } else {
        _searchText = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voter Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onChanged: _searchUsers,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Search...',
                  suffixIcon: Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .where('First Name', isGreaterThanOrEqualTo: _searchText)
                  .where('First Name',
                      isLessThanOrEqualTo: _searchText + '\uf8ff')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                _users = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_users[index]['First Name']),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
