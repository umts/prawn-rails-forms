# frozen_string_literal: true

require 'prawn-rails-forms/document_extensions'
require 'prawn-rails-forms/field_row'
require 'prawn-rails-forms/version'
require 'prawn-rails'

module PrawnRailsForms
end

module PrawnRails
  class Document
    include PrawnRailsForms::DocumentExtensions
  end
end
