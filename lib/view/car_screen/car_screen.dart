import 'package:atrak/model/Car_model.dart';
import 'package:atrak/view/car_screen/step_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:atrak/Model/Car_model.dart';
// import 'package:atrak/Model/Bar_model.dart';
import 'package:atrak/gen/assets.gen.dart';
import 'package:atrak/repository/bloc/blocs.dart';
import 'package:atrak/repository/bloc/event.dart';
import 'package:atrak/repository/bloc/state.dart';
import 'package:atrak/repository/jjTools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:atrak/view/car_screen/formCar_screen.dart';
import 'package:atrak/view/component_screen/MyString.dart';
import 'package:atrak/view/component_screen/Solid_color.dart';
import 'package:atrak/view/component_screen/card_screen.dart';
import 'package:atrak/view/component_screen/loading.dart';
import 'package:atrak/view/component_screen/paginition_class.dart';
import 'package:atrak/view/component_screen/search_screen.dart';
import 'package:atrak/view/component_screen/solidColor.dart';
import 'package:atrak/view/component_screen/storage_screen.dart';
import 'package:atrak/view/component_screen/style.dart';
import 'package:atrak/view/component_screen/table_screen.dart';
import 'package:atrak/view/component_screen/title_screen.dart';
// import 'package:atrak/view/getBar_screen/addBar_screen.dart';
import 'package:atrak/view/home_screen/header_screen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../repository/repository_screen.dart';
import '../home_screen/background_screen.dart';

class CarScreen extends StatefulWidget {
  CarScreen({required this.animateCart});
  late Function(int) animateCart;
  late Function(int) back;

  @override
  State<CarScreen> createState() => _CarScreenState();
}
class _CarScreenState extends State<CarScreen> {
  List<Car_model> car_list = [];
  final Map<String, TextEditingController> searchController = {
    'search': TextEditingController(),
  };

