module TexterraNLPSpecs
  # Path and parameters for preset NLP queries
  NLP_SPECS = {
    languageDetection: {
      path: 'nlp/language',
      params: {
        class: 'ru.ispras.texterra.core.nlp.datamodel.Language',
        filtering: 'KEEPING'
      }
    },
    sentenceDetection: {
      path: 'nlp/sentence',
      params: {
        class: 'ru.ispras.texterra.core.nlp.datamodel.Sentence',
        filtering: 'KEEPING'
      }
    },
    tokenization: {
      path: 'nlp/token',
      params: {
        class: 'ru.ispras.texterra.core.nlp.datamodel.Token',
        filtering: 'KEEPING'
      }
    },
    lemmatization: {
      path: 'nlp/lemma',
      params: {
        class: 'ru.ispras.texterra.core.nlp.datamodel.Lemma',
        filtering: 'KEEPING'
      }
    },
    posTagging: {
      path: 'nlp/pos',
      params: {
        class: 'ru.ispras.texterra.core.nlp.datamodel.pos.POSToken',
        filtering: 'KEEPING'
      }
    },
    spellingCorrection: {
      path: 'nlp/spellingcorrection',
      params: {
        class: 'ru.ispras.texterra.core.nlp.datamodel.SpellingCorrection',
        filtering: 'KEEPING'
      }
    },
    namedEntities: {
      path: 'nlp/namedentity',
      params: {
        class: 'ru.ispras.texterra.core.nlp.datamodel.ne.NamedEntityToken',
        filtering: 'KEEPING'
      }
    },
    termDetection: {
      path: 'nlp/term',
      params: {
        class: 'ru.ispras.texterra.core.nlp.datamodel.Frame',
        filtering: 'KEEPING'
      }
    },
    disambiguation: {
      path: 'nlp/disambiguation',
      params: {
        class: 'ru.ispras.texterra.core.nlp.datamodel.DisambiguatedPhrase',
        filtering: 'KEEPING'
      }

    },
    keyConcepts: {
      path: 'nlp/keyconcepts',
      params: {
        class: 'ru.ispras.texterra.core.nlp.datamodel.KeyconceptsSemanticContext',
        filtering: 'KEEPING'
      }

    },
    domainDetection: {
      path: 'nlp/domain',
      params: {
        class: 'domain',
        filtering: 'KEEPING'
      }

    },
    subjectivityDetection: {
      path: 'nlp/subjectivity',
      params: {
        class: 'ru.ispras.texterra.core.nlp.datamodel.SentimentSubjectivity',
        filtering: 'KEEPING'
      }

    },
    polarityDetection: {
      path: 'nlp/polarity',
      params: {
        class: 'ru.ispras.texterra.core.nlp.datamodel.SentimentPolarity',
        filtering: 'KEEPING'
      }

    },
    aspectExtraction: {
      path: 'nlp/aspectsentiment',
      params: {
        class: 'aspect-sentiment',
        filtering: 'KEEPING'
      }

    },
    domainPolarityDetection: {
      path: 'nlp/domainpolarity%s',
      params: {
        class: %w(domain sentiment-polarity),
        filtering: 'KEEPING'
      }

    },
    tweetNormalization: {
      path: 'nlp/twitterdetection',
      params: {
        class: %w(sentence language token),
        filtering: 'REMOVING'
      }
    },
    syntaxDetection: {
      path: 'nlp/syntax',
      params: {
        class: 'ru.ispras.texterra.core.nlp.datamodel.syntax.SyntaxRelation',
        filtering: 'KEEPING'
      }
    }

  }
end
