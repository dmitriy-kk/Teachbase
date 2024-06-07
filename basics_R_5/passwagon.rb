class PassengerWagon
  include InstanceCounter
  include CompanyName
  def initialize
    self.register_instances
    inter_company_name
  end
end