require 'sinatra'

set :public_folder, './'

get '/' do
  File.read(File.join('.', 'index.html'))
end