import 'package:Tinder/data/repository/users_repository.dart';
import 'package:bloc/bloc.dart';

import 'get_users_state.dart';
import 'users_event.dart';

class GetUsersBloc extends Bloc<UsersEvent, GetUsersState> {
	final UserRepository userRepository;
	
	GetUsersBloc({this.userRepository}) : assert(userRepository != null);
	
	@override
	GetUsersState get initialState => GetUsersUnInitial();
	
	@override
	Stream<GetUsersState> mapEventToState(UsersEvent event) async* {
		// to notify that is loading
		yield GetUsersLoading();
		// if you have multiple event
		if (event is GetUsersEvent) {
			var result = await userRepository.getFavoriteUsers();
			yield GetUsersSuccess(result);
		}
		// if have error you can yield GetUsersError state
	}
	
}