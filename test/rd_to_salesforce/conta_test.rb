require 'test_helper'

class ContaTest < ActiveSupport::TestCase
  def test_Conta_all
    lista = RdToSalesforce::Conta.all

    assert(lista.count > 0)
  end
end