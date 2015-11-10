require 'test_helper'

class RdToSalesforceTest < ActiveSupport::TestCase
  def test_truth
    assert_kind_of Module, RdToSalesforce
  end

  def test_Pessoa_all
    lista = RdToSalesforce::Pessoa.all

    assert(lista.count > 0)
  end

  def test_Pessoa_find
    pessoa = RdToSalesforce::Pessoa.find('00Q61000004ibpjEAA')

    assert_equal('Loehr', pessoa.last_name)
  end

  def test_Pessoa_create
    pessoa = RdToSalesforce::Pessoa.new('rbtest nome','rbtest','rbtest@email.com','rbtest','rbtest','1234567890','rbtest.com','00561000000GmCgAAK')

    result = pessoa.create

    puts 'pessoa.id: ' + pessoa.id.to_s

    assert_equal(true, result)
  end

  def test_Pessoa_create_error
    pessoa = RdToSalesforce::Pessoa.new('','','','','','','','')

    result = pessoa.create

    assert_equal(false, result)

    puts pessoa.errors
  end
end
