module TexterraNLPSpecs
  # Path and parameters for preset NLP queries
  NLPSpecs = {
    languageDetection: {
        path: 'nlp/ru.ispras.texterra.core.nlp.pipelines.LanguageDetectionPipeline',
        params: {
          :class => 'ru.ispras.texterra.core.nlp.datamodel.Language',
          filtering: 'KEEPING'
        }
    },
    sentenceDetection: {
        path: 'nlp/sentence',
        params: {
          :class => 'ru.ispras.texterra.core.nlp.datamodel.Sentence',
          filtering: 'KEEPING'
        }
    },
    tokenization: {
        path: 'nlp/token',
        params: {
          :class => 'ru.ispras.texterra.core.nlp.datamodel.Token',
          filtering: 'KEEPING'
        }
    },
    lemmatization: {
        path: 'nlp/lemma',
        params: {
          :class => 'ru.ispras.texterra.core.nlp.datamodel.Lemma',
          filtering: 'KEEPING'
        }
    },
    posTagging: {
        path: 'nlp/pos',
        params: {
          :class => 'ru.ispras.texterra.core.nlp.datamodel.pos.IPOSToken',
          filtering: 'KEEPING'
        }
    },
    spellingCorrection: {
        path: 'nlp/ru.ispras.texterra.core.nlp.annotators.spelling.SpellingCorrector',
        params: {
          :class => 'ru.ispras.texterra.core.nlp.datamodel.SpellingCorrection',
          filtering: 'KEEPING'
        }
    },
    namedEntities: {
        path: 'nlp/ru.ispras.texterra.core.nlp.pipelines.NETaggingPipeline',
        params: {
          :class => 'ru.ispras.texterra.core.nlp.datamodel.ne.NamedEntityToken',
          filtering: 'KEEPING'
        }
    },
    termDetection: {
        path: 'nlp/ru.ispras.texterra.core.nlp.pipelines.TermDetectionPipeline',
        params: {
          :class => 'ru.ispras.texterra.core.nlp.datamodel.Frame',
          filtering: 'KEEPING'
        }
    },
    disambiguation: {
        path: 'nlp/ru.ispras.texterra.core.nlp.pipelines.DisambiguationPipeline',
        params: {
          :class => 'ru.ispras.texterra.core.nlp.datamodel.DisambiguatedPhrase',
          filtering: 'KEEPING'
        }

    },
    keyConcepts: {
        path: 'nlp/ru.ispras.texterra.core.nlp.pipelines.KeyConceptsPipeline',
        params: {
          :class => 'ru.ispras.texterra.core.nlp.datamodel.KeyconceptsSemanticContext',
          filtering: 'KEEPING'
        }

    },
    domainDetection: {
        path: 'nlp/domain',
        params: {
          :class => 'domain',
          filtering: 'KEEPING'
        }

    },
    subjectivityDetection: {
        path: 'nlp/subjectivity',
        params: {
          :class => 'ru.ispras.texterra.core.nlp.datamodel.SentimentSubjectivity',
          filtering: 'KEEPING'
        }

    },
    polarityDetection: {
        path: 'nlp/polarity',
        params: {
          :class => 'ru.ispras.texterra.core.nlp.datamodel.SentimentPolarity',
          filtering: 'KEEPING'
        }

    },
    aspectExtraction: {
        path: 'nlp/aspectsentiment',
        params: {
          :class => 'aspect-sentiment',
          filtering: 'KEEPING'
        }

    },
    domainPolarityDetection: {
        path: 'nlp/domainpolarity%s',
        params: {
          :class => [ 'domain', 'sentiment-polarity' ],
          filtering: 'KEEPING'
        }

    },
    tweetNormalization: {
        path: 'nlp/twitterdetection',
        params: {
          :class => ['sentence', 'language', 'token'],
          filtering: 'REMOVING'
        }

    }
  }
 
end