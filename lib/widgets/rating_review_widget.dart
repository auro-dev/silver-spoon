import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:platemate_user/app_configs/app_colors.dart';

///
/// Created by Auro  on 21/01/22 at 7:31 pm
///

class RatingReviewWidget extends StatelessWidget {
  final String type;

  // final Rating? apiRating;
  final GlobalKey<FormState>? formKey;
  final Rx<AutovalidateMode>? autoValidateMode;
  final RxDouble? rating;
  final TextEditingController? titleController;
  final TextEditingController? descController;
  final String? Function(String r)? titleValidator;
  final Function(String? r)? descValidator;
  final Function(double? r)? rateValidator;
  final Function(double? r)? rateChanged;
  final bool loading;
  final bool doctor;
  final VoidCallback? onSubmit;

  const RatingReviewWidget({
    this.type = 'order',
    // this.apiRating,
    this.formKey,
    this.autoValidateMode,
    this.rating,
    this.titleController,
    this.descController,
    this.titleValidator,
    this.descValidator,
    this.rateValidator,
    this.rateChanged,
    this.doctor = false,
    this.loading = false,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: formKey,
      //autovalidateMode: autoValidateMode!.value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // children: apiRating != null
        //     ? [
        //         Padding(
        //           padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
        //           child: Text(
        //             'Your rating',
        //             style:
        //                 TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        //           ),
        //         ),
        //         // ReviewsTile(
        //         //   isDoctor: true,
        //         //   rating: apiRating!.rating ?? 0,
        //         //   title: apiRating!.title ?? '',
        //         //   description: apiRating!.review ?? '',
        //         // ),
        //       ]
        //     : [
        children: [
          if (!doctor)
            HeadText(
              'Rate the $type',
            ),
          FormField<double>(
            initialValue: rating == null ? 0 : rating!.value,
            validator: (val) {
              return rateValidator!.call(val);
            },
            onSaved: rateChanged,
            builder: (FormFieldState<double> state) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RatingBar(
                  initialRating: state.value!,
                  allowHalfRating: true,
                  glow: false,
                  wrapAlignment: WrapAlignment.spaceBetween,
                  itemPadding: const EdgeInsets.all(14),
                  itemSize: 48,
                  direction: Axis.horizontal,
                  ratingWidget: RatingWidget(
                    empty: Icon(
                      Icons.star_rounded,
                      color: const Color(0xffD9D9D9),
                    ),
                    full: Icon(
                      Icons.star_rounded,
                      color: const Color(0xffFFC91D),
                    ),
                    half: Icon(
                      Icons.star_half_rounded,
                      color: const Color(0xffFFC91D),
                    ),
                  ),
                  onRatingUpdate: state.didChange,
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
                    child: Text(
                      '${state.errorText}',
                      style: TextStyle(
                        color: theme.errorColor,
                        fontSize: 12,
                      ),
                    ),
                  )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
            child: Text('Share your experience',
                style: TextStyle(color: Color(0xff929292))),
          ),
          Container(
            // padding: const EdgeInsets.fromLTRB(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.borderColor,
                )),
            child: Column(
              children: [
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                      hintText: 'Title',
                      contentPadding: const EdgeInsets.all(12),
                      border: InputBorder.none,
                      hintStyle:
                          const TextStyle(color: const Color(0xffC0C0C0))),
                  style: TextStyle(fontWeight: FontWeight.w500),
                  controller: titleController,
                  validator: (val) {
                    return titleValidator!.call(titleController!.text);
                  },
                  scrollPadding: const EdgeInsets.only(bottom: 200),
                ),
                TextFormField(
                  controller: descController,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (val) {
                    return descValidator!.call(descController!.text);
                  },
                  minLines: 3,
                  maxLines: 5,
                  decoration: InputDecoration(
                      hintText: 'Description',
                      contentPadding: const EdgeInsets.all(12),
                      border: InputBorder.none,
                      hintStyle:
                          const TextStyle(color: const Color(0xffC0C0C0))),
                  scrollPadding: const EdgeInsets.only(bottom: 200),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: loading
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : TextButton(
                          onPressed: onSubmit,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text('Submit'),
                          ),
                          style: TextButton.styleFrom(
                              primary: AppColors.brightSecondaryColor),
                        ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewsTile extends StatefulWidget {
  final String title, description;
  final double rating;
  final bool isDoctor;

  const ReviewsTile(
      {required this.rating,
      required this.title,
      required this.description,
      this.isDoctor = false});

  @override
  _ReviewsTileState createState() => _ReviewsTileState();
}

class _ReviewsTileState extends State<ReviewsTile> {
  bool _readMore = true;

  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle descriptionStyle = DefaultTextStyle.of(context).style.copyWith(
          fontSize: 15,
        );
    // Color color;
    // if (widget.rating >= 2.5) {
    //   color = Color(0xff56AB18);
    // } else {
    //   color = Color(0xffAB1818);
    // }
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        children: [
          Row(
            children: [
              // widget.isDoctor
              //     ? Icon(
              //         widget.rating < 2.5 ? Icons.thumb_down : Icons.thumb_up,
              //         size: 18,
              //         color: color)
              //     : Padding(
              //         padding: const EdgeInsets.only(top: 2),
              //         child: AppRatingWidget(widget.rating),
              //       ),
              SizedBox(width: 14),
              Text(
                '${widget.title}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              softWrap: true,
              textAlign: TextAlign.left,
              overflow: TextOverflow.clip,
              text: TextSpan(
                style: descriptionStyle,
                text: widget.description.length > 260
                    ? _readMore
                        ? widget.description.substring(0, 250)
                        : widget.description
                    : widget.description,
                children: <TextSpan>[
                  if (widget.description.length > 260)
                    TextSpan(
                      text: _readMore ? ' View More' : ' View Less',
                      style: descriptionStyle.copyWith(
                          color: AppColors.brightSecondaryColor),
                      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeadText extends StatelessWidget {
  final String text;

  const HeadText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("$text");
  }
}
