require "json"
require "sinatra"

class Controller < Sinatra::Base

  get "/:id?" do
    data = Model::find(params[:id] || 0)
    @main = data.main
    @item = data.item
    @question = data.question
    erb :index
  end

  get "/raw/:id?" do
    content_type :json
    Model::find(params[:id] || 0).to_json
  end

end