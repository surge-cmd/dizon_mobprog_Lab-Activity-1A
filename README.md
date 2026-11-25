# Dizon Evan Daniel S

## Lab Activity 1A:

### How to integrate Image into `newsfeed_card.dart` and make it dynamic whether a post has an image or not

To integrate an image into `newsfeed_card.dart` and dynamically control whether it renders, `NewsfeedCard` accepts optional parameters (`hasImage` defaulting to `false` and `imagePath` pointing to the asset location). Inside the card's `Column` layout, a helper method (`_buildPostImage()`) checks `hasImage`: when `hasImage` is `true`, it renders an `Image.asset(imagePath, fit: BoxFit.cover, ...)` widget wrapped in `ClipRRect` and `Padding`. When `hasImage` is `false`, it returns `const SizedBox.shrink()`, which takes zero visual space so text-only posts stay compact without empty gaps. Adding an `errorBuilder` to `Image.asset` also prevents layout crashes if a specified asset path is missing or fails to load.
