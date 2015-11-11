require 'databasedotcom'
require 'databasedotcom-rails'

module RdToSalesforce
  class Conta
    include Databasedotcom::Rails::Controller

    attr_accessor :id, :name, :first_name, :last_name

    def initialize(first_name, last_name)
      @first_name = first_name
      @last_name = last_name

      @name = first_name + ' ' + last_name

      @id = nil
    end

    def self.all
      contas = []

      users = User.find_all_by_isActive_and_UserType(true, 'Standard')

      users.each do |user|
        conta = user_to_conta(user)

        contas << conta
      end

      return contas
    end

    private
    def self.user_to_conta(user)
      new = Conta.new(user.FirstName, user.LastName)
      new.id = user.Id

      return new
    end
  end
end