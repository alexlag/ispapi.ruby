require_relative './kbm_specs'

module TexterraKBM
  include TexterraKBMSpecs

  # Determines if Knowledge base contains the specified term
  #
  # @param term [String] term
  # @return [Hash] with :presence field
  def term_presence(term)
    presetKBM :termPresence, term
  end

  # Returns information measure for the given term. Information measure denotes, how often given term is used as link caption among all its occurences
  #
  # @param term [String] term
  # @result [Hash] with :infomeasure field
  def term_info_measure(term)
    presetKBM :termInfoMeasure, term
  end

  # Return concepts resource from the Knowledge base corresponding to the found meanings of the given term
  #
  # @param term [String] term
  # @result [Hash] with :elements field
  def term_meanings(term)
    presetKBM :termMeanings, term
  end

  # If concept isn't provided, returns concepts with their commonness, corresponding to the found meanings of the given term. Commonness denotes, how often the given term is associated with the given concept.
  #   With concept(format is {id}:{kbname}) returns commonness of given concept for the given term.
  #
  # @param term [String] term
  # @param concept [String] concept as {id}:{kbname}
  # @result [Hash] with :elements field
  def term_commonness(term, concept='')
    concept = "id=#{concept}" unless concept.empty?
    presetKBM :termCommonness, [term, concept]
  end

  # Return neighbour concepts for the given concepts(list or single concept, each concept is {id}:{kbname}). 
  #  If at least one traverse parameter(check REST Documentation for values) is specified, all other parameters should also be specified 
  # 
  # @param concepts [String, Array] either concept as {id}:{kbname} or array of such concepts
  # @param traverse_params [Hash] optional, should contain :linkType, :nodeType, :minDepth, :maxDepth keys with values
  # @result [Hash] with :elements field
  def neighbours(concepts, traverse_params={})
    traverse = traverse_params.inject('') do |res, (name, value)|
      res += ";#{name}=#{value}"
    end unless traverse_params.empty?
    presetKBM :neighbours, [wrap_concepts(concepts), traverse]
  end

  # Return neighbour concepts size for the given concepts(list or single concept, each concept is {id}:{kbname}).
  # 
  # @param concepts [String, Array] either concept as {id}:{kbname} or array of such concepts
  # @param traverse_params [Hash] optional, should contain :linkType, :nodeType, :minDepth, :maxDepth keys with values
  #   If at least one traverse parameter(check REST Documentation for values) is specified, all other parameters should also be specified  
  # @result [Hash] with :size field
  def neighbours_size(concepts, traverse_params={})
    traverse = traverse_params.inject('') do |res, (name, value)|
      res += ";#{name}=#{value}"
    end unless traverse_params.empty?
    presetKBM :neighbours, [wrap_concepts(concepts), "#{traverse}/size"]
  end

  # Compute similarity for each pair of concepts(list or single concept, each concept is {id}:{kbname}). 
  #
  # @param concepts [Array] array of concepts as {id}:{kbname}
  # @param linkWeight [String] pecifies method for computation of link weight in case of multiple link types - check REST Documentation for values
  def similarity_graph(concepts, linkWeight='MAX')
    presetKBM :similarityGraph, "#{wrap_concepts(concepts)}linkWeight=#{linkWeight}"
  end

  # Computes sum of similarities from each concepts(list or single concept, each concept is {id}:{kbname}) from the first list to all concepts(list or single concept, each concept is {id}:{kbname}) from the second one.
  # 
  # @param first_concepts [Array] array of concepts as {id}:{kbname}
  # @param second_concepts [Array] array of concepts as {id}:{kbname}
  # @param linkWeight [String] pecifies method for computation of link weight in case of multiple link types - check REST Documentation for values  
  def all_pairs_similarity(first_concepts, second_concepts, linkWeight='MAX')
    presetKBM :allPairsSimilarity, ["#{wrap_concepts(first_concepts)}linkWeight=#{linkWeight}", wrap_concepts(second_concepts)]
  end

  # Compute similarity from each concept from the first list to all concepts(list or single concept, each concept is {id}:{kbname}) from the second list as a whole. 
  #   Links of second list concepts(each concept is {id}:{kbname}) are collected together, thus forming a "virtual" article, similarity to which is computed.
  # 
  # @param concepts [Array] array of concepts as {id}:{kbname}
  # @param virtual_aricle [Array] array of concepts as {id}:{kbname}
  # @param linkWeight [String] pecifies method for computation of link weight in case of multiple link types - check REST Documentation for values  
  def similarity_to_virtual_article(concepts, virtual_aricle, linkWeight='MAX')
    presetKBM :similarityToVirtualArticle, ["#{wrap_concepts(concepts)}linkWeight=#{linkWeight}", wrap_concepts(virtual_aricle)]
  end

  # Compute similarity between two sets of concepts(list or single concept, each concept is {id}:{kbname}) as between "virtual" articles from these sets. 
  #   The links of each virtual article are composed of links of the collection of concepts. 
  # 
  # @param first_virtual_aricle [Array] array of concepts as {id}:{kbname}
  # @param second_virtual_article [Array] array of concepts as {id}:{kbname}
  # @param linkWeight [String] pecifies method for computation of link weight in case of multiple link types - check REST Documentation for values  
  def similarity_between_virtual_articles(first_virtual_aricle, second_virtual_article, linkWeight='MAX')
    presetKBM :similarityBetweenVirtualArticle, ["#{wrap_concepts(first_virtual_aricle)}linkWeight=#{linkWeight}", wrap_concepts(second_virtual_article)]
  end

  # Search for similar concepts among the first neighbours of the given ones(list or single concept, each concept is {id}:{kbname}).
  # 
  # @param concepts [Array] array of concepts as {id}:{kbname}
  # @param linkWeight [String] pecifies method for computation of link weight in case of multiple link types - check REST Documentation for values  
  # @param params [Hash]
  # => linkWeight [String] pecifies method for computation of link weight in case of multiple link types - check REST Documentation for values  
  # => offset [Integer] provides a possibility to skip several concepts from the start of the result
  # => limit [Integer] provides a possibility to limit size of result
  # check REST Documentation for values
  def similar_over_first_neighbours(concepts, params={linkWeight:'MAX'})
    presetKBM :similarOverFirstNeighbours, "#{wrap_concepts(concepts)};linkWeight=#{params[:linkWeight]}", params
  end

  # Search for similar concepts over filtered set of the first and the second neighbours of the given ones(list or single concept, each concept is {id}:{kbname}).
  # 
  # @param concepts [Array] array of concepts as {id}:{kbname}
  # @param linkWeight [String] pecifies method for computation of link weight in case of multiple link types - check REST Documentation for values  
  # @param params [Hash]
  # => :linkWeight [String] pecifies method for computation of link weight in case of multiple link types - check REST Documentation for values  
  # => :offset [Integer] provides a possibility to skip several concepts from the start of the result
  # => :limit [Integer] provides a possibility to limit size of result
  # => :among [SimilarCandidatesFilter] specifies how to filter neighbour concepts when searching for most similar
  # check REST Documentation for values
  def similar_over_filtered_neighbours(concepts, params={linkWeight:'MAX'})
    presetKBM :similarOverFilteredNeighbours, "#{wrap_concepts(concepts)};linkWeight=#{params[:linkWeight]}", params
  end

  # Get attributes for concepts(list or single concept, each concept is {id}:{kbname})
  #  
  # @param concepts [String, Array] either concept as {id}:{kbname} or array of such concepts
  # @param attributes [Array] specifies attributes to be included into response
  # => Supported attributes:
  #     coordinates - GPS coordinates
  #     definition - brief concept definition
  #     url(<language>) - URL to page with description of the given concept on the specified language
  #     <language> - language code, like: en, de, fr, ko, ru, ...
  #     synonym - different textual representations of the concept
  #      title - concept title
  #     translation(<language>) textual representation of the concept on the specified language
  #     <language> - language code, like: en, de, fr, ko, ru, ...
  #     type - concept type
  def get_attributes(concepts, attributes=[])
    presetKBM :getAttributes, wrap_concepts(concepts), attribute: attributes
  end

  private 

    # Utility wrapper for matrix parameters
    def wrap_concepts(concepts)
      if concepts.is_a? Array
        concepts.map { |c| "id=#{c};" }.join
      else
        "id=#{concepts};"
      end
    end

    # Utility EKB part method
    def presetKBM(methodName, pathParam, queryParam={})
      specs = KBMSpecs[methodName]
      queryParam.merge specs[:params]
      GET(specs[:path] % pathParam, queryParam)
    end

end