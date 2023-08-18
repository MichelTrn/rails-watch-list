class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    # Besoin de trouver l'id de la liste en la récupérant dans les params
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])
    @movie = Movie.find(params[:bookmark][:movie_id])
    # Besoin de récupérer l'id dans les params et le movie dans la liste sélectionné
    # le movie_id se trouve dans l'instance bookmark puis l'instance movie
    @bookmark = Bookmark.new(bookmark_params)
    # On créé notre bookmarks en fonction des params récupéré
    @bookmark.list = @list
    @bookmark.movie = @movie
    # Mais besoin d'associé la list_id et le movie_id dans le bookmark avec les instances
    if @bookmark.save
      # Il ne faut pas mettre de .save! ici car n'affiche pas les erreurs
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
    # On a besoin de permit movie pour renvoyer la bonne vue
  end
end
