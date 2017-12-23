
PLAID = Plaid::Client.new(
  client_id: ENV['PLAID_CLIENT_ID'],
  secret: ENV['PLAID_SECRET'],
  env: (ENV['PLAID_ENV'] || 'something').to_sym,
  public_key: ENV['PLAID_PUBLIC_KEY']
)
