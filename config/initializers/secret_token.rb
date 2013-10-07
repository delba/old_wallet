# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Wallet::Application.config.secret_key_base = '35e46233a22fcb7f26ae57da2e506f8f1924245f85017400b39fa8af1702a178a364103194569b8165aeddf4f589b87c6f295f7a72cec9d2c903dcf178399e35'
