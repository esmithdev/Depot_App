module ApplicationHelper

	def hidden_div_if(condition, attributes = {}, &block)
		if condition
			attributes["style"] = "display: none"
		end
			content_tag("div", attributes, &block)
	end


	def lang
		[ ["English",                  "en"], ["Espa&ntilde;ol".html_safe, "es"] ]
    end					
end
