class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
#Resetting the root as the parent directory of the current directory
  set :root, File.join(File.dirname(__FILE__),'..')
  #Sets the views directory correctly
  set :views, Proc.new{File.join(root, "views")}

  #INDEX
  get '/people' do
    @title = "People"
    @people = People.all

    erb  :'people/index'
  end
  #NEW
  get '/people/new' do
    erb :"people/new"
  end
  #SHOW
  get '/people/:id' do
    id = params[:id].to_i
    @people = People.find id
    erb :'people/show'
  end
  #Create
  post '/people' do
    people = People.new
    people.first_name = params[:first_name]
    people.last_name = params[:last_name]
    people.gender = params[:gender]
    people.save
    redirect '/people'
  end
  #UPDATE
  put '/people/:id' do
    id = params[:id].to_i
    people = People.find id

    people.first_name = params[:first_name]
    people.last_name = params[:last_name]
    people.gender = params[:gender]

    people.save

    redirect '/people'
  end
  #Delete
  delete '/people/:id' do
    id = params[:id].to_i
    People.destroy id
    redirect '/people'
  end
  #EDIT
  get '/people/:id/edit' do
    id = params[:id].to_i
    @people = People.find id

    erb :'people/edit'
  end

end # class end
