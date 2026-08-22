# Currency Exchange Tracker — UI/UX Design Brief

## Ground rule (read first)

Everything you design must come from the information in this document. Do not
add currencies, screens, fields, copy, icons, or features that aren't listed
below or explicitly marked as open. If you're unsure whether something is
allowed, treat it as *not* allowed and ask instead of inventing it. Layout,
color system, typography, spacing, and general visual polish are open — the
source spec explicitly leaves those to the designer — but the *content* (what
data appears, what it's called, what states exist) is fixed by this brief.

## What the app is

A Flutter app called **Currency Exchange Tracker**. It shows live exchange
rates for 5 currencies against the Egyptian Pound (EGP), and lets the user tap
into a detail view with a 7-day historical chart. Base currency is always EGP.
There is no login, no account, no settings screen, no currency converter/
calculator, and no currency other than the 5 listed below — do not add any of
these.

**Target currencies (exactly these 5, this order):**

| Code | Name | Response key |
|------|------|---------------|
| USD | US Dollar | `egp.usd` |
| EUR | Euro | `egp.eur` |
| GBP | British Pound | `egp.gbp` |
| SAR | Saudi Riyal | `egp.sar` |
| JPY | Japanese Yen | `egp.jpy` |

No currency symbols, flags, or icons are specified in the source spec. If you
want to add flag icons or symbols as a visual-polish choice, that's fine — but
don't present them as if they were required or sourced from the API, since
they aren't.

## Data source (for realistic mock content only)

The rates come from a public API. It returns rates **FROM 1 EGP TO** the
target currency, so the app inverts them to display "1 USD = X EGP". Below are
**real, verified responses** — use these actual numbers as your mock/placeholder
content in the screens so the design reads as authentic data, not made-up
numbers.

**Latest (today, 2026-08-21):**
```json
{
  "date": "2026-08-21",
  "egp": {
    "usd": 0.019654764,
    "eur": 0.016812418,
    "gbp": 0.014403292,
    "sar": 0.073705366,
    "jpy": 3.12425033
  }
}
```

**Yesterday (2026-08-20):**
```json
{
  "date": "2026-08-20",
  "egp": {
    "usd": 0.019742738,
    "eur": 0.016901026,
    "gbp": 0.014509684,
    "sar": 0.074035266,
    "jpy": 3.12638234
  }
}
```

**Inverted + daily change, derived from the above (this is the actual shape
the UI binds to — a DTO computed client-side, not returned by the API):**

| Code | Rate today (1 unit = X EGP) | Rate yesterday | Absolute change | % change | Direction |
|------|------|------|------|------|------|
| USD | 50.878 | 50.652 | +0.226 | +0.446% | EGP weaker → red |
| EUR | 59.481 | 59.169 | +0.312 | +0.527% | EGP weaker → red |
| GBP | 69.430 | 68.919 | +0.511 | +0.742% | EGP weaker → red |
| SAR | 13.568 | 13.507 | +0.061 | +0.452% | EGP weaker → red |
| JPY | 0.320 | 0.320 | ~0.000 | ~0.00% | roughly flat |

Color rule (from spec, exact wording): **green when EGP strengthens, red when
EGP weakens.** EGP weakens = it now takes *more* EGP to buy 1 unit of the
foreign currency (rate went up) = red. EGP strengthens = rate went down =
green. Apply this consistently; don't invent a different color mapping.

**7-day history for the detail screen (example currency: USD), real verified
data, oldest → newest:**

| Date | 1 USD = X EGP |
|------|------|
| 2026-08-15 | 49.961 |
| 2026-08-16 | 50.257 |
| 2026-08-17 | 49.853 |
| 2026-08-18 | 50.194 |
| 2026-08-19 | 50.529 |
| 2026-08-20 | 50.652 |
| 2026-08-21 | 50.878 |

Use this real series for the line-chart mock content instead of a smooth fake
curve — it has a realistic amount of noise.

## Screens to design

### 1. Exchange Rates List (home screen)

- A list of exactly 5 rows, one per currency above, in the table order given.
- Each row shows: currency name, currency code, the rate ("1 USD = 50.878
  EGP" style — how many EGP per 1 unit of foreign currency), and the daily
  change as both absolute and percentage, color-coded per the rule above.
- Pull-to-refresh gesture to manually re-fetch.
- Required states — design all of them as separate frames:
  - **Loaded** (normal list, using the real data above)
  - **Loading** (initial fetch, before any data exists)
  - **Error** (the fetch failed — needs a clear, user-friendly message and a
    retry action)
  - **Empty** (fetch succeeded but returned no usable rates)
  - **Offline** (device has no connection; cached data is shown with a clear
    indicator of when it was last updated — this is an overlay/banner state
    on the loaded list, not a separate screen)

### 2. Currency Detail

- Reached by tapping a row in the list.
- Shows: the current exchange rate, the daily change (absolute and
  percentage, same color rule), and the date of the last update.
- A line chart of the last 7 days of rates for that currency (use the USD
  7-day table above as the mock content; the same structure applies to any of
  the 5 currencies).
- Required states — design all of them as separate frames:
  - **Loaded** (rate info + chart populated)
  - **Chart loading** — must be a **shimmer placeholder**, not a spinner.
    This is explicit in the spec; don't substitute a spinner.
  - **Error** — if the API returns no data or fails, a clear user-friendly
    message (not a raw error/stack trace).

## Explicitly out of scope — do not design these

- Login/auth/onboarding screens
- Settings/preferences screens
- A currency converter or calculator input
- Any currency not in the 5-row table above
- Push notifications, alerts, or price-target features
- Multi-language/localization screens (unless you want to note it as an open
  visual-polish idea, but do not treat it as required)

## What "open" actually means here

The source spec's exact words: *"Design decisions, visual polish, and user
experience are entirely in your hands... we evaluate the app as a complete
experience, not just the code behind it."* So: color palette, typography,
spacing, iconography, empty-state illustrations, chart styling, and overall
visual identity are yours to define. What is **not** open is the underlying
data model — the 5 currencies, the fields per row, the states listed above,
and the color-direction rule must stay exactly as specified.
