-- Waitlist for the pre-launch sign-up form (signin.html).
-- Public (anon) clients may INSERT only; no one may read back via the API.

CREATE TABLE IF NOT EXISTS public.waitlist (
  id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email      text NOT NULL,
  source     text,
  created_at timestamptz NOT NULL DEFAULT now()
);

-- Prevent duplicate signups (case-insensitive).
CREATE UNIQUE INDEX IF NOT EXISTS waitlist_email_unique
  ON public.waitlist (lower(email));

ALTER TABLE public.waitlist ENABLE ROW LEVEL SECURITY;

-- Allow anonymous + authenticated clients to add themselves to the list.
DROP POLICY IF EXISTS "waitlist_public_insert" ON public.waitlist;
CREATE POLICY "waitlist_public_insert"
  ON public.waitlist
  FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

-- No SELECT/UPDATE/DELETE policies: rows are write-only from the client.
