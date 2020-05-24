
Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, ENV["GITHUB_CLIENT_ID"],ENV["GITHUB_CLIENT_SECRET"]
end
#GITHUB_CLIENT_ID identifies the GitHub application
#GITHUB_CLIENT_SECRET the password for my GitHub  application