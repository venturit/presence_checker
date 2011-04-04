#require 'net/http'
Rails.application.config.middleware.use OmniAuth::Builder do
  configure do |config|
    #config.path_prefix = '/test_omniauth/auth' if RAILS_ENV == 'production'
    if RAILS_ENV == 'production'
      config.on_failure = Proc.new do |env|
        message_key = env['omniauth.error.type']
        new_path = "/test_omniauth/auth/failure?message=#{message_key}"
        [302, {'Location' => new_path, 'Content-Type'=> 'text/html'}, []]
      end
    end
  end
  provider :shibboleth, {:uid_attribute => 'eppn'}
  #provider :cas, {:cas_server => 'http://localhost:8443', :disable_ssl_verification => true}
end