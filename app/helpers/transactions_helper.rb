module TransactionsHelper
  def money(cents)
    return nil if cents.blank?
    return "-#{money(-cents)}" if cents < 0
    e, c = cents.divmod 100
    c = "%02d" % c
    "#{e}.#{c}"
  end
end

