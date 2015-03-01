module SearchHelper
  def model_search(model, fields, query)
    puts "in model search"
    fields.reduce([]) { |results, field|
      results + model.where("#{field} LIKE ?", "%#{query}%")
    }.uniq
  end
end
