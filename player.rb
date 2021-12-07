class Player < User
  attr_reader :name

  def initialize(name)
    super
    @name = name
  end
end
