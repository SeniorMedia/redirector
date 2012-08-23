module Redirector
  module RegexAttribute
    
    def regex_attribute(attribute_name)
      include ValidationMethod
      cattr_accessor :regex_attribute_name
      self.regex_attribute_name = attribute_name
      validates "#{attribute_name}_is_regex".to_sym, :inclusion => { :in => ['0', '1', true, false] }
      validate :regex_attribute_is_valid_regex
    end
    
    module ValidationMethod
      protected
      
      def regex_attribute_is_valid_regex
        if self.send("#{regex_attribute_name}_is_regex?") && self.send("#{regex_attribute_name}?")
          begin
            Regexp.compile(self.send(regex_attribute_name))
          rescue RegexpError
            errors.add(regex_attribute_name, 'is an invalid regular expression')
          end
        end
      end
    end
  end
end
