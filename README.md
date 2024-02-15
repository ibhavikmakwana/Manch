# Social Media App (नाम में क्या रखा है :P) [![Analyze](https://github.com/ibhavikmakwana/manch/actions/workflows/analyze_actions.yml/badge.svg)](https://github.com/ibhavikmakwana/manch/actions/workflows/analyze_actions.yml)


## Screenshots

| Login | Login Error | Sign up |
| ------------------ | --------------------------- | ------------------ |
| <img src="https://user-images.githubusercontent.com/22465800/127871005-fe919608-5f61-4533-8911-0549c72a2471.png" height="400" alt="Screenshot"/>  | <img src="https://user-images.githubusercontent.com/22465800/127871123-560dc871-494b-4f0c-bea2-1d984be121ac.png" height="400" alt="Screenshot"/> | <img src="https://user-images.githubusercontent.com/22465800/127871162-dd9a04bf-b6ac-447b-a9f6-00ffe7baa9a4.png" height="400" alt="Screenshot"/> |

| Edit Profile | Filled Edit Profile | Profile |
| ------------------ | --------------------------- | ------------------ |
| <img src="https://user-images.githubusercontent.com/22465800/127871283-83f1db8b-ad0f-4750-8536-f1a01b50861d.png" height="400" alt="Screenshot"/>  | <img src="https://user-images.githubusercontent.com/22465800/127871297-fd1d3a58-bdcb-448c-9d7c-8a510ab41646.png" height="400" alt="Screenshot"/> | <img src="https://user-images.githubusercontent.com/22465800/127871328-cfadb349-124e-4cb8-8986-7593bd9159d4.png" height="400" alt="Screenshot"/> |


## Getting Started

To run this Project you'll need an account on the [Supbase](https://app.supabase.io/).


1. After creating an account run below query from the Supabase SQL editor to create required table.

```dart
-- Create a table for Profiles
create table if not exists profiles (
  id uuid references auth.users on delete cascade not null,
  updated_at timestamp with time zone,
  created_at timestamp with time zone,
  user_name text unique,
  email text unique,
  name text,
  avatar_url text,
  website text,
  about text,

  primary key (id),
  unique(user_name),
  unique(email)
);

alter table profiles enable row level security;

create policy "Public profiles are viewable by everyone."
  on profiles for select
  using ( true );

create policy "Users can insert their own profile."
  on profiles for insert
  with check ( auth.role() = 'anon' );

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

create policy "Anyone can update an avatar."
  on storage.objects for update
  with check ( bucket_id = 'avatars' );
```


2. Go to `Authentication` => `settings` and make sure `Disable email confirmations` is Active or Enabled.
<img width="771" alt="Screenshot 2021-07-31 at 11 05 09 AM" src="https://user-images.githubusercontent.com/22465800/127730215-958ad8a8-b4f2-4ddb-b024-5937c41c5797.png">


3. After successfully running above query get the Base url and Base key and pass it to the command line args. while running flutter app.

```dart
flutte run --dart-define=BASE_URL=supabase_base_url --dart-define=BASE_KEY=supabase_base_key
```

That's it! You'll be able to run this app, Ping me if you stuck on any step.

Let's create an open source alternative of the social media apps out there together.


## Generating files
- `flutter pub run build_runner build`
> If code generation fails, consider running it with the flag `--delete-conflicting-outputs` 



## Design Credit
https://www.figma.com/proto/pVVxJrrPmgo2OR2D5yEj0o/dianfei-SocialAppUIKit-Updated-(Community)?node-id=25%3A1577&scaling=min-zoom


