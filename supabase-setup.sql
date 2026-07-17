-- Daybook cloud-storage table and security policies
-- Run this entire file in Supabase: SQL Editor -> New query -> Run.

create table if not exists public.daybooks (
  user_id uuid primary key references auth.users(id) on delete cascade,
  journal_data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.daybooks enable row level security;

-- Browser access is allowed only for signed-in users. Row Level Security
-- below then limits every user to their own row.
revoke all on table public.daybooks from anon;
grant select, insert, update on table public.daybooks to authenticated;

drop policy if exists "daybooks_select_own" on public.daybooks;
create policy "daybooks_select_own"
on public.daybooks
for select
to authenticated
using ((select auth.uid()) = user_id);

drop policy if exists "daybooks_insert_own" on public.daybooks;
create policy "daybooks_insert_own"
on public.daybooks
for insert
to authenticated
with check ((select auth.uid()) = user_id);

drop policy if exists "daybooks_update_own" on public.daybooks;
create policy "daybooks_update_own"
on public.daybooks
for update
to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);
