class Wagon
  include InstanceCounter
  include CompanyName
  attr_reader :type
  def initialize(capacity)
    @capacity = capacity
    self.register_instances
    inter_company_name
  end
end