# ToDo App using Domain-Driven Design

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

You have surely seen or built Flutter apps using Firebase Auth and FirebaseFirestore and I'm sure you didn't put the Firebase calls into your widget code. In other words, you used some sort of an architecture.

You may have used `Clean Architecture`, `MVVM`, `MVC` or many more. These patterns give you a project design strategy.

But How is Domain-Driven Design (DDD) different then?

Simply said, it's better on every level. We still have a good separation into layers which brings beautiful traits ease of navigation and testability. So no, we still don't put all of our code into the UI or state management

---

The diagram below outlines the key architectural layers present in a DDD Flutter app.

<img src="./ddd-architecture-proposal.svg" style="display: block; margin-left: auto; margin-right: auto; width: 75%;"/>

---

## Getting Started 🚀

This project contains 2 flavors:

- development
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*ToDo App works on iOS, Android, and Web._

[coverage_badge]: coverage_badge.svg
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
