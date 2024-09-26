# frozen_string_literal: true

class Hash
  def sample(n)
    Hash[to_a.sample(n)]
  end
end
