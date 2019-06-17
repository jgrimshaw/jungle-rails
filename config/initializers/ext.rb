class Numeric
   def is_float?
     self.to_f.to_s == self.to_s
   end

   def is_whole?
     !is_float?
   end
end