Rails.application.config.middleware.use OmniAuth::Builder do
  provider :sso, ENV["SSO_APP_ID"], ENV["SSO_APP_SECRET"]
end