require 'rd_to_salesforce/version'
require 'databasedotcom'
require 'databasedotcom-rails'
require 'active_model'

module RdToSalesforce
  class Pessoa
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include Databasedotcom::Rails::Controller

    attr_accessor :id, :name, :last_name, :email, :company, :job_title, :phone, :website, :conta_id, :conta, :errors

    # def initialize(name, last_name, email, company, job_title, phone, website, conta_id)
    #   @name = name
    #   @last_name = last_name
    #   @email = email
    #   @company = company
    #   @job_title = job_title
    #   @phone = phone
    #   @website = website
    #   @conta_id = conta_id
    #
    #   @id = nil
    #   @conta = nil
    # end

    def initialize(*args)
      unless args.nil?
        @name = args[0] unless args[0].nil?
        @last_name = args[1] unless args[1].nil?
        @email = args[2] unless args[2].nil?
        @company = args[3] unless args[3].nil?
        @job_title = args[4] unless args[4].nil?
        @phone = args[5] unless args[5].nil?
        @website = args[6] unless args[6].nil?
        @conta_id = args[7] unless args[7].nil?
      end
    end

    def self.all
      pessoas = []

      leads = Lead.all

      contas = User.find_all_by_isActive_and_UserType(true, 'Standard')

      leads.each do |lead|
        user = contas.find { |conta| conta.Id == lead.OwnerId }

        pessoa = lead_to_pessoa(lead)
        pessoa.conta = user.Name

        pessoas << pessoa
      end

      return pessoas
    end

    def self.find(id)
      lead = Lead.find(id)
      conta = User.find_by_Id(lead.OwnerId).Name

      lead_to_pessoa(lead, conta)
    end

    def create
      lead = pessoa_to_lead
      lead.IsConverted = false
      lead.IsUnreadByOwner = true

      begin
        if lead.save
          @id = lead.Id
          return true
        end
      rescue Exception => e
        @errors = e
        return false
      end
    end

    def update
      lead = pessoa_to_lead
      lead.Id = @id

      begin
        lead.update_attributes 'FirstName' => @name, 'LastName' => @last_name, 'Email' => @email, 'Company' => @company,
                               'Title' => @job_title, 'Phone' => @phone, 'Website' => @website, 'OwnerId' => @conta_id
        return true
      rescue Exception => e
        @errors = e
        return false
      end

    end

    def destroy
      lead = pessoa_to_lead
      lead.Id = @id

      begin
        lead.delete
        return true
      rescue Exception => e
        @errors = e
        return false
      end

    end

    def persisted?
      false
    end

    private
    def self.lead_to_pessoa(lead, conta = nil)
      # new = Pessoa.new(lead.FirstName, lead.LastName, lead.Email, lead.Company, lead.Title, lead.Phone, lead.Website, lead.OwnerId)
      new = Pessoa.new
      new.name = lead.FirstName
      new.last_name = lead.LastName
      new.email = lead.Email
      new.company = lead.Company
      new.job_title = lead.Title
      new.phone = lead.Phone
      new.website = lead.Website
      new.conta_id = lead.OwnerId

      new.id = lead.Id
      new.conta = conta unless conta.nil?

      return new
    end

    def pessoa_to_lead
      lead = Lead.new

      lead.FirstName = @name
      lead.LastName = @last_name
      lead.Email = @email
      lead.Company = @company
      lead.Title = @job_title
      lead.Phone = @phone
      lead.Website = @website
      lead.OwnerId = @conta_id

      return lead
    end

  end
end