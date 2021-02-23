Rails.application.config.middleware.use(OmniAuth::Builder) do
  provider(
    :procore,
    ENV['CLIENT_ID'],
    ENV['CLIENT_SECRET'],
    client_options: {
      site: ENV['OAUTH_URL'],
      api_site: ENV['BASE_URL'],
    },
  )
end
