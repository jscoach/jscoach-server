class Category < ActiveRecord::Base
  include Postcss
  include ReactNative
  include React
  include Vue
  include VanillaJs
  include Angular
  include Node

  extend FriendlyId

  friendly_id :name, use: [:scoped, :slugged, :finders], scope: :collection

  has_and_belongs_to_many :packages, uniq: true
  belongs_to :collection

  default_scope { order "position asc" }

  def self.discover(pkg)
    categories = []
    pkg.collections.each do |collection|
      case collection.slug
      when "postcss"
        categories |= discover_postcss(collection, pkg)
      when "react-native"
        categories |= discover_react_native(collection, pkg)
      when "react"
        categories |= discover_react(collection, pkg)
      when "vue"
        categories |= discover_vue(collection, pkg)
      when "angular"
        categories |= discover_angular(collection, pkg)
      when "vanilla-js"
        categories |= discover_vanilla_js(collection, pkg)
      when "node"
        categories |= discover_node(collection, pkg)
      end
    end
    categories
  end

  def to_s
    name
  end
end
