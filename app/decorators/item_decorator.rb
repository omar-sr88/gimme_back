class ItemDecorator
  
 attr_reader	:item

  def initialize(item)
  	@item = item
    #self.set_progress
  end

  def self.build_collection(items)
    items.map { |item| new(item) }
  end


  def method_missing(method_name, *args, &block)
    item.send(method_name, *args, &block)
  end
 
  def respond_to_missing?(method_name, include_private = false)
    item.respond_to?(method_name,include_private) ||  super
  end

  def days_left
    days_to_return(Time.now, item.initial_return_date)
  end

  def progress
    total = days_to_return(item.date_lended, item.initial_return_date) 
    if days_left > 0
      (total - days_left)*100/total unless total == 0
    else
      100
    end
  end

  def progress_message
    if days_left < 0 
       I18n.t :no_days_left
    elsif days_left == 0
       I18n.t :current_day_left
    else
      I18n.t("some_days_left", :days => days_left, :count => days_left)
      #{}"Faltam #{days_left} dias"
    end    
  end

  def progress_status
    if days_left < 0 
      "progress-bar-danger"
    elsif days_left == 0
      "progress-bar-warning"
    else
      "progress-bar-success"
    end 
  end

  def days_to_return(date1, date2)
      (date2.to_date - date1.to_date).to_i
  end


  def is_mine?(user)
    item.is_owned_by?(user)
  end
   
  # STATIC CALCULATED AS ATTR ACCESSORS?
  #
  #attr_accessor :days_left, :progress, :progress_message,  :progress_status
  
  # def set_progress
	 #  total = item.days_to_return(item.date_lended, item.initial_return_date) 
		# item.days_left = item.days_to_return(Time.now, item.initial_return_date)

		# if item.days_left > 0
		#   item.progress = (total - item.days_left)*100/total unless total == 0
		# else
		#   item.progress = 100
		# end

		# if item.days_left < 0 
  #     item.progress_status = "progress-bar-danger"
  #     item.progress_message = "Xi jão, te deram o guela!"
  #   elsif item.days_left == 0
  #     item.progress_status = "progress-bar-warning"
  #     item.progress_message = "É Hoje! Vai atrás mermão!"
  #   else
  #     item.progress_status = "progress-bar-success"
  #     item.progress_message = "Faltam #{item.days_left} dias"
  #   end	
  # end
end