# Social Media App (नाम में क्या रखा है :P)

## Getting Started

To run this Project you'll need an account on the [Supbase](https://app.supabase.io/).

1. After creating an account run below query from the Supabase SQL editor to create required table.

Create a table for Public Profiles

```dart
create table profiles (
  id uuid references auth.users not null,
  updated_at timestamp with time zone,
  user_name text unique,
  avatar_url text,
  email text,
  name text,
  about text,

  primary key (id),
  unique(user_name)
);

alter table profiles enable row level security;

create policy "Public profiles are viewable by everyone."
  on profiles for select
  using ( true );

create policy "Users can insert their own profile."
  on profiles for insert
  with check ( auth.uid() = id );

create policy "Users can update own profile."
  on profiles for update
  using ( auth.uid() = id );

-- Set up Realtime!
begin;
  drop publication if exists supabase_realtime;
  create publication supabase_realtime;
commit;
alter publication supabase_realtime add table profiles;

-- Set up Storage!
insert into storage.buckets (id, name)
values ('avatars', 'avatars');

create policy "Avatar images are publicly accessible."
  on storage.objects for select
  using ( bucket_id = 'avatars' );

create policy "Anyone can upload an avatar."
  on storage.objects for insert
  with check ( bucket_id = 'avatars' );
```

2. After successfully running above query get the Base url and Base key and pass it to the command line args. while running flutter app.

```dart
flutte run --dart-define=BASE_URL=supabase_base_url --dart-define=BASE_KEY=supabase_base_key
```

That's it! You'll be able to run this app, Ping me if you stuck on any step.

Let's create an open source alternative of the social media apps out there together.



## Design Credit
https://www.figma.com/proto/pVVxJrrPmgo2OR2D5yEj0o/dianfei-SocialAppUIKit-Updated-(Community)?node-id=25%3A1577&scaling=min-zoom


