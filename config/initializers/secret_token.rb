# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

# Although this is not needed for an api-only application, rails4
# requires secret_key_base or secret_token to be defined, otherwise an
# error is raised.
# Using secret_token for rails3 compatibility. Change to secret_key_base
# to avoid deprecation warning.
# Can be safely removed in a rails3 api-only application.
Ror::Application.config.secret_key_base = 'a21799ae2d1897c2b0ae47a8a8a776b4a52569a0a0eb14412820b555018c8e4005eb1f633a0b1d847f459a11e0f39f3ee6665a5307467a46dd45447944436868'
