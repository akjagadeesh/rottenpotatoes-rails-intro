module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  def has_been_checked?(rating)
  	if @ratings
  		@ratings.include? rating
  	else
  		true
  	end
  end
end
