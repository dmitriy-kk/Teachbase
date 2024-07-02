class Wagon
  include InstanceCounter
  include CompanyName
  attr_reader :type, :capacity, :used_capacity
  def initialize(capacity)
    @capacity = capacity
    @used_capacity = 0
    self.register_instances
    inter_company_name
  end

  def free_capacity
    capacity - used_capacity
  end

  private
  attr_writer :used_capacity
end