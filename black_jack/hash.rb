class Hash
  def sample(n)
    Hash[to_a.sample(n)]
  end
end