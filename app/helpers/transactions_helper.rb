module TransactionsHelper
  def money(cents)
    e, c = cents.divmod 100
    c = "%02d" % c
    "#{e}.#{c}"
  end
end

