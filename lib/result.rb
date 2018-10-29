module Result
  class BaseResult
    def initialize(code: :ok, data: nil)
      @code = code
      @data = data
    end

    def code!(value)
      @code = value
      self
    end

    def data
      @data
    end

    def success?
      @code == :ok
    end

    def error?
      !success?
    end
  end

  def self.success(data = nil)
    BaseResult.new(code: :ok, data: data)
  end

  def self.error(data = nil)
    BaseResult.new(code: :ko,  data: data)
  end
end
