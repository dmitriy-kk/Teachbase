# frozen_string_literal: true

module CompanyName
  attr_reader :company_name

  protected

  def inter_company_name
    puts 'Ведите название производителя'
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
      self.class.instances += 1
    end
  end
end

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end
  module ClassMethods
    attr_reader :validations

    def validate(attribute, type, *args)
      @validations ||= []
      @validations << [attribute, type, args]
    end

    protected

    def validate_presence(attribute)
      raise 'Имя должно быть заполнено' if attribute.nil?
      raise 'Введены  данные в формате не String' unless attribute.instance_of?(String)
      raise 'Введена пустая стока, это не допустимо' if attribute.empty?
    end

    # def validate_presence_rute(attribute1, attribute2)
    #   raise 'Начальная станция маршрута не создана!!! Создайте станцию.' if attribute1 != Station
    #   raise 'Конечная станция маршрута не создана!!! Создайте станцию.' if attribute2 != Station
    # end

    def validate_format(attribute, args)
      raise "#{attribute} не коректный формат" if attribute !~ args.first
    end

    def validate_type(attribute, args)
      raise "#{attribute} class is not #{args.first}" if attribute.class != args.first
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        attribute = instance_variable_get("@#{validation.first}")
        self.class.send :validate_presence, attribute if validation[1] == :presence
        self.class.send :validate_format, attribute, validation.last if validation[1] == :format
        self.class.send :validate_type, attribute, validation.last if validation[1] == :type
        # self.class.send :validate_presence_rute, attribute1, attribute2  validation.last if validation[3] == :rute

      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end

class Test
  attr_accessor :name, :trains

  include Validation

  validate :name, :presence
  validate :name, :type, String
  validate :name, :format, /[a-zA-Z]/
  validate :trains, :type, Array

  def initialize(name)
    @name = name
    @trains = []
    validate!
  end

end