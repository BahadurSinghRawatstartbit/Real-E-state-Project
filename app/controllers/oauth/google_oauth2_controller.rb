# module OAuth
#   class GoogleOauth2Controller < ApplicationController
  

#     def callback
#       auth = request.env['omniauth.auth']
#       origin = request.env['omniauth.origin']
# byebug
#       user_account =UserAccount.find_or_initialize_by(
                    
#                     provider: auth.provider,
#                     provider_account_id: auth.uid,
#                     )
      
#       user_account.attributes = {
#         access_token:  auth.credentials.token,
#         auth_protocol: 'oauth2',
#         expires_at:    Time.at(auth.credentials.expires_at).to_datetime,
#         refresh_token: auth.credentials.refresh_token,
#         scope:         auth.credentials.scope,
#         token_type:    "Bearer",
#         user: current_user,
        
#       }
# byebug
#       user_account.save!

#       redirect_to origin

#     end
#   end
# end

module OAuth
  class GoogleOauth2Controller < ApplicationController
    skip_before_action :verify_authenticity_token, only: :callback

    def callback
      auth   = request.env['omniauth.auth']
      origin = request.env['omniauth.origin']

      # 1️⃣ Find or create USER from Google email
      user = User.find_or_create_by!(email: auth.info.email) do |u|
        u.name = auth.info.name
        u.password = SecureRandom.hex(6)
      end

      # 2️⃣ Find or create USER ACCOUNT (OAuth identity)
      user_account = UserAccount.find_or_initialize_by(
        provider: auth.provider,
        provider_account_id: auth.uid
      )

      user_account.assign_attributes(
        user:          user,
        auth_protocol: 'oauth2',
        access_token:  auth.credentials.token,
        refresh_token: auth.credentials.refresh_token,
        expires_at:    Time.at(auth.credentials.expires_at),
        scope:         auth.credentials.scope,
        token_type:    auth.credentials.token_type
      )

      user_account.save!

      # 3️⃣ Log the user in
      session[:user_id] = user.id

      redirect_to origin.presence || root_path
    end
  end
end
