# frozen_string_literal: true

module Types
  class BookType < Types::BaseObject
    field :id, ID, null: false
    field :title, String
    field :isbn, String
    field :author, Types::AuthorType, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def author
      dataloader.with(Sources::AuthorById).load(object.author_id)
    end
  end
end
