module SearchHelper
  def model_search(model, fields, query)
    where_clause = fields.map { |field| "#{field} LIKE '%#{query}%'"}.join(" OR ")
    model.where(where_clause)
  end
end
