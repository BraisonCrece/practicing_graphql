# frozen_string_literal: true

module Types
  class AuthorType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :surname, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :books, [Types::BookType], null: true

    def books
      dataloader.with(Sources::BooksByAuthorId).load(object.id)
    end
  end
end
