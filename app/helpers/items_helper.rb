module ItemsHelper
	def write_date(date)
	  if date != nil
	    date.to_s
	  else
	    Date.current().to_s
	end       
  end   
end
