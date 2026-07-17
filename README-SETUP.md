# Daybook setup

This folder contains:

- `index.html` — the GitHub Pages website
- `supabase-setup.sql` — the database table and privacy rules

## 1. Create the Supabase project

Create a Supabase project, then open **SQL Editor**, paste the contents of `supabase-setup.sql`, and run it.

## 2. Copy the two browser credentials

In Supabase, open **Project Settings → API**. Copy:

- **Project URL**
- **Publishable key** (a legacy `anon` key also works)

Open `index.html` in a text editor and replace:

```js
const SUPABASE_URL = 'PASTE_YOUR_SUPABASE_URL_HERE';
const SUPABASE_PUBLISHABLE_KEY = 'PASTE_YOUR_SUPABASE_PUBLISHABLE_KEY_HERE';
```

Do **not** use a `service_role` or secret key.

## 3. Configure the login redirect

In Supabase, open **Authentication → URL Configuration**.

For this repository, use:

```text
Site URL: https://chall523.github.io/Daybook/
Redirect URL: https://chall523.github.io/Daybook/
```

The redirect URL is used for account confirmation and password resets.

## 4. Publish on GitHub Pages

Upload these files to the top level of the `Daybook` repository:

- `index.html`
- optionally `README-SETUP.md`

Then open **Repository Settings → Pages** and select:

```text
Source: Deploy from a branch
Branch: main
Folder: /(root)
```

The site should appear at:

```text
https://chall523.github.io/Daybook/
```

## What this version includes

- Email/password account creation and sign-in
- Email confirmation support
- Password-reset emails
- Private per-user database records through Row Level Security
- Cloud synchronization between devices
- Local cached copy if the network temporarily fails
- Automatic migration of the old browser-only `daybook-state` data when the account has no cloud record yet
- Manual JSON export and import backups

## Security note

The Supabase publishable key is designed to be used in browser code. The database remains private because the SQL file enables Row Level Security and restricts each signed-in user to the row matching their authenticated user ID.
