# if you don't have an akismet key, get one at https://akismet.com/signup
if defined?(Dummy::Application.config.rakismet)
  Dummy::Application.config.rakismet.key = ENV['RAKISMET_KEY']
  Dummy::Application.config.rakismet.url = ENV['RAKISMET_URL']
end
