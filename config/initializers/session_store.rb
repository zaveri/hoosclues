# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hoosclues_session',
  :secret      => '78db3e43665167e42db6153b6f890315a8b8c8e364f309e17e1477159bfe10c12206599d0f1d6343d7349fa34f9555f6e92ef775908044961ab1d46e31cab976'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