  var box = GetStorage();
  int currentPage=1;
  List<Car_model> listPage=[];
  List<Car_model> listPageFilter = [];
  List<Car_model> get currentItems {
    int start = (currentPage - 1) * 10;
    int end = start + 10;
    if (end > listPageFilter.length) end = listPageFilter.length;
    return listPageFilter.sublist(start, end);
  }
  bool _isShow = false;
  void _toggle(){
    setState(() {
      _isShow=!_isShow;
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    Repository _repository = RepositoryProvider.of(context);
    return BlocProvider(
      create: ((context) =>
      Car_bloc(_repository)..add(Car_bloc_event_loading())),
      child: BlocBuilder<Car_bloc, Car_bloc_state>(
          builder: (context, state) {
            if (state is Car_bloc_state_loading) {
              return Center(
                child: Loading().showloading(context),
              );
            }
            if (state is Car_bloc_state_loaded) {
              List<Car_model> car = state.car;
              // if(listPageFilter.isEmpty){
              listPage = car;
              listPageFilter = listPage;
              // }
              double sizeScreenMain = box.read(sizeScreen);
              RefreshController _refreshController = RefreshController(initialRefresh: false);
              return Stack(
                  children:
                  [
                    Background(),
                    Column(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Image(image: Assets.images.logo.provider(),width: size.width*0.2,),
                            ),
                            Text(MyStrings.nashr_logo,style: AppStyle.mainTextStyleLogo.copyWith(color: SolidColorMain.simia_BackwhiteAndBlack),)
                          ],
                        ),
                        // SearchScreen(hintText: MyStrings.nashr_search,icon:box.read(today)==night ? Assets.icons.blackSearch : Assets.icons.whiteSearch,controler: searchController['search'],lableText: '',isPost: true,isPost2: false,search: (val){
                        //   filterByType(val!);
                        // },),
                        SizedBox(height: 5,),
                        TitleScreen().title(size, context, MyStrings.nashr_tb_title,false,(val){Navigator.of(context).pop();}),
                        SizedBox(height: 5,),
                        Container(
                          width: size.width/1.10,
                          child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                            Text(MyStrings.nashr_getCar_id,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_Title),),
                            Text(MyStrings.nashr_getCar_mabda,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_Title),),
                            Text(MyStrings.nashr_getCar_maghsad,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_Title),),
                            Text('',style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_Title),),
                            Text('',style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_Title),),
                            Text('',style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_Title),),

                          ],),
                        ),
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
                                    if(car.isEmpty){
                                      BlocProvider.of<Car_bloc>(context).add(Car_bloc_event_loading()); //درخواست دوباره
                                    }
                                    _refreshController.refreshCompleted();
                                  },
                                  child: CustomScrollView(
                                    slivers: [
                                      SliverList(
                                        delegate: SliverChildListDelegate([

                                        ]),
                                      ),
                                      car.isEmpty ? SliverToBoxAdapter(
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
                                            childAspectRatio:7.0,
                                          ),
                                          delegate: SliverChildBuilderDelegate(
                                                (context, index) {

                                              print(">>>>> >>> >>>${index}");
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

                                                          SizedBox(height: 2,),
                                                          Container(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(bottom: 1.0),
                                                              child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                                                                Text('${car[index].id}',style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: SolidColorMain.simia_subTitle),),
                                                                Text('${car[index].department_title}',style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: box.read(today)==night ? SolidColor.dr_appColorWhite: SolidColor.dr_appBlack3),),
                                                                Text('${car[index].formAnswers_date}',style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: box.read(today)==night ? SolidColor.dr_appColorWhite: SolidColor.dr_appBlack3),),
                                                                    ZoomTapAnimation(onTap:(){
                                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StepProgressPage(userId: car[index].userId,formId: car[index].formAnswers_formId,answerSetId: car[index].id,)));
                                                                    } ,child:CardScreen().cardButton(size, context, 2.0, 2.0, SolidColorMain.simia_PaleOrange, SolidColorMain.simia_orange, 5.0, Assets.icons.eyeBlack.provider(), MyStrings.nashr_tb_seeKala,SolidColorMain.simia_orange , true)),

                                                              ],),
                                                            ),
                                                          ),
                                                          // Divider(
                                                          //   color: SolidColorMain.simia_cancleAndPlus,     // رنگ خط
                                                          //   thickness: 1,           // ضخامت خط
                                                          //   indent: 16,             // فاصله از چپ
                                                          //   endIndent: 16,          // فاصله از راست
                                                          // ),
                                                          // _dataTitle(MyStrings.nashr_getCar_price,MyStrings.nashr_getCar_finalprice,SolidColorMain.simia_BackwhiteAndBlack),
                                                          // SizedBox(height: 2,),
                                                          // _dataTitle(MyStrings.nashr_getCar_price,MyStrings.nashr_getCar_finalprice,SolidColorMain.simia_subTitle),
                                                          // Divider(
                                                          //   color: SolidColorMain.simia_cancleAndPlus,     // رنگ خط
                                                          //   thickness: 1,           // ضخامت خط
                                                          //   indent: 16,             // فاصله از چپ
                                                          //   endIndent: 16,          // فاصله از راست
                                                          // ),
                                                          // _dataTitle(MyStrings.nashr_getCar_date,MyStrings.nashr_getCar_oclock,SolidColorMain.simia_Title),
                                                          // SizedBox(height: 2,),
                                                          // _dataTitle(MyStrings.nashr_getCar_date,MyStrings.nashr_getCar_oclock,SolidColorMain.simia_subTitle),
                                                          // Divider(
                                                          //   color: SolidColorMain.simia_cancleAndPlus,     // رنگ خط
                                                          //   thickness: 1,           // ضخامت خط
                                                          //   indent: 16,             // فاصله از چپ
                                                          //   endIndent: 16,          // فاصله از راست
                                                          // ),

                                                          // _isShow ? Column(children: [
                                                          //   _dataTitle(MyStrings.nashr_getCar_getCar,MyStrings.nashr_getCar_getNumber,SolidColorMain.simia_Title),
                                                          //   SizedBox(height: 2,),
                                                          //   _dataTitle(MyStrings.nashr_getCar_getCar,MyStrings.nashr_getCar_getNumber,SolidColorMain.simia_subTitle),
                                                          //   SizedBox(height: 2,),
                                                          //   _dataTitle(MyStrings.nashr_getCar_driver,MyStrings.nashr_getCar_hour,SolidColorMain.simia_Title),
                                                          //   SizedBox(height: 2,),
                                                          //   _dataTitle(MyStrings.nashr_getCar_driver,MyStrings.nashr_getCar_hour,SolidColorMain.simia_subTitle),
                                                          //   SizedBox(height: 2,),
                                                          //   _dataTitle(MyStrings.nashr_getCar_vazn,MyStrings.nashr_getCar_maghsads,SolidColorMain.simia_Title),
                                                          //   SizedBox(height: 2,),
                                                          //   _dataTitle(MyStrings.nashr_getCar_vazn,MyStrings.nashr_getCar_maghsads,SolidColorMain.simia_subTitle),
                                                          //   Divider(
                                                          //     color: SolidColorMain.simia_cancleAndPlus,     // رنگ خط
                                                          //     thickness: 1,           // ضخامت خط
                                                          //     indent: 16,             // فاصله از چپ
                                                          //     endIndent: 16,          // فاصله از راست
                                                          //   ),
                                                          //   SizedBox(height: 2,),
                                                          //   _dataTitle(MyStrings.nashr_getCar_createdate,MyStrings.nashr_getCar_bydate,SolidColorMain.simia_Title),
                                                          //   SizedBox(height: 2,),
                                                          //   _dataTitle(MyStrings.nashr_getCar_createdate,MyStrings.nashr_getCar_bydate,SolidColorMain.simia_subTitle),
                                                          //   SizedBox(height: 2,),
                                                          //   _dataTitle(MyStrings.nashr_getCar_dis,MyStrings.nashr_getCar_bydate,SolidColorMain.simia_Title),
                                                          //   SizedBox(height: 2,),
                                                          //   _dataTitle(MyStrings.nashr_getCar_dis,MyStrings.nashr_getCar_bydate,SolidColorMain.simia_subTitle),
                                                          //   SizedBox(height: 2,),
                                                          //   _dataTitle(MyStrings.nashr_getCar_disMaghsad,MyStrings.nashr_getCar_disMaghsad,SolidColorMain.simia_Title),
                                                          //   SizedBox(height: 2,),
                                                          //   _dataTitle(MyStrings.nashr_getCar_disMaghsad,MyStrings.nashr_getCar_disMaghsad,SolidColorMain.simia_subTitle),
                                                          // ],):Text(''),
                                                          // Container(
                                                          //   // width: size.width/1.10,
                                                          //   child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                                                          //     Text(MyStrings.nashr_getCar_status,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: box.read(today)==night ? SolidColor.dr_appColorWhite: SolidColor.dr_appBlack),),
                                                          //     CardScreen().cardButton(size, context, 2.0, 1.0, SolidColorMain.simia_PaleGreen, SolidColorMain.simia_green, 5.0, "", MyStrings.nashr_getCar_status1,SolidColorMain.simia_green , false),
                                                          //   ],),
                                                          // ),
                                                          SizedBox(height: 2,),
                                                          // Container(
                                                          //   // width: size.width/1.10,
                                                          //   child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                                                          //     ZoomTapAnimation(onTap:(){
                                                          //       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FormcarScreen()));
                                                          //     } ,child:CardScreen().cardButton(size, context, 2.0, 2.0, SolidColorMain.simia_PaleOrange, SolidColorMain.simia_orange, 5.0, Assets.icons.edit.provider(), MyStrings.nashr_getCar_edit,SolidColorMain.simia_orange , true)),
                                                          //     Text('',style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack3),),
                                                          //     Text('',style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack3),),
                                                          //     ZoomTapAnimation(
                                                          //       onTap: _toggle,
                                                          //       child: Row(
                                                          //         children: [
                                                          //           Text(_isShow ? MyStrings.nashr_getCar_lowgher : MyStrings.nashr_getCar_etc,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack3),),
                                                          //           Padding(
                                                          //               padding: const EdgeInsets.all(2.0),
                                                          //               child: Icon(_isShow ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down_rounded,color: box.read(today)==night ? SolidColor.dr_appBlack1: SolidColor.dr_appBlack3,)
                                                          //           ),
                                                          //         ],
                                                          //       ),
                                                          //     ),
                                                          //
                                                          //
                                                          //   ],),
                                                          // ),
                                                        ],),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            childCount: currentItems.length, // تعداد کل خانه‌ها
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
            if (state is Car_bloc_state_Error) {
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
  }
  void _select(context,size,val){
    // _shModal.JModalBar().modalTopSheet(context,size);
  }
  //جستجو
  void filterByType(String selectedType) {
    print("6669999999999999999");
    final filtered = listPage
        .where((product) =>
    product.department_title == selectedType)
        .toList();
    setState(() {
      listPageFilter = filtered;
      print("بعد از فیلتر (درست): ${filtered}");
    });

    // اگر نیاز داری بعد از فیلتر یه کار دیگه بکنی:
    Future.delayed(Duration.zero, () {
      print("بعد از فیلتر (درست): ${listPageFilter}");
      // doSomethingWithFiltered(subCategoryByFilter);
    });
  }
  // همه رو نشون بده
  void clearFilter() {
    setState(() {
      listPageFilter = listPage;
    });
  }
  Widget _dataTitle(title1,title2,color){
    return Container(
      // width: size.width/1.10,
      child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
        Text(title1,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: color),),
        Text(title2,style: AppStyle.mainTextStyleLogo.copyWith(fontSize: 13.0,color: color),),
      ],),
    );
  }
}
