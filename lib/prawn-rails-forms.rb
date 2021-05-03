# frozen_string_literal: true

require 'prawn-rails-forms/document_extensions'
require 'prawn-rails-forms/field_row'
require 'prawn-rails-forms/version'
require 'prawn-rails'

module PrawnRailsForms
  def self.default_text_field_options=(options)
    @default_text_field_options = options
  end

  def self.default_text_field_options
    @default_text_field_options ||= {}
  end
end

PrawnRails::Document.include PrawnRailsForms::DocumentExtensions
