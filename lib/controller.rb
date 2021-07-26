require 'sinatra'
require_relative 'gossip.rb'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end
  
  get '/gossip/new' do
    erb :gossip_new
  end

  post '/gossip/new' do
    Gossip.new(params[:gossip_author],params[:gossip_content]).save
    redirect '/'
  end

  get '/gossip/:id' do
    @id = params[:id].to_i
    @gossip = Gossip.find(@id)
    @comments = Gossip.show_comment(@id+1)
    erb :show
  end

  post '/gossip/:id' do
    @id = params[:id].to_i
    Gossip.comment(@id+1,params[:new_comment])
    redirect '/gossip/:id'
  end

  get '/gossip/:id/edit' do
    @id = params[:id].to_i
    erb :edit
  end
  
  post '/gossip/:id/edit' do
    @id = params[:id].to_i
    Gossip.edit(@id,params[:gossip_edit])
    redirect '/gossip/:id'
  end

end


#erb :show, locals:{id: params["id"].to_i, gossip: Gossip.find(params[:id].to_i)}