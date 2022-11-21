part of 'user_cubit.dart';

 enum StateListUsers {loading, success, error, none}
 enum StateUser {loading, success, error, none}

 class UserState extends Equatable {
  late final UserModel user;
  late final StateUser enumuser;

   UserState({
     UserModel? user,
     StateUser? enumuser
   }){
     this.enumuser = enumuser ?? StateUser.none;
     this.user = user ?? UserModel(name: '', img: '', id: '', contacts: []);
   }

   UserState copyWith({
     UserModel? user,
     StateUser? enumuser
   }){
     return UserState(
     enumuser: enumuser ?? this.enumuser,
     user: user ?? this.user,
     );
   }

  @override
  List<Object> get props => [enumuser, user,];
}