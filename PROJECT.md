# Stack of Napkins — Project Context

## What it is
An AI product for solo founders and solopreneurs — "a team of one, running
like ten." Built on the QM agent harness, it gives one person a crew of
agents (inbox, social, content, support, data, docs) that draft and act
under an approval-first trust dial. Positioned as augment-not-replace:
owned, on your own stack, no lock-in.

## Status
Pre-launch. Marketing site + waitlist live; product in build.

## Stack
Static HTML, Supabase (REST + RLS), Vercel (`cleanUrls`).

## Pages
- `index.html` — homepage (hero, the crew, industry verticals)
- `pricing.html` — three flat tiers (Starter $29 / Pro $99 / Scale $299)
- `signin.html` — pre-launch waitlist join form

Internal navigation uses extensionless routes (`/pricing`, `/signin`) via
`vercel.json` `cleanUrls`.

## Waitlist flow
1. Visitor submits the email field on `signin.html`
2. POST to Supabase REST API → INSERT into `public.waitlist`
3. RLS: public (anon) INSERT only; no read-back. Duplicate emails are
   rejected by a case-insensitive unique index (client treats 409 as success)

Migration: `supabase/migrations/20260816_waitlist.sql`

## Domains & Services
- Domain: stackofnapkins.com
- Supabase: https://hqnhovkfofbxfqtftewa.supabase.co (RLS enabled)
- Deployed: Vercel (auto-deploy from main)

## Notes
- The previous "AI agency for professional services" brand and its contact
  form / email pipeline (Resend, `notify-contact` edge function,
  `contact_submissions` trigger) have been retired. If the
  `contact_submissions` table, `on_contact_submission` trigger,
  `notify_contact_email()` function, or `notify-contact` edge function
  still exist on the live Supabase project, drop/undeploy them there —
  removing the repo files does not touch the live database.
