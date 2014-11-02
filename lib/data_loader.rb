require 'tokenizer'
require_relative 'document'

class DataLoader

  attr_reader :tokenizer, :classes

  # Assigns classes and initializes Tokenizer class
  def initialize(classes)
    @classes = classes
    @tokenizer = Tokenizer::Tokenizer.new
  end

  # Creates array of documents for given data set
  def documents(set)
    classes.each_with_object([]) do |klass, documents|
      documents << documents_for_class(klass, set)
    end.flatten
  end

  private

  # Creates array of documents for given class and data set
  def documents_for_class(klass, set)
    documents = []
    Dir.foreach("data/#{set}/#{klass}") do |item|
      next if item[0] == '.'
      documents << document_from_file(klass, set, item)
    end
    documents
  end

  # Creates instance of Document class from tokenized text file
  def document_from_file(klass, set, item)
    tokenized_text = tokenizer.tokenize(File.open("data/#{set}/#{klass}/#{item}", 'r:windows-1251:utf-8').read)
    Document.new(item, klass, tokenized_text)
  end
end