import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:streamchat/domain/logic/stream/stream_cubit.dart';
import 'package:streamchat/domain/logic/user/user_cubit.dart';
import 'package:streamchat/domain/models/contactsmodel.dart';
import 'package:streamchat/domain/models/usermodel.dart';
import 'package:streamchat/screens/Chats/Components/chat.dart';
import 'package:streamchat/screens/Chats/Components/lastmessage.dart';
import 'package:streamchat/screens/Chats/Components/lastmessageat.dart';
import 'package:streamchat/screens/Global/global_functions.dart';

class ContactsScreen extends StatefulWidget {
  ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  late StreamChannelListController contactschannelsController;

  @override
  Widget build(BuildContext context) {
    contactschannelsController =
        context.watch<StreamCubit>().contactschannelsController;
    Size size = MediaQuery.of(context).size;
    final list = context
        .select<UserCubit, List<UserModel>>((value) => value.state.listuser);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: PagedValueListenableBuilder<int, Channel>(
            valueListenable: contactschannelsController,
            builder: (context, value, child) {
              return value.when((channel, nextPageKey, error) {
                if (channel.isEmpty) {
                  return const Center(
                    child: Text('Sin contactos'),
                  );
                }
                return LazyLoadScrollView(
                    onEndOfPage: () async {
                      if (nextPageKey != null) {
                        contactschannelsController.loadMore(nextPageKey);
                      }
                    },
                    child: CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                            return InkWell(
                              onTap: () => Navigator.of(context)
                                  .push(MaterialPageRoute(builder: ((context) {
                                return StreamChannel(
                                  channel: channel[index],
                                  child: ChatScreen(
                                    name: namechannelTocontact(
                                        channel[index], list),
                                    img:
                                        'https://placeholder.com/assets/images/150x150-2-500x500.png',
                                  ),
                                );
                              }))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(56),
                                          child: Container(
                                            height: 60,
                                            width: 60,
                                            child: FadeInImage.assetNetwork(
                                              placeholder:
                                                  'assets/placeholder.jpg',
                                              image:
                                                  'https://placeholder.com/assets/images/150x150-2-500x500.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: SizedBox(
                                            height: 40,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  namechannelTocontact(
                                                      channel[index], [
                                                    UserModel(
                                                        name: 'Yndira',
                                                        img: '',
                                                        id: 'Yndira_be638e78-1e3e-4fcb-a197-777d4cc40916',
                                                        contacts: [])
                                                  ]),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15),
                                                ),
                                                Container(
                                                    width: size.width * 0.5,
                                                    child: buildLastMessage(
                                                        channel[index]))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    buildLastMessageAt(channel[index])
                                  ],
                                ),
                              ),
                            );
                          }, childCount: channel.length),
                        )
                      ],
                    ));
              }, loading: () {
                return CircularProgressIndicator();
              }, error: (v) {
                return Center(
                  child: Text(v.message),
                );
              });
            },
          ),
        ));
  }

  @override
  void dispose() {
    contactschannelsController.dispose();
    super.dispose();
  }
}
