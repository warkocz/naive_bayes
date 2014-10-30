require_relative 'document'
require_relative 'naive_bayes'

CLASSES = [CLASS_L = 'list', CLASS_D = 'dict']

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

nb = NaiveBayes.new(CLASSES, TRAINING_DOCUMENTS, TEST_DOCUMENTS)
nb.run


