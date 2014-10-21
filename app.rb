require 'sinatra/base'
require 'sinatra/flash'
require_relative 'routes/init'

class MyApp < Sinatra::Base
  register Sinatra::Flash

  enable :method_override
  enable :sessions

  configure do
    set :app_file, __FILE__
    set :show_production, false
    set :trunk_path, '/var/www/html/trunk'
    set :production_path, '/var/www/html/producao'
    set :master_user, 'murillo.parreira'
    set :master_password, '@m150'
    set :senhas, {'edilson.ferreira' => '@e324', 'murillo.parreira' => '@m150', 'ricardo.pulice' => '%r357', 'danilo.lopes' => 'danilo123'}
  end

  configure :development do
    enable :logging, :dump_errors, :raise_errors
  end

  configure :production do
    set :raise_errors, false 
    set :show_exceptions, false 
  end
end