module TexterraKBMSpecs
  # Path and parameters for preset KBM queries
  KBMSpecs = {
    termPresence: {
      path: 'representation/%s/contained',
      params: {}
    },
    termInfoMeasure: {
      path: 'representation/%s/infomeasure',
      params: {}
    },
    termMeanings: {
      path: 'representation/%s/meanings',
      params: {}
    },
    termCommonness: {
      path: 'representation/%s/commonness/%s',
      params: {}
    },
    neighbours: {
      path: 'walker/%s/neighbours%s',
      params: {}
    },
    similarityGraph: {
      path: 'similarity/%s/graph',
      params: {}
    },
    allPairsSimilarity: {
      path: 'similarity/%s/summed/%s',
      params: {}
    },
    similarityToVirtualArticle: {
      path: 'similarity/%s/toVirtualArticle/%s',
      params: {}
    },
    similarityBetweenVirtualArticle: {
      path: 'similarity/%s/betweenVirtualArticles/%s',
      params: {}
    },
    similarOverFirstNeighbours: {
      path: 'similarity/%s/similar/neighbours',
      params: {}
    },
    similarOverFilteredNeighbours: {
      path: 'similarity/%s/similar/all',
      params: {}
    }
  }
end