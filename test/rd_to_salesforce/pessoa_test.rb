require 'test_helper'

class PessoaTest < ActiveSupport::TestCase
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

    pessoa.destroy # destroy to keep database clean

    assert_equal(true, result)
  end

  def test_Pessoa_create_error
    pessoa = RdToSalesforce::Pessoa.new('','','','','','','','')

    result = pessoa.create

    assert_equal(false, result)
  end

  def test_Pessoa_destroy
    pessoa = RdToSalesforce::Pessoa.new('rbtest nome delete','rbtest','rbtest@email.com','rbtest','rbtest','1234567890','rbtest.com','00561000000GmCgAAK')

    pessoa.create

    result = pessoa.destroy

    puts pessoa.errors unless result

    assert_equal(true, result)
  end

  def test_Pessoa_destroy_error
    pessoa = RdToSalesforce::Pessoa.new('rbtest nome delete','rbtest','rbtest@email.com','rbtest','rbtest','1234567890','rbtest.com','00561000000GmCgAAK')

    result = pessoa.destroy

    assert_equal(false, result)
  end

  def test_Pessoa_update
    pessoa = RdToSalesforce::Pessoa.new('rbtest nome to update','rbtest','rbtest@email.com','rbtest','rbtest','1234567890','rbtest.com','00561000000GmCgAAK')

    pessoa.create

    pessoa.name = 'rbtest nome UPDATED'

    result = pessoa.update

    pessoa.destroy # destroy to keep database clean

    puts pessoa.errors unless result

    assert_equal(true, result)
  end
end