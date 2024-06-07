module CompanyName
  
  attr_reader :company_name

  protected

  def inter_company_name
    puts "Ведите название производителя"
    name = gets.chomp.to_s
    self.company_name = name
  end
  
  attr_writer :company_name
end

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances
    def instances
      @instances ||= 0
    end
  end

  module InstanceMethods
    protected
    def register_instances
      self.class.instances +=1
    end
  end
end 

class Test
  include InstanceCounter
  
  def initialize
    self.register_instances 
  end
  
end




