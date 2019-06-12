class WordsController < ApplicationController

  get "/tables/:slug/words/:id/delete" do
    @table = Table.find_by_slug(params[:slug])
    @word = Word.find(params[:id])
    if logged_in?
      if authorized?(@table.user_id)
        erb :"/words/delete_confirmation"
      else
        erb :'/sessions/authorization'
      end
    else
      erb :'/sessions/failure'
    end
  end

  delete "/tables/:slug/words/:id" do
    @table = Table.find_by_slug(params[:slug])
    if logged_in?
      if authorized?(@table.user_id)
        @table = Table.find_by_slug(params[:slug])
        word = Word.find(params[:id])
        @table.delete_word(word)
        flash[:message] = "#{word.hebrew} deleted. "
        redirect "/users/#{current_user.id}/tables/#{@table.slug}/edit"
      else
        erb :'/sessions/authorization'
      end
    else
      erb :'/sessions/failure'
    end
  end
  
end
