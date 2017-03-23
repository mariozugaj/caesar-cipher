# app/app.rb
require 'sinatra/base'
require 'sprockets'
require 'uglifier'
require 'sass'
require 'coffee-script'
require 'execjs'
require 'autoprefixer-rails'
require_relative 'models/caesar_cipher'

class ApplicationController < Sinatra::Base
  # initialize new sprockets environment
  set :environment, Sprockets::Environment.new

  # append assets paths
  environment.append_path 'assets/stylesheets'
  environment.append_path 'assets/js'

  # compress assets
  environment.js_compressor  = :uglify
  environment.css_compressor = :sass

  # get assets
  get '/assets/*' do
    env['PATH_INFO'].sub!('/assets', '')
    settings.environment.call(env)
  end

  AutoprefixerRails.install(environment)

  # routes
  get '/' do
    slim :index
  end

  post '/encrypt' do
    cipher = params[:cipher]
    shift = params[:key].to_i
    @encrypted = CaesarCipher.new.encrypt(cipher, shift)
  end

  post '/decrypt' do
    cipher = params[:cipher]
    shift = params[:key].to_i
    @decrypted = CaesarCipher.new.decrypt(cipher, shift)
  end
end
