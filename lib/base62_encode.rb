class Integer
  BASE62_PRIMITIVES = ['0'..'9', 'A'..'Z', 'a'..'z'].map(&:to_a).flatten

  def base62_encode
    num = self.abs
    neg = self < 0
    result = (num == 0) ? "0" : ""
    while (num > 0)
      result = BASE62_PRIMITIVES[num % BASE62_PRIMITIVES.size] + result
      num /= BASE62_PRIMITIVES.size
    end
    neg ? "-" + result : result
  end
end
