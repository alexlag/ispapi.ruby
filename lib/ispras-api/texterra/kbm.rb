require_relative './kbm_specs'

module TexterraKBM
  include TexterraKBMSpecs

  # Determines if Knowledge base contains the specified terms and computes features of the specified types for them.
  #
  # @param [String] text Text with term-candidates
  # @param [Array] term_candidates Term-candidates start and end
  # @param [Hash] params Specifies types of features required to compute
  #
  # @result [Array] Texterra annotations
  def representation_terms(text, term_candidates, params={featureType: ['commonness', 'info-measure']})
    path = KBM_SPECS[:representationTerms][:path]
    options = {
      headers: {
        'Content-Type' => 'application/json'
      },
      query: params,
      body: {
        text: text,
        annotations: {
          'term-candidate' => term_candidates
        }
      }.to_json
    }
    response = self.class.post "/#{path}", options
    response.code == 200 ? response.parsed_response : check_error(response)
  end

  # Return neighbour concepts for the given concepts(list or single concept, each concept is {id}:{kbname}).
  #
  # @param concepts [String, Array<String>] either concept as {id}:{kbname} or array of such concepts
  # @param traverse_params [Hash] optional
  # @option traverse_params [String] :linkType searching for neightbour concepts only along these link types
  # @option traverse_params [String] :nodeType searching for neightbour concepts only of these types
  # @option traverse_params [Fixnum] :minDepth minimum distance from original to result concepts
  # @option traverse_params [Fixnum] :maxDepth maximum distance from original to result concepts
  #
  # @result [Hash] with :elements field
  #
  # If at least one traverse parameter(check REST Documentation for values) is specified, all other parameters should also be specified
  def neighbours(concepts, traverse_params = {})
    traverse = traverse_params.inject('') do |res, (name, value)|
      res + ";#{name}=#{value}"
    end unless traverse_params.empty?
    preset_kbm :neighbours, [wrap_concepts(concepts), traverse]
  end

  # Return neighbour concepts size for the given concepts(list or single concept, each concept is {id}:{kbname}).
  #
  # @param concepts [String, Array<String>] either concept as {id}:{kbname} or array of such concepts
  # @param traverse_params [Hash] optional
  # @option traverse_params [String] :linkType searching for neightbour concepts only along these link types
  # @option traverse_params [String] :nodeType searching for neightbour concepts only of these types
  # @option traverse_params [Fixnum] :minDepth minimum distance from original to result concepts
  # @option traverse_params [Fixnum] :maxDepth maximum distance from original to result concepts
  #
  # @result [Hash] with :size field
  #
  # @note If at least one traverse parameter(check REST Documentation for values) is specified, all other parameters should also be specified
  def neighbours_size(concepts, traverse_params = {})
    traverse = traverse_params.inject('') do |res, (name, value)|
      res + ";#{name}=#{value}"
    end unless traverse_params.empty?
    preset_kbm :neighbours, [wrap_concepts(concepts), "#{traverse}/size"]
  end

  # Compute similarity for each pair of concepts(list or single concept, each concept is {id}:{kbname}).
  #
  # @param [Array<String>] concepts Array of concepts as {id}:{kbname}
  # @param [String] linkWeight Specifies method for computation of link weight in case of multiple link types - check REST Documentation for values
  def similarity_graph(concepts, linkWeight = 'MAX')
    preset_kbm :similarityGraph, "#{wrap_concepts(concepts)}linkWeight=#{linkWeight}"
  end

  # Computes sum of similarities from each concepts(list or single concept, each concept is {id}:{kbname}) from the first list to all concepts(list or single concept, each concept is {id}:{kbname}) from the second one.
  #
  # @param [Array<String>] first_concepts Array of concepts as {id}:{kbname}
  # @param [Array<String>] second_concepts Array of concepts as {id}:{kbname}
  # @param [String] linkWeight Specifies method for computation of link weight in case of multiple link types - check REST Documentation for values
  def all_pairs_similarity(first_concepts, second_concepts, linkWeight = 'MAX')
    preset_kbm :allPairsSimilarity, ["#{wrap_concepts(first_concepts)}linkWeight=#{linkWeight}", wrap_concepts(second_concepts)]
  end

  # Compute similarity from each concept from the first list to all concepts(list or single concept, each concept is {id}:{kbname}) from the second list as a whole.
  # Links of second list concepts(each concept is {id}:{kbname}) are collected together, thus forming a "virtual" article, similarity to which is computed.
  #
  # @param [Array<String>] concepts Array of concepts as {id}:{kbname}
  # @param [Array<String>] virtual_aricle Array of concepts as {id}:{kbname}
  # @param [String] linkWeight Specifies method for computation of link weight in case of multiple link types - check REST Documentation for values
  def similarity_to_virtual_article(concepts, virtual_aricle, linkWeight = 'MAX')
    preset_kbm :similarityToVirtualArticle, ["#{wrap_concepts(concepts)}linkWeight=#{linkWeight}", wrap_concepts(virtual_aricle)]
  end

  # Compute similarity between two sets of concepts(list or single concept, each concept is {id}:{kbname}) as between "virtual" articles from these sets.
  # The links of each virtual article are composed of links of the collection of concepts.
  #
  # @param [Array<String>] first_virtual_aricle Array of concepts as {id}:{kbname}
  # @param [Array<String>] second_virtual_article Array of concepts as {id}:{kbname}
  # @param [String] linkWeight Specifies method for computation of link weight in case of multiple link types - check REST Documentation for values
  def similarity_between_virtual_articles(first_virtual_aricle, second_virtual_article, linkWeight = 'MAX')
    preset_kbm :similarityBetweenVirtualArticle, ["#{wrap_concepts(first_virtual_aricle)}linkWeight=#{linkWeight}", wrap_concepts(second_virtual_article)]
  end

  # Search for similar concepts among the first neighbours of the given ones(list or single concept, each concept is {id}:{kbname}).
  #
  # @param [Array<String>] concepts Array of concepts as {id}:{kbname}
  # @param [Hash] params
  # @option params [String] :linkWeight Specifies method for computation of link weight in case of multiple link types
  # @option params [Fixnum] :offset Provides a possibility to skip several concepts from the start of the result
  # @option params [Fixnum] :limit Provides a possibility to limit size of result
  #
  # @note check REST Documentation for values
  def similar_over_first_neighbours(concepts, params = { linkWeight: 'MAX' })
    preset_kbm :similarOverFirstNeighbours, "#{wrap_concepts(concepts)};linkWeight=#{params[:linkWeight]}", params
  end

  # Search for similar concepts over filtered set of the first and the second neighbours of the given ones(list or single concept, each concept is {id}:{kbname}).
  #
  # @param [Array<String>] concepts Array of concepts as {id}:{kbname}
  # @param [Hash] params
  # @option params [String] :linkWeight Specifies method for computation of link weight in case of multiple link types
  # @option params [Fixnum] :offset Provides a possibility to skip several concepts from the start of the result
  # @option params [Fixnum] :limit Provides a possibility to limit size of result
  # @option params [String] :among Specifies how to filter neighbour concepts when searching for most similar
  #
  # @note check REST Documentation for values
  def similar_over_filtered_neighbours(concepts, params = { linkWeight: 'MAX' })
    params[:among] ||= ''
    preset_kbm :similarOverFilteredNeighbours, "#{wrap_concepts(concepts)};linkWeight=#{params[:linkWeight]}", params
  end

  # Get attributes for concepts(list or single concept, each concept is {id}:{kbname})
  #
  # @param [String, Array<String>] concepts Either concept as {id}:{kbname} or array of such concepts
  # @param [Array<String>] attributes Specifies attributes to be included into response
  # @note check REST Documentation for supported attributes
  def get_attributes(concepts, attributes = [])
    preset_kbm :getAttributes, wrap_concepts(concepts), attribute: attributes
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
  def preset_kbm(methodName, pathParam, queryParam = {})
    specs = KBM_SPECS[methodName]
    queryParam.merge specs[:params]
    GET(specs[:path] % pathParam, queryParam)
  end
end
