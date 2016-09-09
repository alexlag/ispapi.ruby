module TexterraNLPSpecs
  # Path and parameters for preset NLP queries
  NLP_SPECS = {
    languageDetection: {
      path: 'nlp/language',
      params: {
        class: 'language',
        filtering: 'KEEPING'
      }
    },
    sentenceDetection: {
      path: 'nlp/sentence',
      params: {
        class: 'sentence',
        filtering: 'KEEPING'
      }
    },
    tokenization: {
      path: 'nlp/token',
      params: {
        class: 'token',
        filtering: 'KEEPING'
      }
    },
    lemmatization: {
      path: 'nlp/lemma',
      params: {
        class: 'lemma',
        filtering: 'KEEPING'
      }
    },
    posTagging: {
      path: 'nlp/pos',
      params: {
        class: 'pos-token',
        filtering: 'KEEPING'
      }
    },
    spellingCorrection: {
      path: 'nlp/spellingcorrection',
      params: {
        class: 'spelling-correction-token',
        filtering: 'KEEPING'
      }
    },
    namedEntities: {
      path: 'nlp/namedentity',
      params: {
        class: 'named-entity',
        filtering: 'KEEPING'
      }
    },
    termDetection: {
      path: 'nlp/term',
      params: {
        class: 'frame',
        filtering: 'KEEPING'
      }
    },
    disambiguation: {
      path: 'nlp/disambiguation',
      params: {
        class: 'disambiguated-phrase',
        filtering: 'KEEPING'
      }

    },
    keyConcepts: {
      path: 'nlp/keyconcepts',
      params: {
        class: 'keyconcepts',
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
        class: 'subjectivity',
        filtering: 'KEEPING'
      }

    },
    polarityDetection: {
      path: 'nlp/polarity',
      params: {
        class: 'polarity',
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
        class: %w(domain polarity),
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
        class: 'syntax-relation',
        filtering: 'KEEPING'
      }
    }

  }
end
