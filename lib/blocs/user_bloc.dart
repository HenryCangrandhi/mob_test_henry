import 'package:bloc/bloc.dart';
import 'package:mob_test_henry/blocs/user_event.dart';
import 'package:mob_test_henry/blocs/user_state.dart';
import 'package:http/http.dart' as http;
import 'package:mob_test_henry/models/user.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<GetUserEvent>((event, emit) async {
      emit(UserLoading());
      final response = await http.get(Uri.parse(
        'https://627e360ab75a25d3f3b37d5a.mockapi.io/api/v1/accurate/user'
      ));
      emit(UserLoaded(users: userFromJson(response.body)));
    }
    );
  }
}