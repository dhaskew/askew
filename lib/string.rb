
module Askew

  class String
    # colorization
    def apply_color(ascii_color_code)
      "\e[#{ascii_color_code}m#{self}\e[0m"
    end
    
    def red;        apply_color(31) end
    def green;      apply_color(32) end
    def yellow;     apply_color(33) end
    def blue;       apply_color(34) end
    def magenta;    apply_color(35) end
    def cyan;       apply_color(36) end
    def grey;       apply_color(37) end

    def bold;       "\e[1m#{self}\e[22m" end
    def italic;     "\e[3m#{self}\e[23m" end
    def underline;  "\e[4m#{self}\e[24m" end
    
  end 

end
