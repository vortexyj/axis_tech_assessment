# Currency Exchange Tracker

A Flutter app that tracks live exchange rates for five currencies against the
Egyptian Pound (EGP), with a tap-through detail view showing a 7-day
historical chart per currency. Built as a modular, multi-package Flutter
monorepo with clean-architecture layering inside each feature.

## What it does

**Exchange Rates List** (home screen) — USD, EUR, GBP, SAR and JPY, each
shown as "1 unit = X EGP" with the daily change (absolute and percentage),
color-coded red when EGP weakens and green when it strengthens. Pull to
refresh. Handles five states end to end: loaded, initial loading (skeleton),
error with retry, empty, and offline (a banner over the last-known-good list,
not a separate screen).

**Currency Detail** — reached by tapping a row. Shows the current rate, the
same color-coded change, when it was last updated, and a line chart of the
last 7 days for that currency. The chart's loading state is a shimmer
placeholder, not a spinner, per spec. Same offline banner as the list screen.

**Offline support** — every successful fetch is cached locally, keyed by
date. If a later request fails specifically because of a connectivity
problem (not a server or parsing error), the app falls back to the cached
response and tells the user it's showing cached data and when it was last
fetched, rather than just failing.

## Architecture

The rates API returns "1 EGP = X foreign currency" — the inverse of what's
displayed — and never returns a diff between two dates. Both screens invert
the rate themselves and compute the daily/weekly change client-side from two
or more separate API calls; the API is a thin, mostly stateless data source,
not a source of app-level truth.

The repo is a Flutter monorepo: the root app is a thin shell (DI bootstrap +
routing) around a set of independent local packages under `modules/`.

```
modules/
├── core/              Cross-cutting foundation: base Cubit/BlocProvider
│                       plumbing, the CurrencyEnums the whole app keys off,
│                       app-wide value constants, and thin re-export
│                       wrappers around third-party packages (dio, get_it,
│                       shimmer, fl_chart, intl, ...) so feature modules
│                       never depend on those packages directly.
├── network/            Dio-backed HTTP client behind a small Request/
│                       GetRequest/PostRequest mixin API.
├── failures/            Typed Failure hierarchy (ConnectionFailure,
│                       ServerFailure, ParsingFailure, ...) and the
│                       exception → Failure mapping used everywhere.
├── local_storage/       SharedPreferences/FlutterSecureStorage behind one
│                       small interface, used for the offline rate cache.
├── ui_components/       The design system: colors, text styles, theme, and
│                       every shared widget (AppCard, AppButtonView,
│                       RateChangeText, OfflineBanner, RateHistoryChart,
│                       ErrorWidgetView, BottomSheetView).
└── features/
    ├── splash/          Entry screen, hands off to the exchange list.
    ├── exchange/         The Exchange Rates List feature.
    └── currency_details/ The Currency Detail feature.
```

Each feature module (`splash`, `exchange`, `currency_details`) is itself
layered the same way:

```
lib/
├── data/
│   ├── models/                 Request/response wire models
│   ├── remote_data_source/     Talks to Network, throws on failure
│   ├── local_data_source/       Reads/writes the offline cache
│   └── <feature>_repository/    Orchestrates remote-first, cache-on-
│                                connection-failure
├── domain/
│   ├── entities/                Plain domain types (no JSON on them)
│   ├── <feature>_repository/     Abstract repository contract
│   └── <feature>_usecase/        One use case per repository method
├── presentation/
│   ├── cubits/                  State management (flutter_bloc Cubit)
│   └── Ui/screens/               The screen widgets
└── di/                          GetIt wiring for this module
```

The **cubit** is the only layer the UI talks to. Each screen's `body()` is a
flat `Column` of section methods (header, offline banner, list/chart, ...),
and each section owns its own `BlocBuilder` with a narrow `buildWhen`, so a
change to one part of the state (say, the offline flag) doesn't rebuild
sections that don't care about it.

**Why cache fallback lives in the repository, not the cubit:** the cubit
asks for "today's rate" and either gets one or doesn't — it has no idea
whether that rate came from the network or a cache. `ExchangeRepositoryImpl`
/`CurrencyDetailsRepositoryImpl` catch a thrown exception, map it to a typed
`Failure`, and only fall back to the local cache when that failure `is
ConnectionFailure` — a parsing or server error still surfaces as a real
error rather than silently masking a bug with stale data.

## Tech stack

- **State management:** `flutter_bloc` (Cubit)
- **DI:** `get_it`, wired per-module and bootstrapped once at app start
- **Networking:** `dio`
- **Functional error handling:** `dartz` (`Either<Failure, T>`)
- **Local storage:** `shared_preferences` / `flutter_secure_storage`
- **Charts:** `fl_chart`
- **Loading state:** `shimmer`
- **Responsive sizing:** `flutter_screenutil`
- **Testing:** `flutter_test`, `bloc_test`, `mocktail`

## Getting started

```bash
flutter pub get                       # from the repo root
flutter run -t lib/main_production.dart
```

Each package under `modules/` is a standalone Flutter package with its own
`pubspec.yaml`; if you're working inside one directly (e.g. for its tests),
run `flutter pub get` inside that package first.

## Testing

```bash
flutter test                                    # per module, from that module's directory
```

Unit tests cover the domain math (rate inversion, change/percent
calculations), cubit state transitions (loading → success/failure/empty/
offline, including the detail screen's two-stage "rate ready, chart still
loading" state), and repository cache-fallback branching. Widget tests cover
the shared components in `ui_components`. See `AI_USAGE.md` for how this
suite was built and what it caught.

## AI usage

This project was built with heavy use of Claude Code. `AI_USAGE.md` at the
repo root is a complete, timestamp-verifiable log of every prompt used
end to end — not a curated summary.
