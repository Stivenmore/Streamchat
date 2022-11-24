part of 'user_cubit.dart';

 enum StateListUsers {loading, success, error, none}
 enum StateUser {loading, success, error, none}

 class UserState extends Equatable {
  late final UserModel user;
  late final List<UserModel> listuser;
  late final StateUser enumuser;
  late final StateListUsers enumlistuser;

   UserState({
     UserModel? user,
     StateUser? enumuser,
     StateListUsers? enumlistuser,
     List<UserModel>? listuser
   }){
     this.enumuser = enumuser ?? StateUser.none;
     this.user = user ?? UserModel(name: '', img: '', id: '', contacts: []);
     this.enumlistuser = enumlistuser ?? StateListUsers.none;
     this.listuser = listuser ?? <UserModel>[];
   }

   UserState copyWith({
     UserModel? user,
     StateUser? enumuser,
    StateListUsers? enumlistuser,
     List<UserModel>? listuser
   }){
     return UserState(
     enumuser: enumuser ?? this.enumuser,
     user: user ?? this.user,
     enumlistuser: enumlistuser ?? this.enumlistuser,
     listuser:  listuser ?? this.listuser
     );
   }

  @override
  List<Object> get props => [enumuser, user, enumlistuser, listuser];
}