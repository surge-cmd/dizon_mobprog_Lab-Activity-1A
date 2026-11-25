import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dizon_mobprog/constants.dart';
import 'package:dizon_mobprog/widgets/custom_text.dart';

class NewsfeedCard extends StatefulWidget {
  final String userName;
  final String postContent;
  final String date;
  final int numOfLikes;
  final bool hasImage;
  final String? imagePath;
  final String? avatarPath;

  const NewsfeedCard({
    super.key,
    required this.userName,
    required this.postContent,
    required this.date,
    this.numOfLikes = 0,
    this.hasImage = false,
    this.imagePath = 'assets/images/iron_man.jpg',
    this.avatarPath,
  });

  @override
  State<NewsfeedCard> createState() => _NewsfeedCardState();
}

class _NewsfeedCardState extends State<NewsfeedCard> {
  late int _likeCount;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.numOfLikes;
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likeCount += _isLiked ? 1 : -1;
    });
  }

  Widget _buildAvatar({required double radius}) {
    final bool hasAsset =
        widget.avatarPath != null && widget.avatarPath!.isNotEmpty;
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[300],
      backgroundImage: hasAsset ? AssetImage(widget.avatarPath!) : null,
      child: !hasAsset
          ? Icon(
              Icons.person,
              size: radius * 1.15,
              color: Colors.grey[800],
            )
          : null,
    );
  }

  Widget _buildPostImage() {
    if (!widget.hasImage) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil().setHeight(6),
        bottom: ScreenUtil().setHeight(6),
      ),
      child: Image.asset(
        widget.imagePath ?? 'assets/images/iron_man.jpg',
        width: double.infinity,
        height: ScreenUtil().setHeight(210),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: ScreenUtil().setHeight(210),
            color: Colors.grey[200],
            alignment: Alignment.center,
            child: CustomText(
              text: 'Add image at ${widget.imagePath ?? "assets/images/iron_man.jpg"}',
              fontSize: ScreenUtil().setSp(11),
              color: Colors.grey[700]!,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pad = ScreenUtil().setSp(10);

    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(8),
        vertical: ScreenUtil().setHeight(5),
      ),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenUtil().setSp(6)),
      ),
      child: Padding(
        padding: EdgeInsets.all(pad),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Enhancement 2: Avatar + User Name + Date + Globe + More icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildAvatar(radius: ScreenUtil().setSp(15)),
                SizedBox(width: ScreenUtil().setWidth(10)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: widget.userName,
                      fontSize: ScreenUtil().setSp(14),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: widget.date,
                          fontSize: ScreenUtil().setSp(11),
                          color: Colors.grey[600]!,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(4)),
                        Icon(
                          Icons.public,
                          size: ScreenUtil().setSp(12),
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.more_horiz,
                  size: ScreenUtil().setSp(18),
                  color: Colors.grey[700],
                ),
              ],
            ),

            SizedBox(height: ScreenUtil().setHeight(8)),

            // Post text
            CustomText(
              text: widget.postContent,
              fontSize: ScreenUtil().setSp(12),
              color: Colors.black87,
            ),

            // Enhancement 1: Conditional Image widget
            _buildPostImage(),

            SizedBox(height: ScreenUtil().setHeight(8)),

            // Likes count row (disregarding reaction icons per instruction)
            Row(
              children: [
                Icon(
                  Icons.thumb_up,
                  size: ScreenUtil().setSp(13),
                  color: fbPrimary,
                ),
                SizedBox(width: ScreenUtil().setWidth(5)),
                CustomText(
                  text: '$_likeCount',
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey[700]!,
                ),
              ],
            ),

            SizedBox(height: ScreenUtil().setHeight(4)),
            Divider(height: ScreenUtil().setHeight(10), color: Colors.grey[300]),

            // Enhancement 3: Widget-based Like, Comment, and Share buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: _toggleLike,
                  style: TextButton.styleFrom(
                    foregroundColor: _isLiked ? fbPrimary : Colors.grey[700],
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(8),
                    ),
                  ),
                  icon: Icon(
                    Icons.thumb_up_alt_outlined,
                    size: ScreenUtil().setSp(15),
                    color: _isLiked ? fbPrimary : Colors.grey[700],
                  ),
                  label: CustomText(
                    text: 'Like',
                    fontSize: ScreenUtil().setSp(12),
                    color: _isLiked ? fbPrimary : Colors.grey[700]!,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(8),
                    ),
                  ),
                  icon: Icon(
                    Icons.chat_bubble_outline,
                    size: ScreenUtil().setSp(15),
                    color: Colors.grey[700],
                  ),
                  label: CustomText(
                    text: 'Comment',
                    fontSize: ScreenUtil().setSp(12),
                    color: Colors.grey[700]!,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(8),
                    ),
                  ),
                  icon: Icon(
                    Icons.redo,
                    size: ScreenUtil().setSp(16),
                    color: Colors.grey[700],
                  ),
                  label: CustomText(
                    text: 'Share',
                    fontSize: ScreenUtil().setSp(12),
                    color: Colors.grey[700]!,
                  ),
                ),
              ],
            ),

            SizedBox(height: ScreenUtil().setHeight(4)),

            // Comment input bar matching the diagram
            Row(
              children: [
                _buildAvatar(radius: ScreenUtil().setSp(13)),
                SizedBox(width: ScreenUtil().setWidth(8)),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(12),
                      vertical: ScreenUtil().setHeight(6),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(ScreenUtil().setSp(16)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            text: 'Write a comment...',
                            fontSize: ScreenUtil().setSp(11),
                            color: Colors.grey[600]!,
                          ),
                        ),
                        Icon(
                          Icons.sentiment_satisfied_alt_outlined,
                          size: ScreenUtil().setSp(14),
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: ScreenUtil().setWidth(6)),
                        Icon(
                          Icons.camera_alt_outlined,
                          size: ScreenUtil().setSp(14),
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: ScreenUtil().setWidth(6)),
                        Icon(
                          Icons.gif_box_outlined,
                          size: ScreenUtil().setSp(14),
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: ScreenUtil().setHeight(8)),

            // "View all comments" footer matching the reference screen
            CustomText(
              text: 'View all comments',
              fontSize: ScreenUtil().setSp(12),
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}