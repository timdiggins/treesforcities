# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_treesforcities_session',
  :secret      => 'f4b8bbaadf955da24f324134f18ae034a0e888da8cc1a03c6d58709b7457d4340a5d9d794de553d52026ed902ac358e75e8a6613c1fdd19c0d12fabf12a6dd29'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
