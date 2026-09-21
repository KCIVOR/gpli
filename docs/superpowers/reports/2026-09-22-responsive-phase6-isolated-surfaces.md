# Responsive Phase 6 — Isolated conversion-critical surfaces (2026-09-22)

**Outcome: all sub-surfaces blocked. No CSS, view, JS or controller was changed in this phase.**
Per the plan, a surface is added to the manifest only once it is reachable *and* safe to inspect. Inventory (Step 1) and evidence:

| Surface | Route / shell | Owner CSS | Sensitivity | Reachable safely? | Evidence |
|---|---|---|---|---|---|
| Student payment page | `payment` → `views/payment-global/index.php` (own shell, `payment-global/includes_top.php`) | `gp-payment.css` | Gateway SDKs, payment tokens, hidden fields | **No.** Empty for guests (0 bytes). Needs a student session *and* a populated cart/`payment_details` session; adding to cart mutates session state and checkout is a purchase flow. | `curl /payment` → 200, 0 bytes |
| Instructor payout checkout | `admin/paypal_checkout_for_instructor_revenue`, `razorpay_checkout_for_instructor_revenue` | `gp-payout-checkout.css` | Payout amounts/IDs, gateway keys | **No.** The PayPal view is built from POSTed `amount_to_pay`, `payout_id`, `production_client_id`; the Razorpay action can mark a payout paid. No read-only entry point. | `Admin.php:1457-1467`, `:1538-1543` |
| Installer | `install/step0…` → `views/install/` | `gp-install.css` | Database config, purchase-code check | **No.** `Install::step*` redirects to login unless `default_controller == 'install'` (i.e. on an uninstalled system). The installed local site cannot render it. | `Install.php:25-30` |
| Lesson player | `home/lesson/<slug>/<course>/<lesson>` → `views/lessons/` | lesson includes (not DS-owned yet) | Enrolment/progress data | **Not without a write.** Admin may open it, but the controller calls `crud_model->update_last_played_lesson()`, which inserts/updates a `watch_histories` row for the viewing user. Plan rule 11 forbids data writes during QA. | `Home.php:874-895`, `Crud_model.php:4301-4330` |
| Mobile webview | `views/mobile/*` (own shell, own payment/quiz views) | — | Token-authenticated API pages | **No.** Rendered via API with a mobile token; not reachable from a browser session. | `views/mobile/`, `Api*.php` |
| Homepage builder | admin page + preview | `gp-homepage-builder.css` | Site content | Admin route exists (`admin/home_page_builder`) but not audited: builder forms and modals were not walked through (Phase 5 gap). | — |

## To unblock (nothing needs to be built; needs approved fixtures)
- **Payment/payout:** a disposable student account plus a test-mode gateway and a throwaway cart; inspect only, never press pay. For payout: a fixture payout row and a sandbox gateway.
- **Lesson player:** explicit approval to let a non-production user open a lesson (one `watch_histories` row is created/updated), ideally with a disposable enrolled student.
- **Installer:** a separate uninstalled copy (never the working site).
- **Mobile webview:** a mobile API token for a test user and the WebView URLs.
- **Homepage builder:** a Phase-5-style walkthrough on a non-production admin.

Print/PDF certificates, canvas output and email media remain out of scope, as the plan states.
