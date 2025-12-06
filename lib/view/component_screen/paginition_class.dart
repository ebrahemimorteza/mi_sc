import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:atrak/view/component_screen/Solid_color.dart';
import 'package:atrak/view/component_screen/style.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Paging extends StatefulWidget {
  final int totalItems;
  final int perPage;
  Function(int) changePage;

  Paging({
    super.key,
    required this.totalItems,
    required this.changePage,
    this.perPage = 10,
  });

  @override
  State<Paging> createState() => _PagingState();
}

class _PagingState extends State<Paging> {
  late int currentPage;

  int get totalPages => (widget.totalItems / widget.perPage).ceil();

  @override
  void initState() {
    super.initState();
    currentPage = 1; // صفحه اول به صورت پیشفرض

  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) {
      setState(() {
        currentPage = page;
        widget.changePage(currentPage);
      });
    }
  }

  void nextPage() {
    if (currentPage < totalPages) {
      setState(() {
        currentPage++;
        widget.changePage(currentPage);
      });
    }
  }

  void prevPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
        widget.changePage(currentPage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return _buildPagination(size, context);
  }

  Widget _buildPagination(size, context) {
    return Center(
      child: Container(
        width: size.width / 1.20,
        decoration: BoxDecoration(
          color: SolidColorMain.simia_whiteAndBlack,
          border: Border.all(color: SolidColorMain.simia_cancleAndPlus),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ZoomTapAnimation(
              onTap: nextPage,
              child: Text(
                "بعدی",
                style: AppStyle.mainTextStyleLogo.copyWith(
                  color: currentPage < totalPages
                      ? SolidColorMain.simia_BackwhiteAndBlack
                      : SolidColorMain.simia_Blue,
                ),
              ),
            ),
            SizedBox(width: 4),
            Container(
                width: 2, height: 20, color: SolidColorMain.simia_cancleAndPlus),
            SizedBox(width: 4),
            _buildPageNumbers(context),
            SizedBox(width: 4),
            Container(
                width: 2, height: 20, color: SolidColorMain.simia_cancleAndPlus),
            SizedBox(width: 2),
            ZoomTapAnimation(
              onTap: prevPage,
              child: Text(
                "قبلی",
                style: AppStyle.mainTextStyleLogo.copyWith(
                  color: currentPage > 1
                      ? SolidColorMain.simia_BackwhiteAndBlack
                      : SolidColorMain.simia_Blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageNumbers(BuildContext context) {
    return Row(
      children: List.generate(totalPages, (index) {
        int pageNum = index + 1;
        bool isActive = pageNum == currentPage;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: _buildPageButton(context, pageNum.toString(), isActive),
        );
      }).reversed.toList(),
    );
  }

  Widget _buildPageButton(context, String pageNumber, bool isActive) {
    return GestureDetector(
      onTap: () {
        goToPage(int.parse(pageNumber));
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: isActive
              ? SolidColorMain.simia_Blue
              : SolidColorMain.simia_PaleBlue,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Center(
          child: Text(
            pageNumber,
            style: AppStyle.mainTextStyleLogo.copyWith(
              color: isActive
                  ? SolidColorMain.simia_whiteAndBlack
                  : SolidColorMain.simia_BackwhiteAndBlack,
            ),
          ),
        ),
      ),
    );
  }
}
