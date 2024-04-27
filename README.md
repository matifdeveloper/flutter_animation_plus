# flutter_animation_plus Package

## Overview
The `flutter_animation_plus` package provides a collection of versatile animation widgets designed to enhance the Flutter application's visual appeal and interactivity. With over 15+ unique animation options, developers can easily integrate dynamic effects into their UI elements.

## Installation
To use `flutter_animation_plus` in your Flutter project, add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_animation_plus: ^0.0.1
```

### Example 1:
```
FadingAnimation(
  duration: const Duration(seconds: 1),
  repeat: false,
  child: Text(
    "Fading Animation",
    style: TextStyle(fontSize: 25),
  ),
);
```

### Example 2:
```
FlipAnimation(
  duration: const Duration(seconds: 1),
  repeat: false,
  child: Text(
    "Flip Animation",
    style: TextStyle(fontSize: 25),
  ),
);

```

### Conclusion
The flutter_animation_plus package offers a wide range of animation widgets to bring life and interactivity to your Flutter applications. Choose from various effects to create captivating user experiences effortlessly.