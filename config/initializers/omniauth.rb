Rails.application.config.middleware.use OmniAuth::Builder do
  configure do |config|
    config.path_prefix = '/oauth'
    config.logger=Rails.logger if Rails.env.development?
  end
  provider :google_oauth2,
          #  Rails.application.credentials.dig(:google,:google_client_id),
          #  Rails.application.credentials.dig(:google,:google_client_sk_id),
          ENV["GOOGLE_CLIENT_ID"],
          ENV["GOOGLE_CLIENT_SECRET"],
           {
            include_granted_scopes:true,
            scope: 'email,profile,offline',
            prompt: 'select_account'
           }
end
