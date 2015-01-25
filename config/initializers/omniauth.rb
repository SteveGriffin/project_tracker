# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], {
    :scope => 'email,profile'
  }

  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user:email", provider_ignores_state: :true #access_type: 'offline' #scope: "user:email,user:follow"
end
