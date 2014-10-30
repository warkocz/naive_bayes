class Document

  attr_accessor :klass, :words

  def initialize(klass, words)
    @klass = klass
    @words = words
  end

end