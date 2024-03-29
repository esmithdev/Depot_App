class Cart < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :line_items, :dependent => :destroy
  #destroying an instance of cart destroys the line items in them

  	def add_product(product_id)
		current_item = line_items.find_by_product_id(product_id)
		if current_item
			current_item.quantity += 1
		else	
			current_item = line_items.build(:product_id => product_id)
		end
		
		current_item
	end

	def total_price
		line_items.to_a.sum {|item| item.total_price }
	end	

	def total_items 
		line_items.sum(:quantity) #corresponds with view output and create js.rjs view
	end
end
