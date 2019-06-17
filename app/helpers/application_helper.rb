module ApplicationHelper

  def star_rating_classes(rating)
    0.upto(4).map do |idx|
      if rating.to_s == '0' || rating < idx
        'gray'
      else
        if rating >= idx+1
          'gold'
        elsif rating.is_float? && rating.to_i == idx
         "gold-gray"
       end
      end
    end
  end

end
