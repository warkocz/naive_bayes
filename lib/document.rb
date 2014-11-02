class Document

  attr_accessor :id, :klass, :words, :classified_klass, :probability

  def initialize(id, klass, words)
    @id = id
    @klass = klass
    @classified_klass = nil
    @probability = nil
    @words = words
  end

end