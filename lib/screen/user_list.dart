import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mob_test_henry/blocs/user_bloc.dart';
import 'package:mob_test_henry/blocs/user_state.dart';
import 'package:mob_test_henry/widgets/filter_bottom_sheet.dart';

class UserList extends StatefulWidget {
  const UserList({super.key, required this.title});
  final String title;

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  String searchText = '';
  String resultFilter = 'Default';
  bool isSorted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(widget.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 16,
                                right: 12,
                              ),
                              child: Icon(
                                Icons.search,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search',
                                  contentPadding: EdgeInsets.only(bottom: 7),
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    searchText = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () async {
                      resultFilter = (await FilterBottomSheet.showFilterBottomSheet(
                        context: context,
                        onSelectFilter: (filter) {
                          setState(() {
                            resultFilter = filter;
                          });
                        },
                        selectedFilter: resultFilter,
                      )) ?? '';
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.filter_alt_outlined,
                        size: 22,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSorted = !isSorted;
                    print(isSorted);
                  });
                },
                child: const Row(
                  children: [
                    Icon(Icons.sort, size: 20),
                    SizedBox(width: 4),
                    Text('Sort by Name'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<UserBloc,UserState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  if (state is UserLoaded) {
                    if (resultFilter == 'City') {
                      state.users.sort((a, b) => a.city.toLowerCase().compareTo(b.city.toLowerCase()));
                    } else if (isSorted) {
                      // Jika filter bukan 'City' dan tombol sorting diaktifkan
                      state.users.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
                    } else {
                      // Jika filter bukan 'City' dan tombol sorting dinonaktifkan
                      state.users.sort((a, b) => a.id.compareTo(b.id));
                    }

                    return ListView.builder(
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          if(state.users[index].name.toLowerCase().contains(searchText.toLowerCase()) ) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                child: SizedBox(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: const BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    color: Colors.white,
                                    elevation: 0,
                                    child:  Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: Icon(
                                            Icons.account_circle_outlined,
                                            color: Colors.black,
                                            size: 60,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: state.users[index].name,
                                                    ),
                                                    TextSpan(
                                                      text: ' (${state.users[index].id})',
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.home,
                                                    color: Colors.black,
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                      state.users[index].address
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.email_outlined,
                                                    color: Colors.black,
                                                    size: 18,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                      state.users[index].email
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.phone,
                                                    color: Colors.black,
                                                    size: 18,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                      state.users[index].phoneNumber
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_city_outlined,
                                                    color: Colors.black,
                                                    size: 18,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                      state.users[index].city
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          else {
                            return const SizedBox.shrink();
                          }
                        }
                    );
                  }
                  return const Center(child: Text('No Data'));
                }
              ),
            ),
          ],
        ));
  }
}
