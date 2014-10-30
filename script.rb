CLASSES = [CLASS_L = 'l', CLASS_D = 'd']

Document = Struct.new(:klass, :words)

TRAINING_DOCUMENTS = [
    Document.new(CLASS_L, %w(append remove reverse)),
    Document.new(CLASS_L, %w(index append remove fromkeys)),
    Document.new(CLASS_D, %w(copy update)),
    Document.new(CLASS_D, %w(popitem fromkeys update)),
    Document.new(CLASS_D, %w(sort reverse keys))
]

TEST_DOCUMENTS = [
    Document.new(nil, %w(popitem popitem update fromkeys)),
    Document.new(nil, %w(append)),
]

class NaiveBayes

  attr_reader :classes, :training_documents, :test_documents, :training_documents_by_class, :training_words_by_class, :total_uniq_training_words

  def initialize(classes, training_documents, test_documents)
    @classes = classes
    @training_documents = training_documents
    @test_documents = test_documents
    @training_documents_by_class = prepare_training_documents_by_class
    @training_words_by_class = prepare_training_words_by_class
    @total_uniq_training_words = calculate_total_uniq_training_words
  end

  def run
    test_documents.each do |test_document|
      test_document.klass = class_with_max_probability_for(test_document)
      display_results_for(test_document)
    end
  end

  private

  def calculate_total_uniq_training_words
    training_documents.map { |d| d.words }.flatten.uniq
  end

  def prepare_training_documents_by_class
    classes.each_with_object({}) do |klass, training_documents_by_class|
      training_documents_by_class[klass] = training_documents.select { |d| d.klass == klass }
    end
  end

  def prepare_training_words_by_class
    classes.each_with_object({}) do |klass, training_words_by_class|
      training_words_by_class[klass] = training_documents_by_class[klass].map(&:words).flatten
    end
  end

  def class_with_max_probability_for(test_document)
    classes.max_by { |klazz| probability_for(klazz, test_document) }
  end

  def display_results_for(document)
    puts "#{document.words} ==> class: #{document.klass}, probability: #{probability_for(document.klass, document)}"
  end

  def prior_probability_for(klass)
    training_documents_by_class[klass].size / training_documents.size.to_f
  end

  def probability_for(klass, test_document)
    probabilities = [prior_probability_for(klass)]
    probabilities += conditional_probabilities_for(test_document.words, klass)
    final_probability(probabilities)
  end

  def conditional_probabilities_for(words, klass)
    words.each_with_object([]) do |word, conditional_probabilities|
      conditional_probabilities << conditional_probability_for(word, klass)
    end
  end

  def conditional_probability_for(word, klass)
    (count_word_occurrences_in(klass, word) + 1) / (training_words_by_class[klass].size + total_uniq_training_words.size).to_f
  end

  def final_probability(probabilities)
    probabilities.inject(0) { |result, probability| result + Math.log(probability) }
  end

  def count_word_occurrences_in(klass, word)
    training_words_by_class[klass].count(word)
  end

end

nb = NaiveBayes.new(CLASSES, TRAINING_DOCUMENTS, TEST_DOCUMENTS)
nb.run


