require 'test_helper'

class PessoaTest < ActiveSupport::TestCase
  include RdToSalesforce
  def test_Pessoa_all
    lista = Pessoa.all

    assert(lista.count > 0)
  end

  def test_Pessoa_find
    pessoa = Pessoa.find('00Q61000004ibpjEAA')

    assert_equal('Loehr', pessoa.last_name)
  end

  def test_Pessoa_create
    # pessoa = Pessoa.new('rbtest nome','rbtest','rbtest@email.com','rbtest','rbtest','1234567890','rbtest.com','00561000000GmCgAAK')
    pessoa = Pessoa.new
    pessoa.name = 'rbtest nome'
    pessoa.last_name = 'rbtest'
    pessoa.job_title = 'rbtest@email.com'
    pessoa.company = 'rbtest'
    pessoa.job_title = 'rbtest'
    pessoa.phone = '1234567890'
    pessoa.website = 'rbtest'
    pessoa.conta_id = '00561000000GmCgAAK'

    result = pessoa.create

    pessoa.destroy # destroy to keep database clean

    assert_equal(true, result)
  end

  def test_Pessoa_create_error
    # pessoa = Pessoa.new('','','','','','','','')
    pessoa = Pessoa.new
    pessoa.name = ''
    pessoa.last_name = ''
    pessoa.job_title = ''
    pessoa.company = ''
    pessoa.job_title = ''
    pessoa.phone = ''
    pessoa.website = ''
    pessoa.conta_id = ''

    result = pessoa.create

    assert_equal(false, result)
  end

  def test_Pessoa_destroy
    # pessoa = Pessoa.new('rbtest nome delete','rbtest','rbtest@email.com','rbtest','rbtest','1234567890','rbtest.com','00561000000GmCgAAK')
    pessoa = Pessoa.new
    pessoa.name = 'rbtest nome delete'
    pessoa.last_name = 'rbtest'
    pessoa.job_title = 'rbtest@email.com'
    pessoa.company = 'rbtest'
    pessoa.job_title = 'rbtest'
    pessoa.phone = '1234567890'
    pessoa.website = 'rbtest'
    pessoa.conta_id = '00561000000GmCgAAK'

    pessoa.create

    result = pessoa.destroy

    puts pessoa.errors unless result

    assert_equal(true, result)
  end

  def test_Pessoa_destroy_error
    # pessoa = Pessoa.new('rbtest nome delete','rbtest','rbtest@email.com','rbtest','rbtest','1234567890','rbtest.com','00561000000GmCgAAK')
    pessoa = Pessoa.new
    pessoa.name = 'rbtest nome delete'
    pessoa.last_name = 'rbtest'
    pessoa.job_title = 'rbtest@email.com'
    pessoa.company = 'rbtest'
    pessoa.job_title = 'rbtest'
    pessoa.phone = '1234567890'
    pessoa.website = 'rbtest'
    pessoa.conta_id = '00561000000GmCgAAK'

    result = pessoa.destroy

    assert_equal(false, result)
  end

  def test_Pessoa_update
    # pessoa = Pessoa.new('rbtest nome to update','rbtest','rbtest@email.com','rbtest','rbtest','1234567890','rbtest.com','00561000000GmCgAAK')
    pessoa = Pessoa.new
    pessoa.name = 'rbtest nome to update'
    pessoa.last_name = 'rbtest'
    pessoa.job_title = 'rbtest@email.com'
    pessoa.company = 'rbtest'
    pessoa.job_title = 'rbtest'
    pessoa.phone = '1234567890'
    pessoa.website = 'rbtest'
    pessoa.conta_id = '00561000000GmCgAAK'

    pessoa.create

    pessoa.name = 'rbtest nome UPDATED'

    result = pessoa.update

    pessoa.destroy # destroy to keep database clean

    puts pessoa.errors unless result

    assert_equal(true, result)
  end
end