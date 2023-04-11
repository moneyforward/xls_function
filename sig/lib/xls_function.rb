module XlsFunction
  VERSION: String

  class Error < StandardError
  end

  def self.evaluate: (untyped source, **untyped context) -> untyped

  def self.parser: () -> untyped

  def self.use_parser_factory: () ?{ () -> untyped } -> untyped

  def self.transform: () -> untyped

  def self.use_transform_factory: () ?{ () -> untyped } -> untyped

  attr_accessor self.verbose: untyped

  def self.logger: () -> Logger

  def self.logger=: (Logger obj) -> Logger

  def self.locale=: (untyped value) -> untyped

  def self.current_locale: () -> untyped

  def self.functions: () -> untyped
end
