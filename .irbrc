require 'irb/completion'
require 'irb/ext/save-history'
require 'rubygems'

Dir.glob(File.expand_path('~/.local/irb*.rb', __FILE__)).each do |file|
  require file
end

IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true

class Object
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end

  # print documentation
  #   ri 'Array#pop'
  #   Array.ri
  #   Array.ri :pop
  #   arr.ri :pop
  def ri(method = nil)
    unless method && method =~ /^[A-Z]/ # if class isn't specified
      klass = self.kind_of?(Class) ? name : self.class.name
      method = [klass, method].compact.join('#')
    end
    puts `ri '#{method}'`
  end
end

def cop
  last_value = IRB.CurrentContext.last_value
  %x[echo '#{last_value}' | pbcopy]
  "copied \`#{last_value}' to your clipboard"
end

def r
  reload!
end
