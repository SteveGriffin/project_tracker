# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user:email", provider_ignores_state: :true #access_type: 'offline' #scope: "user:email,user:follow"
end