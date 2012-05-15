require "sinatra"
require "json"

class Controller < Sinatra::Base

  get "/" do
    @data = Model::find(0)
    erb :index
  end

  get "/:id" do
    @data = Model::find(params[:id])
    erb :index
  end

  get "/raw/:id" do
    content_type :json
    Model::find(params[:id]).to_json
  end

end