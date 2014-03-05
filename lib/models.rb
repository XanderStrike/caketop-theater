class Movies < ActiveRecord::Base
  
  def genres
    Genres.where(movie_id: self.id)
  end

  def similar
    similar_ids = Similars.where(movie: self.id).map(&:related_movie)
    Movies.where(id: similar_ids)
  end

end

class Watches < ActiveRecord::Base
end

class Requests < ActiveRecord::Base
end

class Feedbacks < ActiveRecord::Base
end

class Genres < ActiveRecord::Base

  def movies
    Movies.where(id: Genres.where(genre_id: self.genre_id).map(&:movie_id))
  end
end

class Shows < ActiveRecord::Base

  def title
    self.name
  end
  
  def genres
    Genres.where(movie_id: self.id)
  end
end

class Similars < ActiveRecord::Base

end
