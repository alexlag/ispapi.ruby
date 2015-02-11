# Ruby wrapper for [ISPRAS API](https://api.ispras.ru/)

## Installation
It's simple gem, so ```gem install ispras-api``` and adding ```gem 'ipras-api'``` should work.

## Usage

Currently wraps *texterra* and *twitter-nlp* services, so apikey for any of those is needed

Code should look similar to this:
```ruby
require 'ispras-api'

texterra = TexterraAPI.new 'APIKEY'
text = 'Apple today updated iMac to bring numerous high-performance enhancements to the leading all-in-one desktop.'

key_concepts = texterra.key_concepts text
puts key_concepts[0]
# > {:id=>"21492980", :kbname=>"enwiki", :title=>"IMac", :weight=>"0.35956284403800964"}

wiki_url = texterra.get_attributes('21492980:enwiki', 'url(en)')[:elements][:object][:attributes][:i_attribute][:url]
# > "http://en.m.wikipedia.org/wiki/IMac" 
```
Don't forget to check [REST documentation](https://api.ispras.ru/dev/rest) 
