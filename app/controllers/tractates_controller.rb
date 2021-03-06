class TractatesController  < ApplicationController

  get "/tractates" do
    @tractates = Tractate.all.sort_by {|tractate| tractate.name}
    erb :'/tractates/index'
  end

  get "/tractates/:slug" do
    @tractate = Tractate.find_by_slug(params[:slug])
    erb :'/tractates/show'
  end

  get "/users/:id/tractates" do
    @user = User.find(params[:id])
    if logged_in?
      if authorized?(@user.id)
        @tractates = @user.tractates.uniq.sort_by
        erb :'users/tractates'
      else
        erb :'/sessions/failure'
      end
		else
			erb :'/sessions/failure'
		end
  end

  get '/users/:id/tractates/:slug' do
    @user = User.find(params[:id])
    if logged_in?
      if authorized?(@user.id)
        @tractate = Tractate.find_by_slug(params[:slug])
        @tables = @user.tables.select do |table| 
          if table.tractate
            table.tractate.name == @tractate.name
          end
        end
        erb :"/users/tractates_show"
      else
        erb :'/sessions/authorization'
      end
    else
     erb :'/sessions/failure'
   end
  end

end
