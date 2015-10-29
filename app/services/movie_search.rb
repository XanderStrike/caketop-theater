class MovieSearch
  attr_accessor :results

  def initialize(params)
    @params = params
    @results = Movie.where('')

    filter
  end

  def self.simple_search(q)
    q = "%#{q}%"
    Movie.where("title like ? or original_title like ? or overview like ?", q, q, q)
  end

  private

  def filter
    # poor man's strong params
    [:title, :overview].map {|key| like(key) }
    [:runtime_max, :revenue_max, :budget_max, :vote_average_max].each {|key| less_than(key) }
    [:runtime_min, :revenue_min, :budget_min, :vote_average_min].each {|key| greater_than(key) }

    [:filename].each {|key| encode_like(key)}
    [:container, :a_format, :v_format, :resolution].each {|key| encode_equals(key)}

    @results = @results.where(id: Genre.where(genre_id: @params[:genre]).map(&:movie_id)) unless @params[:genre].blank?
    @results = @results.order((@params[:sort] || 'title asc'))
  end

  def like(k)
    query(k, 'like', "%#{@params[k]}%")
  end

  def greater_than(k)
    query(k.to_s[0..-5], '>', @params[k])
  end

  def less_than(k)
    query(k.to_s[0..-5], '<', @params[k])
  end

  def encode_like(k)
    encode_query(k, 'like', "%#{@params[k]}%")
  end

  def encode_equals(k)
    encode_query(k, '=', @params[k])
  end

  def query(column, comparison, value)
    @results = @results.where("#{column} #{comparison} ?", value) unless value.blank? || value == '%%'
  end

  def encode_query(column, comparison, value)
    @results = @results.includes(:encodes).where("encodes.#{column} #{comparison} ?", value).references(:encodes) unless value.blank? || value == '%%'
  end
end
