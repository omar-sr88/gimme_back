class ItemProgress

 attr_reader	:items

  def initialize(items)
  	@items = items
  end

  def set_progress
  	items.each do |item|
	  	total = item.days_to_return(item.date_lended, item.initial_return_date) 
		item.days_left = item.days_to_return(Time.now, item.initial_return_date)

		if item.days_left > 0
		  item.progress = (total - item.days_left)*100/total unless total == 0
		else
		  item.progress = 100
		end

		if item.days_left < 0 
          item.progress_status = "progress-bar-danger"
          item.progress_message = "Xi jão, te deram o guela!"
        elsif item.days_left == 0
          item.progress_status = "progress-bar-warning"
          item.progress_message = "É Hoje! Vai atrás mermão!"
        else
          item.progress_status = "progress-bar-success"
          item.progress_message = "Faltam #{item.days_left} dias"
        end	
	end

  end
end