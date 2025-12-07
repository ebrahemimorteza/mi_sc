import 'package:atrak/gen/assets.gen.dart';
import 'package:atrak/model/Message_model.dart';
import 'package:atrak/repository/bloc/state.dart';
import 'package:atrak/repository/repository_screen.dart';
import 'package:atrak/tools/loading.dart';
import 'package:atrak/view/component_screen/card_screen.dart';
import 'package:atrak/view/component_screen/search_screen.dart';
import 'package:atrak/view/home_screen/background_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/Solid_color.dart';
import 'package:atrak/view/component_screen/line_screen.dart';
import 'package:atrak/view/component_screen/solidColor.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
import 'package:atrak/view/component_screen/style.dart';
import 'package:atrak/view/component_screen/title_screen.dart';
import 'package:atrak/view/home_screen/header_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../repository/bloc/blocs.dart';
import '../../repository/bloc/event.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen({super.key,required this.back});
  final Function(int) back;

  @override
  State<MessageScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<MessageScreen> {
  var box = GetStorage();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    Repository _repository = RepositoryProvider.of(context);
    return BlocProvider(
      create: ((context) =>
      Message_bloc(_repository)..add(Message_bloc_event_loading())),
      child: BlocBuilder<Message_bloc, Message_bloc_state>(
          builder: (context, state) {
            if (state is Message_bloc_state_loading) {
              return Center(
                child: Loading().showloading(context),
              );
            }
            if (state is Message_bloc_state_loaded) {
              List<Message_model> message = state.message;
              print("------------------------>");
              print(message.length);
              print("------------------------>");
              // if(listPageFilter.isEmpty){
              // listPage = car;
              // listPageFilter = listPage;
              // }
              double sizeScreenMain = box.read(sizeScreen);
              RefreshController _refreshController = RefreshController(initialRefresh: false);
              return Stack(
                  children:
                  [
                    Background(),
                          // HeaderScreen(changeScreen: (val){},),
                    Positioned.fill(
                      top: 30.0,
                      child: Column(
                        children: [
                          TitleScreen().title(size, context, MyStrings.nashr_message,true,(){widget.back(1);}),
                          SizedBox(height: 5,),
                          Expanded(
                            child: AnimationLimiter(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  // width: sizeScreenMain < 900 ? size.width/1.20 : size.width/1.0,
                                  child: SmartRefresher(
                                    controller: _refreshController,
                                    enablePullUp: false,
                                    header: WaterDropHeader(complete: Text('بارگذاری موفق'),
                                      failed: Text('بارگذاری ناموفق'),
                                      waterDropColor: SolidColorMain.simia_Blue,),
                                    onRefresh: () async{
                                      // monitor network fetch
                                      await Future.delayed(Duration(milliseconds: 1000));
                                      // if failed,use refreshFailed()
                                      if(message.isEmpty){
                                        BlocProvider.of<Message_bloc>(context).add(Message_bloc_event_loading()); //درخواست دوباره
                                      }
                                      _refreshController.refreshCompleted();
                                    },
                                    child: CustomScrollView(
                                      slivers: [
                                        SliverList(
                                          delegate: SliverChildListDelegate([

                                          ]),
                                        ),
                                        message.isEmpty ? SliverToBoxAdapter(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 58.0),
                                            child: Center(child: Text("شبکه در دسترس نیست",style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 15,color: SolidColorMain.simia_blueRole),)),
                                          ),
                                        ) :SliverPadding(
                                          padding: EdgeInsets.only(top:0,bottom:size.height*.08,left:sizeScreenMain < 900 ? 10 : 300,right: sizeScreenMain < 900 ? 10 :  300),
                                          sliver:  SliverGrid(
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1,
                                              crossAxisSpacing: 20,
                                              mainAxisSpacing: 5,
                                              childAspectRatio:3.0,
                                            ),
                                            delegate: SliverChildBuilderDelegate(
                                                  (context, index) {
                                                    return AnimationConfiguration.staggeredGrid(
                                                  position: index,
                                                  duration: const Duration(seconds: 1),
                                                  columnCount: 4,
                                                  child: ScaleAnimation(
                                                    child: FadeInAnimation(
                                                      child:Container(
                                                        width: size.width/1.30,
                                                        decoration: BoxDecoration(
                                                          color:SolidColorMain.simia_whiteAndBlack,
                                                          borderRadius: BorderRadius.circular(10),
                                                          border: Border.all(
                                                            color:SolidColorMain.simia_cancleAndPlus,
                                                            width: 1.5,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                                                          child: Column(children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(top: 10.0),
                                                              child: Container(
                                                                // decoration: BoxDecoration(
                                                                //     color: CupertinoColors.white,
                                                                //     borderRadius: BorderRadius.all(Radius.circular(30.0))
                                                                // ),
                                                                child: Column(children: [

                                                                  card(size,box,message[index].id,message[index].messenger_textMessage,message[index].messenger_dateOfCreation),

                                                                ],),
                                                              ),
                                                            ),
                                                            SizedBox(height: 2,),
                                                            // Container(
                                                            //   child: Padding(
                                                            //     padding: const EdgeInsets.only(bottom: 1.0),
                                                            //     child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                                                            //       Text('${message[index].id}',style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_subTitle),),
                                                            //       Text('${message[index].messenger_textHTML}',style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: box.read(today)==night ? SolidColor.dr_appColorWhite: SolidColor.dr_appBlack3),),
                                                            //       Text('${message[index].messenger_dateOfCreation}',style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: box.read(today)==night ? SolidColor.dr_appColorWhite: SolidColor.dr_appBlack3),),
                                                            //       ZoomTapAnimation(onTap:(){
                                                            //
                                                            //       } ,child:CardScreen().cardButton(size, context, 2.0, 2.0, SolidColorMain.simia_PaleOrange, SolidColorMain.simia_orange, 5.0, Assets.icons.eyeBlack.provider(), MyStrings.nashr_tb_seeKala,SolidColorMain.simia_orange , true)),
                                                            //
                                                            //     ],),
                                                            //   ),
                                                            // ),
                                                          ],),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              childCount: message.length, // تعداد کل خانه‌ها
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Positioned(bottom:70,right:20,child: ZoomTapAnimation(onTap:(){
                    //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StepProgressPage()));
                    // },child: CardScreen().cardAdd(size),)),
                    // Positioned(right:0,left:0,bottom:5,child: Paging(totalItems: listPageFilter.length,changePage: (val){
                    //   setState(() {
                    //     currentPage=val;
                    //   });
                    // },))
                  ]);
            }
            if (state is Message_bloc_state_Error) {
              late String error = state.error_text;
              return Center(
                child: Text(error),
              );
            }
            return Center(
              child: Text(MyStrings.nashr_loading_warning),
            );
          }),
    );
    // Padding(
    //   padding: EdgeInsets.only(top: 10.0),
    //   child: Container(
    //       // decoration: BoxDecoration(
    //       //     color: CupertinoColors.white,
    //       //     borderRadius: BorderRadius.all(Radius.circular(30.0))
    //       // ),
    //           child: Column(children: [
    //             SizedBox(height: 5,),
    //             TitleScreen().title(size, context, MyStrings.nashr_message),
    //             SizedBox(height: 10,),
    //             card(size,box),
    //
    //           ],),
    //   ),
    // );
  }
  Widget card(Size size,box,id,text,date){
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Container(
          width: size.width/1.10,
          height: 93.0,
          margin: EdgeInsets.all(1.0), 
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            color:SolidColorMain.simia_PaleBlue,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ListTile(
            title: Text("${text}",
              // list[index]!.messenger_textMessage,
              style:TextStyle(color: SolidColorMain.simia_BackwhiteAndBlack),
            ),
            subtitle: Text("${id}",
              // list[index]!.messenger_time +
              //     " " +
              // list[index]!.messenger_postageDate,
              style: TextStyle(color: SolidColorMain.simia_BackwhiteAndBlack),
            ),
            trailing: Text("${date}",
              // list[index]!.status,
              style: TextStyle(color: SolidColorMain.simia_BackwhiteAndBlack),
            ),
          ),
        ),
      ),
    );
  }
}
