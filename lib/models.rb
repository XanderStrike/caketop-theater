class Movies < ActiveRecord::Base
  
  def genres
    Genres.where(movie_id: self.id)
  end

end

class Watches < ActiveRecord::Base
end

class Requests < ActiveRecord::Base
end

class Genres < ActiveRecord::Base
end
