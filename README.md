# Product Overview

Flutter Web application displaying products from FakeStore API.

## Requirements

- Flutter SDK (stable channel)
- Dart SDK ^3.9.2

## Quick Start

Flutter (Channel stable, 3.35.5)

```bash
# Install dependencies
flutter pub get
dart run build_runner build
```

### Run on Different Platforms

```bash
# Web (Chrome)
flutter run -d chrome

# macOS
flutter run -d macos

# Windows
flutter run -d windows

# iOS Simulator
flutter run -d ios

# Android Emulator/Device
flutter run -d android
```

> **Note:** macOS requires network entitlements (already configured). Android requires INTERNET permission (already configured).

## Architecture
z
**Layer-based structure** with separation of concerns:

```
lib/
├── core/          # Constants, theme, network client
├── data/          # Models, repositories
├── presentation/  # Screens, widgets, providers
└── router/        # go_router configuration
```

### Key Decisions

| Area    | Choice               | Rationale                              |
| ------- | -------------------- | -------------------------------------- |
| HTTP    | Dio                  | Interceptors, timeouts, error handling |
| State   | Riverpod             | FutureProvider, AsyncValue pattern     |
| Routing | go_router            | Deep linking, web-friendly URLs        |
| Models  | json_serializable    | Simple model, minimal setup            |
| Images  | cached_network_image | Caching for API images                 |

### Responsiveness

- **Mobile** (<600px): 1 column grid
- **Tablet** (600-900px): 2 columns
- **Desktop** (>900px): 4 columns

Uses native Flutter `LayoutBuilder` and `MediaQuery`.

## API

- Endpoint: `https://fakestoreapi.com/products`
- Model: Product (id, title, price, description, category, image, rating)