require "json"
require "sinatra"

class Controller < Sinatra::Base

  set :public_folder, File.dirname(__FILE__) + '/static'

  get "/:id?" do
    data = Model::find(params[:id] || 0)
    @main = data.main
    @item = data.item
    @question = data.question
    @date = data.date
    erb :index
  end

  get "/raw/:id?" do
    content_type :json
    Model::find(params[:id] || 0).to_json
  end

end